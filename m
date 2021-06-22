Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773673B086C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhFVPRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:17:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232156AbhFVPQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:16:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5970B61289;
        Tue, 22 Jun 2021 15:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624374881;
        bh=3we7Q+7oup/k3bH7oBPacMDKI+UoeT+oMJOH2NAnA1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a/rZhZb6KlhJka/XnPA9DRrd8wfTm16TgdD2lazvGqxdhP/5iuEPGivLCU7hnVJQj
         jz3a1tH6Co83YUcbYsXlsi9I2s8z1611ere2zxOjjCAws0sm7qSgavZq0o9v8ljybR
         jU17FAJrIdUx7ukqhTx6TI81XLmNoJV6MG32UvdG2znTs+XNhhGZ/KTgCZEKtLDlfV
         YO0l3ifu1/QQ6FfF32jfptbEh71CTgnvqgZoJQnp5gESk0UgOonEpbDKs6pZmULSng
         ILX+HInKPpZrqQje5U/OaSWBrbrqwZaqLwgLpzotPbwXvT7o8nb2mDRhcFiCre091x
         k0oF4ub6SPTgA==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, kernel test robot <lkp@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
Subject: Re: [PATCH 1/2] ASoC: codecs: wcd938x: fix unused variable warning
Date:   Tue, 22 Jun 2021 16:14:05 +0100
Message-Id: <162437355277.1773.9681249031887965233.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210621134502.19537-1-srinivas.kandagatla@linaro.org>
References: <20210621134502.19537-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2021 14:45:01 +0100, Srinivas Kandagatla wrote:
> This patch fixes below
> 
> 	warning: unused variable wcd938x_dt_match
> 
> by placing device match table under CONFIG_OF

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: codecs: wcd938x: fix unused variable warning
      commit: 8c4863c261c812a1088b0f8c6b66386d885390e1
[2/2] ASoC: codecs: wcd938x: fix uninitialized symbol warnings
      commit: d245fff1013cb7456ea9ca3f7b858e438c6bbf79

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
