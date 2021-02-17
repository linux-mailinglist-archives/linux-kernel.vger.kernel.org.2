Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CF031DC9C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbhBQPoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:44:12 -0500
Received: from pv50p00im-ztdg10012001.me.com ([17.58.6.51]:44140 "EHLO
        pv50p00im-ztdg10012001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233476AbhBQPoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1613576589;
        bh=qY6a0Sr6oY2hiCTNhF9SsJZEouIXiMrkajwvQEyslnQ=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=uPo0py6jVpkYKGsw8CdHMplteRtdYiH57EmVYfamrm9IQFxbgkZimxXzLiwo4c03G
         LDzwArcQBFST8KWuKho8NXagy8X6aOke/mPIxpOAL2nRF6Smnmr02d/rXW00Obd8Px
         AzAVTnaE6UMCx4wKoJAFuIs4JlpH4X05Y8IVhEzCL0Uqohy/oZoMEAniEwifxpUFO8
         DLSqdANkqOLJfU/RCcDHszS75LOKoastf80ir5Bh8NV/2RWjuh2KaG3ANMJanaSWT2
         WC8n8zxrpBb7c+RrBHP205ftmJ4Bk/ZREq1Ga/8/CkS49/J85JLhMHWtLavHtZ3uK4
         f6kLGiOpsCwPw==
Received: from everest.nathzi1505 (unknown [45.250.51.33])
        by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id CCC1728035A;
        Wed, 17 Feb 2021 15:43:07 +0000 (UTC)
From:   Pritthijit Nath <pritthijit.nath@icloud.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Pritthijit Nath <pritthijit.nath@icloud.com>
Subject: [PATCH] staging: wlan-ng: Fixed incorrect type warning in p80211netdev.c
Date:   Wed, 17 Feb 2021 21:12:55 +0530
Message-Id: <20210217154255.112115-1-pritthijit.nath@icloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-17_13:2021-02-16,2021-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2102170119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change fixes a sparse warning "incorrect type in argument 1
(different address spaces)".

Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
---
 drivers/staging/wlan-ng/p80211netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
index 6f9666dc0277..70570e8a5ad2 100644
--- a/drivers/staging/wlan-ng/p80211netdev.c
+++ b/drivers/staging/wlan-ng/p80211netdev.c
@@ -569,7 +569,7 @@ static int p80211knetdev_do_ioctl(struct net_device *dev,
 		goto bail;
 	}
 
-	msgbuf = memdup_user(req->data, req->len);
+	msgbuf = memdup_user((void __user *)req->data, req->len);
 	if (IS_ERR(msgbuf)) {
 		result = PTR_ERR(msgbuf);
 		goto bail;
-- 
2.25.1

