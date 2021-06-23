Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721623B1E54
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 18:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhFWQLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 12:11:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229982AbhFWQLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 12:11:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1483611C1;
        Wed, 23 Jun 2021 16:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624464574;
        bh=Fe/lgYVdQSc/KaJO3ok3Kpjxi6Q44XBvRLAARo0KrWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=udUQbmRrNyEoqdGC76sEWbInLp+FO9Roalt2YJ6+/kV8wgev+dcoFahhJCiFA7obK
         W0ZOVdejgo7jFx60O3/k/lgm7+j+7vSb4Ld1omB2k0A/RovQYvfFX1akSU8j4JLYk8
         047lPRl5p6OhTNKWS7B+vTObOdn7nUCANci7I1xAsBQAOM2gsB+ACtxqtZ6H6wlCFU
         zgpTSFD1ifHcZIIEZUVeN98IqDdxwHotAVM/lq4O3BlMQkl4HKepNJbkiJFEp66AKO
         bVyKM8prbsIAAzjYGkhK0PsxyKSwCd7vwqRoWmaqdsS/PNKUFaPWcm82+uOphd0nuK
         Bfw5m5tz9aimg==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sergey Larin <cerg2010cerg2010@mail.ru>
Subject: Re: [PATCH] regulator: max8893: Select REGMAP_I2C to fix build error
Date:   Wed, 23 Jun 2021 17:08:53 +0100
Message-Id: <162446430310.55481.7404123200722937268.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210622141526.472175-1-axel.lin@ingics.com>
References: <20210622141526.472175-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2021 22:15:26 +0800, Axel Lin wrote:
> Fix build error if REGMAP_I2C is not set.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: max8893: Select REGMAP_I2C to fix build error
      commit: 1aeb1a72f330a0fa21610fb44769cd0e68379418

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
