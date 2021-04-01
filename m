Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFBD7351339
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhDAKR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234071AbhDAKR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:17:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FB92610A5;
        Thu,  1 Apr 2021 10:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617272247;
        bh=AmB1o+YWSRbCC5rBIMr9eV2iGuWSsMgF97x7uR85EQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dsoj+rrdJF9ppMxZKT5232A20cdMkd46EL2qtMSxBhdBw9NWPY9s8HSC2sifjxauR
         uIKBdzztLdpFG40jz41n1xUoG0ZbwZbvMNlsijP8/fNio48c5LmHsQD9XLY+n7vSFZ
         GNiJ8+xRnv8w9Gd6Mxd8l1yQn0eis1u+PqaIUu741DnJEXGqA0srKOH6qGFCgj+PZC
         v/Jvv1moItfAPqWrPtvu/5C8nT33LdW3EtBXw5Wgl2A1tUoqilwlK4PmLs+0hVFY/+
         OVO6909QoTdw+wIj8HbfBqZP4gXiOoLlicHo4OfpSF+I+t9tR36COiAqhj6iuh+UjB
         /W+Fp/Gg0J/gg==
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, tiwai@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] ASoC: remove cppchecks warnings on lm49453 and da732x
Date:   Thu,  1 Apr 2021 11:16:27 +0100
Message-Id: <161726938995.2219.309801757681001460.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210326221619.949961-1-pierre-louis.bossart@linux.intel.com>
References: <20210326221619.949961-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2021 17:16:17 -0500, Pierre-Louis Bossart wrote:
> There are the last two patches in the cleanups, this time I am not
> sure what the code does and what the proper fix might be. Feedback
> welcome.
> 
> Pierre-Louis Bossart (2):
>   ASoC: lm49453: fix useless assignment before return
>   ASoC: da732x: simplify code
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: lm49453: fix useless assignment before return
      commit: 458c23c509f66c5950da7e5496ea952ad15128f7
[2/2] ASoC: da732x: simplify code
      commit: 945b0b58c5d7c6640f9aad2096e4675bc7f5371c

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
