Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5334538C5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 18:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbhKPRvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 12:51:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231666AbhKPRvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 12:51:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F214F61BE2;
        Tue, 16 Nov 2021 17:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637084901;
        bh=kzq0dlu0gjzDR19x6UB8TtYBuQv/WXthmFOPYes7mv4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tE5KZQn6XGHZxSTDoS6gQwYT24jKy4qJvWLYfMtNg27dhXaO3Hl9niha8HY9mYtwT
         XnScvK3Wnkl6DKnfYI3nkiG9reh2DxCtIkQNDVapeBrLsSzdDrCesenLty1+6o4u3T
         3ulw3QTyOY9S2RC/ZRhlF5+9ilzHT6Mk9dM5fivWVNCbhLXWXfN1J7R7R7CXp+N0qC
         XkwzjFMsSPp0kF+kzwX+DXVjb6z9PF3PmZTzQQMGjLP2UuPzkyt/OjHPweXcJFOO5L
         NNkRAZwkzinV/ob26iMwzPEnmaFxCigJxP3RqEj/5f7rV19KmbtmdvnyGywZeRAYvK
         MPlfSGiur+roQ==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     pierre-louis.bossart@linux.intel.com, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com
In-Reply-To: <20211116115021.14213-1-srinivas.kandagatla@linaro.org>
References: <20211116115021.14213-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: sdm845: only setup slim ports once
Message-Id: <163708489973.808776.5891488829987310491.b4-ty@kernel.org>
Date:   Tue, 16 Nov 2021 17:48:19 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 11:50:21 +0000, Srinivas Kandagatla wrote:
> Currently same slim channel map setup for every dai link, which is redundant.
> Fix this by adding a flag and conditionally setting these channel maps.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: sdm845: only setup slim ports once
      commit: 5f55c9693a222ee1b8ec62a57fbcff59af0c4837

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
