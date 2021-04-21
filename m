Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459D3366EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243915AbhDUPUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 11:20:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39522 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240440AbhDUPUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:20:15 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LF1eqh026116;
        Wed, 21 Apr 2021 15:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=Rxpae055naMvyjukIZqKVynJM4wLpOcw2BPFdfdM5sM=;
 b=fMvfrfBNuzxuhiV0MGTz5RPARWG2+dSn8rnew48y6jv0ulpp+c3EsDnUOY7JKDf2nBii
 aFR33QXvKMTxS0RrHAK004y/mCtjUfdCkI0gCdEXCbyFW6zpOoo11hFsI/qE6t5N5GYP
 rkHgw2LHdrxenhc6j3d3H10TENgpW29jeBz/REfhiNaPBMktSVYfxI6hIjQOEEdHtQwc
 hcHZjTkR9qVVU7MNqJbyng03toEncjesjN2tSZi+lJdwSwkVt4bSnou4Rm/MHnYYZEQj
 a44Sd/AY3FDdbqFuv1Mc2F+tmzBYIBH+kkHWxKR1T/yiUYu1g9P5UfkEaM0cQ/i2qHKH MQ== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 381tw0gjjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 15:19:37 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13LFJaS9054029;
        Wed, 21 Apr 2021 15:19:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38098rvm7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 15:19:36 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13LFGvhc037551;
        Wed, 21 Apr 2021 15:19:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 38098rvm6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 15:19:35 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13LFJYXI031486;
        Wed, 21 Apr 2021 15:19:34 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Apr 2021 08:19:33 -0700
Date:   Wed, 21 Apr 2021 18:19:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Cc:     David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] platform/x86: intel_pmc_core: Uninitialized data in
 pmc_core_lpm_latch_mode_write()
Message-ID: <YIBCf+G9Ef8wrGJw@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87e61d84-e23e-1ccc-c4ed-57ffa0ed95fb@redhat.com>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: ECw56KjdYg0IXNc2JtlNvMSsnop18kv7
X-Proofpoint-ORIG-GUID: ECw56KjdYg0IXNc2JtlNvMSsnop18kv7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simple_write_to_buffer() can return success if even a single byte
is copied from user space.  In this case it can result in using
uninitalized data if the buf[] array is not fully initialized.  Really
we should only succeed if the whole buffer is copied.

Just using copy_from_user() is simpler and more appropriate.

Fixes: 8074a79fad2e ("platform/x86: intel_pmc_core: Add option to set/clear LPM mode")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: The first version of this patch returned -EINVAL if userspace didn't
give us NUL terminated strings.  That's not necessarily a good
assumption.

This patch is just simpler as well.  No need to introduce the "len"
variable because "count" is capped at the start of the function.

 drivers/platform/x86/intel_pmc_core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index d174aeb492e0..b0e486a6bdfb 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -1360,17 +1360,13 @@ static ssize_t pmc_core_lpm_latch_mode_write(struct file *file,
 	struct pmc_dev *pmcdev = s->private;
 	bool clear = false, c10 = false;
 	unsigned char buf[8];
-	ssize_t ret;
 	int idx, m, mode;
 	u32 reg;
 
 	if (count > sizeof(buf) - 1)
 		return -EINVAL;
-
-	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf, count);
-	if (ret < 0)
-		return ret;
-
+	if (copy_from_user(buf, userbuf, count))
+		return -EFAULT;
 	buf[count] = '\0';
 
 	/*
-- 
2.30.2

