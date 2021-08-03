Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52F33DF872
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 01:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhHCXWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 19:22:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233297AbhHCXW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 19:22:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9DEE60F70;
        Tue,  3 Aug 2021 23:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628032935;
        bh=GTOm5i1eFHoZWIAtLq1pJZHY6UHGcU6XPXFTbm98e/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cj8bEyOJUkIviH1NJ3QclFfyphJQRwILTKSm3c2b5TLXM45hugfp6A7A3h6XQUw6P
         yf+TdP3Bxgd6iDmefErVAbpLy2KfVGfIDTtKg85qHtoYpTZciBGJxRTGTuW/zYuuD3
         TwF2oVrn20cEitvmEWQgs28YgN1KlqskTuJEy+cYYADGx2qgmRRqntsG2iCuRP89qu
         B7K1BCHC2isZiL8PXj1w6swkOPiYQxTCO1ebgfummAq+L4hWSTuMU5ADo+NodE8qXE
         siZnQ0DBwb9jElkkuV6e7FzBRh2Y+xRYLffJK7ghP31685BDiJ1xGJCJ6S7a/4C3/W
         VC4eOE6hikbLg==
From:   Mark Brown <broonie@kernel.org>
To:     Argus Lin <argus.lin@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: mediatek: mt6359: convert to use module_platform_driver
Date:   Wed,  4 Aug 2021 00:22:00 +0100
Message-Id: <162803121460.44131.10692737941162516565.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210531051203.228567-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210531051203.228567-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2021 14:12:03 +0900, Nobuhiro Iwamatsu wrote:
> Simplify the code by using module_platform_driver macro for
> mt6359-accdet.
> 
> 
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt6359: convert to use module_platform_driver
      commit: edcade2e5e942453f001bd7a0d31f55059cec34f

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
