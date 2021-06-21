Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C1D3AF567
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhFUStA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:49:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231634AbhFUSsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:48:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C0AF61245;
        Mon, 21 Jun 2021 18:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624301200;
        bh=1AfCZAdobtc+TRpabBrvY/zNGO+CvgEvM8vDC/i/19o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uXWioR9KGa4qrZ5NmI67EATBEvXDjb3oUxHJ9qBqfVWwn5r7hkWDF5oYEDXgiDijj
         cX9nBhUHsJ05IpT7A9NMtUm1wfguWNn35d67KzDQ/btQSXtopRGC/j0wkJUilsxciY
         eMjs8o9JVw2yvP2iQ9NhB8fK+7SHqaI+X2gGdfI7mShH+rRxJMeEKm1c3jn4yMHV2Y
         nGXpUG6FpF6t6wPCimOvEchXBUcGREWekDqe4WjlEYXDSG0+1rd2/NiXBbKFg+Lc/M
         u/NJlXCTayrvwJw9X0O9xM1s+XXJuVbb6hvw5Ra7OI+NgL4d1s1OXGHjsJTlp6RFpw
         03WQ7QGri02Ww==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Guodong Xu <guodong.xu@linaro.org>
Subject: Re: [PATCH] regulator: hi6421: Use correct variable type for regmap api val argument
Date:   Mon, 21 Jun 2021 19:45:53 +0100
Message-Id: <162430087047.9551.5184182272983250648.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210619124133.4096683-1-axel.lin@ingics.com>
References: <20210619124133.4096683-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2021 20:41:33 +0800, Axel Lin wrote:
> Use unsigned int instead of u32 for regmap_read/regmap_update_bits val
> argument.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: hi6421: Use correct variable type for regmap api val argument
      commit: ae60e6a9d24e89a74e2512204ad04de94921bdd2

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
