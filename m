Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFBF419D53
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237701AbhI0Rsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:48:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238220AbhI0Rse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:48:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B78660FD7;
        Mon, 27 Sep 2021 17:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632764815;
        bh=UoyOu+HGkNrrwRCUSi8qZGFNqq889PT42AR660QqB9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=egp4xPjalJTs6BAa89Ta28O7cMa5W7LkxaLodBqAWXLOCDy4Dy+tHQXSFlnqohNIY
         HndsgH6piahEn+ahihyEt9nrNGqimLF3NH6am7UDDTl0BxsqIk3U+CX0uPWj4079sm
         EDdTpUIJC2sgRthHtZovZ753PiuTaZ8OdukRzYEAnQ3c5u4e5N4iQtu90Lt6wci+RF
         BObZqPyetFNqSjJ+pA1knByONWC5/olJISv5ROoCuEmDFUMSevj3/b8xqjXElT/syg
         p5v0M8bf+YggBaqpT4CwcNCCjkjt7oYsxj+kkH+c19qWlza+iBXlcLDzb+16o6Ri0b
         7MR6PEOm207cg==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, Zenghui Yu <yuzenghui@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH] regulator: dummy: Use devm_regulator_register()
Date:   Mon, 27 Sep 2021 18:45:22 +0100
Message-Id: <163276457919.18909.9263799505896893235.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210925035507.1904-1-yuzenghui@huawei.com>
References: <20210925035507.1904-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2021 11:55:07 +0800, Zenghui Yu wrote:
> debugfs code complained at boot time that
> 
>   debugfs: Directory 'reg-dummy-regulator-dummy' with parent 'regulator'
>   already present!
> 
> if we compile kernel with DEBUG_TEST_DRIVER_REMOVE. The problem is that we
> don't provide .remove() method for dummy_regulator_driver, which should
> invoke regulator_unregister() on device teardown to properly free things.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: dummy: Use devm_regulator_register()
      commit: c6e5e92cb29eab3e49dab444730b4ac200caaacb

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
