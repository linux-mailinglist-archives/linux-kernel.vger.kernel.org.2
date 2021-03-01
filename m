Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF2432A060
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243493AbhCBER1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:17:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346237AbhCAXjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 18:39:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90B50600CD;
        Mon,  1 Mar 2021 23:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614641915;
        bh=crMSjT8phIUU1gQ1onZ/Yp6euqoj8W2K4uvkW3zWsI8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BvSp6hND4OePcVaNRzgMsmBwZExTtVoJvxcDBVE6XiQcewW0sAmT9NYIYb9pIRZvW
         9vdUrttaN3GDMd7A0JzAG87pr3c+AgIY5YUO8B3Mms3JdSKy6FlBvhpgejn5ikRzvV
         HQlm8g3TVDXerFs3q2/2tlWIeKXC0Xtr1yi7htqJ6pTEbeylBTcr6NDzDElKtx832y
         +r7GdZRqHLMnaQReJ0nAGGrGByVplZ7YP37Ql0wIvvaotzgfVB7gwxDABZ3KDLOLNh
         zqoOar0Emxya0oUuepQmIoZvTEkhqqibeAbf+RT+cCX1h4R2K3hFr3iWZyCIfyn/Wl
         29ssBqCdkIpSg==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20210216060128.126938-1-axel.lin@ingics.com>
References: <20210216060128.126938-1-axel.lin@ingics.com>
Subject: Re: [PATCH] regulator: pf8x00: Use regulator_map_voltage_ascend for pf8x00_buck7_ops
Message-Id: <161464183214.31485.8914564217194445331.b4-ty@kernel.org>
Date:   Mon, 01 Mar 2021 23:37:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Feb 2021 14:01:28 +0800, Axel Lin wrote:
> The voltages in pf8x00_sw7_voltages are in ascendant order, so use
> regulator_map_voltage_ascend.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: pf8x00: Use regulator_map_voltage_ascend for pf8x00_buck7_ops
      commit: 6930ab7ac03c1be5d1944473cbf327c9d4d14ce4

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
