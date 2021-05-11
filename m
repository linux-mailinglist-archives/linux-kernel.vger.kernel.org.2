Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AFE37A1E3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhEKI3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:29:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230338AbhEKI2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:28:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31A296147E;
        Tue, 11 May 2021 08:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721667;
        bh=l8Z/OzCfeWsNmqmpOZGd1liyMDpNo7gr8CIy6SCuWuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GggvETJ49ghxR3jGggzJ6p0bycd1w39dMmZ8r0464V/YAjOVjLugxBEg0pbx3NErg
         xgXpyHzFVlxdtoUmkYJIUt625ivDU8vxPgj49BZJkhxEHgtvTF+AgAqmWi9UOKTb3S
         SNTXlGD0RK5UeKscWvKKaYLBZZoZQWx6mGp2srF6uqpZdssFeNUN06VfQLHh0g7BKW
         Er2hyoNNPzF6i6L08ICk8J0Xp07+l2OH5x+Kb/SiHES3bj8aeYZAg1sSC0bayHi7bq
         kdjnbYpQzAZy1tml+3e2hmcRhEnNEjOfdIo4L7w9RsvLtvOl5C8clIlXCQC6fIj8jo
         uEPyQwLeLwRLg==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, srinivas.kandagatla@linaro.org,
        perex@perex.cz, bgoswami@codeaurora.org, trix@redhat.com,
        tiwai@suse.com
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2] ASoC: codecs: lpass-wsa-macro: handle unexpected input
Date:   Tue, 11 May 2021 09:25:51 +0100
Message-Id: <162072058168.33157.3176018576144440940.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430142117.3272772-1-trix@redhat.com>
References: <20210430142117.3272772-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2021 07:21:17 -0700, trix@redhat.com wrote:
> Static analysis reports this problem
> 
> lpass-wsa-macro.c:1732:6: warning: Array subscript is undefined
>         if (wsa->ec_hq[ec_tx]) {
>             ^~~~~~~~~~~~~~~~~
> 
> The happens because 'ec_tx' is never initialized and there is
> no default in switch statement that sets ec_tx.  Add a default
> case that returns an error before the array is accessed.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: lpass-wsa-macro: handle unexpected input
      commit: 58f01c7fc81baced84f237554d56847e17b5d730

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
