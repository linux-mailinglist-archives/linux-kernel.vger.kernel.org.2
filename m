Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B49F451C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354257AbhKPASC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:18:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:47022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351740AbhKOXlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 18:41:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9E3F6325A;
        Mon, 15 Nov 2021 23:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637019307;
        bh=phk22W087gGn63frwTpAzHA3cZd3qLIpMBGvdYs0Xec=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RhO4m2JEy6bXBHq5uUN+RwQr5vrJhwnjrRDXpp5yE2Q95vvP7n//PUXdiLZk/D8ho
         z58WraBiVj55cuW9nYycADs6GRvtTGOxiGYzCL0DLYU5RqqVU+PlIGlostQ5h1uMD9
         zAilJNmVzw/ZT8DIKE0CLQC1zflbB5dabJEM0RDbrRYbz6p4VFotOvNcggyYiLM+br
         VIPrJ11Tizw+OkLsKmdDwmmv+LliwLWNF2aZZmSoTNtUZdScQQ8B82AxQmHhkobsKI
         PgmtqvgLakhMWJyiywfnjJkkLJlO6115no0Y+4ZTzes4lnATDmlRIoW3AUDTegWpj3
         /yfEu9C3u1dfA==
From:   Mark Brown <broonie@kernel.org>
To:     yang.lee@linux.alibaba.com, perex@perex.cz, lgirdwood@gmail.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        tiwai@suse.com, srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <57a89cc31eb2312addd3c77896d7df8206aef138.1635967035.git.christophe.jaillet@wanadoo.fr>
References: <57a89cc31eb2312addd3c77896d7df8206aef138.1635967035.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: codecs: Axe some dead code in 'wcd_mbhc_adc_hs_rem_irq()'
Message-Id: <163701930557.675370.6905108518323377395.b4-ty@kernel.org>
Date:   Mon, 15 Nov 2021 23:35:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Nov 2021 20:19:27 +0100, Christophe JAILLET wrote:
> 'hphpa_on' is know to be false, so this is just dead code that should be
> removed.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Axe some dead code in 'wcd_mbhc_adc_hs_rem_irq()'
      commit: 95cead06866a95baf0f8355bba81a8142d5908cf

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
