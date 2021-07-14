Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A344A3C881F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 17:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239874AbhGNP7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:59:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239806AbhGNP7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:59:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B01D1613C8;
        Wed, 14 Jul 2021 15:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626278172;
        bh=wkb+Ug45CGOKkmBX3vbjlUge+7Y9qpA1VxkXxTYjeHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S010m5/mOLDeZMxppQHkfH1CsUKALnPyTDy8u7kPcqcsjKea+0+NwSVy0JVhx6+mw
         C1fkBSwrggXqTO47yVgN6jQ+GpFSOW0Nu2HOANf46MQEYWVohBhl/g/Dd6Sl1zxnhk
         KS/C5yPB+BUBzIefNNLY4EdYlm9PYFTBUmalply3D0VApmWOKloBx3VPeezU1m2278
         7UmHHdj/+TOO9gLBl8+nt39ZchhkKlTJFMU0hnfFHyQdWi4MEcITDQQwrfHCx13SkY
         YcZmcE8OWOw8LWLZstrbTPqLW3GgNxd8j0DqYPzRtIAf87XpMQx0ZilQd+PNtophJ/
         CAwFYHj0N+0nw==
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, axel.lin@ingics.com,
        cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
Subject: Re: [PATCH] regulator: rtq6752: Fix the typo for reg define and author name
Date:   Wed, 14 Jul 2021 16:55:18 +0100
Message-Id: <162627768617.55091.18440772529764739837.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1626230170-13648-1-git-send-email-u0084500@gmail.com>
References: <1626230170-13648-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 10:36:10 +0800, cy_huang wrote:
> Fix the typo for reg define and author name.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rtq6752: Fix the typo for reg define and author name
      commit: 77eac0e1ce9c61b66c15f7cc503ae848b74fe42c

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
