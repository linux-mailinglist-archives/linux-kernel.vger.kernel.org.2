Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D60B45508C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 23:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241388AbhKQWek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 17:34:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:42038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241317AbhKQWee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 17:34:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A219361B6F;
        Wed, 17 Nov 2021 22:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637188295;
        bh=Z+MeT6LT5Kb9JkETeAPAoQPtL76Z5bYCfF+s92dnR40=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rN8HDXYymUxaa8b0YMukBak1XAWQF82pA3DESm2D0B7qCbDzJt0qVu1K6HE1LbwDU
         SvRaDSunpkf7B0Te5m0t3cHpLhNlQG9mv1lFwXlxHfGPljxQyNlzZnQJBZJEdxagQT
         EtZPEpkuhlI5VFGzga+DWwT3NFxaLENq0uerKEbICOEIs10l/ebc800ExBhoulxZAW
         06Ax/ND55Vt15qV+KjWZbcX/JmnctVOROtNhJ04eW8Xixq+KJZrhFB2v+Y+lpyBiV/
         //hJRelwxWMRUMdCBU4wYoTHTzM6fl/GbLBOsa0b6AZrTQC+hf5RweAt6vZQlzU9oK
         eG1D2TYwjuSEQ==
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        peter.ujfalusi@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, kai.vehmanen@linux.intel.com,
        alsa-devel@alsa-project.org, daniel.baluta@gmail.com,
        lgirdwood@gmail.com, daniel.baluta@nxp.com,
        pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com
In-Reply-To: <20211116152137.52129-1-daniel.baluta@oss.nxp.com>
References: <20211116152137.52129-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH 0/4] New debug feature: IPC message injector
Message-Id: <163718829340.136850.578880691226569719.b4-ty@kernel.org>
Date:   Wed, 17 Nov 2021 22:31:33 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 17:21:33 +0200, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> With the new SND_SOC_SOF_DEBUG_IPC_MSG_INJECTOR it is going to be
> possible to inject arbitrary messages via the debugfs/sof/ipc_msg_inject
> file and get the reply from the same file as a binary.
> 
> The main use of this feature is to stress test the firmware's robustness
> against maliciously (or erroneous) crafted messages.
> We also receive firmware crash reports with only a binary of the sent
> message which caused the firmware crash.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: SOF: utils: Add generic function to get the reply for a tx message
      commit: 8ae77801c81d16a09f6b67a6f8d91255d34f5f2c
[2/4] ASoC: SOF: imx: Use the generic helper to get the reply
      commit: 18c45f270352fb76c8b5b133b3ae3971769f8a22
[3/4] ASoC: SOF: intel: Use the generic helper to get the reply
      commit: 0bd2891bda4550774946abbfac88443a16c15d5a
[4/4] ASoC: SOF: debug: Add support for IPC message injection
      commit: 2f0b1b013bbc5d6f4c7c386e12f423d6b4ef3245

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
