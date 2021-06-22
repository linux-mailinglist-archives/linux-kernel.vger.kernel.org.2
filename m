Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADDE3B086A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhFVPQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:16:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232107AbhFVPQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:16:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9CA860BD3;
        Tue, 22 Jun 2021 15:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624374876;
        bh=9nlCYcwqJ1vnQ9bk5JIVIMyBSmpad5izn20RrHQQDjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GLuKJLiIYN2/DFWioXKR8mwigKWHko61JufxOKbH5a40RUgTuZtNEZYvjF99m8AQj
         3wZctFuPzF/8qBEaW6o3K5CmBLQxM1aThJs5qsiQ1/R6NhCw0+75q9YaGq0RUQJvn7
         KHD0WvFO3aBYSzbvRa8j8vPS648jlhP5wnsOWjIAu1iJToRrTTL3bq2tlLOnP96gyC
         9wQDlYnKUqoGu2MfIaLevW4e82/7zVn72LbhZdTsIFFVgxhDPq4V97K2i4WoTu7ly9
         zyjfV3/wpzxznr85k+vNRmUrwIsHRetGsRn1O3ir+9phpNbHJpp+Z+RgyuRq+gW6tB
         NYHYLlQJ6v4sw==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH] regulator: hi6421v600: Fix setting wrong driver_data
Date:   Tue, 22 Jun 2021 16:14:03 +0100
Message-Id: <162437385474.2223.5068353167104451603.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210622043329.392072-1-axel.lin@ingics.com>
References: <20210622043329.392072-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2021 12:33:29 +0800, Axel Lin wrote:
> Current code set "config.driver_data = sreg" but sreg only init the mutex,
> the othere fields are just zero. Fix it by pass *info to config.driver_data
> so each regulator can get corresponding data by rdev_get_drvdata().
> 
> Separate enable_mutex from struct hi6421_spmi_reg_info since only need one
> mutex for the driver.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: hi6421v600: Fix setting wrong driver_data
      commit: 9bc146acc33125cd9f365b92f1c02ec89f639977

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
