Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6CB398FC5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 18:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhFBQTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:19:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229751AbhFBQTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:19:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FDB86161E;
        Wed,  2 Jun 2021 16:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622650648;
        bh=H32PM2qecRNYvcKFMj5jWRXRrg43aAUqm+2D/jxKv9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WcfPF7McSmUw1KIX/TI/lOH34wZWRcEz25+xcSu1iQJVGcIxs+Pjt55PF9UCdWrAK
         j+C2Au7Fov+X2vw74KTFYZ1RuVs0RchIHVkHogmQWWuLgN7MpJiPAHmtOFW+k4lpjs
         miUDN1tcCKruXMQ2Br3RAupY6MB5Nr7m7FA9RRUoSUdVQ8eJ+WqdL4gZpuX2nirUSY
         vT5Q4Jst3KJ6H1VvcIjo9rjrAWWRYLyuuw/7s6+Lt1PoK+hc8kddNkkD9L/8zx7YtF
         EgTeuu+260d6RuImszYStJW/px+77eI3eo7HSxt7JPA4m+Hp+94Haa6UdU3iNnZ2uN
         VsXdha6ieN1/A==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, yang.jie@linux.intel.com, perex@perex.cz,
        liam.r.girdwood@linux.intel.com,
        YueHaibing <yuehaibing@huawei.com>, cezary.rojewski@intel.com,
        pierre-louis.bossart@linux.intel.com
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: Intel: Skylake: use DEVICE_ATTR_RO macro
Date:   Wed,  2 Jun 2021 17:16:54 +0100
Message-Id: <162265045454.22459.4494001129448611734.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210524115506.35724-1-yuehaibing@huawei.com>
References: <20210524115506.35724-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2021 19:55:06 +0800, YueHaibing wrote:
> Use DEVICE_ATTR_RO() helper instead of plain DEVICE_ATTR(),
> which makes the code a bit shorter and easier to read.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: Skylake: use DEVICE_ATTR_RO macro
      commit: ae624a38be37e1a3127d5fa32c996e09974bb88d

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
