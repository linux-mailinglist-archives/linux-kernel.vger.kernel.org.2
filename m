Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD3B3CD6BB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 16:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241101AbhGSN5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 09:57:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241054AbhGSN5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 09:57:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49DB861107;
        Mon, 19 Jul 2021 14:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626705476;
        bh=VNwdS0+8c9WbGN3K5A5MZ3wG/e+O8rjIniWqtVydlw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BOJ5IEM2OpxchkGJILvsPCVblPpGHWfvF6iEE9LzWKDgXppgK8DYn3J0OIrazAMV1
         KO33DjU9ujzMGMgn8O1d0pCLwnxom/idp2ReGECAZDTlaDT0EnmWUWPQ6YBiTmaZQ0
         x9T1lrqX/BWESBmkZLzq0Qg2K7ujXHva0XRDQaubfx8lbaFIubSIPcvuhtpiGnSltt
         n1OyEKHENrrBtmt6yiQSDy+TCYfZqZloO6u9KzxCbmRpUROVvtZFi01FYuRL4V9XZN
         vlealkPHmtxAWH4jvA8LrnDLPFWByTyYEwQ4I/g5YeUCDInnHpJE8w8jhuONL2fwFx
         1ojOJ1/igEb7Q==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Colin King <colin.king@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: Fix a couple of spelling mistakes in Kconfig
Date:   Mon, 19 Jul 2021 15:37:43 +0100
Message-Id: <162670521669.50753.17260706438616909217.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210719103429.15544-1-colin.king@canonical.com>
References: <20210719103429.15544-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2021 11:34:29 +0100, Colin King wrote:
> There are a couple of spelling mistakes in the Kconfig text. Fix them.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Fix a couple of spelling mistakes in Kconfig
      commit: f020e4d0b4016f5592d082cc3a1db430c567c4dc

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
