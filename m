Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF238351F29
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbhDASyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:54:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238968AbhDASpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:45:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A671361376;
        Thu,  1 Apr 2021 16:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617293772;
        bh=dwHmd5z7d3S6IKZJVqZz0GEYmtsn7TXcZwT3wxRq0HU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P82XwlnOVJaSE5ZHL1OyJ7KOQrkT/rE4Tky0TKeN8YgnK/v9WeRj91MiHA9qKAD/C
         GVsdXH/dbIAZcq2gxKSPD/OETUCKTrq90Nw1/OjX6YU7LViVNOP322zhkcN1vrs8Wv
         pKMevN4w9qw5uvkTDt5CsS3Y2NO1+QBtj4bwrEBLb2vDXUM2JigvSwkuzjLtX78UgA
         K12SsejB1ilGABY6Tp3swg2/xqc5ZNqWKSoq2AQTH398Wn8Yv3+/asDQPQ/T+d+f8z
         b6BqEkUDEW/05ivCL9QX+t25kopc6guY2rMDQu2wlYYC00VaRtFJqIgwB4f/QAZem2
         1LnPGz/t4Ef2A==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/2] ASoC: codecs: lpass-tx-macro: set npl clock rate correctly
Date:   Thu,  1 Apr 2021 17:15:49 +0100
Message-Id: <161729333651.31618.804470082704941093.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210331171235.24824-1-srinivas.kandagatla@linaro.org>
References: <20210331171235.24824-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 18:12:34 +0100, Srinivas Kandagatla wrote:
> NPL clock rate is twice the MCLK rate, so set this correctly to
> avoid soundwire timeouts.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: codecs: lpass-tx-macro: set npl clock rate correctly
      commit: b861106f3cd693f944ba46d9ea8744a3fbfd14db
[2/2] ASoC: codecs: lpass-rx-macro: set npl clock rate correctly
      commit: adfc3ed7dcb98f7411d3632e3bdf81690294fe7d

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
