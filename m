Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E484538C4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 18:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239061AbhKPRvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 12:51:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:48624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231666AbhKPRvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 12:51:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FED361465;
        Tue, 16 Nov 2021 17:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637084899;
        bh=9S8Obok4VkO6PP9b543MeICB3R+R1lg4Lv5qK4BCG+c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=csT1QYII1A9SSj1BKK1YBn+/Lv+JfddMBRUjXtYLZPa44I3Vai3t2TED0eR+ld/1n
         mM4oNr9Z1vh2Yj03vrERWtlL62BDXSvctH34qHxFsoWZDCETmk1zWnpTEoLZDATKet
         O5wDsboqoqpGMZGOkWy3PHQFdQpxTwxSZUdZrWSHBOdSNoWlZe4KCHhgkg3rH/OcN2
         TXM6RTkIuWCW3kZZo/ZiITZmsfbL9yaI1WFQSfq8NI9cxH9yuqrLjsVqUKJaQgBFgk
         wtgL3qhYtPuFq2eOuintZhmyrBJL6Ph4YDd0VYA1bvCHy+8+gkUXvoWZe+I8q3+r0V
         oNZWI/cj8MZnw==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com,
        Daniel Baluta <daniel.baluta@oss.nxp.com>,
        alsa-devel@alsa-project.org
Cc:     peter.ujfalusi@linux.intel.com, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, lgirdwood@gmail.com,
        daniel.baluta@nxp.com, daniel.baluta@gmail.com
In-Reply-To: <20211116124131.46414-1-daniel.baluta@oss.nxp.com>
References: <20211116124131.46414-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH] ASoC: SOF: i.MX: simplify Kconfig
Message-Id: <163708489732.808776.5580166615449013834.b4-ty@kernel.org>
Date:   Tue, 16 Nov 2021 17:48:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 14:41:31 +0200, Daniel Baluta wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Follow the Intel example and simplify the Kconfig
> a) start from the end-product for 'select' chains
> b) use 'depends on' to filter out configurations.
> c) use snd-sof-of as a common module without any 'select'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: i.MX: simplify Kconfig
      commit: 7548a391c53cab2af0954d252cc5a9a793fd4c0e

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
