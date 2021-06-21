Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0E93AF56C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhFUStX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:49:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232135AbhFUStP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:49:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 848D26128A;
        Mon, 21 Jun 2021 18:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624301221;
        bh=u4E7N74D5ICKc9j+WDBObEXlU0zyPpspSv6KfmMn7N0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H4F0ibZgaXX6U83jHhLZTIC+Zm3XoM6mzWjO98BNqOQgt71PSWzGOjwawLckH/1cB
         r7kJhbRtCuSr0kqT2QZEgjnIUkinK0re8nNRQ4G8pFFL6lGMae/xuTXKSv8q0S3TB4
         mXxqPEJeTwZw2epe2dShvJWypBTROYodLqH4San8xzhpolWyvnLE/8e91f+7UR+yq9
         RYKFVbUqHnPjmRZRXiFpN3HUXGg86OOXUHGGJYTWg+Zv93HSzZNjt8KVCWAZmlcWZs
         GsYg6B92qITz0xeOXe6aU8YRzjgWxHw7JVuIMtruj4B9IyLWbFAfUyD1PekZKe/JmY
         tk2NNknLE4vDg==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, srinivas.kandagatla@linaro.org,
        lgirdwood@gmail.com
Subject: Re: [PATCH -next 1/2] ASoC: qcom: apq8016_sbc: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 21 Jun 2021 19:46:00 +0100
Message-Id: <162430055263.9224.4713697107804997031.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210615140711.1676704-1-yangyingliang@huawei.com>
References: <20210615140711.1676704-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 22:07:10 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: qcom: apq8016_sbc: Use devm_platform_get_and_ioremap_resource()
      commit: e6bb518199181c9c35827a48142fbb548125d0b0
[2/2] ASoC: qcom: lpass-cpu: Use devm_platform_get_and_ioremap_resource()
      commit: 77b7bae7802848feabe37a92533bee64387906e7

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
