Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E6E38E601
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhEXMBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232730AbhEXMBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:01:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A88B61289;
        Mon, 24 May 2021 12:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621857613;
        bh=hQrOAS4aGOcOABl9F8WBQyICvVJ3wIvpsZJU9IrjWKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=exxIRD3mHEMJU5ZQ58B7nd9XIRVlOYJYwVNV5VDK4WdiYr8vBiKFu5tW6wbOOVe4K
         pesWH7g/HDjGr5SMSqfGTge5BJ0squVksW7sSPylMivekzf7Mk98CBi3i8BcIfLBzu
         b5ZQtnaaICAx5qKIJoDS/guh03nCItYqi7ZARWgU3zwqH1FTLn2K101LDCuATSKmKV
         6+K9xbznsw9DQJMvDAQxlIht7lI/IMsD91GR2CRDvMWI4DDazTL4yi13rNLP7tAFI2
         zmRxECBBdo0A0Y5vhNM8TV32LJ8w8romyf8sFqPjhgYFLsMMRutzl5pGP4bKBYf1rE
         n6x/T9G6gz6Aw==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-power@fi.rohmeurope.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] regulator: bd70528: Fix off-by-one for buck123 .n_voltages setting
Date:   Mon, 24 May 2021 12:59:50 +0100
Message-Id: <162185754506.49496.15880289485799578744.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210523071045.2168904-1-axel.lin@ingics.com>
References: <20210523071045.2168904-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 May 2021 15:10:44 +0800, Axel Lin wrote:
> The valid selectors for bd70528 bucks are 0 ~ 0xf, so the .n_voltages
> should be 16 (0x10). Use 0x10 to make it consistent with BD70528_LDO_VOLTS.
> Also remove redundant defines for BD70528_BUCK_VOLTS.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: bd70528: Fix off-by-one for buck123 .n_voltages setting
      commit: 0514582a1a5b4ac1a3fd64792826d392d7ae9ddc
[2/2] regulator: bd71828: Fix .n_voltages settings
      commit: 4c668630bf8ea90a041fc69c9984486e0f56682d

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
