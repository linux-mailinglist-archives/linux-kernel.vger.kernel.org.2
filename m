Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF45F387D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 18:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbhERQeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 12:34:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350746AbhERQeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 12:34:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8863A611CE;
        Tue, 18 May 2021 16:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621355563;
        bh=0UcIEE3s827wTmWGADjhAl8/9TWOigYmf+X8WRZ5/2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ql9hyvdeG0VeCFDvOv7gyhjfvkFx0ofVYOT5B44QYA9+NJlQHOh+VifgqVaR9g0IQ
         3zvg7kW0m97nxHzAXEqVffYBx6UFBha9F6NFcLUYIe9zbc3VqQ/j5kwjoUC0GCx2dB
         D/ec9CpuI3H0qaZcmIJ05Q2mu3dCjDWomIlcZuvFkGRXkALtjTxa1+/7mxkE/8qI+y
         CKVGNlIozp7y/R16YShoo9rlbTZN3KhBFZp5Qtv92JeIHPSyHHE7+yG7c1sXHPRmv2
         qzM0/hM2Caj5AxRAz83NSGx3FRm77Jt9+feRwAPx3mwjRiONaYXu73o/mMofxh6KXk
         S7//VGw+gcBUA==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Arnd Bergmann <arnd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: Re: [PATCH] ASoC: fsl: fix SND_SOC_IMX_RPMSG dependency
Date:   Tue, 18 May 2021 17:31:33 +0100
Message-Id: <162135531445.37831.11488423603905441605.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210514213118.630427-1-arnd@kernel.org>
References: <20210514213118.630427-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 23:31:14 +0200, Arnd Bergmann wrote:
> Kconfig produces a warning with SND_SOC_FSL_RPMSG=y and SND_IMX_SOC=m:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_IMX_RPMSG
>   Depends on [m]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_IMX_SOC [=m] && RPMSG [=y]
>   Selected by [y]:
>   - SND_SOC_FSL_RPMSG [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && COMMON_CLK [=y] && RPMSG [=y] && SND_IMX_SOC [=m]!=n
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: fix SND_SOC_IMX_RPMSG dependency
      commit: cdf112d4c65f83065793b73b49363123517fdb71

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
