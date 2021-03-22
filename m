Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25644344544
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhCVNPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:15:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232812AbhCVNAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:00:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD21661606;
        Mon, 22 Mar 2021 13:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616418044;
        bh=7DYx3XTcZIDSd/Yh62FnX1RO37xiq5KQmE62rcWToq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nEmoDhtN8jwxpOLSob/NcBDmKRt+eg0Cs5GxrDvaA/y4OFpI9Hd6rrraHGFEs0HWZ
         Em9uX+hSD3jNfZLdmr97Ww6gPNPrH3+FlLdW166YC8Aa1HoBKhmNEPmSD4Vjees/Yo
         39njxZauqFxcqGwDrGbk3bykeptRgKV6yVsVwFuAU9RnzFRl9eGI6hgpKuzbwT9Haf
         PJC/F1C8s09QgQOh7GPmRkdiOahygwsNHugnRCejWCuTQ0WaXjvg9qkgDQ/5vOUnaB
         aPST73yOFyNa2GlBWb6Jduw3yYpGepWNVLp/T+YXearJrUjaT6tEh0e2gkzAAnQ1FO
         LiwWVv4ap0JLQ==
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>,
        Chuhong Yuan <hslester96@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>, shumingf@realtek.com,
        Takashi Iwai <tiwai@suse.com>, Basavaraj.Hiregoudar@amd.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>, derek.fang@realtek.com,
        Alexander.Deucher@amd.com, flove@realtek.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v5 1/2] ASoC: amd: Add support for RT5682 codec in machine driver
Date:   Mon, 22 Mar 2021 13:00:31 +0000
Message-Id: <161641797251.25992.139451453109004005.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1616118056-5506-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1616118056-5506-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 07:10:42 +0530, Vijendar Mukunda wrote:
> Add support for RT5682 codec in machine driver.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: amd: Add support for RT5682 codec in machine driver
      commit: 7e71b48f9e27e437ca523432ea285c2585a539dc

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
