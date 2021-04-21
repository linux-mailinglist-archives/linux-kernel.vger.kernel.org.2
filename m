Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFDE366BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241009AbhDUNG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240782AbhDUNFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:05:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9868F61460;
        Wed, 21 Apr 2021 13:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010278;
        bh=9uzdvyMr5Iexoom4fx0xeBdE1K6RagGMfhHHKFz+woM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qOrK3AGcf9UerjKHZZW5LI1lAtJvfo+jbtJMA7zCIAkiKBLlCZWzm8VWzqO21CGbs
         kX6RTtRHjY5PhFu7JQx96V7+fArrqVbh4gOK2FB969jwgfVlrkHy7LNXUVL5ve6a1p
         jM8gZuzFTHFOd3VlG+1FAyUtS7/vFkI7B5Gh+0Q4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>, Mark Brown <broonie@kernel.org>
Subject: [PATCH 078/190] Revert "ASoC: cs43130: fix a NULL pointer dereference"
Date:   Wed, 21 Apr 2021 14:59:13 +0200
Message-Id: <20210421130105.1226686-79-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a2be42f18d409213bb7e7a736e3ef6ba005115bb.

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

Cc: Kangjie Lu <kjlu@umn.edu>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/cs43130.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 80bc7c10ed75..c2b6f0ae6d57 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -2319,8 +2319,6 @@ static int cs43130_probe(struct snd_soc_component *component)
 			return ret;
 
 		cs43130->wq = create_singlethread_workqueue("cs43130_hp");
-		if (!cs43130->wq)
-			return -ENOMEM;
 		INIT_WORK(&cs43130->work, cs43130_imp_meas);
 	}
 
-- 
2.31.1

