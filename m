Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56BC3B1E58
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 18:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhFWQMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 12:12:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230234AbhFWQL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 12:11:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C41A611C1;
        Wed, 23 Jun 2021 16:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624464579;
        bh=YtLrmGnAHP8j0/ejjP4QnVepvZuwepgqgcLHrpPJK6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ph9f2RzaP+Dt0SKnCy84OfCu/ccbNcyIS0/MiKeBJl1QGMHNZ/kOq8kuT/AokBAp4
         3ech0vBSvPawmFgis9RSXeeTneYhqTXMvEjUvvIf09t5oEpgtYcrgeagWbY7ht5AcO
         HEFeA6mYcg4laJRuZXjGYlT0ncdKdLPWVQEKIlHTKx1JEnmUKroYZ3OFkKcm8m1Z2X
         l5JTquukrxN7g0msF5CxG/gyfJ6+cEh8v5JXuX7iGdWZsBBwJpOO80XlWey5oG/vrj
         6rRqNxglfxgPhhJbQC7MJuFIma7zrtMR9inZOvXb24sfow6qReaO8yargyhzEJqsZA
         5ba4KG0YTScrA==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: (subset) [PATCH 1/2] regulator: da9052: Ensure enough delay time for .set_voltage_time_sel
Date:   Wed, 23 Jun 2021 17:08:55 +0100
Message-Id: <162446430310.55481.6860082910855701737.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210618141412.4014912-1-axel.lin@ingics.com>
References: <20210618141412.4014912-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 22:14:11 +0800, Axel Lin wrote:
> Use DIV_ROUND_UP to prevent truncation by integer division issue.
> This ensures we return enough delay time.
> 
> Also fix returning negative value when new_sel < old_sel.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: da9052: Ensure enough delay time for .set_voltage_time_sel
      commit: a336dc8f683e5be794186b5643cd34cb28dd2c53

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
