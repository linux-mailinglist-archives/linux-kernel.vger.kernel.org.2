Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB8D39701A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhFAJRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:17:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47288 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231139AbhFAJRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:17:17 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1519DOvn012202;
        Tue, 1 Jun 2021 09:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=AMzMC6WVaFSkjgPnsMYkeiLg88Ox0rk4fBCHhz3nMU0=;
 b=cjHZ8IANNdBYUlgMX5+xUYr0SRbKktNKSC+E572PM4zalHe5eF7Ta8kxyPj3o5gk++tB
 I2dfrARyQfnjI6FZ81g/wj1n17IhKLvCD4urz47wgZJ467a2K9aZFww/OBRUZr2SJVi0
 vEXz6xyJkwQyEhZ1J+lj1mMffdZbnY6BOdKM+A3TfCuBJfkhEOiPeM1xtEWuGGh72zbz
 3ooYO4/veGwfaTThvivWzqB36RdUcHO+Jxfo+ZSIT+tcj3e3LkOijtRvCUSKvJw2hWG0
 gliX9fA1fWyHPxxtb2yixbVC/dnDnfOWEXBAK9sLA1CraGVPPTDaPLokqlwOWrNMt4ty uw== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 38vj1krhws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 09:15:32 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 1519BRe3005688;
        Tue, 1 Jun 2021 09:15:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38ude8dk48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 09:15:31 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1519FU8O035633;
        Tue, 1 Jun 2021 09:15:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 38ude8dk3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 09:15:30 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1519FTP4026485;
        Tue, 1 Jun 2021 09:15:29 GMT
Received: from mwanda (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Jun 2021 02:15:29 -0700
Date:   Tue, 1 Jun 2021 12:15:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Matt Porter <mporter@kernel.crashing.org>
Cc:     Alexandre Bounine <alex.bou9@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] rapidio: potential overflow in riocm_ch_send()
Message-ID: <YLX6p+NXg2w+UqRq@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: QBjpSKkFcV6F-Sk7eCVz14jMFJzaHfpI
X-Proofpoint-GUID: QBjpSKkFcV6F-Sk7eCVz14jMFJzaHfpI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "buf" variable has "len" bytes, and the size is controlled by the
user in cm_chan_msg_send().  If the length is fewer than sizeof(*hdr)
then it could lead to memory corruption.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Strictly speaking the last two bytes of length are reserved and not
written to but it's simpler and better to check "< sizeof(*hdr)" instead
of "< sizeof(*hdr) - 2".  This is better for future proofing.

 drivers/rapidio/rio_cm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
index db4c265287ae..5c332b9867e1 100644
--- a/drivers/rapidio/rio_cm.c
+++ b/drivers/rapidio/rio_cm.c
@@ -784,7 +784,8 @@ static int riocm_ch_send(u16 ch_id, void *buf, int len)
 	struct rio_ch_chan_hdr *hdr;
 	int ret;
 
-	if (buf == NULL || ch_id == 0 || len == 0 || len > RIO_MAX_MSG_SIZE)
+	if (buf == NULL || ch_id == 0 ||
+	    len < sizeof(*hdr) || len > RIO_MAX_MSG_SIZE)
 		return -EINVAL;
 
 	ch = riocm_get_channel(ch_id);
-- 
2.30.2

