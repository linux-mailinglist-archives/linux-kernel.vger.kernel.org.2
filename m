Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095C4332EB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhCITID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:08:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230111AbhCITHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:07:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91DBE65230;
        Tue,  9 Mar 2021 19:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615316855;
        bh=kL8V2tIiFOJatpiuDn9iQM2rKrqezgz7PUjeotjXIWU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kaYyKoqva9Q9G6T97vdJYbuLWwR0klxD2GpP+GdiD15CJWxXN/4igYEckquHNNc7Y
         e+1RDhgaoYmHuyLD0BEUa9DOwxlBZioIhHalJg/i9ZqFIAFjcYDpDTVLOqoeXgRD3l
         NSRSaUmr76RLqxZC962zul+R/M+CiODa9lWOMqJnVuTOd/a+3QIqTYcU/M0gunCABX
         fNCz4QkOmB1xv1bwgERmG+3i/XsDJOc5IQBQbyC5oiBAKJktznOd6DVCqi0M15Cos1
         TLuNh7bCWOhuGSMuVf44B6PMQtD5f/AYzaq6wGC/NEgTORA25wds1UP4hfso4uaXE3
         i1DcXgiHQZSAQ==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Jack Yu <jack.yu@realtek.com>, Takashi Iwai <tiwai@suse.com>,
        'Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20210309131455.1883120-1-weiyongjun1@huawei.com>
References: <20210309131455.1883120-1-weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] ASoC: rt715-sdca: Remove unused including <linux/version.h>
Message-Id: <161531678411.49117.10283512358773519203.b4-ty@kernel.org>
Date:   Tue, 09 Mar 2021 19:06:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2021 13:14:55 +0000, 'Wei Yongjun wrote:
> Remove including <linux/version.h> that don't need it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt715-sdca: Remove unused including <linux/version.h>
      commit: a29ba32ac97760822a0a664d1ec521c6be8d632f

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
