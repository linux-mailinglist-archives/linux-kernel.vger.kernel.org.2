Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D69397943
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbhFARkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:40:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234677AbhFARkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:40:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82C6261042;
        Tue,  1 Jun 2021 17:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622569130;
        bh=Xsmxi6pliJ+0XI319VNWPGayFdynnWrSCxNqFnsI1zM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YQ72IIj8L3JWpnM/iXhHY4YSRkCUONKb09JIohIQ0O2qxXQJD6JISxKxrjUviu6Ft
         GaraFajh/iSvB+L0PTQjCT0hFfdT4MMrnMVQQm/WzmgdpQvsnCfOkm//DP0RfnmUh5
         v6N1CyfiIva8vp6KT87RNAx2SB+gFMS5PTtVOa/oxc12p1D5m/tDwAfrlRSU+e0mVz
         jKdmjmm2WKuP5jEr2NfcG2TG+68esvILamaX2HU491Rd5cuZhZy78G3deyjNjKUQCI
         fU/tmhTU0bpmLgplsJfXh/a5kU+WGnlhCTfPbBKZ9+ENroZn+jOhUg4fZVq7+1Z35H
         qMblq8T7ziyjA==
From:   Mark Brown <broonie@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] ASoC: Constify snd_compress_ops
Date:   Tue,  1 Jun 2021 18:38:08 +0100
Message-Id: <162256892744.19919.16377116740112548750.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210526231013.46530-1-rikard.falkeborn@gmail.com>
References: <20210526231013.46530-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 01:10:08 +0200, Rikard Falkeborn wrote:
> The only use of the static and global snd_compress_ops structs is to
> assign their address to the compress_ops field in the
> snd_soc_component_driver struct which is a pointer to const. Make them
> const to allow the compiler to put them in read-only memory.
> 
> Rikard Falkeborn (5):
>   ASoC: cs47125: Constify static struct snd_compress_ops
>   ASoC: wm5102: Constify static struct snd_compress_ops
>   ASoC: wm5110: Constify static struct snd_compress_ops
>   ASoC: qcom: q6asm-dai: Constify static struct snd_compress_ops
>   ASoC: SOF: Intel: Constify sof_probe_compressed_ops
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: cs47125: Constify static struct snd_compress_ops
      commit: 44b9f90705bb580a9616ecd5498dd30943c1f1ce
[2/5] ASoC: wm5102: Constify static struct snd_compress_ops
      commit: b6f5d62e7afc398c375855c0d8105e5561f9fc37
[3/5] ASoC: wm5110: Constify static struct snd_compress_ops
      commit: 4127a3a541ac35360cb45909944747d61c606f0a
[4/5] ASoC: qcom: q6asm-dai: Constify static struct snd_compress_ops
      commit: a8048051d7ce2349e4cda28954ded733d6c42028
[5/5] ASoC: SOF: Intel: Constify sof_probe_compressed_ops
      commit: 7db43da8c0990bb1276d1b7b185b1b9f9be6dcbb

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
