Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4649335F8AB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352618AbhDNQHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352610AbhDNQHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:07:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92C3B611B0;
        Wed, 14 Apr 2021 16:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618416413;
        bh=L4F495iiGqUPwVJ4yGcCT0wnok09sJf0k66HFI3lKV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sMOacyPQRr8/MPuUavf2Pn/pCNUvsu2u+/soswqXFs7ti8gxsIqCrnnOGoXrr14nv
         jgVfNHTpijfPBACmIMdeaKYFNwzmmEMo8WCnVCDih1tx22iujjn1kpJwm4I+FksnDO
         FK5kUm/KWi66DUSdc2O22y1lkNbBZrml/El2kDSsFs7UQ5BW7UOoOPc/KLx+TPl+3g
         fv0tUZ3EK0aIiy/lXosQR93QlwL+U62AVQqQKxlxtrN5bPEXV/foClBEfSSMWg+0Bb
         fHXUlhALVM1v/R69olzXhN8jF1pERGrgvtDEmTjkU7wEMfFfJ5lDhCCBELe/gEUdCL
         rqyH7DfzzBThA==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, perex@perex.cz, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 -next 1/2] ASoC: ak5558: correct reset polarity
Date:   Wed, 14 Apr 2021 17:06:22 +0100
Message-Id: <161841601730.20953.3339137188444911098.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1618382024-31725-1-git-send-email-shengjiu.wang@nxp.com>
References: <1618382024-31725-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021 14:33:43 +0800, Shengjiu Wang wrote:
> Reset (aka power off) happens when the reset gpio is made active.
> The reset gpio is GPIO_ACTIVE_LOW

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: ak5558: correct reset polarity
      commit: 0b93bbc977af55fd10687f2c96c807cba95cb927
[2/2] ASoC: ak5558: change function name to ak5558_reset
      commit: 4d5d75ce2b32577afef26a233119d8ee1b764ea7

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
