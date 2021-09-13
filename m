Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A83408980
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 12:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbhIMK4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 06:56:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239324AbhIMKzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 06:55:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43B4661029;
        Mon, 13 Sep 2021 10:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631530476;
        bh=Q5absrfI8fHZmSEfHakac+PXQAsMu32YZoq5qrmLeys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UDOepgP+ODy7eZvGNENXCoQwDdGg6kheBSQPfhONr0B0b7QTw5Qz4Ocft1Ar4LYa4
         ROySD8uvn36VtEpTpVBh6gH26ysvWys/SpMQNAPfEOiS2xvd2QCX9hwjunkr1kPZEw
         HG0mS9A1jMwvwHhpQJGSptOLIL4hwAFGc6P4NA6el5Wr3no488LG+EQvM/597F9sV+
         LoL5zpNAaYzBlxPJJCWcVP6l0OPGyYbC9AAGDdCEw5wakWFjf5NUSXhLx9DuofLLh5
         UrfmBvTkepN0EO5YuQ90Fd+Zo5mfE0Jx1BE2CSNADe4QLlmSYNzeStZjnJfCzOPdfK
         GKUlC/DkInPwg==
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Chuhong Yuan <hslester96@gmail.com>,
        Gu Shengxian <gushengxian@yulong.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>, tiwai@suse.de,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: amd: acp: declare and add prefix to 'bt_uart_enable' symbol
Date:   Mon, 13 Sep 2021 11:53:15 +0100
Message-Id: <163152996585.45703.10982811041582304324.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210907184216.33067-1-pierre-louis.bossart@linux.intel.com>
References: <20210907184216.33067-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2021 13:42:14 -0500, Pierre-Louis Bossart wrote:
> Sparse reports the following warning:
> 
> sound/soc/amd/acp-pcm-dma.c:39:6: error: symbol 'bt_uart_enable' was
> not declared. Should it be static?
> 
> It's not very good practice to export such symbols that can easily
> conflict, add the acp_ prefix and add declaration in header file.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: declare and add prefix to 'bt_uart_enable' symbol
      commit: 198433023ef962b71f3d4274ca7a4c8f04e7ace1

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
