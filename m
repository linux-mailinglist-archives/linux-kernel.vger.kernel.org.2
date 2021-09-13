Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F35408977
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 12:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbhIMKzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 06:55:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239227AbhIMKzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 06:55:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA44C60F12;
        Mon, 13 Sep 2021 10:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631530466;
        bh=Qxg+4e+raDTbi+DvAt577T2o4JtcGFFnqeOqZRVhwzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XJH2tc421tCz0QxRc8F9e0EvqgPJhYOc+ZyUYo/MbIwy1i+Kxyac93ebjeUwvLC5I
         FeGssxiTJalCfKLL0P5tQ58Nk3vc3bEhhKDCnYObONcr8Mnkhw0TuAO7dYjQ5CNr2k
         Ac4tKB0lNf+64i5vCylqwrPbBUrk7gu1mU8U1dAd0dpOU73mZMfSDI7T4MnLyHvSUG
         qjhGTniO/tyL0ecXqsqBpUtjE20ca1BLtSHy6W1F0ir3TGQDy5J7XTt8Hjkb61XIXl
         q6aXyGgBmJYkadlgO8IL53msjKoRqPPZV+b8DdE59LrqZ53MzxOjP6Od4PNQGCRPko
         pQ6tXaPL3rXKQ==
From:   Mark Brown <broonie@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: ti-abb: Kconfig: Add helper dependency on COMPILE_TEST
Date:   Mon, 13 Sep 2021 11:53:11 +0100
Message-Id: <163153010299.45871.13675121408659991283.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210908105738.1933-1-caihuoqing@baidu.com>
References: <20210908105738.1933-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2021 18:57:37 +0800, Cai Huoqing wrote:
> COMPILE_TEST is helpful to find compilation errors in other platform(e.g.X86).
> In this case, the support of COMPILE_TEST is added, so this module could
> be compiled in other platform(e.g.X86), without ARCH_SYNQUACER configuration.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: ti-abb: Kconfig: Add helper dependency on COMPILE_TEST
      commit: b36061c2ea5bdacf51305f8bc79f29595b343eb6

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
