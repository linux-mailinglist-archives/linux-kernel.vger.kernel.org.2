Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1644C3C5B06
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbhGLKvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:51:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234454AbhGLKuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:50:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9393A61106;
        Mon, 12 Jul 2021 10:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626086850;
        bh=BnlJcPr+Zyi8JXurFal5bKGXE9/r4rgeDkMZY1BrBOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f54GkE7X6Zqs53ZTLbYjDPOw/jE4rqcqW2n7CfCsILVtFRmpt7oEXGJYmhBilOKQy
         5rWNjL6LnpglqNZLwgGI2lNCM831XzsQwjr6XBT3Q6sW4ZJ7bExH1A01Fk2HsFiKuC
         gI5vkCGhYqjQSCen4OcQPRN3bVj8jE0ti1fTKNhFCS1s2KHCGB/Lx84XHra5J2ufdI
         gMkpTuQM6/Em/lkOGhtOnNstYm/crNJu4exNYvuBeOrWKsaeO/70RiMNbJvIgUPDSd
         4zAE1UdNfspqpZ1qbkFlTXMWVx+vW3JL1yD1Kwbf0IRj2MJaFSEvWiX73UrPbpxbrJ
         5DWp8AT6gi4oA==
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>, robh+dt@kernel.org
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        cy_huang@richtek.com
Subject: Re: [PATCH 1/2] regulator: rtq6752: Add binding document for Richtek RTQ6752
Date:   Mon, 12 Jul 2021 11:45:53 +0100
Message-Id: <162608654080.4419.14873958641987918183.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1625845236-30285-1-git-send-email-u0084500@gmail.com>
References: <1625845236-30285-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jul 2021 23:40:35 +0800, cy_huang wrote:
> Add binding document for Richtek RTQ6752.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: rtq6752: Add binding document for Richtek RTQ6752
      commit: 526e99cf43fe3884014f9e9f2ca5d04d56007287
[2/2] regulator: rt6752: Add support for Richtek RTQ6752
      commit: f40f9409719fa092924803723b9445be13fac8fb

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
