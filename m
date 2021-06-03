Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9192539AA44
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhFCSoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:44:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230129AbhFCSoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:44:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05366613E3;
        Thu,  3 Jun 2021 18:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622745755;
        bh=/2lVcoMomY359dN1VAbK/0PvRcfNCHXPjJD7BjmQ4QY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iqUlVxV2F3jEqObyb4qDwolSRUT3TZdHKrNMLnXlMPiJaDYR1tSPrytUJE8YdKUI5
         oBZi3Cvm+FWkK0FFNAqe8rKQqxkaD7nYEM6CGeEwbTQsQv3dmUkdioj6mZAwBb7ljY
         IKHu+v93rQwjCG6HiqvmFl3RvULnrB04/bR3SHVhRF5JBL1Ar7qLucXdbjZzBnc1kX
         PkoxGGeIF4yT6K1uAmITX/vR2QYExKmY6xcuB9B4V/Lw8dPJxMOgW5ahfrssShuMSw
         eD1lAnxVerF/ZLe7Pq4SQadxHcnHzI6go7pZluTbSW/b/gqfYLMPXmdiqRh/UmDgIY
         yZqt5q3XpN6/g==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: rt4801: Fix NULL pointer dereference if priv->enable_gpios is NULL
Date:   Thu,  3 Jun 2021 19:41:51 +0100
Message-Id: <162274566701.14958.10688450781965712146.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210603094944.1114156-1-axel.lin@ingics.com>
References: <20210603094944.1114156-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 17:49:44 +0800, Axel Lin wrote:
> devm_gpiod_get_array_optional may return NULL if no GPIO was assigned.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rt4801: Fix NULL pointer dereference if priv->enable_gpios is NULL
      commit: cb2381cbecb81a8893b2d1e1af29bc2e5531df27

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
