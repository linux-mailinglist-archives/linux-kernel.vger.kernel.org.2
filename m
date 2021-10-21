Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAAD43633E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhJUNpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhJUNpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:45:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2AD0610EA;
        Thu, 21 Oct 2021 13:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634823781;
        bh=zyl056ujnyrpsc/A2PV4eHnsMzkvggU3ul2Xfdu4Tx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U9Ih6UYycgjtjHtrsWRKu9VZGbImRJ0k/t2oqbT/frnPaC5EBV/H/PyikwdguD3Fw
         6uGRiB7Kt8tYf/XtjIPDo4MGk7I6FDYf8KSm5K1aL4q49iOuJs+y4mkI/FHrW4I2xW
         fduLspy2Ufdp3JsZDfKY74UM5iAM6UBT/Kaa1e7Fz5e9Y57YCZ5a1azFcMiPO7Jkvn
         mx/BgJYBV6OGzFeoIDK7P9HCxyFFk0Grs5P0Xw1TGzP5Y9os4XchjHd1AfYj5GZRlQ
         vsAsamh2/NIkv07UiCXyCItrmv3y+LCxDtKtyIkZ8DqK02A4Ro1MeSflRBcvFQ6kxx
         zE1WPYD4u9Y8Q==
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] regulator: lp872x: Remove lp872x_dvs_state
Date:   Thu, 21 Oct 2021 14:42:57 +0100
Message-Id: <163482376874.1547520.6448484830004949384.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019004335.193492-1-nathan@kernel.org>
References: <20211019004335.193492-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 17:43:35 -0700, Nathan Chancellor wrote:
> After this driver was converted to gpiod, clang started warning:
> 
> vers/regulator/lp872x.c:689:57: error: implicit conversion from
> enumeration type 'enum lp872x_dvs_state' to different enumeration type
> 'enum gpiod_flags' [-Werror,-Wenum-conversion]
>         dvs->gpio = devm_gpiod_get_optional(lp->dev, "ti,dvs", pinstate);
>                     ~~~~~~~~~~~~~~~~~~~~~~~                    ^~~~~~~~
> 1 error generated.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: lp872x: Remove lp872x_dvs_state
      commit: 061514dbfb79910ef60eb40dd9fc528be3f45d62

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
