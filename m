Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E4834D8B9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhC2T7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:59:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231938AbhC2T6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:58:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8856E61976;
        Mon, 29 Mar 2021 19:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617047917;
        bh=O4yG+QcLTsHGlbXDAjCrViOg6xBSlg1/SH28druab+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ci58Obfs1vK49MmrrP1rL5Z6S5bF8mw2eDAy6QJAAgNPZ3rfGiM4ZXsDiIu5DxzH8
         btHm9uHgeDDfnPVf/l+2yvXhZDbiSXB469JdFUnjV07UFsToMYo7TmuVz/2CwCSJsR
         S2l7Eeg7V3e2ZM7pZaNyIzm/kk4KLilGB6jQiGNd3ovdofpmP0eLExBCGj+FUv/3tE
         oTN7JKo+wv2JRvGaA+qSV3QXhHEIJQB8j8FXtkaGfzh8mr9SiORdtvpb2yUx6eTy4J
         hVl1MEyxnGZ2Dx6fvKX59vFKP9vf+J44nQ/nqR0zg52fXleAUBYtMRJMStBZSIl2Ui
         tY3Es/kMZYMQg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND 1/2] ASoC: amd: update spdx license for acp machine driver
Date:   Mon, 29 Mar 2021 20:58:11 +0100
Message-Id: <161704724764.10039.1962173442335521261.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1616777074-5151-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1616777074-5151-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2021 22:14:30 +0530, Vijendar Mukunda wrote:
> update SPDX license for acp machine driver.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: amd: update spdx license for acp machine driver
      commit: 23f23db29ac996a824dce2b3a800c7a002f1c480
[2/2] ASoC: amd: fix acpi dependency kernel warning
      commit: d463cead11ace05c81de31a0fb9c2507c5c1d0a2

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
