Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB7039E700
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 21:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhFGTDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 15:03:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231258AbhFGTC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 15:02:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBBE461139;
        Mon,  7 Jun 2021 19:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623092467;
        bh=QU9H4Bu8DEXA13HF2T4s77tQ1PYVV/RhWLM+hv2Zx0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JLnrZXsL/w5bbjY2F9kLuC7AHOppFnm6/PhhtRHthJXtjXJ2P25MLCxkeccJSfVUV
         NJgylvT9fSk8qX8UDOGqgB7jJ5ms0JwWyKPMRm1QDAGug//jawUaQcSeUMtX1RXKPb
         MbWxyr7X8W5I29WnVNd1eB7cvin/O2x1zgzx0ZL8fpZJ8Ym757p8Zc8MZfz81MjUBy
         QcjUWHcDu0Fdnk3ns4ldjlmT4Im2BJwqNIvPMdp9e4DC7Omu1Nnc95Fx95m9Y+XvzI
         JSX+ucA0B60mXXd5Zod44TYyqPSPTp530D4tBAdj81epI6toMQ6pP01jXgFkCVA60F
         D0TPCYfVg2ZrA==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] regulator: max77686: Convert to use regulator_set_ramp_delay_regmap
Date:   Mon,  7 Jun 2021 20:00:42 +0100
Message-Id: <162309235193.30707.6583500055502151849.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210605013424.1298773-1-axel.lin@ingics.com>
References: <20210605013424.1298773-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jun 2021 09:34:24 +0800, Axel Lin wrote:
> Use regulator_set_ramp_delay_regmap instead of open-coded.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: max77686: Convert to use regulator_set_ramp_delay_regmap
      commit: 3c37d899ef8bd9940f9eee551c6c0b16b36aa1e2

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
