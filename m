Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5C837A1E6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhEKI30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:29:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhEKI27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:28:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40BA061942;
        Tue, 11 May 2021 08:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721673;
        bh=rVZx4H7SLhEfY9uZaZksv7D3ECMJkUkfL2J6l5EyOKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a7L85Q6oK67wz+PpJvPdesYqBNI6/Ua6fNPiZBQIUfRO/xM0SxJTmgmeuILQ8lwt4
         6Y8x7tvptZvOHTmWNddPVDaJkOExChnXAcVauKTZcr5PK8YgAe7V+5gEM8SsFxatH9
         37MIeoMu9OM7RP/SFiNyDulq6z7gCdXTarmTvcrxqLe+CAHdHbEOy6si9KMNCCDmzt
         eA8puvHhI/SmkyauOq2SeQOFptIngcejZV5qhm8mLhXLj9O3CliK+QpveQkbAruTRo
         40W6cM9DHtK++5M+do4uIUHJ1Ej7qs7lbPCQfEmgx9A6ZycvEsQhDP3RkOeNNf8/RP
         zoMctCAu65VrQ==
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Takashi Iwai <tiwai@suse.com>,
        Colin Ian King <colin.king@canonical.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     Mark Brown <broonie@kernel.org>, kael_w@yeah.net
Subject: Re: [PATCH] ASoC: codecs: lpass-rx-macro: Remove unneeded semicolon
Date:   Tue, 11 May 2021 09:25:53 +0100
Message-Id: <162072058169.33157.72791432961188955.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506021005.4897-1-wanjiabing@vivo.com>
References: <20210506021005.4897-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2021 10:09:49 +0800, Wan Jiabing wrote:
> Fix the following coccicheck warning:
> 
> ./sound/soc/codecs/lpass-rx-macro.c:2631:2-3: Unneeded semicolon

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: lpass-rx-macro: Remove unneeded semicolon
      commit: f758b9ef9a1abeea37086b8da0073c27eebf74aa

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
