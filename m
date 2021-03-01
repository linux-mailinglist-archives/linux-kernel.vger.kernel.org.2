Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDA832A05F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241841AbhCBERB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:17:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346236AbhCAXjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 18:39:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3149660C40;
        Mon,  1 Mar 2021 23:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614641909;
        bh=OUUbM4MOf/Lvzac82oFwUNGVQh1l3Y3If1L4tFJdAvY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=c0CYtTyVk34kzOIq60C21olN5n1/I6mOZD0oiMEzUE6qRDsG64lPC7OUkQyB5IEwy
         uOY+Y1Y2M4MykNRLzHWzQPO3UqY8asQd8nG68HTwCD+vR9m9H6XtqAmSoiPUnszBuC
         QyPzoQoCFP1mG+RJNRoKbP6zNgKOLAj/7P2rxV926thB80UCLgGcagRErlzp6sEzIq
         eoPqTF8cuLU6w5qwwR3VV7/DetbIuWlbS3Xy9vMqFaMVMykG6qj+kgeEMUxLFPgEOt
         yVSpC4CTqfxoaUAEFssr1UI4f+lhgTh5rULZfraF8wEW0LkOTlTw4dTj1z/JBlXpdQ
         5xoaqt0aqeKag==
From:   Mark Brown <broonie@kernel.org>
To:     cristian.marussi@arm.com, Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lgirdwood@gmail.com, sudeep.holla@arm.com
In-Reply-To: <1614303575-27436-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1614303575-27436-1-git-send-email-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH v2] regulator: add missing call to of_node_put()
Message-Id: <161464183214.31485.12684241723788311060.b4-ty@kernel.org>
Date:   Mon, 01 Mar 2021 23:37:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Feb 2021 09:39:35 +0800, Yang Li wrote:
> In one of the error paths of the for_each_child_of_node() loop,
> add missing call to of_node_put().
> 
> Fix the following coccicheck warning:
> ./drivers/regulator/scmi-regulator.c:343:1-23: WARNING: Function
> "for_each_child_of_node" should have of_node_put() before return around
> line 347.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: add missing call to of_node_put()
      commit: 755a74fc655ee95ce37bb0f552cbd39b52978a05

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
