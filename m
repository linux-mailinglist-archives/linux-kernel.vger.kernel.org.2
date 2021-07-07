Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4303BED7F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 19:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhGGRz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 13:55:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230196AbhGGRzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 13:55:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EC9461CC1;
        Wed,  7 Jul 2021 17:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625680390;
        bh=4QIY8b1Mxzaig/m/1fus9m0xcXRpDY8JJoStIDqVbhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CasGi0DZBuZ8p2LPBFLNOPi7syiS56fJXu+BK7AULDJKZ0HXzrWd80uQy8Gsh/eAy
         c7qnJcOl01WhiIwC2dj/tzHJBgd3qbmL9f4DO4DS4z/Xj+XOJAAh8l4IimEDFfVmpm
         2q182yP9nvUqm8K+e3zRoypDJZuWPJSM0KkDwicyDoIOPS5QmrUA2yqlWMwziP1NRx
         q3NSQJW7qt1gJ/Z6igjc0Sfv/hvh7Kwmnx+G60W9VotsNVfBlDlVvo9enMVCnRZ1n+
         QoYduqAzyr/t//tSxoSiRlS7PYspChrVECpwDkRaJ2o19zON46HmyuLY6l0sxEkMBp
         D7hneoM6ZGemA==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Henry Chen <henryc.chen@mediatek.com>
Subject: Re: [PATCH RFT] regulator: mtk-dvfsrc: Fix wrong dev pointer for devm_regulator_register
Date:   Wed,  7 Jul 2021 18:52:33 +0100
Message-Id: <162567917758.18771.9497444375435982346.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210702142140.2678130-1-axel.lin@ingics.com>
References: <20210702142140.2678130-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jul 2021 22:21:40 +0800, Axel Lin wrote:
> If use dev->parent, the regulator_unregister will not be called when this
> driver is unloaded. Fix it by using dev instead.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mtk-dvfsrc: Fix wrong dev pointer for devm_regulator_register
      commit: ea986908ccfcc53204a03bb0841227e1b26578c4

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
