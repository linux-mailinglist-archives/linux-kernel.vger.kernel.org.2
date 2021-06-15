Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E903A7DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhFOMJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:09:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230151AbhFOMI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:08:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FFD161241;
        Tue, 15 Jun 2021 12:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623758814;
        bh=2MYmjJV9kAgn72HGkFP0R9jgnz9kNJ3Xe1//XX3a8f8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WoY9S/pQjlqu+ItTrh1MNzzt7UVqQL8NVJdXc1d0E6QVoMlQ4toGCsu+CDnvoymxD
         xLs5QP+qnERBjzPdzNGWcUIVmbY7tiMzcUbZFRcaBY4Cl+4/gcKao123EfYd8RQzQY
         T3XBXqtAoW6VykGUdozFuIc8RRS84euwrgxy7k4FIorBycyp5Nhg4yAFhUY7AMvNgR
         3nDzXGRQBN1hfCeVXEOmmHQruKIrdqWuwUzHqjCD3YxRpg345T7djnrtRvLT0pXmMt
         M+NGtW5S3cnKSqjfGAeQZ73Wfj6+Iamey8658EOuHJ1VmRQkCk/yEKpr7HdrsgHoEq
         6OywpKOIBbhww==
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: fsl-sai: Add compatible string for imx8mm/8mn/8mp/8ulp
Date:   Tue, 15 Jun 2021 13:06:27 +0100
Message-Id: <162375817571.30661.11566703557624039707.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1622613770-10220-1-git-send-email-shengjiu.wang@nxp.com>
References: <1622613770-10220-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 14:02:50 +0800, Shengjiu Wang wrote:
> Add compatible string for imx8mm/8mn/8mp/8ulp, these platforms all
> support SAI IP.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: fsl-sai: Add compatible string for imx8mm/8mn/8mp/8ulp
      commit: 6f73de7da10b9476232820558fb7b3eb6bb9afe4

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
