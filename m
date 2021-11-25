Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3754D45DB4C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 14:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355437AbhKYNmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 08:42:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:58254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354941AbhKYNkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 08:40:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B206861074;
        Thu, 25 Nov 2021 13:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637847421;
        bh=amtopp9RHl/TvQxvYXr20cIuv/ZoExLoTxclzPSkcBA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lry3K083Ck3VPN/+LLXeWeHs2U+6WlSBURFxscS5dAQiy0xcwcFsvBKrxoSAAtTsf
         TIDPXhj8KZ5TzwwoSXHyolDqZY8H62XgSCGyuWLhkmNgYY/c1UMbC/CJUww31ZdpWP
         s0drXYg0jUIqsHk74MHC3f9i2xehyXP+PSDLsfTwq65PfUSfVF2tQS2i+44OZE4G2b
         xueUahted9G0xy3dYpCqa5Y5skyWfO/0LVuNx7mCuMhu1iX419TL7CODcj7ZlA20n8
         Wn1Piw8/UjguGL+ngDkhz9Ed2ec/tGKjLxkKoq/ug0ndWRoX04XEFDLN8ySdqhEhnb
         NQeboRWUHoHcA==
From:   Mark Brown <broonie@kernel.org>
To:     sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org
Cc:     yc.hung@mediatek.com, daniel.baluta@nxp.com
In-Reply-To: <20211125071608.3056715-1-yangyingliang@huawei.com>
References: <20211125071608.3056715-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] ASoC: SOF: mediatek: Add missing of_node_put() in platform_parse_resource()
Message-Id: <163784741946.3101847.9704540045126980062.b4-ty@kernel.org>
Date:   Thu, 25 Nov 2021 13:36:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 15:16:08 +0800, Yang Yingliang wrote:
> The node pointer is returned by of_parse_phandle() with
> refcount incremented in platform_parse_resource(). Calling
> of_node_put() to aovid the refcount leak.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: mediatek: Add missing of_node_put() in platform_parse_resource()
      commit: fc6c62cf1cbf24c81ccb1d248120311336d5f3cc

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
