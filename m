Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CE6397940
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbhFARks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:40:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234641AbhFARk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:40:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CAE561042;
        Tue,  1 Jun 2021 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622569125;
        bh=iUqKscYPjDDlLRwvidolE2TbOYvSMk74dIBMKzUZyV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uE2QdmUhC/nvAMHSnjD0Bn6InMspzBSSlYbsb+0hCnFtGTBrY2V5Xlei4+blRV7b0
         sJBxTB1OMXWJdSNDe+NXkBCEdy9pgVeJ8/8fFK+80CBFF1Wxe1uknWrBdeB91IGMM9
         x+NncMLBK2e4KNk/amUU2+BzJqNY6G+/SaifpjSp7LC4gyC5qCdhEHLnHGouACggc5
         qENbm8IgqadoTTKY2rK9PGGb1XpyeiUU5nvU+aX+dlYxAxVpqhdoyH4mOJDVAvGo/q
         rChL6i1fFjAPBNspDqIfLGCackPnMopVZPJybyvVrT3WbO/k546oMqUjAIkEPMccDX
         7EZqL8jMVd4pA==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH RFT 1/2] regulator: rtmv20: Fix .set_current_limit/.get_current_limit callbacks
Date:   Tue,  1 Jun 2021 18:38:06 +0100
Message-Id: <162256901745.20048.14057115217631222086.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210530124101.477727-1-axel.lin@ingics.com>
References: <20210530124101.477727-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 May 2021 20:41:00 +0800, Axel Lin wrote:
> Current code does not set .curr_table and .n_linear_ranges settings,
> so it cannot use the regulator_get/set_current_limit_regmap helpers.
> If we setup the curr_table, it will has 200 entries.
> Implement customized .set_current_limit/.get_current_limit callbacks
> instead.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: rtmv20: Fix .set_current_limit/.get_current_limit callbacks
      commit: 86ab21cc39e6b99b7065ab9008c90bec5dec535a
[2/2] regulator: rtmv20: Add Richtek to Kconfig text
      commit: 5f01de6ffae2b00d3795a399d8d630bdae3c8997

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
