Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9FF35E24E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346512AbhDMPJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346533AbhDMPJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:09:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 507C2613AB;
        Tue, 13 Apr 2021 15:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618326557;
        bh=n62q5EPfx7TlonQCJXka/eBID5Q419/EP3vdvBqEKPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a/E6qyJwBMk/HjcwnpLd5MB32RbCMYkv/JEHib6DELW+NG8rEg1ZThPOwx80jvw6t
         drmBxMFRdq1ULdWxLagnVgGc/VQbBBBf39kuDAC8qqdIvx0lzxVnoOUSwgo+NwdN5/
         SZ/7xTbo9LRX0DcVHt8/qGH2GxCEk7OeSmfSA+W1r7eer30/jAiqk1KsuSDxH9SJrl
         U9GXIcBEVD8SJ6D8to1ijr1L7uOCYY6jfFh9sAu23cZp4vRwoYVwQNEVNHoML+0br3
         eKJAcBF2bBlilDcxRakYUKC5RCYoC0LGOzfpp3fRNsK8bw1enI9lHi5HdhU4vbLmdB
         ZUC1yomeaVdlA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: meson: axg-frddr: fix fifo depth on g12 and sm1
Date:   Tue, 13 Apr 2021 16:08:52 +0100
Message-Id: <161832446009.49152.6444814116918123903.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210412132256.89920-1-jbrunet@baylibre.com>
References: <20210412132256.89920-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2021 15:22:56 +0200, Jerome Brunet wrote:
> Previous fifo depth patch was only tested on axg, not g12 or sm1.
> Of course, while adding hw_params dai callback for the axg, I forgot to do
> the same for g12 and sm1, leaving the depth unset and breaking playback on
> these SoCs.
> 
> Add hw_params callback to the g12 dai_ops to fix the problem.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: axg-frddr: fix fifo depth on g12 and sm1
      commit: 858066864a6383d1eecd2fa96a0b8e69935632f8

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
