Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD45413847
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhIUR3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:29:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230304AbhIUR3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:29:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31F0861178;
        Tue, 21 Sep 2021 17:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632245263;
        bh=4wznaaP03tnFM8BprBoP3rh9QQqQF2VPJocjoL51BuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hoYNdAiUjWaLcM6M+o6RV3UthxTiD6l2HWBLV4wxKXP0t6FLMIDWHLzUK5zjDcR49
         146IGSMBJsFgRqXObuVVdrJFzchQYQJyTqIt9FmygiIWxv+hyzt9eKfw4dTvvJFwPh
         rgihGoqfwVirV+iRVABTkE//dyTC4r4+6bEcFiEb3tPt4D9lGelpxtYsUgJ7PW++N1
         rMqmP+gHEe/w2hxXQ5HXEejTUUUJlw8b2GLtcRCYS6FFRnPk8vX7moJyzKIkO5JG4F
         eeqr6eQLspvcgZTQvoucMi6RcF3EqokT0g4yniIefbkvJ/PETMnnaciKY5wq5tOQ9F
         tbZCi6aH8nuhQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, jbrunet@baylibre.com, robh+dt@kernel.org,
        stephan@gerhold.net, Sameer Pujar <spujar@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: Fix warning related to 'sound-name-prefix' binding
Date:   Tue, 21 Sep 2021 18:26:59 +0100
Message-Id: <163224493612.45861.17851911764511102643.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1632238860-16947-1-git-send-email-spujar@nvidia.com>
References: <1632238860-16947-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2021 21:11:00 +0530, Sameer Pujar wrote:
> commit 82d3ec1d89fa ("ASoC: Use schema reference for sound-name-prefix")
> added name-prefix.yaml schema and the same reference was used in couple
> of other schemas. But this is causing following warning and the same is
> fixed in current patch.
> 
>  Documentation/devicetree/bindings/sound/nxp,tfa989x.example.dt.yaml:
>  audio-codec@34: 'sound-name-prefix' does not match any of the regexes:
>  'pinctrl-[0-9]+'
>   From schema: Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
>  Documentation/devicetree/bindings/sound/nxp,tfa989x.example.dt.yaml:
>  audio-codec@36: 'sound-name-prefix' does not match any of the regexes:
>  'pinctrl-[0-9]+'
>   From schema: Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Fix warning related to 'sound-name-prefix' binding
      commit: 013148fe7f5eb420a497e35d9aa8020cdfe92eb6

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
