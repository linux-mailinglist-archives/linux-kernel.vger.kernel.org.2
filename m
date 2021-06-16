Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD7C3AA1A7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhFPQnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229709AbhFPQnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:43:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CB5261019;
        Wed, 16 Jun 2021 16:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623861703;
        bh=JpusAiLtV76/8dDpsQUyhfDUJpm/FbwXfOq+f1NroZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aYBQBc78r9FmMLTEUjLUxm0sQbfVhfsFAhqyFQBa2v14UKtdTJxybyD7NC747o4/c
         UZmhOuOuzgOGsqbQx1Pi4Iiu2GT5vo+qOhyBiUf0tIIcMF0UKOOtm0hV4YGT5dF+g7
         KOUzxSHmYichjsyr2eSe0x9SWiFzwB2jteZvivRVAmTx/xmYSWcNMcmsvEa1FkChPH
         cacv97HUUC8zGcgzGfqNFvOHTPSaybS9onN+xQvve+SQJaQbhc5+sMBuIHvgqYt7d6
         +q8JG6buIPiARWFGT/DzNCjooG9o9OLlwvyfS+QB2Qm6xJreD3kwfIM1jXKudTyMZ+
         sUtwi7oNWM0NA==
From:   Mark Brown <broonie@kernel.org>
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] regulator: fixed: use dev_err_probe for gpio
Date:   Wed, 16 Jun 2021 17:41:12 +0100
Message-Id: <162386032647.25898.14083468115761592388.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210616125331.153414-1-r.czerwinski@pengutronix.de>
References: <20210616125331.153414-1-r.czerwinski@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 14:53:31 +0200, Rouven Czerwinski wrote:
> Instead of returning the the PTR_ERR directly, use dev_err_probe which
> will also correctly set the deferred probe reason in
> /sys/kernel/debug/deferred_devices, making it easier to debug missing
> devices on the system.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: fixed: use dev_err_probe for gpio
      commit: 7740ab84c13e32002742106afd443a4ca7fe3918

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
