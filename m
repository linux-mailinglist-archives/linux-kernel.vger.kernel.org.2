Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF20E39AA50
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhFCSor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhFCSoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:44:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5094613F4;
        Thu,  3 Jun 2021 18:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622745781;
        bh=TRbzEjqd6F1rvkQqzUZpCxer4BSH6P4i4D6NOAwFxe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SJsMMI4MXP6sLkNxkoE83JPmAiojQcAr4jtAejzDvnBuIT2pWpzHkkkUgkThOxfck
         py8jPSVZDyHZK3W+gkBn3rCOwDn/djkIJYORFRohQAp+bcxdK5OgMUBOSM3a/gPFXZ
         FpIdKY/pnif7YpRZE+W6TU0eOsdJ2sZzjlkeVZWRZBlNNs8B4FYkadG3/IUnBkv7ps
         IZxiWpzpfWL/xU6QloCYxvJWbxi0G7GHuwIwWKYB+IjpK9etylm6InWW/IFA2Y1gYt
         FqHT2/v32s6pLoNnV34YTXerb3Y9DyoI8oh7HUwHDWz3LArL0KYHbhqYS1g8dSQFsm
         GuaYDuQjW1pug==
From:   Mark Brown <broonie@kernel.org>
To:     Colin King <colin.king@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH][next][V2] ASoC: rsnd: check for zero node count
Date:   Thu,  3 Jun 2021 19:42:01 +0100
Message-Id: <162274557552.14795.11440858083758467099.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210603110315.81146-1-colin.king@canonical.com>
References: <20210603110315.81146-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 12:03:15 +0100, Colin King wrote:
> Most callers of_get_child_count() check that "nr" is non-zero so it
> causes a static checker warning when we don't do that here.  This
> does not cause a problem or a crash, but having zero SSUIes does not
> make sense either so let's add a check.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rsnd: check for zero node count
      commit: d66e033910593d99700cd9e2a75698395fcd676f

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
