Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260C838E603
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhEXMBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:01:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232781AbhEXMBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:01:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 203E361360;
        Mon, 24 May 2021 12:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621857619;
        bh=sBUVgrkJOmSl+eB1p+v03Rr1KVjGGx1yCXcdUay5zDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LlB/I1KTHqqeIc5RJ8J9yj+DIaCgymZ9XupkY9CKRbkpObZaTnjmHCbsqs8AAgoEC
         8myfjMtJOhgEC56D6kqa0Xq2aYu09ZGEiMsSKnszpQM3IPYwXfEXM5n/JH3TIsODaY
         fAx/4fUVEIkOOB+LcRyVd3bx5Jk9sbX82QkzzP6uZiJqwTFj3/GM5kiornwLaqciYt
         AKc9EhTYqf9qZHp5ino80pMnM/+iBRItNsE/BEtLAJ5Z3ztvSuhdgfpT2VAJHZHeVY
         O4fA8jNP0Emx1doe6dy0NExdos1OhJgjCCIr5RDefmZsujfI4VLYhn2UKO5KFtVJoq
         aPCUFNjTn38Vg==
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Christoph Fritz <chf.fritz@googlemail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Axel Lin <axel.lin@ingics.com>,
        linux-kernel@vger.kernel.org,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>
Subject: Re: [PATCH] regulator: bd71815: select CONFIG_ROHM_REGULATOR
Date:   Mon, 24 May 2021 12:59:52 +0100
Message-Id: <162185754505.49496.2658967792826373332.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210421135433.3505561-1-arnd@kernel.org>
References: <20210421135433.3505561-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021 15:54:27 +0200, Arnd Bergmann wrote:
> The newly added driver is missing a dependency as shown by this
> randconfig build failure:
> 
> arm-linux-gnueabi-ld: drivers/regulator/bd71815-regulator.o: in function `buck12_set_hw_dvs_levels':
> bd71815-regulator.c:(.text+0x4b6): undefined reference to `rohm_regulator_set_dvs_levels'

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: bd71815: select CONFIG_ROHM_REGULATOR
      commit: 5ba3747dbc9ade2d22a8f5bff3c928cb41d35030

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
