Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FF13A6F87
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbhFNT4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:56:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235007AbhFNT4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:56:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F2B1611CA;
        Mon, 14 Jun 2021 19:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623700473;
        bh=ThtZ5KnZ3/ie7v6eh0fNkBg735PhEswIu5njsJoPD7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tFruZjyh/pqpn6QEzmrydoEMw6jJaMf/mQG6jHfLIp/5dbwm5s1NVTKNTRUlP70Pe
         te8vnHspBJRFV1ssja4EAIosEa4DU0thCel1CMyQfU+rn8HuJzbPlVmaQHYLrXCcpW
         ngu1iGXC6w/AEuDT6NWE9xZwnf8axvw8tu6r24Uts3dnG4e16GQ9R4w9D7n8YhXBvl
         3BzlYitvJq9y+7PZlllrdyNvp4HqgHNLVxr/co+1jqp/ZyZqMs0454O0CQFWg4t7OG
         NeZsZf9uhdhWsQnmzINNw/BUQ1nT7aRobFSCMNdhOfsSsSkPdt7PCfY2Ksk4hc2J5Q
         gfOoExVe05TJw==
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>, lgirdwood@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: rt6160: Remove dummy line and add module description
Date:   Mon, 14 Jun 2021 20:53:36 +0100
Message-Id: <162370026643.40835.12863844790748605599.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1623335910-5385-1-git-send-email-u0084500@gmail.com>
References: <1623335910-5385-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 22:38:30 +0800, cy_huang wrote:
> Remove dummy line and add module description.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rt6160: Remove dummy line and add module description
      commit: 23f95199b6446f828bf879ca316f388893435faa

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
