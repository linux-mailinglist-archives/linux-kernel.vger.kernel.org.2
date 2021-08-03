Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567923DF7F2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 00:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhHCWgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 18:36:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233416AbhHCWg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 18:36:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF24360EBB;
        Tue,  3 Aug 2021 22:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628030177;
        bh=LXhoBeBzUTqbh8mDn29zpcWCz1WKAtQq4APb31gMywI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=as3eYrOEj1INmODgOgzQjzwKcBchk8y0e9ltc9kyj+McqYMklyah52uvSJzVkphfO
         LUoSTnLuEPZHVtRzlkwbj1+S1WSWo5akkJD2DDfRjM2vJgi//clAjHdaOIedmcRbfi
         0uSSgjq9uj69PV8wPZokDtpENqa1tNSAOVpcvWwbJyjJ+YNpfIOXUC/cbO3lRQrLfo
         YqA5b7lYEjagGVDC1KeG7mMK6Q/jBFdAIHMWRLTigAjzdemM2MZ5fj68ky2k2eKhHq
         dfldOI4LwqfgFkJsej4YEOVClo0+mtvpMOv2ZLy4rW3wYM+4FkYx1svp4khYxejdd6
         e4Bqvpwp7QSQw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Colin King <colin.king@canonical.com>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ASoC: rt5514: make array div static const, makes object smaller
Date:   Tue,  3 Aug 2021 23:35:37 +0100
Message-Id: <162802985540.42099.11025103485301142729.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210801064023.138359-1-colin.king@canonical.com>
References: <20210801064023.138359-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Aug 2021 07:40:23 +0100, Colin King wrote:
> Don't populate the array div on the stack but instead it
> static const. Makes the object code smaller by 48 bytes.
> 
> Before:
>    text    data     bss     dec     hex filename
>   53894   16368     128   70390   112f6 ./sound/soc/codecs/rt5514.o
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5514: make array div static const, makes object smaller
      commit: 5c8a7efc2fd5eb716c48d7d7ab4295effbc09ba3

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
