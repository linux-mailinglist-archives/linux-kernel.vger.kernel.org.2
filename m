Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B967836731F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245462AbhDUTFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245426AbhDUTFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:05:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C959161460;
        Wed, 21 Apr 2021 19:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619031871;
        bh=D24DHVubd4/wjoy4vR3G76V2bPoq5gjtJRYAY8+PXaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TNv/itFOjZDVUAvBJ/uaem8kksZesASXtk0ycKnKoiYz6kdmzvcWlcQZcup5K60DJ
         FTShWrdEEJWmLM124UCN/lImExVAyGpbSIU2Pnr38WhVJwrzdAf1PFTkQLQzXasI17
         cYae/2d6f/2GztL46NDklHKazJ/JOsJL4bT6oEGEd3HBnJA/c6GgBBxdRjVjJ3aO58
         UZTo6rI53p/n/dMhlRzw4uUO7+bUr/tOcpUVnbFkBvxaeOVSLjnY81Pn5XRfuGaGCS
         s8jSmFe//BQ6sFKjVXvTXGPDHjPkGOxhWlBBApZ+dbBfaVZKyoDn033hBVB1cT3CMh
         0orXt3IBGWc+g==
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH V3] regulator: da9121: automotive variants identity fix
Date:   Wed, 21 Apr 2021 20:03:33 +0100
Message-Id: <161903035952.13561.16363531324449448954.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210421120306.DB5B880007F@slsrvapps-01.diasemi.com>
References: <20210421120306.DB5B880007F@slsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021 12:03:06 +0000, Adam Ward wrote:
> This patch fixes identification of DA913x parts by the DA9121 driver,
> where a lack of clarity lead to implementation on the basis that variant
> IDs were to be identical to the equivalent rated non-automotive parts.
> 
> There is a new emphasis on the DT identity to cope with overlap in these
> ID's - this is not considered to be problematic, because projects would
> be exclusively using automotive or consumer grade parts.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: da9121: automotive variants identity fix
      commit: 013592be146a10d3567c0062cd1416faab060704

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
