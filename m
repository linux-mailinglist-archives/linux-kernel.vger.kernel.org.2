Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30FC93AA1A6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhFPQnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229673AbhFPQnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:43:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEF3761245;
        Wed, 16 Jun 2021 16:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623861700;
        bh=qPEyaPxkg8wG0vDnf/QYoDWAN6KdP/LSIw8nh2GnqrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SKUQnR6NenPhu5O7LcJuNPwJvI7hK44l6yFh4LN/JG9qZN0Xs/7XcTEeGysRrY/ls
         89aA84u6S2A/5saVnxvsZrzT+2mTC/S0aD0JBGBBtAM3NDV+fAADK9PqKU9zk8oBqS
         dXhzSHXYKxBPLQvwngtnf3qSvnGwdq5XyBc9/7JdiGicp/EOL7K1zRJ0FHkbgf2J67
         6rQwyNoEDAlANTQpWmY4np+SKUg+qJUzjurZJx+PbegOOtlJF6YjQtasUqyXc60zMI
         3+s+L11SvRgUCIXtlQDYFNSsrsbcEnyfE1kM7lrFKSqux8vkjmZUAkx+qtFQP63+Qi
         kybspVMbvJU1Q==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: rt6160: Fix setting suspend voltage
Date:   Wed, 16 Jun 2021 17:41:11 +0100
Message-Id: <162386032647.25898.374749192959767842.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210616011816.3479406-1-axel.lin@ingics.com>
References: <20210616011816.3479406-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 09:18:16 +0800, Axel Lin wrote:
> The vsel active level is for the normal voltage, the opposite level is
> the suspend voltage.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rt6160: Fix setting suspend voltage
      commit: 512d895664a318d57de0ca3655d2bf1c280767a0

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
