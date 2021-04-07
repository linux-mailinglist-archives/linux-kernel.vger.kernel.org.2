Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7453575FF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356344AbhDGU1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:27:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356096AbhDGU1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:27:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F6D06121E;
        Wed,  7 Apr 2021 20:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617827219;
        bh=DbNJfOATZhRLaLqCciLxAQrVD95vTb6G/WEYWfPZ0HA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IcMrHIEZIDb57hiR7wzXGoNstuGeQ7K1XeYlonLjjOQ9tAcqOarhp8PaJrcPD7PyU
         JO0iUHQ2SxvjovsebRa4NZ54nkkcDrgEWQpkT7fuvlEB0RMEz3T1ZGL/fsOPVEmX4M
         BU7F7maOsVxovcxTBM9hs7VMhO5XyXnRElUxitF0sGNgJmbAS5jADWLlW/hSSDKkpb
         cS+hB3gKRQ36XJ0DyOE7Kz36bqmTFcqDCQPg7zihuBTDpP1V6oWeBkSOTLWz5d+eGe
         ESB6/9ej9vskMv76UXVw6ok0vvMqlhZDIZghnx8/SJyHVApZGE/aOqGV8sdlCmWigc
         Ct8vR5Q20Lvng==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: meson: axg-fifo: add NO_PERIOD_WAKEUP support
Date:   Wed,  7 Apr 2021 21:26:24 +0100
Message-Id: <161782703231.42756.2000858967744578792.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407145914.311479-1-jbrunet@baylibre.com>
References: <20210407145914.311479-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 16:59:14 +0200, Jerome Brunet wrote:
> On the AXG family, the fifo irq is not necessary for the HW to operate.
> It is just used to notify that a period has elapsed. If userpace does not
> care for these wakeups (such as pipewire), we are just wasting CPU cycles.
> 
> Add support for NO_PERIOD_WAKEUP and disable irq when they are no needed.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: axg-fifo: add NO_PERIOD_WAKEUP support
      commit: 9be701ec3493d3348723a38f0c19702d710758ce

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
