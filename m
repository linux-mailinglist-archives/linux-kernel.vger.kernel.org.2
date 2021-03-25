Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D990349851
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhCYRiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhCYRhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:37:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13DA461A2C;
        Thu, 25 Mar 2021 17:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616693861;
        bh=1g0ymfKKeil9RN/uPQNtw7qS+3W7ggqGXapUCg0NkV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kEfGfakWKp7ciHKy0udBHqlqmjlANfUTku7KpJ/sgEjH7iUge9hHR/C+qRjvIDnY9
         begDphefk0w0XugDXIJZPxUUce3tMuf5GPtrJqmB+YKqbs9jHxNHApLimYsOnvBJsG
         nh5mdvLe7JSKmb5PiRcpdrJBN8zSlK0m4pk9uPQHZXKNgNIskyPfzDOoDvLnOrkCtn
         jRJhYwEvfhwTaSoY9RzO1AxgKIMN7/1DP6Rs+dqV4Naw8pWN2lC266o7kqULO6BtpT
         qM8/+Dpi+QH+GVK/4H2zZwg9zXbqwnY4ipIBECN2S5O5FyO0u+1bleZp/zGhN4s/FZ
         +rCyuY2Sv/qyA==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, perex@perex.cz, festevam@gmail.com,
        Xiubo.Lee@gmail.com, devicetree@vger.kernel.org,
        nicoleotsuka@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, timur@kernel.org,
        alsa-devel@alsa-project.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        lgirdwood@gmail.com, robh+dt@kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 0/6] Add audio driver base on rpmsg on i.MX platform
Date:   Thu, 25 Mar 2021 17:37:08 +0000
Message-Id: <161669370551.41585.13939031002896940550.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1615516725-4975-1-git-send-email-shengjiu.wang@nxp.com>
References: <1615516725-4975-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2021 10:38:39 +0800, Shengjiu Wang wrote:
> On Asymmetric multiprocessor, there is Cortex-A core and Cortex-M core,
> Linux is running on A core, RTOS is running on M core.
> The audio hardware device can be controlled by Cortex-M device,
> So audio playback/capture can be handled by M core.
> 
> Rpmsg is the interface for sending and receiving msg to and from M
> core, that we can create a virtual sound on Cortex-A core side.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: soc-component: Add snd_soc_pcm_component_ack
      commit: 8bdfc0455e3a59e2c1207a56be22e910fae0e0d5
[2/6] ASoC: fsl_rpmsg: Add CPU DAI driver for audio base on rpmsg
      commit: b73d9e6225e86492f6a901223a34ecfa7b55c178
[3/6] ASoC: dt-bindings: fsl_rpmsg: Add binding doc for rpmsg audio device
      commit: 49c6bf62498344fa8f8af2314231f3eb37e0e150
[4/6] ASoC: imx-audio-rpmsg: Add rpmsg_driver for audio channel
      commit: 1935050de0b6c6c961e9de51d5b5d05642f861f1
[5/6] ASoC: imx-pcm-rpmsg: Add platform driver for audio base on rpmsg
      commit: 3c00eceb2a5391ed1ca6703b71cad35ab8cd4352
[6/6] ASoC: imx-rpmsg: Add machine driver for audio base on rpmsg
      commit: 39f8405c3e502e7b9d0533fa0b0bfe715b3e89c1

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
