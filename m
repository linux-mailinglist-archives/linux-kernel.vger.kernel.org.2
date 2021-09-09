Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3D2405A44
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 17:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbhIIPkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 11:40:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233129AbhIIPkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 11:40:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BD1C61101;
        Thu,  9 Sep 2021 15:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631201973;
        bh=T/mw/UbjbrrOlnUVot7WIwHPaeG3mY6jLafZbnQXNto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i8P0a3DYUqvolCsgpd39ALimrV04sYugsuGLc5z5sEQyVPkWyJFfAxH7cg9M1R2z5
         R/MKKdhX6Q7jDQZ7CZI/XES508M3xPOjd2XQuoSAilrOegH5H66zULlkHCLu0SFYJG
         DjLdUAQ8UPe5bXX2KeP3Q/qK0WC46Mb32vGS7fSBdcLt8MKvNiLCHRgEHg7CVBrlvH
         GiwtibH8jKOviM/abCb6w4QW1kXZRdpuONi+172Esj+bnZTO6ogtN+SF/yEYr0zjl/
         yGOvVIO5gTOh4eNh5pILwXnsMvc6/jxgChwt9ygrGCtKOrIw9u1L95SbNUDk9qtME7
         iUj+hTgHtlBTA==
From:   Mark Brown <broonie@kernel.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: fix update references to stm32 audio bindings
Date:   Thu,  9 Sep 2021 16:38:51 +0100
Message-Id: <163120168200.50116.15964820004324884962.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210909145449.24388-1-arnaud.pouliquen@foss.st.com>
References: <20210909145449.24388-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Sep 2021 16:54:49 +0200, Arnaud Pouliquen wrote:
> The 00d38fd8d2524 ("MAINTAINERS: update references to stm32 audio bindings")
> commit update the bindings reference, by
> removing bindings/sound/st,stm32-adfsdm.txt, to set the
> new reference to bindings/iio/adc/st,stm32-*.yaml.
> 
> This leads to "get_maintainer finds" the match for the
> Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml,
> but also to the IIO bindings
> Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: fix update references to stm32 audio bindings
      commit: 26be23af1866eead5a29f8501f9d774ac277d0bd

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
