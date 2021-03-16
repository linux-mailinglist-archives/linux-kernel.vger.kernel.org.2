Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB92E33DBDB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbhCPSBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:01:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239556AbhCPSAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:00:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87EEA65133;
        Tue, 16 Mar 2021 18:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615917604;
        bh=HoSgMtiIiSAkVpHOLGFLlZiBQhF3CTEX630pkOg0tF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oPFo3HEmTj7fXwVlPAbg2/67boHFQ5fn1riyjzHQVTcmIIJrMvgNBFL7gMO3M/3gk
         OhqnVkWUr+LxO1vWgXl56pTnORZXAzS9SBHed9ZnJVw3uHxKvzIx5MtJeBGY2AObkB
         NlB9edqAUyhPMwjlRdYk653y+ScwnxxDQxSwhoechPZlTpdHXCL5UD8KgPuCgtsjKd
         JjqIlm+yajsnVIjEup91KXVa8fD5P75eo7POnhMqVL7FJCG6tu5RzVUVM92re0+iCL
         0HKUT8AL0T/w3ZwcBBE2QYiKp643CctO1emtQ7vYaG2ecAy2GlVqZkSAaQ6xIex1Uk
         QbCD9IE5jc9NQ==
From:   Mark Brown <broonie@kernel.org>
To:     Xiubo.Lee@gmail.com, linux-kernel@vger.kernel.org, perex@perex.cz,
        timur@kernel.org, linuxppc-dev@lists.ozlabs.org, tiwai@suse.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>, festevam@gmail.com,
        lgirdwood@gmail.com, nicoleotsuka@gmail.com,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_spdif: use snd_ctl_boolean_mono_info
Date:   Tue, 16 Mar 2021 17:59:43 +0000
Message-Id: <161591744696.13544.5081763572355349115.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1615887736-31217-1-git-send-email-shengjiu.wang@nxp.com>
References: <1615887736-31217-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021 17:42:16 +0800, Shengjiu Wang wrote:
> Remove redundant code and use snd_ctl_boolean_mono_info
> instead.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: use snd_ctl_boolean_mono_info
      commit: 6ad864ed6ac50f11a6d8575fda79991cca8f245c

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
