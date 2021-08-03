Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A199C3DF7F3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 00:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhHCWgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 18:36:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233399AbhHCWgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 18:36:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52206601FD;
        Tue,  3 Aug 2021 22:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628030188;
        bh=DOyU2sYorvQY4kQgLU4xRaU30VsJypmI5w2Lq/QPj1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJNgikBqAHXwSOywcGo5VU4P3Tj/C+pEjPqGfm4bXxcKiHYWMXUavkSi6zA0co2JI
         vduvjGSg09xv766Qi0TyIIhilCX1702yvctSMKWj9s6MKBZgrLhgFFzvGIkkIS/362
         u9YxQXlDK8NdjUdRtMb/+h7K30jWCuhxivhNLHUwIOV2eboUrY2IWTCupksdnJCyxF
         hG1syLWZXJX6lEjndS+S/evcbzlgWVR3lcI2IWp3WArnzq05xf/e4s7rryfRFI0Ihr
         QXkXtyoq3SvI286rw2u0lrzn16dqANM6oAAH759fErreakDGTEhRU2dYIFe493iuw9
         9GqOo0lKJplbA==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        nuno.sa@analog.com, lars@metafoo.de, nicolas.ferre@microchip.com,
        perex@perex.cz, tiwai@suse.com
Subject: Re: [PATCH] ASoC: codecs: ad193x: add support for 96kHz and 192kHz playback rates
Date:   Tue,  3 Aug 2021 23:35:41 +0100
Message-Id: <162802985539.42099.2701841258072136197.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803104825.2198335-1-codrin.ciubotariu@microchip.com>
References: <20210803104825.2198335-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2021 13:48:25 +0300, Codrin Ciubotariu wrote:
> ad193x devices support 96KHz and 192KHz sampling rates, when PLL/MCLK is
> referenced to 48kHz.
> Tested on ad1934.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: ad193x: add support for 96kHz and 192kHz playback rates
      commit: 0d73297e483e5b7ce197c0a923424e5dd96eae4d

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
