Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D003A83C6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 17:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhFOPRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 11:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230079AbhFOPRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:17:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3FF361603;
        Tue, 15 Jun 2021 15:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623770129;
        bh=sfA/mRzFumjOz9kbWz70761Nc8lsiKZ4a9I7LArzfdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PCcS8E14gb4WssndiWJcRFxUH5w/rDXeGcqSMLhxzAHcvEB6XiAQjJozvdu2x26V/
         hMCqdOS5JNCcnvjtTETxRPqQyA8msRkwPdgPkWk7DrnZkQbsXkxYYJRfie8SkPCQes
         Upb63aJy0EiTJsccPzUpUzvwdeSh+BGlK67AaQYu0c2ZOoRMH20Rp9Bk1ota39lbtn
         ENipT5Xj4HRq7Ac0Iu/knaf7vNUk6E5Y5c4YpiQPTGmPXWCihXy1RqC6dsje3SRXGJ
         g4Rcc8/sx0uVewaGy6XQXefpXu/f4uL9FVWO5Q53V90vA9a6kwOllw+nbiiqnZNIKQ
         0K0ciybpsT4Bw==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: rt6160: Remove vsel_active_low from struct rt6160_priv
Date:   Tue, 15 Jun 2021 16:15:06 +0100
Message-Id: <162376572819.36399.17993990572863185568.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210615103947.3387994-1-axel.lin@ingics.com>
References: <20210615103947.3387994-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 18:39:47 +0800, Axel Lin wrote:
> Use a local variable instead is enough, this simplifies the code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rt6160: Remove vsel_active_low from struct rt6160_priv
      commit: f3f4f37d53be578c65dd32a1ffad432b33aef236

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
