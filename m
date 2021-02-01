Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1703B30ACF2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhBAQrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:47:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231292AbhBAQrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:47:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3133A60234;
        Mon,  1 Feb 2021 16:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612198001;
        bh=j9hC3Db3nfPN7oz+V2moYoDKkQqj5CZszG4PUDCe7yo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DRWI2OfYdkae8cwpgnSYLd4REIg5apAq3rLMTUqyT5BV7E4KDr+nKps2rqnwZalcU
         Fe6fV3C8MJzMb0UIM59KCUMvi5O903LBTPVPW1CcWd4Z2Zqf32xmivtIrnLJecSDkY
         qGCdPSFuAX3eOa2MHIEQnst4s1s7xoTXQFAdq3zdxx5EnDTNdhsnwq8+uVLaEAi8pl
         Rkt7ISSUEfQ2oUQGfAnKaBgqjUmDAUeuGyqHOOi24LX1uDXO+fv2WuRrKODAEbPYXs
         jcH/tDBDtoRLsPWr9OzpztKU9ZngXLqul2+u2Zm6zaPANYqVwzBNUUOY9PZaI1oZsj
         keiykiLA9ELsQ==
From:   Mark Brown <broonie@kernel.org>
To:     Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        alsa-devel@alsa-project.org
In-Reply-To: <20210123172945.3958622-1-sre@kernel.org>
References: <YAqOSg2z24NpjKDh@mwanda> <20210123172945.3958622-1-sre@kernel.org>
Subject: Re: [PATCHv1] ASoC: cpcap: fix microphone timeslot mask
Message-Id: <161219793995.46194.11902730498139607577.b4-ty@kernel.org>
Date:   Mon, 01 Feb 2021 16:45:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jan 2021 18:29:45 +0100, Sebastian Reichel wrote:
> The correct mask is 0x1f8 (Bit 3-8), but due to missing BIT() 0xf (Bit
> 0-3) was set instead. This means setting of CPCAP_BIT_MIC1_RX_TIMESLOT0
> (Bit 3) still worked (part of both masks). On the other hand the code
> does not properly clear the other MIC timeslot bits. I think this
> is not a problem, since they are probably initialized to 0 and not
> touched by the driver anywhere else. But the mask also contains some
> wrong bits, that will be cleared. Bit 0 (CPCAP_BIT_SMB_CDC) should be
> safe, since the driver enforces it to be 0 anyways.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cpcap: fix microphone timeslot mask
      commit: de5bfae2fd962a9da99f56382305ec7966a604b9

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
