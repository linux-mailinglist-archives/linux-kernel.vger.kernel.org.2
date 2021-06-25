Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841803B4469
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 15:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhFYN15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 09:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231723AbhFYN1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 09:27:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62D6661962;
        Fri, 25 Jun 2021 13:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624627529;
        bh=tap7YRggbHIdkEpjJ/bP0UQLC1WqPENH/gRQwTG/qbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uOpKh/DMAdoOJqUA2DY4RJ3byCu44ZOLlBbc6plAGQssiYWKKWs+MsZB2UGZ1rlP3
         0a4pnrOmT91DqFwnmnuY8rDw4EbOYnraCidGM1hdJReLlUVIILFxOXlEaLMJuWnFZv
         eb/0r1pDLOVvaX37ZBNDkveSCMJKNVNEyBxU8xqiAFZBswTyNVGIbVgeU/AZcwuqry
         Uau1OOvd+OQxMFf3TAjvSZAQmI/7w+6sH295NdLKdlKkjxYdfOp+GZYV0kL/pDYXGr
         qrPvH7D6MYO2AODGXiGvfID5zsUSqpvRh9PRePaRfVFjtZPo7oce3HW3cgddTl40Li
         1tb3Ac2AjwgMQ==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        lgirdwood@gmail.com, Marek Szyprowski <m.szyprowski@samsung.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: qcom: lpass-cpu: mark IRQ_CLEAR register as volatile and readable
Date:   Fri, 25 Jun 2021 14:24:57 +0100
Message-Id: <162462667882.45385.4252603231977049463.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210624092153.5771-1-srinivas.kandagatla@linaro.org>
References: <20210624092153.5771-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 10:21:53 +0100, Srinivas Kandagatla wrote:
> Currently IRQ_CLEAR register is marked as write-only, however using
> regmap_update_bits on this register will have some side effects.
> so mark IRQ_CLEAR register appropriately as readable and volatile.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: lpass-cpu: mark IRQ_CLEAR register as volatile and readable
      commit: 6a7f5bd6185e1c86256d5e52c3bb7a4d390d6e19

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
