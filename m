Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D413AA1AB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhFPQoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231200AbhFPQn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:43:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D042961351;
        Wed, 16 Jun 2021 16:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623861713;
        bh=559inuTvPdv6Mxx/p8xEYL/60qazKbf5t845mqHXAY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SShVWR9lMmHcWWTCezzzzBI1dFb2eEWlLwjz3qpAT5Dh0U1v6F4EBPRhCBaPgz1Lo
         2IQHBhw0GPTzAKrU/PGOzj21j2zxSc1s9kKcjkUcswoh5FiSe0srOTkTYZ+5ASZcyc
         CBniE0EbycEqUUOFejePEU1RIJWBZEb3fhmmRUZxPKbSy86sz1bXgYOyZXVzmRQWa0
         QNHaN+leewogEeUfsx9GjIBEzToTEQi83MwmuiZ5Yw9Cgm6HRBlzQCa8aeWTu6R7x2
         p2dghFphkBIqq6nDtHWT5C6Id5k5oiy2dKr2UlQTPSL7CETNVktFdSroYJHefP6TnY
         7T8YM76d7ZLzw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, Yang Li <yang.lee@linux.alibaba.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        perex@perex.cz, alsa-devel@alsa-project.org, tiwai@suse.com
Subject: Re: [PATCH -next] SoC: codecs: wcd938x: fix boolreturn.cocci warning
Date:   Wed, 16 Jun 2021 17:41:16 +0100
Message-Id: <162386001971.25644.6927312581095753036.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1623811535-15841-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1623811535-15841-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 10:45:35 +0800, Yang Li wrote:
> Return statements in functions returning bool should use true/false
> instead of 1/0.
> 
> Fix the following coccicheck warning:
> ./sound/soc/codecs/wcd938x.c:1190:9-10: WARNING: return of 0/1 in
> function 'wcd938x_volatile_register' with return type bool.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] SoC: codecs: wcd938x: fix boolreturn.cocci warning
      commit: 83bd5c53ebf6f2f7b8b0b7db4c038ad7a5a5448a

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
