Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E676538B8C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 23:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhETVJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 17:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229976AbhETVJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 17:09:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E367B6135B;
        Thu, 20 May 2021 21:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621544899;
        bh=Zdp+4VD0rfzJ0ifGfyClb+3oqnn3GH/diTzzdQMpEo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XDBEEeG2rvBDs9iBETy9kH/h9++izYTDJhBu6bWXFCB4aD21I/d14kT8+J/0hFduW
         TxQwkb5DOEYrLmUXidIa3Ak9njLA5zSkqjYoB0cBwvQ3BHmjLj55tFqx335kkjBzm9
         leO3PO5czpUmjHsm1hOparwkW4S6MQ4pLTkI943464gz3Qrup9qI+ao9yW8z72Rtip
         NSToNLX/+Ez5bWC3DkmlwzsEW9Yz0rYg0zFjcIdnvNWUIVh832NqqzAN16YHomGi7u
         VIl8jH2KBdQYfbm9YPMV7aMPhmvKgRZ/9R2w2Mc5JRB7KJYL1i3OYfgPbQ45RctMP6
         uSI8peiOJaSPQ==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sander Vanheule <sander@svanheule.net>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] regmap: mdio: Don't modify output if error happened
Date:   Thu, 20 May 2021 22:08:03 +0100
Message-Id: <162154469970.5223.4613472844151578353.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210520120518.30490-1-andriy.shevchenko@linux.intel.com>
References: <20210520120518.30490-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021 15:05:18 +0300, Andy Shevchenko wrote:
> regmap_mdio_read() breaks the principle of "no touch output till it's known
> that the operation succeeds". Refactor it accordingly.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: mdio: Don't modify output if error happened
      commit: e56360d6a119f531506658ea87238e48ad4c95c2

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
