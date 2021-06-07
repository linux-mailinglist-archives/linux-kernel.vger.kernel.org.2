Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B6039E6FE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 21:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhFGTC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 15:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230516AbhFGTC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 15:02:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27F94610A1;
        Mon,  7 Jun 2021 19:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623092464;
        bh=QhO8aAbRIYOhaPwSY2BWtYOQP11oCXR7yfAZtiIMKA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=my+yQZe3aJpbbNHn8fQhrdmOBk6hWLCN2fIGNj31I1bRx8bOaWFCoDj9CQus77cXp
         Fm0yPHkU1Z+y5PJnlnzzU2UKMpb+wAj0KMUGaDVmQohmrrW1VzsF1MxOw8G5QlMPap
         kAjh8ZHbp1T2So3RaP9AjhcLA2zlKrvscXQIQ/5bY/Fuvo0OZfakVxFvylOPpsGvjU
         KCTtsh0OAFLsd6VwX4zuSUliGXQ+s8u6+B5DOH54Pbh9AcGrbZ+jFrUaOQJcGfAogZ
         KG0d6fewrj4At5dsSVEFHmsadP2OeuLHIt6yGzHxy9WSn0TYKTp8i6/9CGEwzISh3B
         zQF9voYvx+Qag==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, Wen Su <wen.su@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 1/3] regulator: mt6358: Use unsigned int for volt_tables
Date:   Mon,  7 Jun 2021 20:00:41 +0100
Message-Id: <162309235193.30707.3579470584157247676.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210606065052.1417111-1-axel.lin@ingics.com>
References: <20210606065052.1417111-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jun 2021 14:50:50 +0800, Axel Lin wrote:
> The regulator_desc expects "const unsigned int *volt_table", thus use
> unsigned int instead of u32.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: mt6358: Use unsigned int for volt_tables
      commit: 431ea63b647fb35a0ff7f40f19c2bbd22abeb564
[2/3] regulator: mt6359: Use unsigned int for volt_tables
      commit: 5a5e31150c9ecdb76d3f87ed852f5c650d70c7d2
[3/3] regulator: mt6359: Get rid of linear_range tables
      commit: 73d4ae57f82ec1e5fc92b9acd25bb1db2f8cf8e3

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
