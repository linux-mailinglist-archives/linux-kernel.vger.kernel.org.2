Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8DB3B86DD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 18:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhF3QNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 12:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhF3QNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 12:13:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34FD261580;
        Wed, 30 Jun 2021 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625069464;
        bh=hRk1k2vA8J8z5bDFLDZg/vA+rKnE+U45Ab3oTqM80Ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vde7rzAahYduG5+0Eqq6aX0taJMht9FNIeQCHYAqmgsQYyHmi9voiPgmx3pcYu2UI
         DABHn7isAoeMX/S9Haa9/CnuMRXMUPOu/pSITrFzBQMN4mb9HilfgaW1HUJ2atBCCK
         xv3HAwWfQF3uahpmQHXDlLgxlvUlYyQW4X6sCOeiK8Q57ErpX2nAlirHka4OO6qelC
         rZ3Ow7j57oEZlYaxdMyS4bFJ0uNKLCE0Pun4T8qZoqjsf+0OWI6ws4JOw8JkhcMIBQ
         o9oi8d68ykgUHERtNOQNLaA17831LmfIy51WLkx44SPrY9qI9FzsRqTfCtSY/AlYzo
         CqZGeEhXHY0Fw==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RFT] regulator: hi6421v600: Fix getting wrong drvdata that causes boot failure
Date:   Wed, 30 Jun 2021 17:10:31 +0100
Message-Id: <162506887371.43733.11140131215302795434.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210630074246.2305166-1-axel.lin@ingics.com>
References: <20210630074246.2305166-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jun 2021 15:42:46 +0800, Axel Lin wrote:
> Since config.dev = pdev->dev.parent in current code, so
> dev_get_drvdata(rdev->dev.parent) actually returns the drvdata of the mfd
> device rather than the regulator. Fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: hi6421v600: Fix getting wrong drvdata that causes boot failure
      commit: 5db5dd5be70eaf808d9fd90174b957fc5c2912cb

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
