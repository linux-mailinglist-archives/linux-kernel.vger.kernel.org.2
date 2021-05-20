Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEB038B8C6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 23:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhETVJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 17:09:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhETVJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 17:09:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58668613BB;
        Thu, 20 May 2021 21:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621544896;
        bh=BUA9LNvo8k8nH10fpS36l+eznj9R/ICvAo99H0xPc/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QHhWMnrXytF6NhUpQZtCNq5/PHsYnlBDSxAvo+yNS47VwHKk9uEQpNkYsP8nCgPJk
         HF3q4gXLXtgn2GSrujRUeevHp812VI8BYOzD/4XnN5y6pqRGCYmIb5wj1b2d4x4pKD
         w75Yg5usmgiUDSLjG4329AIRFBLP3uApJ8HFn7JIVbdcFWID8dZYNqCvVkjVPfGDm2
         OVSQyhjhS/7f4nK7OjvE6meS0xk7/6eHiD4q+/eJf+2eJdnusAu5kQUovUuNcBhGIa
         aYo7qm+QPYh+wpo/6xW2sF3qhJI5pFnu003XNPZ0aNe2A4ePp9FA5Yc9VrsYlFZ2Xy
         mHUo35ZvwbUVg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: (subset) [PATCH 1/2] regulator: core: resolve supply for boot-on/always-on regulators
Date:   Thu, 20 May 2021 22:08:02 +0100
Message-Id: <162154474678.5259.15209107268879157269.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210519221224.2868496-1-dmitry.baryshkov@linaro.org>
References: <20210519221224.2868496-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021 01:12:23 +0300, Dmitry Baryshkov wrote:
> For the boot-on/always-on regulators the set_machine_constrainst() is
> called before resolving rdev->supply. Thus the code would try to enable
> rdev before enabling supplying regulator. Enforce resolving supply
> regulator before enabling rdev.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: core: resolve supply for boot-on/always-on regulators
      commit: 98e48cd9283dbac0e1445ee780889f10b3d1db6a

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
