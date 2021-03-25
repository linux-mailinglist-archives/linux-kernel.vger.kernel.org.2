Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6391349849
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhCYRhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230226AbhCYRha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:37:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6460E61A2A;
        Thu, 25 Mar 2021 17:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616693849;
        bh=PJ9dVJr7pQ/MariBpR/ysWqCzzmoHrXzyyOPgE1CF84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O7S/kZB93c1aJU1F+QBupLtIyCZnuk+7MVZT2MbMXeMGvCvzmDk5ML+uVkDy9z4gZ
         zqkujwYKF0Vba6jrJ6bkJrHnBKCgjlZ4xBNxC25T4Js3pD3MC71EKdhqLA0PGOH+9G
         wLQmRJsOnTikkZKwNMXT8jGOMluA4s8jfCV/IhdbyPM2H7TN37IODBkQW1t9DLGGFT
         2DYBe3sv1QE3uedC+F4TN5vc+g0R+OXEYqyyeGQXXH1ExRj6+go+f6MqGYadxvLRy3
         5afzf3f7oakStOssj1h/jAclKkVdfWKizgz5SrATRX17fW1vLNIzukFy71FKpbVgIf
         +/bt8IzqQQJXg==
From:   Mark Brown <broonie@kernel.org>
To:     guennadi.liakhovetski@linux.intel.com, tiwai@suse.com,
        perex@perex.cz, rander.wang@linux.intel.com,
        Ryan Lee <ryans.lee@maximintegrated.com>,
        pierre-louis.bossart@linux.intel.com, yong.zhi@intel.com,
        yung-chuan.liao@linux.intel.com, linux-kernel@vger.kernel.org,
        judyhsiao@google.com, kai.vehmanen@linux.intel.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, vkoul@kernel.org
Cc:     Mark Brown <broonie@kernel.org>, ryan.lee.maxim@gmail.com
Subject: Re: [PATCH 1/3] ASoC:codec:max98373: Changed amp shutdown register as volatile
Date:   Thu, 25 Mar 2021 17:37:04 +0000
Message-Id: <161669370551.41585.8831978780154143601.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210325033555.29377-1-ryans.lee@maximintegrated.com>
References: <20210325033555.29377-1-ryans.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021 20:35:53 -0700, Ryan Lee wrote:
> 0x20FF(amp global enable) register was defined as non-volatile,
> but it is not. Overheating, overcurrent can cause amp shutdown
> in hardware.
> 'regmap_write' compare register readback value before writing
> to avoid same value writing. 'regmap_read' just read cache
> not actual hardware value for the non-volatile register.
> When amp is internally shutdown by some reason, next 'AMP ON'
> command can be ignored because regmap think amp is already ON.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC:codec:max98373: Changed amp shutdown register as volatile
      commit: a23f9099ff1541f15704e96b784d3846d2a4483d
[2/3] ASoC:codec:max98373: Added 30ms turn on/off time delay
      commit: 3a27875e91fb9c29de436199d20b33f9413aea77
[3/3] ASoC:codec:max98373: Added controls for autorestart config
      commit: 7a0d884986f3693aca8a2dc4e1b31d35c508542e

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
