Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD428380CCD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 17:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhENPYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233732AbhENPY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:24:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 269AF61458;
        Fri, 14 May 2021 15:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621005796;
        bh=p5zqoz8w803888+pXGNwIAiyWxv42TTRebNBM9Rqzro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GBpDf/v5P9uU3MczNBadXP4klM6TBViTSsSzGF64zJ0sEVEg8hWI5//04vYv/4Z9t
         D1rwFrAvCfnQ9xCbs+hcPkY60/TJBGYFBFSeNPTRZCIwiLA4J+peE9wTz5tIt4SvIa
         0wuHlw8ZWk9VrUORGXmiMYdADjIpo93/Pl2HmT5FyxOLM/i5psTODAMT7SACbZc1VO
         9qAyjSR891GXQW6qwAj0i+cEJiody0A8cjhiOS2xCk1oOKxRX1eiq/SyPlVO03Xe8v
         7LZPUW5uai6/1pqrVXRl1S1cV4LfNYQxsPjqCAoGY2QN+98B2mp9NB646LHLvKMnXn
         v/rmm8RyagNyQ==
From:   Mark Brown <broonie@kernel.org>
To:     sathyanarayana.nujella@intel.com, brent.lu@intel.com,
        tiwai@suse.com, Zou Wei <zou_wei@huawei.com>,
        liam.r.girdwood@linux.intel.com, ranjani.sridharan@linux.intel.com,
        yang.jie@linux.intel.com, dharageswari.r@intel.com,
        kuninori.morimoto.gx@renesas.com, kai.vehmanen@linux.intel.com,
        perex@perex.cz, tzungbi@google.com, yong.zhi@intel.com,
        cezary.rojewski@intel.com, fred.oh@linux.intel.com
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: intel/boards: add missing MODULE_DEVICE_TABLE
Date:   Fri, 14 May 2021 16:22:29 +0100
Message-Id: <162100559150.50429.5814132881880654217.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1620791647-16024-1-git-send-email-zou_wei@huawei.com>
References: <1620791647-16024-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021 11:54:07 +0800, Zou Wei wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: intel/boards: add missing MODULE_DEVICE_TABLE
      commit: a75e5cdf4dd1307bb1541edbb0c008f40896644c

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
