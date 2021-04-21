Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7202C366B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbhDUNDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240419AbhDUNDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:03:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A64F76144B;
        Wed, 21 Apr 2021 13:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010181;
        bh=6KNhhR2mpSKu9WEJfspsrmutVxJbZI6kKM3yUMOLVcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KzOS+wBIDFWoJe0Y69k0wsPHeKQBwJxFjBirCfYDdaokCF9ooch0hXPQSxezez3lJ
         LnRCSewP9u+aIDbPR7cih7H/s6xHontLaykDKD2XN1f0BjiszCNfcMcOwo8D2+kyFc
         dErf8lRrhQYOvASiBrttAnyQo97fducJ45+qDNLg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>, Mark Brown <broonie@kernel.org>
Subject: [PATCH 042/190] Revert "ASoC: fix incomplete error-handling in img_i2s_in_probe."
Date:   Wed, 21 Apr 2021 14:58:37 +0200
Message-Id: <20210421130105.1226686-43-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 25bf943e4e7b47282bd86ae7d39e039217ebb007.

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
Cc: https
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/img/img-i2s-in.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/img/img-i2s-in.c b/sound/soc/img/img-i2s-in.c
index e30b66b94bf6..a495d1050d49 100644
--- a/sound/soc/img/img-i2s-in.c
+++ b/sound/soc/img/img-i2s-in.c
@@ -482,7 +482,6 @@ static int img_i2s_in_probe(struct platform_device *pdev)
 	if (IS_ERR(rst)) {
 		if (PTR_ERR(rst) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
-			pm_runtime_put(&pdev->dev);
 			goto err_suspend;
 		}
 
-- 
2.31.1

