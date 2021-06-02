Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38D5398FC9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 18:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhFBQTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:19:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229871AbhFBQTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:19:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B19561942;
        Wed,  2 Jun 2021 16:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622650637;
        bh=ujDgNC82Zvk8eDUwGQURyQIRCq0dpOz4kqIDyxIc8M4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bXP7kGt3FhcmjpDD0tVWojUCnUjwmLjc8u7BLhqaRba2plpwfT4zfxXh0eceumNgv
         YXEajVZ4HJms1IjMBfGqN9/k0qLeYNCTV+KSfViETsdQ+CJECX7GYTOVZB1udg+BYU
         EtK5Bmox8ZnJRAUFZc1w+ccqWJJ9THghQ5bzfe+L7WvW3XSCVHnmC+cn1MknPNg041
         fUuAdZyNxFBZo5QiLweOBmnrjUdxcruLEuvjgJDVevZCKYrh1tITgFQT+lBBqYP/PZ
         0Sr3hPSAjT8Fw5a6Ytrw8Znxm0MejoNBZt1+xrT6RakJgra+bXw1A4GRM/1wm5jf9y
         YPwSjXexAgXoQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, YueHaibing <yuehaibing@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] regulator: core: Use DEVICE_ATTR_RO macro
Date:   Wed,  2 Jun 2021 17:16:50 +0100
Message-Id: <162265054258.22587.7347166365426724237.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210529115226.25376-1-yuehaibing@huawei.com>
References: <20210529115226.25376-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 May 2021 19:52:26 +0800, YueHaibing wrote:
> Use DEVICE_ATTR_RO() helper instead of plain DEVICE_ATTR(),
> which makes the code a bit shorter and easier to read.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: Use DEVICE_ATTR_RO macro
      commit: a277a2622ca9609de09c18f660f0d10f1ddbb379

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
