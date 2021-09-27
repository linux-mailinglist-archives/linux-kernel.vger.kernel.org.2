Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08010419D62
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237996AbhI0Rt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237908AbhI0RtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:49:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C3A260FF2;
        Mon, 27 Sep 2021 17:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632764851;
        bh=S9lPj7S6AtX8lgkNXK2TH/P606+dWXlaJ6v6Z9fSAFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kYIzxkh3O1AON1PzqSy8BJwjZnoSXGhgyw8GrBDEmRvWBDMc8xx20gGFKic0wswfF
         K60u/4taBh4ZXRWKkUdOBWZsrDctzoXXB/ba6ra3N/NvifCxxqnGVN686hXvo1puId
         hwVMrV8vqUChDExnBkep9C8L8X0+Tqob1KDwPEZi759xHZduHQGVPBSf+EzKVhZXUv
         ACV5KUdzNfpzxZtY1NEy37N0PGQQO4SFqHhPMzNIaOHRp0f1AqIkadSsiuRs36Zrqk
         UfwQyVKDqhkjoCqQkl6AX+JWRgHYRgytWpQWUvTdoM83+aSWRD7LVcu5Q4/uCJFTqJ
         pT/kNYGhhuljg==
From:   Mark Brown <broonie@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>, heiko@sntech.de
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-rockchip@lists.infradead.org,
        Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ASoC: dmaengine: Introduce module option prealloc_buffer_size_kbytes
Date:   Mon, 27 Sep 2021 18:45:34 +0100
Message-Id: <163276442023.18200.4927438084255861267.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1632394246-59341-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1632394246-59341-1-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 18:50:46 +0800, Sugar Zhang wrote:
> Currently, The fixed 512KB prealloc buffer size is too larger for
> tiny memory kernel (such as 16MB memory). This patch adds the module
> option "prealloc_buffer_size_kbytes" to specify prealloc buffer size.
> 
> It's suitable for cards which use the generic dmaengine pcm driver
> with no config.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dmaengine: Introduce module option prealloc_buffer_size_kbytes
      commit: b0e3b0a7078d71455747025e7deee766d4d43432

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
