Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F3740C834
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 17:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbhIOPYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 11:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238112AbhIOPX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 11:23:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E12F660698;
        Wed, 15 Sep 2021 15:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631719359;
        bh=Iq2sTH/qaofQ6nEZPTBwlq8y5cvB7EpizEHayA1L/JY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PTwW6egGz/krolNSjeCL+AgsNjdoBFmMRI+WQ8GmJtH74J72fj1fmYOo6mSD627UR
         nyYIL7CdMwRnym8fr22qINBSlyUA+KkJPZT2mJU3WygeFvyDRx/g2ZNwRloJNXA9cW
         G1eBZ/TwOKEyLxFuAFF+SUr76xEZ3+cg7BmTchohgbh7c3guN7dlQKrkuQnYVQeuTm
         KmxKbdfWX4ytnwS1ewyGXBeRG0mTNqOKlYwt/A0fCvguNpNXH04PnddbO+pjUKEITQ
         spSYwmlxzc9JwzPpOEGqBuKrOe7pR9nhK7NN2Wrtcf0I8vW91NswKocU25+fvRWtaX
         vz35CvADgDDVw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bixuan Cui <cuibixuan@huawei.com>,
        linux-mediatek@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, tiwai@suse.com,
        trevor.wu@mediatek.com, lgirdwood@gmail.com, perex@perex.cz
Subject: Re: [PATCH -next] ASoC: mediatek: mt8195: Add missing of_node_put()
Date:   Wed, 15 Sep 2021 16:21:44 +0100
Message-Id: <163171901942.9674.2137516879503383986.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210911081246.33867-1-cuibixuan@huawei.com>
References: <20210911081246.33867-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2021 16:12:46 +0800, Bixuan Cui wrote:
> The platform_node is returned by of_parse_phandle() should have
> of_node_put() before return.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: Add missing of_node_put()
      commit: b2fc2c92d2fd34d93268f677e514936f50dd6b5c

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
