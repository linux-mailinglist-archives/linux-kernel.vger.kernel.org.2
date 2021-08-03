Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB213DF7EF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 00:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhHCWgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 18:36:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233343AbhHCWgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 18:36:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEBF560EB2;
        Tue,  3 Aug 2021 22:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628030169;
        bh=7ZowmrliWpD4r9mMVZVfwJiOH3b0Qa7K23NoQU9neoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E/HltU+PtWNn2E/y8Wu6WnV2CIgU3N+L1DtcC/t1lYVwCy5LdzLEkt/b8yv3xgnyi
         qCXegyZIyY+7nLEOGe8AjpUIS2RGyyCTAL+sNfnwlJ2EWsc/mCK3jvPehheVIitkiL
         MQB+p4d/+oIOY9U65fusoMBJhzgzwILyEbBGk7a8TdoKXZvoQg/YY0OkTsM7nt3MRa
         zHlH0NJMMTQOvQArvQ0W4tbYbG0O6LB3t+6d6NacxsOP1QNmy6ftbAa2FpwCe//HJP
         a/+4zt4kVA35aiKfAyC0BtOAGaWWv/Q/BJi9RBaNmIQjYg+mvPES1AKq2AougC8IOS
         Tz3Nv2a6Du6+g==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: sy8827n: Enable REGCACHE_FLAT
Date:   Tue,  3 Aug 2021 23:35:34 +0100
Message-Id: <162803004554.42325.10754577546880936824.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803165211.3b00db29@xhacker.debian>
References: <20210803165211.3b00db29@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2021 16:52:11 +0800, Jisheng Zhang wrote:
> Enable regmap cache to reduce i2c transactions and corresponding
> interrupts if regulator is accessed frequently. Since the register map
> is small, we use a FLAT regmap cache.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: sy8827n: Enable REGCACHE_FLAT
      commit: 6bdd1c672a2afbcd1a6d50dc2351ef4ea0bbfc61

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
