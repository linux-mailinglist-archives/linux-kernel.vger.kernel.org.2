Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071C738B8C4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 23:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhETVJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 17:09:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhETVJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 17:09:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A229161353;
        Thu, 20 May 2021 21:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621544894;
        bh=2lRZguFOElFRjpybMHRmt3pKWkNB5XIfZ8ihNvmqO2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DcK46kb2qVA/IsuSEKA/sgj7ijFkWGvPyMvx9BPO2I0yEjiydPSnC9SRH8w1o6H/q
         tNEqn7eud0jj5pg44tZSb5iXIHkVrfs6OfiDpq/QXIqdkQ2Hg0/e9YPCwpqs6IjjeY
         TJQn9gzRwRnWuQbDj4t0jYB89eD4dgk++5pwGKyHwNRpDgkEUyPVem0NZRTk93YS8Q
         cUJgy4Iq4tb+YdjdFlpDwgGkYDlNRbl7FGteTZzJIAmHMauIRV2mTyCON0AI71o/RL
         k4T4EOnInQprFPvbFhMP/QkZgHjzAKUDvDCp5B3QxPv7mCtZpSioB8GDlB/p74cRCq
         az0t/0DIambxw==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] regulator: fixed: Ensure enable_counter is correct if reg_domain_disable fails
Date:   Thu, 20 May 2021 22:08:01 +0100
Message-Id: <162154474675.5259.2820409171558314855.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210520111811.1806293-1-axel.lin@ingics.com>
References: <20210520111811.1806293-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021 19:18:11 +0800, Axel Lin wrote:
> dev_pm_genpd_set_performance_state() may fail, so had better to check it's
> return value before decreasing priv->enable_counter.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: fixed: Ensure enable_counter is correct if reg_domain_disable fails
      commit: 855bfff9d623e7aff6556bfb6831d324dec8d96a

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
