Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBA6451D29
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344095AbhKPAZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:25:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:43348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350056AbhKOUVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 15:21:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67C8961BFE;
        Mon, 15 Nov 2021 20:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637007508;
        bh=K3pfS4NVMA2CpFVPUUWV/jwChtsYnKjFN0rX/alvMW4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GnaAa3OMfZjo0cdkgZJPQdMWdKnJe2oF94QBvMIgKUL2AeeNHfpj6tgH7KjefnNWS
         xa16sWmbNMynWx89TRjz0BV529TEsM/JAOYDBAP03ub/AzuBqwt5YSM2Nt5jIXIsg/
         8USGrkghwCn4f3Qqz9z5aSOaTOxz2S4wdIEqHWDYIsXL9+o8AO3xgY2VFol0RmoHj1
         NVD8XVrVN+uCfW32VTTc/STp0+ltHjeFVNMGluPHBwXIPFptNqvNHfgHlar1kJXaIJ
         WRXz4gz/O4sr1flZYelXgBj//rplzrzJ7i+Gxu+rOeQh42qXubmopWE2RP3y4/Wcou
         7bVZhgjZPANDg==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, robh+dt@kernel.org, tiwai@suse.com,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        stephan@gerhold.net, lgirdwood@gmail.com
Cc:     alsa-devel@alsa-project.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20211031210956.812101-1-vincent.knecht@mailoo.org>
References: <20211031210956.812101-1-vincent.knecht@mailoo.org>
Subject: Re: [PATCH 0/2] Add tfa9897 rcv-gpios support
Message-Id: <163700750616.2049880.11874024359672809309.b4-ty@kernel.org>
Date:   Mon, 15 Nov 2021 20:18:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Oct 2021 22:09:54 +0100, Vincent Knecht wrote:
> This is the continuation of a previous series [1] where
> - patch 1/4 is removed in favor of using pin switch
>   This will be posted independently of tfa989x support,
>   since it mainly require changes to sound/soc/qcom/common.c
>   and device DTS.
> - patch 2/4 is already merged
> so here are reworked patch 3/4 (bindings fixed and example added)
> and patch 4/4 unchanged.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: nxp, tfa989x: Add rcv-gpios property for tfa9897
      commit: 77fffb83933ad9e514ea0c7fd93b28cabcdea311
[2/2] ASoC: codecs: tfa989x: Add support for tfa9897 optional rcv-gpios
      commit: 9da52c39b33e7bd9c1f56175c0466fa468d7f145

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
