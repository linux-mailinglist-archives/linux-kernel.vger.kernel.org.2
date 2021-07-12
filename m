Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B793C5AF9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbhGLKu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234166AbhGLKt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:49:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F640610CD;
        Mon, 12 Jul 2021 10:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626086829;
        bh=dcGCYDVQe0J3eC9RaZWL4oSYqn4TV/vO5FlkU4WE+1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CIi6iCO3uvW2Uj8bCOcLfEYUhkLNbM2Dtq05Ka8D7yEQdK1v8DPQW7u90Qyns7u0o
         xphbMiEWhRie0+AvIOR0SNY3OF/KE6Q0RJXMg5u0E8fQHI5Rc66u0gBrEW2ULWd95B
         DMTHkbUIRJPPnrOcSDgGKp5cJNMObvqY3dmZxLWbTIaQ0qw9DXlD/v1nah2Tib0e+p
         tTUNItoFpIfd8t8Aaem4VYP++mAFDv5Xmx7LGq5yJCjjeRWol893vdLvcOktQps2Rn
         RjQrf6BXlSqHAmHDPpQbQdYsEGXt9beg+tQAjtCOBTCf2Vx/OwyrIKHHQm1rfIBt/o
         qKY8beNdQnjFQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, Jinchao Wang <wjc@cdjrlc.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: Replace symbolic permissions with octal permissions
Date:   Mon, 12 Jul 2021 11:45:46 +0100
Message-Id: <162608654078.4419.1550384753620841125.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210626102454.54931-1-wjc@cdjrlc.com>
References: <20210626102454.54931-1-wjc@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jun 2021 18:24:54 +0800, Jinchao Wang wrote:
> Resolve following checkpatch issue,
> Replace symbolic permissions with octal permissions

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Replace symbolic permissions with octal permissions
      commit: 894cda54a76d7c336b6f301bafe49bf6870d4697

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
