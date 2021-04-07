Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E733C357600
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356200AbhDGU1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244276AbhDGU1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:27:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8D14611EE;
        Wed,  7 Apr 2021 20:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617827222;
        bh=DapdfZkCmQxiuqMn5+0fag9RbsXzXBztZK5Y2BqkUqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X9rT4CRPK4Lot0QDWyJSr4PwnWN/TzBK9sxRedCn2FTzKa7PBXqNBXWHXOFAM4CH9
         Q6hAltC8DX5LJN9LCPOH0jQAr3gYumPmfqD8xc3Qyr0ErNEyZ07uf9zwpm/+DQjiA1
         o16Fg4y+IZxDoSiO5gu/m59HfTiFllfNpil6bCA9b5OeP7BPTQBNW7/g457QH80WiE
         VhaqRWny/7OStm0hxCM75br2s89+2haVrv+KqaePiNoC145noTYUIioDyFUAxyY3Ly
         MevEdbEMwfvSLLa1npz6RxRblWQ0yh42XQM/6xaAdtG3LK6aZxBY2r5AO69hxXDCbP
         XAlwAIpOkiBfQ==
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>,
        Colin King <colin.king@canonical.com>
Subject: Re: [PATCH] ASoC: simple-card: fix possible uninitialized single_cpu local variable
Date:   Wed,  7 Apr 2021 21:26:25 +0100
Message-Id: <161782703230.42756.15970652059464773892.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407092027.60769-1-krzysztof.kozlowski@canonical.com>
References: <20210407092027.60769-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 11:20:27 +0200, Krzysztof Kozlowski wrote:
> The 'single_cpu' local variable is assigned by asoc_simple_parse_dai()
> and later used in a asoc_simple_canonicalize_cpu() call, assuming the
> entire function did not exit on errors.
> 
> However the first function returns 0 if passed device_node is NULL,
> thus leaving the variable uninitialized and reporting success.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: simple-card: fix possible uninitialized single_cpu local variable
      commit: fa74c223b6fd78a5314b4c61b9abdbed3c2185b4

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
