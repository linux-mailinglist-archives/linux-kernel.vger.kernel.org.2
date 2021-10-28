Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BE143E172
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 14:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhJ1NBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 09:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230264AbhJ1NBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 09:01:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC8B760FC4;
        Thu, 28 Oct 2021 12:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635425951;
        bh=PpOMr9WHPMjBQJ5Nh0GGwww06NPoVEpkKwQXu6AK/0Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rt+M0r+V2lr8vSdp9UQAFQn40iuD60oKQ5aNE5/WUh/QIxQvtMD6e0RiVU907OTAL
         qquZwhm/83EYfuK6Z7lLtA7fIa4jreh4QJXH/WF71Kw5KDttKhHb0v7PNG+Cvvg6Df
         fM//Gfo2Xw8lbSa6BcmIPzvgF3DXmtSFMYksUieplcwbKtYphJWMhT6QrUMEQtajfD
         usf9bMzRhAxnexw6erwBYpLFvZ8O5sSCcs6rErCed8s4YpReq9Bwm5/wKSni8VSpaV
         IOgcwNp3wyLxYt4vnS5P9jXk0UmTXbEkzlCPWKNOvQoSc+aHGwQaxZoB4FBHp5nGIv
         F1PsCBJVRzE7g==
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar.Mukunda@amd.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, tiwai@suse.com,
        Julian Braha <julianbraha@gmail.com>
Cc:     alsa-devel@alsa-project.org, fazilyildiran@gmail.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211027184835.112916-1-julianbraha@gmail.com>
References: <20211027184835.112916-1-julianbraha@gmail.com>
Subject: Re: [PATCH RESEND] ASoC: fix unmet dependencies on GPIOLIB for SND_SOC_DMIC
Message-Id: <163542594951.950250.6416745784322716952.b4-ty@kernel.org>
Date:   Thu, 28 Oct 2021 13:59:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 14:48:35 -0400, Julian Braha wrote:
> When SND_SOC_AMD_RENOIR_MACH or SND_SOC_AMD_RV_RT5682_MACH
> are selected, and GPIOLIB is not selected, Kbuild gives
> the following warnings, respectively:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_DMIC
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
>   Selected by [y]:
>   - SND_SOC_AMD_RENOIR_MACH [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AMD_RENOIR [=y]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fix unmet dependencies on GPIOLIB for SND_SOC_DMIC
      commit: 5c7dee4407dcd3522a133acdd90d64bf41d00986

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
