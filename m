Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9591D37A1ED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhEKI3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:29:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230338AbhEKI3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:29:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9360C61948;
        Tue, 11 May 2021 08:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721694;
        bh=YKWOq5o3HhQKTZsQen7jsuSJsP9ocdlM8lx4R1/2yUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bQGjdUAuch3Cp9R2Iagl62AjhX/O584npGj3eJqIIP1e96T7A5KrqT2f9bkbGwV1R
         eQlnxZOCSe2oOYXhF1c/QnvlOOLjQMEMUnUXbJes4oLIQfLs6uC+W3HlP+itm/iPSi
         ZJ4mPc6Xk+3J7/szVzvd0H0Le6QxW/6EMNHu86ThW/kR6HHvlGZqkX7fP3wMGhlY2r
         xveCk0zuPxQ5dr0l6t5V8Xgvp65TUodBrgCPl+auDKuixtOF9h1fzxr2BYmVPPyO40
         CcSDzU9ten2c4iAS79+gojcCc7gPOci6RPCMMaMd03F+k1F4RwRAwV7oxDv3kLyZHq
         OlYscbc45RUcA==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: codecs: lpass-rx-macro: add missing MODULE_DEVICE_TABLE
Date:   Tue, 11 May 2021 09:26:00 +0100
Message-Id: <162072058170.33157.1978725298165946792.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210510103844.1532-1-srinivas.kandagatla@linaro.org>
References: <20210510103844.1532-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 11:38:44 +0100, Srinivas Kandagatla wrote:
> Fix module loading by adding missing MODULE_DEVICE_TABLE.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: lpass-rx-macro: add missing MODULE_DEVICE_TABLE
      commit: d4335d058f8430a0ce2b43dab9531f3a3cf9fe2c

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
