Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E747C39AA42
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhFCSoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230128AbhFCSoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:44:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EA9E613BA;
        Thu,  3 Jun 2021 18:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622745753;
        bh=3KdWGBPvkJwUZ0r2CJ97kkuVeCB4zB3ZQdgB2okBzhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KbRTFPL3rfLaZVtxX1oDPfQnIVEsb9pZgY59BmX3i5xXNK4jE4C6yAOpdrC0RnMre
         e074+HnLYuYYczRDzhjNp/fxSCZANOAVTrPHDWt5qrtxA80dgStIW4Hrs3M/PFfeKC
         6R9reoGGJ6JfQYuAxaiOAWiT2rYrlWAvrgct31Yl70GdM5eyo37vkOjwnR3Pc9QQld
         q9T/DCymTuGxaRLjgyXQivlRvl7eB5VACO9wCugcEnAjFeDMVCB8Nax+140W/najTj
         aAvEfXmtxqdoWVW2pj7hk0wJQct6L6Gzt139ag0Q3RZQMp+cJUA5q4N6VPPqKHoOfR
         N9d6hzUPovERg==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-power@fi.rohmeurope.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: bd9576: Constify the voltage tables
Date:   Thu,  3 Jun 2021 19:41:50 +0100
Message-Id: <162274566700.14958.6483450138806989060.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210525100405.2506483-1-axel.lin@ingics.com>
References: <20210525100405.2506483-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021 18:04:05 +0800, Axel Lin wrote:
> Also use unsigned int instead of int for the voltage tables.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: bd9576: Constify the voltage tables
      commit: 6041d5fe512cd6ceaf730cdfa1786f2bc9b5b1b5

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
