Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C4032C981
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452371AbhCDBHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:07:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:59712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379090AbhCDAzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:55:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EEDB64EBB;
        Thu,  4 Mar 2021 00:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614819314;
        bh=CrZ0LDgVarSQYHBMvLY+6qReNahMDrXe3e1rU8uL/Ig=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HMFRWOfDclSs8FrbyU1RN/2lbPp4xkyNj20DJGWDpPXL4eu5faNFoq07sOhXOQOUp
         3t4WpR3X9ikdW0+qPkzy6K9SQ5urNkdx0yKSCM8w3COVIyu9oafxLJ81yXIl2SShM8
         1jbC6wctxXcXsouiSJrR0sDwuNzAKIW0yJ3NESc+WeFB63XUkAbsQJoHEU3jxDNcO0
         HeLSHnfgIrFByRFpIYhhjB9yiKHy5ro0y9H1hhuYD2LodvwO/p6syY/oeIhEd9yF82
         BDfdBaqWy2Ft66X82cVKdpFdizNZ138PZZWFDsM4gHxOwdJO6JcuTcVc2vFv1pYHUs
         sxWtzF/Nre1yA==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Shuming Fan <shumingf@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20210303064041.898281-1-weiyongjun1@huawei.com>
References: <20210303064041.898281-1-weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] ASoC: rt1316: Fix return value check in rt1316_sdw_probe()
Message-Id: <161481924070.9553.12740264453488013918.b4-ty@kernel.org>
Date:   Thu, 04 Mar 2021 00:54:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2021 06:40:41 +0000, Wei Yongjun wrote:
> In case of error, the function devm_regmap_init_sdw() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1316: Fix return value check in rt1316_sdw_probe()
      commit: f87aec4585c3cf0853ba20637bb8c6bdd2689c46

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
