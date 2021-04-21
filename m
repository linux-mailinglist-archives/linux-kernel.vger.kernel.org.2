Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7BA366B85
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240293AbhDUNDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:03:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240140AbhDUNCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:02:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E937761454;
        Wed, 21 Apr 2021 13:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010137;
        bh=PikN53d+FWu23XlMVOKVXXaD81ya+7z4Xsd2LjkmWKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s6nd4TOn/CDxj39z7KS+Ju9mhUhjJZdmQc658HADs5YK7Rur2/9/8Z4oPjKXG5tT1
         u42eIE9D1KTjhaVUIA44lw/9b5racH6ojbWcRpk5zwHTi1fe4ORPYBK/qStPgKFyQn
         AjYZ166yys5a9VzJRb3rxV6g3jhMd3WJFgwg3gdI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>,
        Mathew King <mathewk@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 025/190] Revert "platform/chrome: cros_ec_ishtp: Fix a double-unlock issue"
Date:   Wed, 21 Apr 2021 14:58:20 +0200
Message-Id: <20210421130105.1226686-26-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit aaa3cbbac326c95308e315f1ab964a3369c4d07d.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Qiushi Wu <wu000273@umn.edu>
Cc: Mathew King <mathewk@chromium.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/chrome/cros_ec_ishtp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
index f00107017318..d4f41d68232c 100644
--- a/drivers/platform/chrome/cros_ec_ishtp.c
+++ b/drivers/platform/chrome/cros_ec_ishtp.c
@@ -677,10 +677,8 @@ static int cros_ec_ishtp_probe(struct ishtp_cl_device *cl_device)
 
 	/* Register croc_ec_dev mfd */
 	rv = cros_ec_dev_init(client_data);
-	if (rv) {
-		down_write(&init_lock);
+	if (rv)
 		goto end_cros_ec_dev_init_error;
-	}
 
 	return 0;
 
-- 
2.31.1

