Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423243312FB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhCHQJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:09:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231176AbhCHQIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:08:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD30A65229;
        Mon,  8 Mar 2021 16:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615219729;
        bh=5ZxenuEnRxfzPre9OG6r5woaetmVVzyp01P71cOUEI4=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=FlP3VA9ZKepWg5/F6l/C/wKWBfJzj9FxaAunQX3+vEqURInAj96aiv8xsqsgsq5Pv
         HeMN9+xB83ZcXUUPLp0lYWRkxIuOWiib2suX57+Ln+8qQrjNXXcDPWsecbP/awBS/G
         6W9WExFp0U7axoirXf2YZWbyHNyYwCMeMRl+jNfw6SiTKij9h+gQdN5LUs+Ry+RamR
         URb9rK9r26AscFSaWq22Y0MfMniaaXSDYY9kJcPSHpJQZjeP1YpRWpVNk2ZXAanTYV
         muiFv8kdewRqCaLhZO974KRku0L4rMOoD7XMRjYYywi8QwZBvVsFD9yK2r7ULqEztl
         fIBMwUDdUDKcQ==
From:   Mark Brown <broonie@kernel.org>
To:     festevam@gmail.com, lgirdwood@gmail.com,
        sebastian.krzyszkowiak@puri.sm, linux-kernel@vger.kernel.org,
        perex@perex.cz, ckeepax@opensource.cirrus.com,
        gustavoars@kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, tiwai@suse.com,
        kuninori.morimoto.gx@renesas.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1615170877-25918-1-git-send-email-shengjiu.wang@nxp.com>
References: <1615170877-25918-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: wm8962: Relax bit clock divider searching
Message-Id: <161521960849.9621.6433725701226320562.b4-ty@kernel.org>
Date:   Mon, 08 Mar 2021 16:06:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Mar 2021 10:34:37 +0800, Shengjiu Wang wrote:
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
      commit: 51309c5bec7cfe567a00a667adbffea444845543

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
