Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0E4321C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 17:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhBVQMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 11:12:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231718AbhBVQJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 11:09:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0E1664E40;
        Mon, 22 Feb 2021 16:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614010151;
        bh=SGYuhAVJGww0TNtTNKJMOFpR0xqUf+EocohHUNwzLVI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SHIA8ZqySz8zJDoZxuvkyxOEJ4cVLVNQKHywHkSoMbftWX7UcJ35eYQM7BZd0mr3C
         PEmn40x/q32pHndwRZ1KiK2Uvou1ACXbyVIviHTv3w5cXKCny0ug3avfqjXzF87Lzl
         bL+PuizsttuLcOP4GsakubcUHx3gEK5rgDDmK46gUz4zORKCZ8JFL5VIQqe73AQp2p
         2JTNxdkV8hI+5YDwnNTMwTVjm8UrZTpHb+gZE9zJ7u+78Ng0f2iVHnNmTfOiIkAJ8v
         Ar/3YiPwSjDIAlV7eOhHnWGLiYNal3hGiVIpn66xg/Xtbpd7NGhyBTiBUpAcJlZBft
         JemSjfP9y7VCw==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20210215034813.45510-1-axel.lin@ingics.com>
References: <20210215034813.45510-1-axel.lin@ingics.com>
Subject: Re: [PATCH] regulator: mt6315: Return REGULATOR_MODE_INVALID for invalid mode
Message-Id: <161401009008.2622.9628765028769391980.b4-ty@kernel.org>
Date:   Mon, 22 Feb 2021 16:08:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Feb 2021 11:48:13 +0800, Axel Lin wrote:
> -EINVAL is not a valid return value for .of_map_mode, return
> REGULATOR_MODE_INVALID instead.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mt6315: Return REGULATOR_MODE_INVALID for invalid mode
      commit: be86c3fd26c708da4bef59162efd41ec4f4666c5

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
