Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0572441DCDF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352110AbhI3PCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:02:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352093AbhI3PBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:01:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8782B6128E;
        Thu, 30 Sep 2021 15:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633014003;
        bh=VB9orFxsY14fyJtvup9liDeJdnBFjZM5Us2Lmk4xzYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M4+8pW4m1jx70gKS7pi6oS+KPNG4A5y62nZfj3Ny1xE032tj8VKISK1Sr9Cn7I3Wy
         VKZ5sDaqCj2sGcSy9xNMb42hh1o7N1LAFn3b9Yjou4eNHz/rvdtu3hVYeTw7CVC93W
         urXhq7vOnG6FpBLTW0eIq1RWVjdDjbN7tsxo+YYzoT4+Wyw8uAApGKD4j3fWCrnUGY
         r4dk498bxjJJASiUbsfsf8kgEwv/aASN2qNGlkyJ7sc+Vx7P7D6Q84AjF1x/B5lXs2
         PyPKC+JEWIqaW1yhkqc8ZmqHQJaM2j/Ump4SxV7ITcMM57T62RkzOZYM4594anuW2Q
         QlcX3PbLgJySg==
From:   Mark Brown <broonie@kernel.org>
To:     derek.fang@realtek.com, lgirdwood@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, robh+dt@kernel.org,
        flove@realtek.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, jack.yu@realtek.com,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        shumingf@realtek.com, oder_chiou@realtek.com
Subject: Re: [PATCH] ASoC: dt-bindings: rt5682s: fix the device-tree schema errors
Date:   Thu, 30 Sep 2021 15:58:54 +0100
Message-Id: <163301248178.43045.15903836903409128227.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929130406.24325-1-derek.fang@realtek.com>
References: <20210929130406.24325-1-derek.fang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2021 21:04:06 +0800, derek.fang@realtek.com wrote:
> From: Derek Fang <derek.fang@realtek.com>
> 
> Fix the device-tree schema errors that be reported by using 'make
> dt_binding_check'.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: rt5682s: fix the device-tree schema errors
      commit: 91cf45595021bd6f6279748aa472de7fc7864084

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
