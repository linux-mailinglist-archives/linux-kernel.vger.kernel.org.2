Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9079937A1D8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhEKI2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230338AbhEKI2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:28:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1804761107;
        Tue, 11 May 2021 08:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721637;
        bh=33gomDD/LsBo48p0ujPwB4ZMY/SnqXxbXoNeyGfnFI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bdE/vh5PnP+PAfw4nvR7MEgcOZNojCP8xPCQwpfMvSb2W5v06mjRzjofihhr+gOZv
         0+l5Jcj+3awOtJyl7DjlbbV6pYLBfs3gpuB1bLtLR7QG55jV6Va2L8FtNDvB2jBLdu
         OnFpL8QXLwRyH5mLbHk9l7PmwLlnteL/54YHPE59W39pWzFm4G4TgZSxTeiTQ0sgye
         3K8KBBh0cadamAJSWcxhhybugCKsJW+goZBuUQZJ+pWcLw7lW+scqZdgQ3ygiO8RC5
         AP9RandUf5806Rxs/va3aQgNIcxxg7E3Ecb4Vux5WapGj8am+TCEYyx9/tPHMwdrHG
         sGvFwsC2sKCog==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Guodong Xu <guodong.xu@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: hi6421v600: Remove unneeded *pmic from struct hi6421_spmi_reg_info
Date:   Tue, 11 May 2021 09:25:41 +0100
Message-Id: <162072067395.33366.7122964867023650977.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430085555.1127994-1-axel.lin@ingics.com>
References: <20210430085555.1127994-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2021 16:55:55 +0800, Axel Lin wrote:
> Use rdev->regmap instead of pmic->regmap.
> With this change, hi6421_spmi_regulator_disable can be removed and use
> regulator_disable_regmap instead.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: hi6421v600: Remove unneeded *pmic from struct hi6421_spmi_reg_info
      commit: 4446e6f3bd5c97c312833b445d0eb2ea638c7e98

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
