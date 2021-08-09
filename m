Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5538A3E4619
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 15:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbhHINHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 09:07:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235120AbhHINGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 09:06:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCC3B61019;
        Mon,  9 Aug 2021 13:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628514393;
        bh=CRqBoGFylYHRZ1UbXvc/U4Ue+E5qLCQBP7JZAgce/N0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQBxW0IYh7CRpz79C5+yLw6/UkgLqIqg+a3kiPEh25bvAvLGZVWPYotYt2zC/Kkpe
         PBxLyo2rMqNhxPxX7cSpqJ7UNqB+iFCP2da1J3HZHHCLBzwyViv8amP3RynYXVrZ0C
         zfDx6pi3SX8GDyeWZPFagOqqEd/y+9lT6zDdDpxKBETwBGB2kmMqliqCbvYKL3GNPe
         e3D6uCeTtOgIbR9H2tGqn24VB/GKJF/FbxBZ4bh0kh16fmmpLaUVezdM8d6UGM6GXa
         fNaw9kFw2x6Vynx2/BeIeulHYOvMuENe33pbUWaCbJyMMJDf4O/mI8JX/9dpaJpV5o
         SxIYvsDS2an5w==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, Alistair Francis <alistair@alistair23.me>,
        kernel@pengutronix.de, lee.jones@linaro.org, linux-imx@nxp.com,
        lgirdwood@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        alistair23@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v9 00/12] Add support for the silergy,sy7636a
Date:   Mon,  9 Aug 2021 14:06:06 +0100
Message-Id: <162851420625.43909.14537871976699842823.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210806091058.141-1-alistair@alistair23.me>
References: <20210806091058.141-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2021 19:10:46 +1000, Alistair Francis wrote:
> This series applied on top of the "mfd: simple-mfd-i2c: Add support for
> registering devices via MFD cells" patch. Once "mfd: simple-mfd-i2c: Add
> support for registering devices via MFD cells" is merged this series is
> ready to go.
> 
> v9:
>  - Convert to use the simple-mfd-i2c instead
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[05/12] regulator: sy7636a: Use the regmap directly
        commit: 27fdd3bbb7a13830c05b6bf777e45c392cb00f63

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
