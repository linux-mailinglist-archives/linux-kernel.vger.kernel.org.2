Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607D23AB6C6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhFQPD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:03:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232975AbhFQPDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:03:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 958A0610A3;
        Thu, 17 Jun 2021 15:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623942107;
        bh=AinlTQZr6X/55gFUN/lRhGZfX6qM3L9BtodIV1cZqaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h6XXfPlmv0IjQN72CwphklPPjvwIIqXOlSsY+qU6qhHrP+SIs8/j1YCddIBqVhtLl
         st/7M4wdw7q7KeRqLyoKLxf+iK5h0cebXBqTGebMroEzImmirRGw+dspeLCpgwiy+J
         Vvp1EoTX4HSb/UoVw75MqOT4f9BHJMCG3Aa0FBKt+VN8/z0YNNTslLxNhvjsAjmw4M
         6k9VSCh/3WsDtcUkSOnAV4wKUG/Dje3/dGdA383oMShVgRPGjG+JieT3JBXOQyOWA1
         AF1VYLwGrVrqVZx/NDKwrz0C7LPFRTY3koWXhTsIPFqJndPH1ifL9MPi9Q9mSJy5mr
         LJOax19YbF3Tg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, arnaud.pouliquen@foss.st.com,
        lgirdwood@gmail.com
Subject: Re: [PATCH -next] ASoC: sti: sti_uniperif: Use devm_platform_get_and_ioremap_resource()
Date:   Thu, 17 Jun 2021 16:01:15 +0100
Message-Id: <162394075660.19104.11973616551623311701.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210617033903.613727-1-yangyingliang@huawei.com>
References: <20210617033903.613727-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 11:39:03 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sti: sti_uniperif: Use devm_platform_get_and_ioremap_resource()
      commit: 06e6d9044022e1be17757b2db5826115bc634868

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
