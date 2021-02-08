Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20A8314016
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbhBHUNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:13:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:58448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235690AbhBHSlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:41:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1F2F64E6F;
        Mon,  8 Feb 2021 18:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612809635;
        bh=7ALs6mqpwEmsTP800ZCsUHPGdJfs/sIf4APkcqdnOxw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AgbQiKd/TXtpeuqqQeXJTMbG2BcWztR5Lz+nbm5VE/ohurr8g3laR2xPMm7ui9EHn
         vM8LcwSS29oGzQa0PLVIGfb+GHhZS5RwNG9W+TK1ihAekdtQ0YsY16Yq24nHir19kq
         A4jnSoIxHLEU7FI558re9r5KMGkr80j3FNCN5lzbwf/izRLHKjGikaIpVoIzGRf0n6
         lTdUIEBqE506kcLYvzCUvdnZl23vpXJqTgT4U5kVd1dc+6u+2bdFhJUCgqbdl8ZpcL
         NKZG064snD0sbNu5kfYT3ICGw9sD7c96q6g8CYjT2FEuIp98zuBY4r+uAGl0iXZai4
         7JeJdhCXwhzUQ==
From:   Mark Brown <broonie@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        drinkcat@chromium.org, Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        srv_heupstream@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1612678457-11548-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1612678457-11548-1-git-send-email-hsin-hsiung.wang@mediatek.com>
Subject: Re: (subset) [PATCH v4 0/3] Add support for MT6315 regulator
Message-Id: <161280958330.10970.11171389385513802451.b4-ty@kernel.org>
Date:   Mon, 08 Feb 2021 18:39:43 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Feb 2021 14:14:14 +0800, Hsin-Hsiung Wang wrote:
> This patch series adds support for MediaTek PMIC MT6315 regulator driver,
> which adds MT6315 related buck voltage data to the driver.
> This series is based on below patch[1].
> 
> [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=429385
> 
> changes since v3:
> - fix the error of binding document.
> - refine the mt6315 regulator for better code quality.
> - update mt6315 regulator node in the mt8192-evb.dts.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] dt-bindings: regulator: document binding for MT6315 regulator
      commit: 977fb5b58469c1367aa075e7e913c03cba7d466f
[2/3] regulator: mt6315: Add support for MT6315 regulator
      commit: 7aa382cfe714f61b0c29f02c31d389c506b4e2ae

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
