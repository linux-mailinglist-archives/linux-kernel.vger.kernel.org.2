Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B62935E252
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346539AbhDMPJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346521AbhDMPJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:09:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0D85613B8;
        Tue, 13 Apr 2021 15:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618326567;
        bh=+W96IuXgYD2p65bDFfeqaBI9QaBpzQ0dmecX2pIWOzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uwZWnBUvOfGce4nQHB2OtXu6CpzMmm6jw0Z79r+7L25sERwcJOSkrvZMZZNPSVMQK
         ca11Ocu4TMOsyGjulR0+FOqecBu81KG20znaVBK5phIMN1ajzZV2De0zcqeC+ttJnK
         83UN8i0EOfCQ7TPi625b5NWP/3IwGYR28bhQH3OWOi3YfWCXnCda9ira4qzjuS8TkL
         o/J3mGwRthtn2W5k+KT2g9Wc3flc2m2ygbJzXUVRnGA+rw8LaxmjJmNoSnr+3f0muj
         lumTJ6MV1s52bYRRNpsUOW1tgA1QU8mqimM2M5eLc7wXDTVg1s/ir1vRg6LK2O7QDQ
         ag8HuLURRgfIw==
From:   Mark Brown <broonie@kernel.org>
To:     david.rhodes@cirrus.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com,
        james.schulman@cirrus.com
Cc:     Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs35l35: Fix an error handling path in 'cs35l35_i2c_probe()'
Date:   Tue, 13 Apr 2021 16:08:55 +0100
Message-Id: <161832446010.49152.17792070153979808894.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <15720439769ba94ffb65c90217392b0758b08f61.1618145369.git.christophe.jaillet@wanadoo.fr>
References: <15720439769ba94ffb65c90217392b0758b08f61.1618145369.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Apr 2021 14:51:06 +0200, Christophe JAILLET wrote:
> If 'devm_regmap_init_i2c()' fails, there is no need to goto err. We should
> return directly as already done by the surrounding error handling paths.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l35: Fix an error handling path in 'cs35l35_i2c_probe()'
      commit: 38c694e98f6a6c8dfa48f2ba6f442363ed836efb

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
