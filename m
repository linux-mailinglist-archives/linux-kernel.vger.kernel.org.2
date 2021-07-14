Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC643C8820
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 17:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbhGNP7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:59:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239842AbhGNP7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:59:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 455B6613C8;
        Wed, 14 Jul 2021 15:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626278174;
        bh=qnXD28YHQU7LtRuOJfXxRjF9c52+gT8hSD7CO6ZJDyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ona/Myj7MZMvEfnT/6NHEyxZOd7Ly9aOtTe/yREgUW8xV2ljjFwSMmZzwzE2OlZX/
         QdpPmnZo+kFeSxp5iDfQZ+EKIvS/rIItOylQP8L0e6Lh07QuaQDU72vQtgqRtkatzR
         NuMtvftOUiVg73KPb/gHt2tfFd1Q0wxAkaDiv+ddQpUx+u9CCuJh2e6qTwW4nyxZnn
         46dJnhQ5OQb6FCbnBSEc6yEzdA8yD6QAvYN3x2BldLaUjXunbGVQP1oOYbXPNuhTcg
         UT/6lLn42Kf/jB7Cryj1Hf0XP8l1l9QKUXowASnukb5RZWkOK8VuCDSL7w4tj+X7/2
         OPETpV2J8n6/Q==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, kernel test robot <lkp@intel.com>,
        lgirdwood@gmail.com
Subject: Re: [PATCH] ASoC: codecs: wcd938x: make sdw dependency explicit in Kconfig
Date:   Wed, 14 Jul 2021 16:55:19 +0100
Message-Id: <162627737185.54838.13473688985790712154.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210713140417.23693-1-srinivas.kandagatla@linaro.org>
References: <20210713140417.23693-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jul 2021 15:04:17 +0100, Srinivas Kandagatla wrote:
> currenlty wcd938x has only soundwire interface and depends on
> symbols from wcd938x soundwire module, so make this dependency
> explicit in Kconfig
> 
> Without this one of the randconfig endup setting
> CONFIG_SND_SOC_WCD938X=y
> CONFIG_SND_SOC_WCD938X_SDW=m
> resulting in some undefined reference to wcd938x_sdw* symbols.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd938x: make sdw dependency explicit in Kconfig
      commit: 9431f8df233f808baa5fcc62b520cc6503fdf022

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
