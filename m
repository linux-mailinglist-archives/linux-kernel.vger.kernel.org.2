Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B925B43851A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 21:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhJWUAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 16:00:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231229AbhJWUAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 16:00:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBEEA60EB2;
        Sat, 23 Oct 2021 19:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635019099;
        bh=99IoE+S3rtkEaAJVjIENuU7UYgI8UNV1pfvUekxvOZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rpJ9xDYNvUjqgjwemWQYsFu+XF4kn32bAeuiBveqfn8sYC0HLMNVbAQwUXPY+Bcfg
         mOtY1zNgxNM4ltnt6tdOcaEelPvhZFVaiGz37cO+wUa6RChQogTEezFI0VFmtpMTB/
         /qFPm6HXnqzzDunG/BRAJbnYVaXMZxIhdjC6XET/GPGu9tvRfeuqLL4Ai6/62nSl/6
         RGb1+27sgfQd55BuCiKkRKcJnJgKa8IrFKQxJmeWSI15ZK/EcN6vrpQUKnaeTiMU9q
         0O/71fnVmIXz3L2hCW3zcNCbyXDUkl0R3Xzk2UBxo/VOZdZzemGibtRF0f44d9FLee
         2iVBegD2d3fgQ==
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regmap: spi: Set regmap max raw r/w from max_transfer_size
Date:   Sat, 23 Oct 2021 20:58:04 +0100
Message-Id: <163501902912.919171.17545779811673453666.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913130101.1577964-1-tanureal@opensource.cirrus.com>
References: <20210913130101.1577964-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2021 14:01:01 +0100, Lucas Tanure wrote:
> Set regmap raw read/write from spi max_transfer_size
> so regmap_raw_read/write can split the access into chunks
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: spi: Set regmap max raw r/w from max_transfer_size
      commit: f231ff38b7b23197013b437128d196710fe282da

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
