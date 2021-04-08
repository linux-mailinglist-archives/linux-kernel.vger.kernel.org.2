Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB3C358A44
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhDHQz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:55:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232458AbhDHQz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:55:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AAD36115B;
        Thu,  8 Apr 2021 16:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617900944;
        bh=GWpb/4CWrW5dOgeUJNjVwnPmhCH3Tqxz6l+xlJjGsZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o6+NQEY10TfULYi/XtxUE45DQd7LGoHX/+xCtDoIam/6qWkrXbsxqumFwCoNt8bwe
         tQyL3mq7+Mp+0i4gjH9ZuoZz9fIhZUs7K0GflIVOmKjTS68Lh6QUNXgQ92QrnZ3NUz
         swg92H8hYpLl7hzxgqYyFHHauARAcljBzSeLgj+Wrlgyr58Qn1RKsTS5hrtALWIqB6
         LBls/auxgyXtr+I9gcmByIyYdOOOi71eok8Mk/fD4YBheay1Yvl/quoiZRAwXSUSVG
         p7AR3On/otsnP4YNOFIZaA3pxGoTGP1nzc0xroUh/byr9K97xvCXjXBowWYx9dpME3
         sAG9D5C+Mrxcw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Muhammad Usama Anjum <musamaanjum@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-sunxi@lists.linux.dev,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        linuxppc-dev@lists.ozlabs.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, dan.carpenter@oracle.com,
        linqiheng@huawei.com, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl: sunxi: remove redundant dev_err call
Date:   Thu,  8 Apr 2021 17:54:43 +0100
Message-Id: <161790012549.16915.4440454202344762892.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407095634.GA1379642@LEGION>
References: <20210407095634.GA1379642@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 14:56:34 +0500, Muhammad Usama Anjum wrote:
> devm_ioremap_resource() prints error message in itself. Remove the
> dev_err call to avoid redundant error message.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: sunxi: remove redundant dev_err call
      commit: a93799d55fd479f540ed97066e69114aa7709787

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
