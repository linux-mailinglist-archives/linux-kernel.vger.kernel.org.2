Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09384451C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355470AbhKPASX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:18:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355336AbhKOXlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 18:41:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94A8D63252;
        Mon, 15 Nov 2021 23:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637019315;
        bh=HuEl3f7lPL2y6l7FsxchqJg97/trWBdfI6HPcHSFJi4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=J4GDPsVXkBXR7bcx8trgWIQCPnDTSzCAToUNOFIj7ijj6VfH3UZJxfuw7CEUyoSoR
         4ur3yK4O6JLXc5+5YeljfRJSCKK0DEZVrYiv/M9oot4u7Ta5Zsrd0szm18Ie1f/b/H
         MEqYBd+HceCIUYP2BrGEMCmYUMxVafFw+igERDNdmwxLfI6qrIuZjFvQdCdJ9wSe56
         KDuudZcjbluKhgvodNxW39Rb+YnzhCVRjCRRtXyrEFt4ov1g6LQzsBvTa7kHpi+vY9
         Qan+Fe1xXjHIs6hlQddzPrpe9vbRo0ax5Ah4gJG+Qzmcx4s8EPZHQgqzdrpQnIrRxl
         XVaaUxbEpW5/Q==
From:   Mark Brown <broonie@kernel.org>
To:     lars@metafoo.de, perex@perex.cz, lgirdwood@gmail.com,
        tiwai@suse.com,
        =?ISO-8859-1?Q?=20Ma=C3=ADra?= Canal <maira.canal@usp.br>,
        nuno.sa@analog.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <YXWo/9o7ye9a11aR@fedora>
References: <YXWo/9o7ye9a11aR@fedora>
Subject: Re: [PATCH] ASoC: adau1701: Replace legacy gpio interface for gpiod
Message-Id: <163701931331.675370.7417859226915915721.b4-ty@kernel.org>
Date:   Mon, 15 Nov 2021 23:35:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Oct 2021 15:42:07 -0300, Maíra Canal wrote:
> Considering the current transition of the GPIO subsystem, remove all
> dependencies of the legacy GPIO interface (linux/gpio.h and linux
> /of_gpio.h) and replace it with the descriptor-based GPIO approach.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: adau1701: Replace legacy gpio interface for gpiod
      commit: 5dbec393cd23ecfdeddced217f8a1c11228139c4

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
