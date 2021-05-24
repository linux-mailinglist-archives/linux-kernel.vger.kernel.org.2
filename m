Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E4538E602
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhEXMBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:01:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232773AbhEXMBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:01:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19BFE6128D;
        Mon, 24 May 2021 12:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621857616;
        bh=tAwmj/GvmpGQ1TV1DPEgTBGRul5xsEZkIBH7367sIm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VCAV8xu/naEtqFlQZg2BIy2KXuqS0n/aqweFjoHWtal4tED6um2eIdLC2f5HGRXLX
         Pra/gJef3D6i17zApfJwLGhjXxmdMybCeVogPwc6Tcq0HTAzyfNvCuHaOCcUxgDy/f
         pwrn+EL0hB3pux1SFaXzx2A0pdKoYQAnyNfDWlBI5XnCnGOHZmtWi9J+0Hxh2vXS0D
         u/HkYsjBftEzoPSCgwRl5EgDAYAVAaG6nNIKVuOsO1/biLCwk7+fqJQczHbgpnPpNH
         OaBK5qav6wJTtA7fP9CmyqoUbxollE0NqsyPw8tGi/UTAcw4CpBye2ffjrSpzKNFc7
         Cx1zVh0lECJSg==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: max8973: Convert to use regulator_set_ramp_delay_regmap
Date:   Mon, 24 May 2021 12:59:51 +0100
Message-Id: <162185754505.49496.9813118430889654326.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210522040814.2042397-1-axel.lin@ingics.com>
References: <20210522040814.2042397-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 May 2021 12:08:14 +0800, Axel Lin wrote:
> Use regulator_set_ramp_delay_regmap instead of open-coded.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: max8973: Convert to use regulator_set_ramp_delay_regmap
      commit: 8590ccd4dfd207d89c3312cf8a8b25990acaa079

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
