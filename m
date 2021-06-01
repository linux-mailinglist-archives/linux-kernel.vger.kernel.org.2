Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EA639793A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbhFARk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234628AbhFARkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:40:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FA6361378;
        Tue,  1 Jun 2021 17:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622569116;
        bh=x45p8Pz4lulkuDWSmaPxdm5VxJc3wZA9n5QPUjFBoww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DsxHV28se8k4DZBjUT+W0XPWWZLp6UJonxlA/cep9Mui+Pia32YINCMQ9xjDqPbhr
         SAuX5hYNS8O0HLAZgbq9s0CE5Oxt9HyaraUY5f8v8w0YlFElROWlGRpMRoILMd871f
         7/55Zx640owAPcWoKs+r6tZCdZTKcAGCaLjUKKL5HCohCpUA8f2Z6E2wf7vT87lYon
         2Nbaelrq+Rbu+Ga6TC8UGxQ9bSkVrOhl6ojfwmq11ChQwtTDlHEwtp1G/Anc80a22X
         eEiEXlXR1HYNve1H8nQD8ONJbd5LXzzD46yNw8IFoiIWMRXHZdy2SC5yFCB30pyWOy
         tKmJQ2dHQwfgw==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Subject: Re: [PATCH] regulator: mt6315: Don't ignore devm_regulator_register failure
Date:   Tue,  1 Jun 2021 18:38:02 +0100
Message-Id: <162256901745.20048.4899339167979215612.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210530020543.418634-1-axel.lin@ingics.com>
References: <20210530020543.418634-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 May 2021 10:05:43 +0800, Axel Lin wrote:
> Also use dev_err instead of dev_notice for messages in error conditions.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mt6315: Don't ignore devm_regulator_register failure
      commit: 7f8c8394425fd5e1449bf0a81ab6ec718cd4346b

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
