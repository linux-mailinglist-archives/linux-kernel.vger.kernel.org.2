Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA1D3E494D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbhHIPzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235842AbhHIPzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:55:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1F4361051;
        Mon,  9 Aug 2021 15:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628524499;
        bh=/beiuNqmW6puIkcAFW4NOFWD2PbeHLQ7YuvfsAjXtmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V/d/GAouFH4eCxPEAF6unNhKCz5jUCGKU8VmWNiWdJTXh6376Qn3PnHqQFZez0dP0
         grOHKphPtDGbmI6/hLKD/YXxzXsfUui+PuxPD1keH3hdydRF1D7gWgP0IqFc5HMrRU
         yKJwkvjRuzSxako/9uWbxrvqrxw0kdKo61W0Y71TyB6cVesUC/ZVA3a0IJCupN2Xvy
         MNJ91YCD5grxG8t9yQSOPMBYwQahFoF1RgoFmNCzTiUprTSk9de39NBPQ9JSLOk84e
         lwiCjsxe99IzuWT/Rvu5wiNqFFLn7Bn/U1WajpfNbSoelh+hS+TYZAt3/mTLHcIHcd
         KS8KBdm+RQf3g==
From:   Mark Brown <broonie@kernel.org>
To:     jack.yu@realtek.com, geert@linux-m68k.org,
        Steve Lee <steves.lee@maximintegrated.com>, krzk@kernel.org,
        alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org,
        linux-kernel@vger.kernel.org, rf@opensource.wolfsonmicro.com,
        ckeepax@opensource.cirrus.com, dmurphy@ti.com, perex@perex.cz,
        nuno.sa@analog.com, shumingf@realtek.com, lgirdwood@gmail.com,
        tiwai@suse.com
Cc:     Mark Brown <broonie@kernel.org>, steves.lee.maxim@gmail.com,
        ryan.lee.maxim@gmail.com
Subject: Re: [PATCH v2] ASoC: max98390: Add support change dsm param name
Date:   Mon,  9 Aug 2021 16:54:35 +0100
Message-Id: <162852418087.21716.3746148896944040139.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210809142140.9293-1-steves.lee@maximintegrated.com>
References: <20210809142140.9293-1-steves.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2021 23:21:40 +0900, Steve Lee wrote:
>   In case of using different type of speaker, support
>  using different dsm parameter bin file for each amp connected.
> 
> 
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98390: Add support change dsm param name
      commit: a10facb752535c078c914b1910dd72eb2e8d584b

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
