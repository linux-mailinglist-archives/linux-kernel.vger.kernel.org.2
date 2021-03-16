Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DD133DBF4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbhCPSCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239551AbhCPSAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:00:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18C136513F;
        Tue, 16 Mar 2021 18:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615917614;
        bh=zCkCxox1OLwnderDRZkFV/XZY0rZMifulX6TMpnOfVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jCoQowmadMlIKMs+WjcPUNyaWB5eP8tFGI5dVLJcYjQUisc3vt8hUiCkLEw+CsfUc
         CDjeasuFdJcGnQpblAZ5XZSnKnPkhdQ0vWx7cqaIRJq7oo1OW/1ThEDALIXr1jMJBv
         WBFDppUXneOrl+Y+kdmYy84ON3+5JFuGkHhvYH+rzrncBTiL3zE6IU9ZJILIH/ZJo0
         miEf64uHbn0suazLJTXu2xcrcTBFsXBm8pOkGvMjNJ8q3XD6WG4ycsIAXPniz/nQPw
         CaRmZaOj+hlE2mWljwjfkqr4HO5oA+urwooHaLPaZ/AO7McHDvsi7Verv9UVIIKl7W
         z3wdIDPMiHXSg==
From:   Mark Brown <broonie@kernel.org>
To:     ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        peter.ujfalusi@ti.com, perex@perex.cz,
        Shengjiu Wang <shengjiu.wang@nxp.com>, tiwai@suse.com,
        lgirdwood@gmail.com, gustavoars@kernel.org,
        alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8962: Relax bit clock divider searching
Date:   Tue, 16 Mar 2021 17:59:46 +0000
Message-Id: <161591744696.13544.17150512683547354902.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1614770488-12861-1-git-send-email-shengjiu.wang@nxp.com>
References: <1614770488-12861-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2021 19:21:28 +0800, Shengjiu Wang wrote:
> With S20_3LE format case, the sysclk = rate * 384,
> the bclk = rate * 20 * 2, there is no proper bclk divider
> for 384 / 40, because current condition needs exact match.
> So driver fails to configure the clocking:
> 
> wm8962 3-001a: Unsupported BCLK ratio 9
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8962: Relax bit clock divider searching
      commit: aa4890f673f9d54d3cb0ea156acfe41958ea7f08

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
