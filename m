Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA9339AA3E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFCSoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCSoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:44:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A6E9613E3;
        Thu,  3 Jun 2021 18:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622745745;
        bh=/FHJvO8AWeZGPPyB+wb1dq5hZadP+DK3x922frAjmdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=deNFq0LQ34ty0Iq53P58Cq23sv2bEFwPA4DZA2zzou2IjCYLrwjlaTTdiBzhVkn0j
         pxKQpxH/as+KkC2pGj0p7NHDcwyd4ZIoWy4PK7Ne5gkSf8AZdgRspDaZgtmydp0Zk/
         J8rUkSoMy3RFT7THzuh9a0jPTh3NpdOib0ajPe1yK0Si4kjzGS6W7C9EGNPQ0zR8lu
         Culq6iMjhpg4JCWF9JhM0f6DzF4JuTTXmovpfIkjkqIg04frAgBz5uaa2OmeDTT3QL
         Vgw/rMY/E1b/ccxRUVmPepzap3Jn3w5ARHBy0UxK2IHwkluFvaHgLq4KxsocOQV2yM
         XJ27u6jxc/2vw==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT] regulator: hi6421v600: Fix .vsel_mask setting
Date:   Thu,  3 Jun 2021 19:41:47 +0100
Message-Id: <162274566699.14958.7717746009565952958.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210529013236.373847-1-axel.lin@ingics.com>
References: <20210529013236.373847-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 May 2021 09:32:36 +0800, Axel Lin wrote:
> Take ldo3_voltages as example, the ARRAY_SIZE(ldo3_voltages) is 16.
> i.e. the valid selector is 0 ~ 0xF.
> But in current code the vsel_mask is "(1 << 15) - 1", i.e. 0x7FFF. Fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: hi6421v600: Fix .vsel_mask setting
      commit: 50bec7fb4cb1bcf9d387046b6dec7186590791ec

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
