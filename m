Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBCC33973C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 20:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbhCLTM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 14:12:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:51598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234124AbhCLTMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 14:12:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE78564F80;
        Fri, 12 Mar 2021 19:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615576351;
        bh=VEXP5QjEckh+DQhKUdfz0ZGBPOSPsysivMGeVwFGC+U=;
        h=From:To:Cc:Subject:Date:From;
        b=Og5u+p/hZ1gASIfdfyWgKSkXmdBIiPSB2EM4RLvqfo2NwQHOBl1U3sGPewjg4mxyC
         86KD+yldfk0xsFqtTtfCFhhsASwd7XMizd8+8xkyqVbsBH+3sdjHgoEuEvTGq0M4fp
         dwNplM9VZhLMEW0N2dF9l44Uriav4ewsfNmbjZmiTy/lobxlGplEi5bdmJN2dJo3V6
         jE+e+Wfp/vuvaKjjJHEeckOrSVdGQKr/EI6xshHpq1YqZ8mMdM4/pUV6KefyeY6GS6
         1jTmv64Idr0QWlReMgjM2ZU9WbuQ6Jnli0/IS7PpgPxdaep8VxcfPUC1Oh6zx0idlU
         GR4yS/iVbke9A==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.12-rc2
Date:   Fri, 12 Mar 2021 19:11:05 +0000
Message-Id: <20210312191230.DE78564F80@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.12-rc2

for you to fetch changes up to d450293c55005a3b0a25d209e981ac425483fead:

  regulator: mt6315: Fix off-by-one for .n_voltages (2021-03-11 13:23:21 +0000)

----------------------------------------------------------------
regulator: Fixes for v5.12

A small collection fo driver specific fixes that have arrived since the
merge window.

----------------------------------------------------------------
Axel Lin (2):
      regulator: mt6315: Return REGULATOR_MODE_INVALID for invalid mode
      regulator: mt6315: Fix off-by-one for .n_voltages

Frieder Schrempf (2):
      regulator: pca9450: Fix return value when failing to get sd-vsel GPIO
      regulator: pca9450: Clear PRESET_EN bit to fix BUCK1/2/3 voltage setting

Wei Yongjun (1):
      regulator: rt4831: Fix return value check in rt4831_regulator_probe()

satya priya (2):
      regulator: qcom-rpmh: Correct the pmic5_hfsmps515 buck
      regulator: qcom-rpmh: Use correct buck for S1C regulator

 drivers/regulator/mt6315-regulator.c    |  4 ++--
 drivers/regulator/pca9450-regulator.c   | 10 +++++++++-
 drivers/regulator/qcom-rpmh-regulator.c |  6 +++---
 drivers/regulator/rt4831-regulator.c    |  4 ++--
 include/linux/regulator/pca9450.h       |  3 +++
 5 files changed, 19 insertions(+), 8 deletions(-)
