Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0238239FBEF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbhFHQJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:09:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233411AbhFHQIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:08:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEFD26120F;
        Tue,  8 Jun 2021 16:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623168418;
        bh=CvGVPvXaCYS/ds8lxrjBsW1bW+/PiChXAhAOAROeqzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJePOBHUISI7/9Jv0DCYPzFnjUmvPC0a3xUCVXP2JG9ii5rCrB2R+hN8Dky46qI1P
         hKXj4TM/Ma71OxQcVglSQfnOQA2QpAwmDwOa47aZATFxcaT2VV8ejekzQubm0SJ+TI
         tV4+/fpBmhwoAAwYezeshC8SJBPtZ/c6oOA8KfLUrYFRdiEIm/On9eZRDM4aopN546
         ngfKJHBga1GD8mIoHGv3WpeZVO8GqHXK+Gkx/6m4fpOdcqfPV1HMlq0QJui1Y2V+sb
         b+OTARGX8ShWo/mf0yIpuOORu1jdRSkwyeJsBo25T7BcIyooeODBmcanUBssTMsVzg
         a8R8kT30/5MXg==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH] regulator: fan53880: Fix vsel_mask setting for FAN53880_BUCK
Date:   Tue,  8 Jun 2021 17:06:32 +0100
Message-Id: <162316831090.28178.17660540178797301819.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210607142907.1599905-1-axel.lin@ingics.com>
References: <20210607142907.1599905-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2021 22:29:07 +0800, Axel Lin wrote:
> According to the datasheet:
> REGISTER DETAILS − 0x02 BUCK, BUCK_OUT is BIT0 ~ BIT7.
> 
> So vsel_mask for FAN53880_BUCK should be 0xFF.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: fan53880: Fix vsel_mask setting for FAN53880_BUCK
      commit: 2e11737a772b95c6587df73f216eec1762431432

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
