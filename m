Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF2F451C76
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356624AbhKPASZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:18:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355338AbhKOXlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 18:41:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6A7A63255;
        Mon, 15 Nov 2021 23:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637019311;
        bh=f/RAxHWMo22E5/g2HCmdkZC4w/uvaz1Ts603+IKDTac=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CrVOZeG+YfIgfam6NwLGYshVRJFS14Pkm26czAJx+CXeMU/3u+H0b2dRcRzHnhOFz
         OWLY4BHgq8j57QnPxQZOv4PDgvs4qry2F2f+Fm5SLT8s0Py2ur8KP6N4sNZ4M5xjh1
         tkNPE1RQ3MZlC2dlkKSS6djy09I6sGO+73z8veZs36GX8+sPOyIpI6fIxIks6COdDu
         CcP2lg9/N48zkXw6JZuLo5VeNH3zqrZkeMF2Zqf/PJq55V4AYBIGKxebyUjYOuaadj
         h4TmLQuIPTz3EJ2RRZL5mPoz3AnWiy4PzozHDc1wnB6ho4tpE8mBobl3YQoBb9xb1l
         gVxycreKjUupA==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20211028140902.11786-1-rf@opensource.cirrus.com>
References: <20211028140902.11786-1-rf@opensource.cirrus.com>
Subject: Re: (subset) [PATCH 0/3] ASoC: cs42l42: Fix definition and handling of jack switch invert
Message-Id: <163701930968.675370.11970784121248131390.b4-ty@kernel.org>
Date:   Mon, 15 Nov 2021 23:35:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 15:08:59 +0100, Richard Fitzgerald wrote:
> Summary: The driver applied the opposite of the DT setting to the
> wrong register bit.
> 
> The jack plug detect hardware in cs42l42 is somewhat confusing,
> compounded by an unclear description in the datasheet. This is most
> likely the reason that the driver implemented a DT property for the
> wrong register bit, that had the opposite effect of what was
> described in the binding.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[3/3] ASoC: dt-bindings: cs42l42: Convert binding to yaml
      commit: 0f9710603e803ae9b64ed3b54019170b323968d7

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
