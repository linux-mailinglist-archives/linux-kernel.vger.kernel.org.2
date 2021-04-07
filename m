Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD36356CB8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352318AbhDGMyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:54:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352531AbhDGMyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:54:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFA6B6113A;
        Wed,  7 Apr 2021 12:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617800051;
        bh=U0mMAyNl+sdHEHcL6GdFgk+/sfL/yL9+u9D6l25K8q8=;
        h=From:To:Cc:Subject:Date:From;
        b=aUQ43xIXd71QtXm9HEQDwUX7udZfAK7JNa62T3LqNhMMsqMMSEMmhOdQPAKUckZvU
         ynDLFaEC+yx64jyfT4rMcD0Kng5+tfNXnxGUVRFS9VFf02GyDmiFffhJqdwB7Uf5wu
         vrydD04nveTeK2Sl7fAKZf/+561ZerkNl2VPyn3+EsGy/UkAPmGhaxfaUzdem7GR2A
         /20IzITeUm0gWhi2tfnz8Iil1ktiMhewGSQm9VhxBJlZJ9BjW0jUA6E8d/OalEVZUO
         mCNpRimujeX68yVWlIaHvZeP/pj2trjW3g/lIA580qjCrzWUufwMWSPdxzNpP+0mYI
         LmpxSFXPr3Vfw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.12-rc6
Date:   Wed, 07 Apr 2021 13:53:41 +0100
Message-Id: <20210407125410.DFA6B6113A@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d450293c55005a3b0a25d209e981ac425483fead:

  regulator: mt6315: Fix off-by-one for .n_voltages (2021-03-11 13:23:21 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.12-rc6

for you to fetch changes up to 1deceabbdc0dd3162def1e26acb2e57a93275909:

  regulator: bd9571mwv: Convert device attribute to sysfs_emit() (2021-03-15 15:42:12 +0000)

----------------------------------------------------------------
regulator: bd9571mwv fixes for v5.12

A set of driver specific fixes here, the main one is a fix to not try to
set unsupported voltages on this device.  The other two patches clean up
the error handling and eliminate the possibility that we could overflow
the page when writing sysfs output (which AFAICT wasn't an issue but
better to be sure).

----------------------------------------------------------------
Geert Uytterhoeven (3):
      regulator: bd9571mwv: Fix AVS and DVFS voltage range
      regulator: bd9571mwv: Fix regulator name printed on registration failure
      regulator: bd9571mwv: Convert device attribute to sysfs_emit()

 drivers/regulator/bd9571mwv-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
