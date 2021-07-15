Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FE03CAD72
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344692AbhGOUBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:01:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245416AbhGOT6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 15:58:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B60561167;
        Thu, 15 Jul 2021 19:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626378890;
        bh=lerGOnSYus8vIfj3B0eHBWlmQtEDko6BAArnD5ahpKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a2j9+GRBV9nnUWslh3DPNNioYvy2UxkrDMBfd50OuzarhVfs30B0NbgwDXnlviIdi
         A6mNbI7FhMcltcYrDt3AxDpH7JXWkx09u1N6Ddshb8QbBcYdUNQx9I+j3ZOiLQWq4s
         rVQyrqi6tvOHyS3CETrMomGBaqeK7P3DyH0wb5vro4DfRy3dMFUN6Uz9itY41Kif3O
         zKMCgG26pTGPUcu2e6HEwIu7Inw81WpTjPeh9br6nb23b544FY9uBmX1mA4ehn6BLc
         Yc5g6gE1sBNJJtW5f0/XAEOioXyOzcRBaG7A5JTH39YzjcFVkzh2lR0FVMmRDGzkao
         Ha4FdgbXEcCfg==
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Pelletier <plr.vincent@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6] regulator: da9063: Add support for full-current mode.
Date:   Thu, 15 Jul 2021 20:54:01 +0100
Message-Id: <162637868447.27563.13293081169063391335.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <824518e6391b783a12eba9ff0527f06607a34bfb.1626160826.git.plr.vincent@gmail.com>
References: <824518e6391b783a12eba9ff0527f06607a34bfb.1626160826.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jul 2021 07:20:31 +0000, Vincent Pelletier wrote:
> In addition to the ability of merging some power outputs, this chip has
> an overdrive mode.
> BCORE1, BCORE2 and BPRO have this ability, in which case the legal
> current draw is increased from 2 amps to 2.5 amps (at the expense of
> a quiescent current increase), and the configurable current limits
> are doubled.
> If a current higher than maximum half-current mode is requested, enable
> overdrive, and scale the current limit down.
> Symmetrically, scale the current limit up when querying a overdrive-enabled
> regulator.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: da9063: Add support for full-current mode.
      commit: 541ee8f640327f951e7039278057827322231ab0

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
