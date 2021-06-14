Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336923A6FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbhFNT5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:57:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235671AbhFNT5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:57:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D58661246;
        Mon, 14 Jun 2021 19:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623700521;
        bh=fNFJUqAq01ipcR1uUZlhTo8RHMzwgmOdackeJZ6s1I8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FqilMXT6Q32JdZ4v/tXITvsmSo+byh4QBPywPrcFjRS9Rlx7uf09ettP/fGz3QdVB
         Dr3GpEjM9qsKgrYOfx51r16YUubepdHTIlJioafGCFkHkWmmDaKs+5KhauDo+IsniA
         y0QFvi/s82CMAjctuW0pO/LVQk2XRKo7x9TSCcZZ3/bGIBkWvVufBgUqtyfzMlfl+6
         ApXEZQ+86xKGuWrmrPeFUAMUmMcJzXunCtCLdez8QyHiVsc8AKJS9SZ1FHDTrPC2DY
         99zCiHOycL4s97U9XYtvv+LLk//QwmyVropfNsgY8l6OFT8E4NLj2MiUWeqPexdYk2
         F1fePt/0N2eYQ==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz
Subject: Re: [RESEND PATCH] ASoC: rt5640: Make codec selectable
Date:   Mon, 14 Jun 2021 20:53:53 +0100
Message-Id: <162369994009.34524.11288841519238246714.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210612200650.1301661-1-martin.blumenstingl@googlemail.com>
References: <20210612200650.1301661-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jun 2021 22:06:50 +0200, Martin Blumenstingl wrote:
> The Realtek rt5640 codec driver can be used with the generic sound card
> drivers, so it should be selectable. For example, with the addition
> of #sound-dai-cells = <0> property in DT, it can be used with simple and
> graph card drivers.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5640: Make codec selectable
      commit: 08c56cab302a059c1f3a95c164def7b21c67ad2e

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
