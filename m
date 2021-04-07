Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7D33575FB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349423AbhDGU1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:27:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356310AbhDGU06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:26:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 507516100A;
        Wed,  7 Apr 2021 20:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617827208;
        bh=4XfeJk66eQSMa2rKurHsDyJBMwgllEefbptPpEFUsjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sMFtJcImqn5uuRWjzhKCc6apO3r+g24/MtOnMFnfXtzYbbDwMYcQb3SIH4IKAzbBr
         33rVHMig8StPzorXPMGrgMULgHlvv8JVxcO3857237DGDpYWRTgPcul6X7uz6Scphu
         cYK2wPvg/nMnFhNPMUDmyczcwxqhRKpCbh8KHADt/P9vRBnC2aVkWsneydE2rbYUQp
         GnvZw9gPYhp02/tiD5QKmEHfHGcCoKpC81cNUBck8Bgo64BSwTqCBtQulZoaop9nZp
         i5QZOYMqmZHlkbEuxeYTvIWYZ67oEmLLgzAjdEHLil3JiUc2ODWxZH0LJvgDlQnfoY
         3TxuZfLtE7X4A==
From:   Mark Brown <broonie@kernel.org>
To:     Colin King <colin.king@canonical.com>,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH][next] regmap-irq: Fix dereference of a potentially null d->virt_buf
Date:   Wed,  7 Apr 2021 21:26:20 +0100
Message-Id: <161782707594.42848.5982836082039966334.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210406164002.430221-1-colin.king@canonical.com>
References: <20210406164002.430221-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Apr 2021 17:40:02 +0100, Colin King wrote:
> The clean up of struct d can potentiallly index into a null array
> d->virt_buf causing errorenous pointer dereferencing issues on
> kfree calls.  Fix this by adding a null check on d->virt_buf before
> attempting to traverse the array to kfree the objects.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap-irq: Fix dereference of a potentially null d->virt_buf
      commit: 14e13b1ce92ea278fc0d7bb95b340b46cff624ab

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
