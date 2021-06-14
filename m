Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFF03A6F89
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbhFNT4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:56:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235431AbhFNT4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:56:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8061961166;
        Mon, 14 Jun 2021 19:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623700478;
        bh=pAy8hb0JREvJmAqiUmn7CzdeFDCPGZ+DIr+aVZz2BEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ju/HX5vV8IwE5JqhLjIaobzhNplWVaQZ+HEflYqDGIL2BDa9doZ0uyM3HQevv/xob
         9pdcpF1fBe7pwIefHfCai8Fvr+xmPdrc635Xo/cmoJ8jqkBpMF1Ke73TstfbUWRV0x
         yyfrCWNkafzeiMWSSCSNNCTCRKsJtGDicbJ9BIN3IICbnaL9QpCL2bi/tXSZpWd0AS
         nF4NXQ/w/QpG2MFbaSJ26SuMvwJiZ5raOOx5tOMmvW1kSuFox2kGGeyFsyXQT//lr7
         pOPg8fevxDEkVK9GayZT3xI+4vOx1/7JfNk0P9TCVpu20ui82MR+W3GgqBEmK1J4bA
         uA+UgpEqxX2bA==
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sander Vanheule <sander@svanheule.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Adrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 0/2] Clause-22/Clause-45 MDIO regmap support fixups
Date:   Mon, 14 Jun 2021 20:53:38 +0100
Message-Id: <162370010329.40759.11124251694693409838.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1623244066.git.sander@svanheule.net>
References: <cover.1623244066.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021 15:10:02 +0200, Sander Vanheule wrote:
> A proposed patch to make C22 access more strict [1], was posted in reply to an
> RFC series which also added C45 register access [2]. It appears that as a
> result, the original RFC patches got merged instead.
> 
> Access functions are corrected to return -ENXIO, instead of silently ignoring
> any invalid high bits in the register offset.
> Additionally, a warning about a discarded const qualifier is fixed.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/2] regmap: mdio: Fix regmap_bus pointer constness
      commit: ce62df2290bb86b39f826a835d6060bc3b43dae7
[2/2] regmap: mdio: Reject invalid addresses
      commit: 0df0240946b1ffbe852fa302c04c0d322229c9ce

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
