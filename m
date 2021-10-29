Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E757643FED6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 16:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhJ2PBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 11:01:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhJ2PB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 11:01:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC7A661166;
        Fri, 29 Oct 2021 14:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635519540;
        bh=mJ033J2sJBsTod2JwVjQBrjrWKl9Rdn8C5KXPYMgGCE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MGB4hdZqpFevXYbJhsmebtLYANQ6zfaGiFi5czl20fTo9auFxTl49hpAGxmiLdSro
         Lc/TDdy7BTBQbbDdeuSYpWKaZlePbSGaLUfkIMg+6aNDa0+bYzFaFwx/r2ARLGd7kV
         uUy30QwZjp2iHBtUxzN3/qK425QSFki/QEn/lyU1+sD7dBawzPWQmChd9V8Z8hVJ3N
         SesVE+VZwv9awx6oGcLUNa5dzD5+80xh/43x1Idk3HbYg9wjMZ+gtZqv5E3wp5lRpI
         fhSDtxaSrbHI7FLQbKU7f0DuvX1aFDTJRC5a+995ry8H5oTgZ9Gg6UpSacHhj2LHK9
         Z2xXKYto1dzRA==
From:   Mark Brown <broonie@kernel.org>
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Julian Braha <julianbraha@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
In-Reply-To: <20211028140909.496022-1-brent.lu@intel.com>
References: <20211028140909.496022-1-brent.lu@intel.com>
Subject: Re: [PATCH v2] ASoc: Intel: glk_rt5682_max98357a: support ALC5682I-VS codec
Message-Id: <163551953757.3555751.3149323718698508108.b4-ty@kernel.org>
Date:   Fri, 29 Oct 2021 15:58:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 22:09:09 +0800, Brent Lu wrote:
> Detect the codec variant in probe function and update DAI link
> accordingly. Also add an new entry in enumeration table for machine
> driver enumeration.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: Intel: glk_rt5682_max98357a: support ALC5682I-VS codec
      commit: 88b4d77d6035dcf1182c4bf05c743e30363f3078

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
