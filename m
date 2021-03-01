Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A703032A048
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575595AbhCBD4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:56:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:59224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245441AbhCAXgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 18:36:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B08E760200;
        Mon,  1 Mar 2021 23:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614641747;
        bh=rLQduTIs5jHkiD4vnc60vLesppydKxcbRhb2ApKSTKA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sWGTr6FBybOpFuzXYoM16lTr83+IxLLBHpvHer+l4rgkE111DgosHn9kcIRdCFr3s
         BHyQ8oXl1RFc56IYowxI+4iYVWdvyyyeJ/54mf1YzczCWyK2VWvq3pPy/1XWuG3L2T
         l1NZZr+elpK7h/oOJoTnKPvoq/Aixq7g/yFNt0AXz1ZxeNwq27T+Rygv6zh0wLYkFh
         M6RnPMA0LDcqoRX6dIMQ3AZ2KzFMuxpqtPJN/LvqR3sFdT1okjZdKPIubxwQX/6Dut
         8MA630DKvpiRygIXGK5o5jtRygkwgEQUb2zUCcwK6aFhGVXOThKRAqyqlJJcf38Zo6
         frZnMV4xlOKJg==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Colin King <colin.king@canonical.com>,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20210215200501.90697-1-colin.king@canonical.com>
References: <20210215200501.90697-1-colin.king@canonical.com>
Subject: Re: [PATCH][next] ASoC: codecs: lpass-rx-macro: remove redundant initialization of variable hph_pwr_mode
Message-Id: <161464168094.31144.11681610130344407838.b4-ty@kernel.org>
Date:   Mon, 01 Mar 2021 23:34:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Feb 2021 20:05:01 +0000, Colin King wrote:
> The variable hph_pwr_mode is being initialized with a value that is
> never read and it is being updated later with a new value.  The
> initialization is redundant and can be removed.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: lpass-rx-macro: remove redundant initialization of variable hph_pwr_mode
      commit: 7f7d1c4fce10ca68e87165898e6232353e4be1af

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
