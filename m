Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B133A6F88
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbhFNT4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235403AbhFNT4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:56:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0BA561166;
        Mon, 14 Jun 2021 19:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623700475;
        bh=ErGfQJKqkRkUqE83GIW+ctduwgTHana1L6qJRDq5mgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KukEwoNIiGfKAGRpF0JZYG1dzwpcKTLD5OkpJ13s8qRQK9xfiZUPd229JEzk4Ntbq
         eiEt+Yi9i4hjzAXIripkBcEDPYJBPjDF2syrDwuF3cHPIEDeFzffyV0xDmlKmajOYc
         pM7fNFrT6e3XV0s9rD9xt7g+uGZTLBZbnr8RTrr/v1z7VvuKfgj4Em6nanURso9UiO
         i4N62PCg6woXoNhIGh9fXBXRLwPK246PpGUbNt56Wi3KM4LkKTCwi46LnvEmr1hHZU
         r8VwMckuGKUuIBdUN7O2M8Z4484zXmCMawgbC4BPv9pp17sL7kx8Oteo3Toh6fj4ac
         Dx0cfPAGBoh6Q==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        ChiYuan Huang <cy_huang@richtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: rt6160: Convert to use regulator_set_ramp_delay_regmap
Date:   Mon, 14 Jun 2021 20:53:37 +0100
Message-Id: <162370026642.40835.4645297362894075513.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210603093809.1108629-1-axel.lin@ingics.com>
References: <20210603093809.1108629-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 17:38:09 +0800, Axel Lin wrote:
> Use regulator_set_ramp_delay_regmap instead of open-coded.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rt6160: Convert to use regulator_set_ramp_delay_regmap
      commit: b113ec2d8562f5f3e0359c547cba53686ee805e9

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
