Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA21425F3D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 23:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242208AbhJGVkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 17:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242218AbhJGVkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 17:40:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C371961212;
        Thu,  7 Oct 2021 21:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633642688;
        bh=4TP2znbdwj0H4YvHogb8ZrGweVg56RD4YiI0IW4v1e8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ptLS1W8BTb9pfQqTxETwpsqQZdqJZ0FG2SPbnpFoiMvY5qENhgokCN7g/NcddRD17
         jl2qoveZamrSVsK8OncuOrNQmhS18xGB1kB7IXDtUJV4CFDZYuLzDIxk3HgNk3XE1F
         H3N7wB0Ax05E5kT3s1dkoXthtkCESYryURJD8VEkuYckLh1n4rlGz9iM0sr40K7ENm
         rP9+RhFtUz5f3TmDyAMcXwYX4A5pU/Z+3yNhEj7WSXqTppTUfGUtm04qp/mcavEeFi
         MwCgH0UiyrXdsMXc4M9DVRrJkpKDnr4GNjW6tmb26a8+eDR8ipcrXjkFtyG97ehyzf
         8NCrcda73htjw==
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     Mark Brown <broonie@kernel.org>, peter.ujfalusi@linux.intel.com,
        guennadi.liakhovetski@linux.intel.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, yang.jie@linux.intel.com,
        Daniel Baluta <daniel.baluta@nxp.com>,
        ranjani.sridharan@linux.intel.com, budliviu@gmail.com,
        sound-open-firmware@alsa-project.org, kai.vehmanen@linux.intel.com
Subject: Re: [PATCH 0/4] Introduce new SOF helpers
Date:   Thu,  7 Oct 2021 22:37:33 +0100
Message-Id: <163364264608.649699.787228689014334103.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211004152147.1268978-1-daniel.baluta@oss.nxp.com>
References: <20211004152147.1268978-1-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Oct 2021 18:21:43 +0300, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> This patchseries adds new helpers in order to reduce code duplication
> and prepare for compress audio support with SOF.
> 
> Bud Liviu-Alexandru (1):
>   ASoC: SOF: Make Intel IPC stream ops generic
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: SOF: Introduce snd_sof_mailbox_read / snd_sof_mailbox_write callbacks
      commit: f71f59dd450813684d838e0c1d6602186b7d2d8f
[2/4] ASoC: SOF: Make Intel IPC stream ops generic
      commit: 97e22cbd0dc318f1cedb3546d2047403506bdc2d
[3/4] ASoC: SOF: imx: Use newly introduced generic IPC stream ops
      commit: 40834190aa81270c52104fa9c82a1cae4bd1d359
[4/4] ASoC: SOF: Introduce fragment elapsed notification API
      commit: 858f7a5c45cacbf9965c4735330ee34baa0728f4

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
