Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5F1398FC3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 18:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhFBQTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:19:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229886AbhFBQS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:18:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F07561943;
        Wed,  2 Jun 2021 16:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622650635;
        bh=FhbwFma+7XW5ms6GmVVrgdeItW5WQW4IBP5Ox6fUieA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJ6fdcgS6U3mgVVWOXS5tmPLPSCsaYoEMiaEBZOfbKnG5StVm9jyxUEXL1zKKMQYb
         lRxQF45yZwAUt7zo/mwLrPCadiwXvi0HdGEn6SgT9Y08XBEVM/AifwLjaIYQnh6s3i
         jc41Mii5ZcPu3SlflE1Sd1ZdMfBUc6R2solgfe93ed3T/PxEjwh7pvaR2MeAnoNhwP
         fi2TkfARZIrT2NQ+IvU6XyHaKmM4LrEFj8pJaypDEysQdlc0OX/nPHIs+CYamQm/u8
         hy0hEFzpd8pnvIQebF4t22qg0bfJFwdV5U2p3T+JFKCo44frvMJuPCCetVYEM4tC/U
         lkfWOj3Hey3mg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] regulator: userspace-consumer: use DEVICE_ATTR_RO/RW macro
Date:   Wed,  2 Jun 2021 17:16:49 +0100
Message-Id: <162265054258.22587.1075010000992890819.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210602080526.11117-1-thunder.leizhen@huawei.com>
References: <20210602080526.11117-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 16:05:26 +0800, Zhen Lei wrote:
> Use DEVICE_ATTR_RO/RW macro helper instead of plain DEVICE_ATTR, which
> makes the code a bit shorter and easier to read.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: userspace-consumer: use DEVICE_ATTR_RO/RW macro
      commit: ba499a50ce5846dd6f7a6df92c1f01d4201b5cce

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
