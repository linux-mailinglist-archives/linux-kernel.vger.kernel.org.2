Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8354598B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 01:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhKWADF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 19:03:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229672AbhKWADE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 19:03:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B742860FF2;
        Mon, 22 Nov 2021 23:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637625597;
        bh=R4inWEq2iQQrWDi7YP3Cg9zv9pdAIG3tab5qNYq/Ugg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=COvgZoc7HlJJ60EycIB0dfNuLnZzk+M4tFPKrTjncQD5K88aSvDUQxufN60ImBDu0
         3NiCGoVblqFbUnJNsrdrB3dk3VSXT51+Pb6t+XitCKYasqScRA8HYh/jK30bNH6c4m
         VCIVr4wa0zJkIfh2P5YpQ3CPx0A9WfaoSqyqQ8rRDi1t62pM3rx3plT9KoqsJXsEPf
         z1naa6EWk/WFH7bhR0IOrbleUET0YBTxG33AlHfK4/4TRuEtcvVaVtljPHAOQbE3cI
         +TSyOoeDwS7ESLxRrU8WyH5QxStCya4J4YE177YWbPiRTuE3Wk1txyh6XQSi9FRFXo
         O+SPjnDeftT0g==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
Cc:     linux-rockchip@lists.infradead.org
In-Reply-To: <20211121150521.159543-1-frattaroli.nicolas@gmail.com>
References: <20211121150521.159543-1-frattaroli.nicolas@gmail.com>
Subject: Re: [PATCH] ASoC: rk817: Add module alias for rk817-codec
Message-Id: <163762559549.2471670.593188809347574663.b4-ty@kernel.org>
Date:   Mon, 22 Nov 2021 23:59:55 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2021 16:05:20 +0100, Nicolas Frattaroli wrote:
> Without a module alias, autoloading the driver does not occurr
> when it is built as a module.
> 
> By adding a module alias, the driver now probes fine automatically
> and therefore analog audio output works as it should.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: rk817: Add module alias for rk817-codec
      commit: 428ee30a05cd1362c8aa86a4c909b0d1c6bc48a4

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
