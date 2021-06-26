Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536223B5035
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 23:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFZVVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 17:21:16 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:47316 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230329AbhFZVVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 17:21:12 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id B915E41374;
        Sat, 26 Jun 2021 21:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1624742327; x=1626556728; bh=NjUXmDvODIG4mmn9yCdR8yIIkg4JaCGdQlL
        QdiV7Hss=; b=esswhwC56BD6DQI4RYH3I+lq2CKEXvwCALxr/AjgYRf7faZDUaS
        wox7jKIvr0Ahw+HoDNMyHO0RZzt5VdHlyOdyTLMsz4hKO95miFIfN/59fQy//+qf
        8NwEIip8P4gWIBbSyCqcKx9Dgv7bo5gtTo/v8ur73C1tApj1TCqGo4k4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0dySZJUevoas; Sun, 27 Jun 2021 00:18:47 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id A0452413B4;
        Sun, 27 Jun 2021 00:18:47 +0300 (MSK)
Received: from localhost.localdomain (10.199.0.6) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Sun, 27
 Jun 2021 00:18:47 +0300
From:   Igor Kononenko <i.kononenko@yadro.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <openbmc@lists.ozlabs.org>, Igor Kononenko <i.kononenko@yadro.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] fms: Support the DVD/BD images size over 2.1Gb
Date:   Sun, 27 Jun 2021 00:18:17 +0300
Message-ID: <20210626211820.107310-5-i.kononenko@yadro.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210626211820.107310-1-i.kononenko@yadro.com>
References: <20210626211820.107310-1-i.kononenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.6]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the ability to use the FMS image size greater than 2.1Gb.  This
limitation is due to the maximum number of available frames on the
CD-ROM media.

An incoming implementation of additional media formats (DVD-ROM, BD-ROM)
should support both formats' possible capacity.

End-user-impact: Now, the FMS able to use a medium-image backend  file,
                 which size is more significant than 2.1Gb

Signed-off-by: Igor Kononenko <i.kononenko@yadro.com>
---
 drivers/usb/gadget/function/storage_common.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/storage_common.c b/drivers/usb/gadget/function/storage_common.c
index b883b8b7b05b..468f7622b11d 100644
--- a/drivers/usb/gadget/function/storage_common.c
+++ b/drivers/usb/gadget/function/storage_common.c
@@ -242,15 +242,8 @@ int fsg_lun_open(struct fsg_lun *curlun, const char *filename)
 
 	num_sectors = size >> blkbits; /* File size in logic-block-size blocks */
 	min_sectors = 1;
-	if (curlun->cdrom) {
+	if (curlun->cdrom)
 		min_sectors = 300;	/* Smallest track is 300 frames */
-		if (num_sectors >= 256*60*75) {
-			num_sectors = 256*60*75 - 1;
-			LINFO(curlun, "file too big: %s\n", filename);
-			LINFO(curlun, "using only first %d blocks\n",
-					(int) num_sectors);
-		}
-	}
 	if (num_sectors < min_sectors) {
 		LINFO(curlun, "file too small: %s\n", filename);
 		rc = -ETOOSMALL;
-- 
2.32.0

