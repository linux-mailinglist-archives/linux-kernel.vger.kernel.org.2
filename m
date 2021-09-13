Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E120640898E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 12:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbhIMK4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 06:56:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239452AbhIMK4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 06:56:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99AEF6103B;
        Mon, 13 Sep 2021 10:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631530517;
        bh=AkP0jovDemSFw2EtzAagzgwX6j/fQza8GDVZEvdK4KU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kwiRISb7qm2rF6Qf3xhnl9h2vkzcF22YRJ6DEgqXM0Jmprw1wEy0RiF2IySCSWFB8
         4feuhLfIajRQqgCnpkBoKP9VVOFLZwWfHZG+Wn6RanhDKoydLprdoKv4us5v31N6ut
         IUO+YOGpXQDts3AqW7EgXrpLy+Bw4Dntp1RVtZsn9rRf0o5hufCTbivpRQrab/RP1r
         03gjbq6TaakJulvNVbl7V+hyOn+4i7Jcjlypzu/TQd/i1Le8e922lkexi8WJLQIGNk
         bv5ku+5uD7r4D1qFAFuDaDW9UI8wIXqBFAszISN3utlBIRToRYpB5+MnWzE6CpW6gA
         k7zuQrxsr8o+w==
From:   Mark Brown <broonie@kernel.org>
To:     matthias.bgg@gmail.com, tiwai@suse.com,
        Trevor Wu <trevor.wu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] ASoC: mt8195: remove unnecessary CONFIG_PM
Date:   Mon, 13 Sep 2021 11:53:29 +0100
Message-Id: <163152996583.45703.15399781135133859191.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210902071440.6087-1-trevor.wu@mediatek.com>
References: <20210902071440.6087-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2021 15:14:40 +0800, Trevor Wu wrote:
> The unnecessary conditional inclusion caused the following warning.
> 
> >> sound/soc/mediatek/mt8195/mt8195-afe-pcm.c:3260:32: warning: unused
> >> variable 'mt8195_afe_pm_ops' [-Wunused-const-variable]
>    static const struct dev_pm_ops mt8195_afe_pm_ops = {
>                                   ^
>    1 warning generated.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mt8195: remove unnecessary CONFIG_PM
      commit: 2b9b42c847b83823527a497c323e74d2efced721

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
