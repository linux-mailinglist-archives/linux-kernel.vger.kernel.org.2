Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DEA39793C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhFARkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234547AbhFARkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:40:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D872613D5;
        Tue,  1 Jun 2021 17:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622569118;
        bh=LjqLJTppU91o1AyqLKXVx3WA+Lw3V9mIMr0+AYDUrSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZqZlJACwb1ec9/TAa3DE7O+/dPsDKh96z1l8j7fSQraLAIVi125qqu6eTU/1YuXpu
         7TpbFWq2Tj8c8S+1vZIAwI9LrY5PNaA586SUdE8oVAQDQLX1lgs2engUUYoAf3SIRk
         Ozd9MPuyN4XSqhvhI+yfDsHnjWF63m9kidx9kU/qST3lfPxyctnZFVxjorNUzhJxPR
         Hnnk97EivLYdnUmc6zUjMbPemN3gwQpCfzda3Q6Lhct9uzJBU4XaUF4EiFp1qe4xFl
         GW8ZXqveVRdqhWXymctSG3sr7eeXesbm6k+g1Eaw196Ly4vLzsJgbQMsNWR9Brm6po
         X8b4p/ypBa3mQ==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Daniel Jeong <gshark.jeong@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: lp8755: Convert to use regulator_set_ramp_delay_regmap
Date:   Tue,  1 Jun 2021 18:38:03 +0100
Message-Id: <162256901744.20048.3993004544595195717.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210527144248.247992-1-axel.lin@ingics.com>
References: <20210527144248.247992-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 22:42:48 +0800, Axel Lin wrote:
> Use regulator_set_ramp_delay_regmap instead of open-coded.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: lp8755: Convert to use regulator_set_ramp_delay_regmap
      commit: fbd168cd76e4ea80fc22d361b08267664db4d905

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
