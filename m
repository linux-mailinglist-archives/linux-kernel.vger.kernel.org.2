Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E45398FCB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 18:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhFBQUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230124AbhFBQTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:19:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3AB761940;
        Wed,  2 Jun 2021 16:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622650640;
        bh=Zo37+RknpmwdBx8dA9wXqbVKrPU4uUmppfJSnBmFG4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LdYCSFxli0WYLh6PGEzcJXE60BYhuKT1CRRmUNpZ3yK4UA/rWBQTyMhKAlS4BlfH+
         0YpmuaKfa/iU9SpFh+eGHlNxcQEbVoti3zM7RPinNA7eQ8ar8BjZ3q/LuOF75xoGkz
         pWTWrV2uodMK7CTRchTJxVafP7o5YH7ktFdwibjz/0VeTF4lAZVXciW6calCYy83XR
         jlkL7UABBHLKr1e4M126ZumxVNXk8ZtrD4GKls1aJho9so8Z10iho1o4Fk41hxIllB
         Npuqd6yTLq16Q4im1r+HbAxmeeipHNu2iDX0+aTgz4MQHmO+g8UjHN9aF+R+DUGEop
         Dncr8D+r2LW6Q==
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-power@fi.rohmeurope.com
Subject: Re: [PATCH v2] regulator: bd718x7: Fix the BUCK7 voltage setting on BD71837
Date:   Wed,  2 Jun 2021 17:16:51 +0100
Message-Id: <162265054258.22587.7755311358570811335.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <bd8c00931421fafa57e3fdf46557a83075b7cc17.1622610103.git.matti.vaittinen@fi.rohmeurope.com>
References: <bd8c00931421fafa57e3fdf46557a83075b7cc17.1622610103.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 08:45:58 +0300, Matti Vaittinen wrote:
> Changing the BD71837 voltages for other regulators except the first 4 BUCKs
> should be forbidden when the regulator is enabled. There may be out-of-spec
> voltage spikes if the voltage of these "non DVS" bucks is changed when
> enabled. This restriction was accidentally removed when the LDO voltage
> change was allowed for BD71847. (It was not noticed that the BD71837
> BUCK7 used same voltage setting function as LDOs).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: bd718x7: Fix the BUCK7 voltage setting on BD71837
      commit: bc537e65b09a05923f98a31920d1ab170e648dba

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
