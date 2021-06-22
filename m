Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43643B086D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhFVPRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:17:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232161AbhFVPRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:17:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80D4A61289;
        Tue, 22 Jun 2021 15:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624374887;
        bh=K/joDXOjMWjSrHEyHcJiXlslAz8UC17B9j+5gcEpRBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iTKCpOUKN8tfhrT6IoLLxIAmmzpcW53nvFpOrGjauIYAfwUpvE4zGyBXUbw64nSvd
         3adt1jaUXyE2/zsqHYok4SO5LUARxt1GFjgRhqK7Bcj1g3ZspMjTmtOxgkMcBjqjIs
         VQuP5rN6DOa5CISEfMOvR7mL8tYj04Qwn3PoGnask0PRQqT7P+jlEFQ9ABE4xnZ6rN
         EQNWLWWaAa8+IxCm3O5BRnArv/x8KbsFSSzko/1qbhm0YaCwNYBLwtk2GquC6nmaDf
         c0bUbFo3ZXD5pHoZJ3DSn85R0jhpVxp1Cyo0sQFil4o+81noYGGiyDzK3WynvWRNos
         J28yFaOCvprYg==
From:   Mark Brown <broonie@kernel.org>
To:     timur@kernel.org, tiwai@suse.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com,
        lgirdwood@gmail.com, nicoleotsuka@gmail.com, festevam@gmail.com
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: change dev_err to dev_dbg for defer probe
Date:   Tue, 22 Jun 2021 16:14:07 +0100
Message-Id: <162437355277.1773.16436234060629231949.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1622616132-10391-1-git-send-email-shengjiu.wang@nxp.com>
References: <1622616132-10391-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 14:42:12 +0800, Shengjiu Wang wrote:
> Don't need to print error message for defer probe

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl-asoc-card: change dev_err to dev_dbg for defer probe
      commit: 4b1d51715d1cf78a1527fe426fc0278dcfea1959

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
