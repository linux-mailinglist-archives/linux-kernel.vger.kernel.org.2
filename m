Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31389455088
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 23:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241352AbhKQWeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 17:34:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:41912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241317AbhKQWe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 17:34:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A10461882;
        Wed, 17 Nov 2021 22:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637188287;
        bh=jn1cqoJ3XZaDqZgqyRQKukXK0FQ0EKQh7jJIum/8OaQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hoTkBKgwg3wNI7wPETWtWKDEHpOczYSpXY7Fd7OfCnJaUCcB8havj6RGTOwsoLH90
         2jZSxxaMytPyaN2Wh7GIYQbsW7a7Jrrpq4Z5ckeblOBBiaua2ngMNUOISCM5IVsapE
         Hkt3bv7MBSB0so6oKFS1OQswjxfsPUx4jZPoK+MQiMRQeUoGUwKLbIqhqoJYXw4t2Y
         ITEgt9B4ELBvXWLwnovHZW/TiBIQZiCv1B7Imrjr9Zcx+Zo4vBMKA1FMnXao9feAfF
         AbLz8UFBxVi9O46VMrpU9ujlPm0QQaFoq8n6PzMaZmC7eryaQ27NJ2j9QW/lSChkdY
         wV5NXrh5OD5ww==
From:   Mark Brown <broonie@kernel.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        Olivier Moysan <olivier.moysan@st.com>,
        linux-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20211117110031.19345-1-olivier.moysan@foss.st.com>
References: <20211117110031.19345-1-olivier.moysan@foss.st.com>
Subject: Re: [PATCH] ASoC: stm32: sai: increase channels_max limit
Message-Id: <163718828521.136850.8228648734064724171.b4-ty@kernel.org>
Date:   Wed, 17 Nov 2021 22:31:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 12:00:31 +0100, Olivier Moysan wrote:
> From: Olivier Moysan <olivier.moysan@st.com>
> 
> The SAI peripheral supports up to 16 channels in TDM mode (8L+8R).
> The driver currently supports TDM over two channels.
> Increase SAI DAI playback/record channels_max,
> to also allow up to 16 channels in TDM mode.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: stm32: sai: increase channels_max limit
      commit: 7fabe7fed182498cac568100d8e28d4b95f8a80e

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
