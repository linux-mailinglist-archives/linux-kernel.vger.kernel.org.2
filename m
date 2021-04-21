Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEFF366BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240894AbhDUNF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240737AbhDUNEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:04:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8EB861457;
        Wed, 21 Apr 2021 13:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010254;
        bh=6JK2ZvNg2y9/7AAfvM1HVUkKpJzy3wX25Nn0tJyAJ/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JrRjzeJxe2ExtvomJnaMrGnHPU4KlIoQnj7VrERsdjH8m6mYzKdklgArdMk2iiEET
         /1GsI0U3J9fgGjRGfpiDizv8BdHN0QOepfjdmhFRZWLg+N62pyW9x1TPZWwxZ2aeVo
         0T64gs/XkPLJBPN8d9ACFyzPmM4U7JW5YwQd9cYE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>, Mark Brown <broonie@kernel.org>
Subject: [PATCH 033/190] Revert "ASoC: img: Fix a reference count leak in img_i2s_in_set_fmt"
Date:   Wed, 21 Apr 2021 14:58:28 +0200
Message-Id: <20210421130105.1226686-34-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c4c59b95b7f7d4cef5071b151be2dadb33f3287b.

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
 sound/soc/img/img-i2s-in.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/img/img-i2s-in.c b/sound/soc/img/img-i2s-in.c
index 0843235d73c9..e30b66b94bf6 100644
--- a/sound/soc/img/img-i2s-in.c
+++ b/sound/soc/img/img-i2s-in.c
@@ -343,10 +343,8 @@ static int img_i2s_in_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	chan_control_mask = IMG_I2S_IN_CH_CTL_CLK_TRANS_MASK;
 
 	ret = pm_runtime_get_sync(i2s->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(i2s->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	for (i = 0; i < i2s->active_channels; i++)
 		img_i2s_in_ch_disable(i2s, i);
-- 
2.31.1

