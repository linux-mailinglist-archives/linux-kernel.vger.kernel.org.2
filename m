Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C69340F9E9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242113AbhIQOGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:06:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241849AbhIQOFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:05:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6BEF6103B;
        Fri, 17 Sep 2021 14:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631887473;
        bh=Hd6qofhVOm0wotTJdXOamHlQNz4ugqpf6apHuNTiVHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=inxBcg1T2FGyuiUq8qDq81WeWkAh3mxST/gA3NELlflR8s0g/JoyJc4amrhhKnJJU
         yhDHe+R/A/zun0pdpiJ3jVimKqq9GSYm8mJkQlzaW8V8rZOCgybS/po/JnQ05k3FRl
         adoC6sFnU7hmnNOSoienC0ztzFCOf2b6dIHHzXuNnTNEGZ/f+zmrEjA7u1OsLVPop0
         X/aUpTnzgWVy9x4FFw9j4Goi1yFmQtU8WCl6jXLY82SRxlLKULqsiggWEJkeAQzo8B
         Bwxl53N/y0z4nzfwkl/KHUj5erRtYqoJr/3weZGlpJE1l/yv6QdXoN6IahwMbqlgi7
         prFKfyrV4EeIw==
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [RFT][PATCH] regulator: max14577: Revert "regulator: max14577: Add proper module aliases strings"
Date:   Fri, 17 Sep 2021 15:03:42 +0100
Message-Id: <163188734684.50615.3711547908292984771.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916144102.120980-1-krzysztof.kozlowski@canonical.com>
References: <20210916144102.120980-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 16:41:02 +0200, Krzysztof Kozlowski wrote:
> This reverts commit 0da6736ecd10b45e535b100acd58df2db4c099d8.
> 
> The MODULE_DEVICE_TABLE already creates proper alias.  Having another
> MODULE_ALIAS causes the alias to be duplicated:
> 
>   $ modinfo max14577-regulator.ko
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: max14577: Revert "regulator: max14577: Add proper module aliases strings"
      commit: dc9660590d106bb58d145233fffca4efadad3655

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
