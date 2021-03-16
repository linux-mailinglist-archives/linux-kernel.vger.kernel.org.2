Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3237D33DBD7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbhCPSAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:00:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239554AbhCPSAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:00:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B063F65130;
        Tue, 16 Mar 2021 18:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615917601;
        bh=Vtpwig98DoZbrSR0CuLqzxBGXELlkECOuNP5eItQs1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B5er0DI4ZmvZIRiX7qGda9dnCI3L7nNsR1o0jHOfuze8qNxaEklDyNkSe7Y5GJxSz
         09PP8gZiwlSo6hjh25CM0x/YiC6auGmVMNffGEXnwebvDD5X2Y/ePISsGk9qo5DfND
         K9ZUQ93tU3bpdlquwXTNOVCDamtDGi3APpz8kw47XGwQYmkthItjiVMBGJ5AmsqwJ+
         vDAkUwWgLS2l0LBSreUtZ8/rruQGP3tp8iwmC2goFiIKf9TPXELiy8VRXHdTl5Gowu
         2I57AaB9VHl96WbxgnsuMdIHzOZxgcV1NpDOJ5ORs/oRemiODBQlfpqese4fLjvW/B
         shOeHe2y1XNjQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: fsl_spdif: Add compatible string for new platforms
Date:   Tue, 16 Mar 2021 17:59:42 +0000
Message-Id: <161591744696.13544.14124776783754754865.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1615884053-4264-1-git-send-email-shengjiu.wang@nxp.com>
References: <1615884053-4264-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021 16:40:53 +0800, Shengjiu Wang wrote:
> Add compatible string for new added platforms which support spdif module.
> They are i.MX8QXP, i.MX8MM, i.MX8MN, i.MX8MQ.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: fsl_spdif: Add compatible string for new platforms
      commit: 9deef665f5811a7ad22b5e6eb80fe2a14ba4494c

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
