Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF8E39FBEE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhFHQJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:09:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233116AbhFHQIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:08:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D37861351;
        Tue,  8 Jun 2021 16:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623168415;
        bh=03AuqcZnBtPZV4hLSGt1SPRKJmoBCgVqX+9IPXVx/gc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DPBi0BIOGltMVWtTtp/XSiztk8mO+CcPof2HCp/VXzkusPbccn1WNzqHL+v4ZzUuL
         CbuTMxOGsUwciDC1ZRi/xVXEDDiEBBP22I3dfUQs6L3IfdGzK+9W6cxMRsX3ek4NY2
         QTTsz/Xkamy0MHM3V0yzrZOOrRHMhCBS/U5ZITQKCpiXaaaJmtOd4KCRUOblgb8Cl1
         Vtis6ETudyn+Jrgd0aPkvjoqfcVArONeXAU6O9eKT4DBZVKOxSGejmjE9FZK2DUH1n
         uvPCcflT66iRomqTRN00cXRZCuhb6KsuJBHO/07Uvi4sfbmvcI+DDtj7wiF+Juois1
         eJYHcy9B5vboQ==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bernhard Walle <bernhard@bwalle.de>
Subject: Re: [PATCH] regulator: ltc3589: Convert to use regulator_set_ramp_delay_regmap
Date:   Tue,  8 Jun 2021 17:06:31 +0100
Message-Id: <162316831089.28178.15032318216112142946.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210604115803.1260976-1-axel.lin@ingics.com>
References: <20210604115803.1260976-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021 19:58:03 +0800, Axel Lin wrote:
> Use regulator_set_ramp_delay_regmap instead of open-coded
> 
> LTC3589_LINEAR_REG() no longer call LTC3589_REG() now.
> Only LTC3589_LINEAR_REG() needs to set go_bit, thus remove go_bit
> parameter from LTC3589_REG() macro.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: ltc3589: Convert to use regulator_set_ramp_delay_regmap
      commit: ba6622c43381e7045f8bc5438089ae53054fdf83

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
