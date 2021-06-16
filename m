Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54813AA1A8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhFPQn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231178AbhFPQnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:43:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3201961351;
        Wed, 16 Jun 2021 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623861705;
        bh=lkKn+lkEJJ+ozPy0zm9VRrQFGnFLXGgS7OXbAJotx0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SNRIUDLMQlKFOGCwVuHdqbqEYl6HMv6/k+UtPXI2aRR4XVPJGkV66r2XvAkjVfiDs
         JSyg1KAi+xyZ61Q+uaj3yHWuod+SBrODBULgEXZ2oTFj3AYmUqIPu35WflfCOQ1Acr
         eoVvtao9hHxQQCNoIw9COB4i4TZaVJFm8iqWSPHB8/CFidyB73KxmG7vghMuM3QyhV
         ckODk6NHfL4QuOE4e3J384prvdc+NU57BCaUbDvzNaDlTdtS6bbRX1M8YYxqCcWKxf
         KJtoTfXMfGa38jbfsSDATP44/Kv6OZsHfl1RkjVhxaBHOTFnUFmTvncLE4u8IiSA98
         +hRt3vDAtIt1Q==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: cs42l42: Correct definition of CS42L42_ADC_PDN_MASK
Date:   Wed, 16 Jun 2021 17:41:13 +0100
Message-Id: <162386001970.25644.8882454434561067128.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210616135604.19363-1-rf@opensource.cirrus.com>
References: <20210616135604.19363-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 14:56:04 +0100, Richard Fitzgerald wrote:
> The definition of CS42L42_ADC_PDN_MASK was incorrectly defined
> as the HP_PDN bit.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: Correct definition of CS42L42_ADC_PDN_MASK
      commit: fac165f22ac947b55407cd3a60a2a9824f905235

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
