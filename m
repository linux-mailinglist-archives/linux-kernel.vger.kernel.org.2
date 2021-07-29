Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39B63DA93D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhG2QkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhG2QkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:40:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68FF760F0F;
        Thu, 29 Jul 2021 16:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627576802;
        bh=U0R/r/foYlfwkOscqf6KiXDujDojG+Hqa8VkU2XkPDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=byFuzIP5Rp1XILovz8ekfTsshsx2cxMhVG4T5m6GGxdiahyujxq7JGuNmKLCWR2vd
         Uw7n40YXQK0sBfPEQT8ZwKsK6x+sgVvdhcpMpl+P5dFW9Wc7Ms61ZsZp7Vo+/1CQni
         9/pJzSs4VvCfqjBijtSQLrdIXwUrE+rrx/zaJaccIh35yXZufiqxX4S8tHY4uIfRcB
         3fB2Y/Qli77vhFxANN0kpHCq+IKV6ZH6k8rF3SVhdkk6i2sCWD0HNUvMO/rb5dWDrw
         CbRT+wmAZX1xT8QiEgcjpJCgPpAxY4swRziXNp13x/5i+2SptChfC7C71ihOvLsW2L
         ZwRj+zfpxTYSg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Takashi Iwai <tiwai@suse.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: samsung: Constify static snd_soc_ops
Date:   Thu, 29 Jul 2021 17:39:46 +0100
Message-Id: <162757633787.53168.13521018691964426558.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210728172548.234943-1-rikard.falkeborn@gmail.com>
References: <20210728172548.234943-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2021 19:25:48 +0200, Rikard Falkeborn wrote:
> These are only assigned to the ops field in the snd_soc_dai_link struct
> which is a pointer to const struct snd_soc_ops. Make them const to allow
> the compiler to put them in read-only memory.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: samsung: Constify static snd_soc_ops
      commit: 2080acf3d18029ca52189a14b2ee462ea89c5d06

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
