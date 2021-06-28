Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B9B3B6732
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 19:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhF1RFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 13:05:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:32914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232328AbhF1RFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 13:05:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCCD4619A0;
        Mon, 28 Jun 2021 17:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624899754;
        bh=JGmo5kWdDE8TegJUaUzYhwHSg+WSIbuVoqpGcUKEEZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=utLyHElepmirxo7pqA4pKwZGx94L0xy7CLqIjVbCSWWX/fZEH2nWQOYLfDlX3/x67
         2XzicIAGYJWujG0ufwMy71/a23Gk4AYLi9/JMB1nKfZimoJDwNcApC8U5M8QAhRBc2
         v/R2Fp0/rb3BLj7J+J7hO9TpTYDWkbFlOBUsIM+OsVJIMZFbc7PP9+5ytORBR9Io+m
         7c4FiF3QrcEzT+51tTQcF3uI5CNOpGaXP0yglF0NF4PuVjA7zZyM206dvnlYjh+HU2
         kXv+qbvjVqQTKrFcFcfZbo6lgmsteeHEshfn4BYXHfJLsmj9O32A2RsRxFBA+XwSAc
         r5ZD3N8v3cS1g==
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, axel.lin@ingics.com,
        lgirdwood@gmail.com
Subject: Re: [PATCH] regulator: rtmv20: Fix wrong mask for strobe-polarity-high
Date:   Mon, 28 Jun 2021 18:01:59 +0100
Message-Id: <162489955392.5196.5543347272155510506.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1624723112-26653-1-git-send-email-u0084500@gmail.com>
References: <1624723112-26653-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jun 2021 23:58:32 +0800, cy_huang wrote:
> Fix wrong mask for strobe-polarity-high.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rtmv20: Fix wrong mask for strobe-polarity-high
      commit: 2b6a761be079f9fa8abf3157b5679a6f38885db4

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
