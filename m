Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6429541F8A6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 02:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhJBATD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 20:19:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232549AbhJBAS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 20:18:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57C8561A50;
        Sat,  2 Oct 2021 00:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633133831;
        bh=kcJKuC0wkvfILqJ9qCwz2Ct/sDna6hfeZwqpy5GIkao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hIYJ7rVWkNABVcCbGiHIsO+b18+sNtUvD/mG8R7uv9KMIdo9ntAw+DW5vJlNBaIBZ
         KZtCyzdd4AQBG9Sa/OHPAnPdZ/wycdqi+XNwgBdvBn4wQG7Bwt9exO5qs52pJd45D1
         1pPYvbmzR6b9R0Y3WAOGq76kFQnIp57D3JZZLEfNcUiEGZSLBxLai3+oCAfWT82OOY
         d5uDt+NQv/SGN2hwSDtzzLMtNJLhhnacxNmGkCh0CkbM74TZ8NDIWNzXtckzE86zSS
         IP7HNe2E7Ox07Sf/MYQbUPKI6LKvaydplKZvRaUhnZX7AVjdCs6BznzLdFqAMaOuAW
         UAY0Chk4DRLTg==
From:   Mark Brown <broonie@kernel.org>
To:     festevam@gmail.com, tiwai@suse.com, alsa-devel@alsa-project.org,
        perex@perex.cz, timur@kernel.org, Xiubo.Lee@gmail.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>, nicoleotsuka@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] ASoC: fsl_spdif: implement bypass mode from in to out
Date:   Sat,  2 Oct 2021 01:16:34 +0100
Message-Id: <163313339132.45396.13488907784155100500.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1632649760-1651-1-git-send-email-shengjiu.wang@nxp.com>
References: <1632649760-1651-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Sep 2021 17:49:20 +0800, Shengjiu Wang wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> Implement SPDIF bypass mode. It implies internal SoC
> routing of SPDIF input signal to SPDIF output signal. The
> test bed requires two boards: B1 configured in bypass mode,
> and B2 to feed B1 SPDIF RX port and read B1 SPDIF TX port:
>    B2 TX -> B1 RX,
>    B2 RX <- B1 TX.
> The test procedure:
>  a) Boot both boards
>  b) B2: start "arecord <spdifcard> -r 48kHz | aplay <local DAC>"
>  c) B2: start "aplay <spdifcard> -r 48kHz <2ch 48kHz audio file>"
>  d) B1: enable bypass mode:
> 	amixer -cimxspdif cset numid=8,iface=PCM,name='Bypass Mode' on
>  e) B2: check DAC audio, make sure the same sample rate is used at
> 	steps b) and c), in example above the rate is 48kHz.
>  f) B1: try to run "aplay" or "arecord" on imxspdif card while in
> 	bypass mode - both must fail until bypass mode is disabled
>  g) B1: disable bypass mode:
> 	amixer -cimxspdif cset numid=8,iface=PCM,name='Bypass Mode' off
>  h) B1: check the usual playback and capture on imxspdif card.
> 	During this test try to set bypass mode - must not be allowed
> 	while playback or capture is running.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: implement bypass mode from in to out
      commit: 83bea088f976a289bc2efe4e404af47ab79d6639

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
