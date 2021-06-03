Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B04239AA46
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhFCSo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230178AbhFCSoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:44:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19321613BA;
        Thu,  3 Jun 2021 18:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622745760;
        bh=72OoV49fQeFaOXhJ8g9WwBnytlBahxPTto9SkqIgaTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HtULfRRW34Qa7w6dDFWKIYNxm8mN3zUDgIXLjIJjKA2DH2kStsSTR/lHBP1v9tY9O
         x8VWub5kFtF0NeFSF4wTnBz7OVJ1keKyuXWii8LV/ru0VOD2vTkdBspeKF0zpY2QLo
         YDWKqR4GtY0G0GDi2nOUGK/sqt6YQohGPJ4dt9s9LEgw8IbP7SvjuC5bNF9Yd86n6N
         ap7NFne6yTH2yo45vmGtVj38TZQUkkp62MZxih1SIVPApzQ9RHb8XkzJK7UI7SMSDK
         K5LB85Tc7It5cp9wvufvzVLVQTL/rzvhGtCE1R+oBq6IQKb6l2u8GzfQMfbq7CZh+L
         75VPTEtyykD5g==
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-power@fi.rohmeurope.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: bd718x7: Fix the BUCK7 voltage setting on BD71837
Date:   Thu,  3 Jun 2021 19:41:53 +0100
Message-Id: <162274566701.14958.15403839882331975339.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210524094204.GA463579@localhost.localdomain>
References: <20210524094204.GA463579@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2021 12:42:04 +0300, Matti Vaittinen wrote:
> The BD71837 voltages for other regulators except the first 4 BUCKs
> should be forbidden when regulator is enabled. There may be out-of-spec
> voltage spikes if the voltage is changed when these "non DVS" bucks are
> enabled. This restriction was accidentally removed when the LDO voltage
> change was allowed for BD71847. (It was not noticed that the BD71837
> BUCK7 used same voltage setting function as LDOs).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: bd718x7: Fix the BUCK7 voltage setting on BD71837
      commit: bc537e65b09a05923f98a31920d1ab170e648dba

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
