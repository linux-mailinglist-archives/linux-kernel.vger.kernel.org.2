Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A723939793B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbhFARkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:40:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234624AbhFARkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:40:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC21261042;
        Tue,  1 Jun 2021 17:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622569114;
        bh=oGX3Z7aQ6sL2whEDiHuoYxDNnw648KzhIAPUnTwHVJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ohM5vlvHKdsOC817RZu7OtC5GI0p9LsdW/4Z7q7c2T8HYvx87TK2h8fWX6vvUNpWQ
         5oP/kbsPpyYAkszyWT+XVe+tMXsLjH8+0ZSl5VpL8SinxBRHo9YeWp+NDwgw5Gcz8T
         rbFkSHLBlhIFrQEO9OyxRf27kKD9v1RTmnjI+3rycXpF4l70HEjan4ABQW1o+sWGFO
         PVy3pAjnmurJDJaS/138eQU86TtDxRAIqBGv3GEN2XTX+FwgNEyJSPW2vyVzdzdWuA
         l3fdrpy74779w3he+RN/bVjmBD4zrq8JKep4A7P+DSqrjir9jbvCP+J0XdiiAcT7EU
         PD1tfGqdYpw5A==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-actions@lists.infradead.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v2] regulator: atc260x: Fix n_voltages and min_sel for pickable linear ranges
Date:   Tue,  1 Jun 2021 18:38:01 +0100
Message-Id: <162256901745.20048.16159802531512956305.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210528230147.363974-1-axel.lin@ingics.com>
References: <20210528230147.363974-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 May 2021 07:01:47 +0800, Axel Lin wrote:
> The .n_voltages was missed for pickable linear ranges, fix it.
> The min_sel for each pickable range should be starting from 0.
> Also fix atc260x_ldo_voltage_range_sel setting (bit 5 - LDO<N>_VOL_SEL
> in datasheet).

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: atc260x: Fix n_voltages and min_sel for pickable linear ranges
      commit: 1963fa67d78674a110bc9b2a8b1e226967692f05

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
