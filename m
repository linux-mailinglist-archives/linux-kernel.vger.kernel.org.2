Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B796039FBF1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbhFHQKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232579AbhFHQI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:08:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA11C6135A;
        Tue,  8 Jun 2021 16:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623168423;
        bh=1mKG/HfPVCwJNmMa/m6k3Wut7bwjgxwP4Ad1vG06D9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ryQWDiHLGITpQoZZovOfHgcua0wakyxOqP+MGmGRlBM17vpNXp57HveiSgaEItzej
         rNRTpo41Gj1O4Y+kYmMv4YBimJciy7oRRLkMm1Jbdf3dxr3ZHAaSNrKXHgxTBBOPzP
         virTup/JiPTimz9cWGSPsoghUdx6RrdSUC1c4isvrnCtoolflpLPuwXey3U9ILiQYT
         umDVfvaxoE6JSfvOWRR3l0EQPYI0F/ounWOMqVTGzBNIZUgNM/nYP7oMKdWHu2CfzF
         aMi3wuNNkIEhtRKK2Fc2uKaP98Mz4QsMqDy1df63RccmdTNRUpFt6TDs/wUk1BhzvX
         Wm0oWmPwzfevQ==
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sander Vanheule <sander@svanheule.net>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Clause-22/Clause-45 MDIO regmap support
Date:   Tue,  8 Jun 2021 17:06:34 +0100
Message-Id: <162316819977.49929.16768941581110259431.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1622743333.git.sander@svanheule.net>
References: <cover.1622743333.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 20:25:08 +0200, Sander Vanheule wrote:
> The initial MDIO regmap implementation only supported (or claimed to
> only support) clause-22 register access, with 5 bit register addresses.
> However, this was not enforced sufficiently, and regnum values were
> passed verbatim to the mdio bus subsystem.
> 
> These patches aim to enforce the register address width, and also add
> clause-45 support for extended address spaces. A clause-45 address is
> defined here as the composite of the device type (see MDIO_MMD_* in
> include/uapi/linux/mdio.h) and the register number, for a total width of
> 21 bit.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/2] regmap: mdio: Clean up invalid clause-22 addresses
      commit: dff404deb8493e6154ad75a62ce7c4e37ff8fccd
[2/2] regmap: mdio: Add clause-45 support
      commit: f083be9db060fbac09123d80bdffb2c001ac0e2b

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
