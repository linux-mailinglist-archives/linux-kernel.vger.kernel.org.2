Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D346A332EBC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhCITIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:08:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:52400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231133AbhCITIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:08:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DAF06523B;
        Tue,  9 Mar 2021 19:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615316889;
        bh=LZvTkv/SxO6tIjypoyqW+hKOj/pXA793+m3se61bT78=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DBF/6vXQ29ht7dJmSDFQpToZ3s2KjnJwDxTvz+VCYDOv0T19+yxttQEJVBkwyHNJ6
         AlbJxHv6tLcRQ+iDQEiDr7h9Us8r4WEB3cI7SsxQoIwBORRGq+hVMPWJPwp+5Ihcp9
         ZuOtpuaMO17FcNnI9rD4W32i43AftxSx/C/xg62oOkW6dmf0EN+WYfCZBK7bXlZJ1Z
         AV9BcNnxvFI71kZMOAHPy+hy3jvCJvmRnHaFyC6wRrctvb3H8/jguEaJxn5NSolvxT
         detSqsU4w84EzsKtUSbbvSx/8y3VRArKIozVIXBsOzoJW9Se4kOywCNQcvIgBSxhcO
         r1HBHyzoWWycg==
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        tiwai@suse.com, lgirdwood@gmail.com
In-Reply-To: <20210301170905.835091-1-codrin.ciubotariu@microchip.com>
References: <20210301170905.835091-1-codrin.ciubotariu@microchip.com>
Subject: Re: (subset) [PATCH v2 0/7] Add I2S-MCC support for Microchip's SAMA7G5
Message-Id: <161531678410.49117.15323877762928879476.b4-ty@kernel.org>
Date:   Tue, 09 Mar 2021 19:06:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2021 19:08:58 +0200, Codrin Ciubotariu wrote:
> SAMA7G5 includes an updated version of I2S-MCC, found previously on
> SAM9X60. This controller includes 8 data pins, 4 for playback and 4 for
> capture. For I2S and LEFT_J formats, these pins can be used to
> send/receive up to 8 audio channels. For DSP_A, with TDM, any pins pair
> (DIN/DOUT) from these 4 can be selected to send/receive data. This
> version also includes 2 FIFOs (send and receive).
> This patch set starts by moving the driver's bindings to yaml and
> continues with adding a new compatible for the SAMA7G5 variant, followed
> by the changes needed for I2S/LEFT_J support, TDM pin pair selection and
> FIFO support, exclusively for SAMA7G5.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[7/7] ASoC: convert Microchip I2SMCC binding to yaml
      commit: 2a29ad9ffc2a11827695b7b4fb32b486c604db3d

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
