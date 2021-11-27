Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E52E45FAFC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 02:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhK0Bfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 20:35:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55788 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351172AbhK0BdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 20:33:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53725B829B3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 01:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58888C53FAD;
        Sat, 27 Nov 2021 01:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637976592;
        bh=ZpNC2uXBWg4aE1yqjzMMzmZtkt79PHdcIC+9Ks0xsCU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XGfVPOjI52SEbgP0ABhWqMJsZSiLY+/PcBhZL5YzNftisw3AvnUveTCbyceziGGRf
         eWUu6R+0fPk7iBi5KQRV5c1BpphyMpT/7yGKIxoZwgAKYZL3WRkqSZ6q8FzY1Ze43s
         yez08Ri0mXHl7HO64O27D/86rZIzGc4PUzj3502KAfcoOYHWvPhe2rJUB+GEVI7hxs
         Zb4jxv4sImTjgFcXSoZwzZiQhqczMRdnN1gf7fr9jzvCRHUW3yAZbOjWC8z0jhCnO8
         hpkex93yFe0ybx7GLkQWjMxdPL159+QxBL56d2Zls9yKXSNiYPJurX0+zE79f+M8K2
         2NTXdbSQWhRlQ==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        David Rhodes <david.rhodes@cirrus.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com
In-Reply-To: <20211125143501.7720-1-tanureal@opensource.cirrus.com>
References: <20211125143501.7720-1-tanureal@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l41: Fix link problem
Message-Id: <163797659108.2987942.14749282669169455911.b4-ty@kernel.org>
Date:   Sat, 27 Nov 2021 01:29:51 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 14:35:01 +0000, Lucas Tanure wrote:
> Can't link I2C and SPI to the same binary, better
> to move CS35L41 to 3 modules approach.
> And instead of exposing cs35l41_reg, volatile_reg,
> readable_reg and precious_reg arrays, move
> cs35l41_regmap_i2c/spi to new module and expose it.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l41: Fix link problem
      commit: a5e0091d62abb9599d9dea505ec0e8c820001831

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
