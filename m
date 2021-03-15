Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE3933C2F4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbhCOQ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234613AbhCOQ6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:58:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE68264F35;
        Mon, 15 Mar 2021 16:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615827501;
        bh=RZJ/BoC2jUBBFMz79wrOVEsQvUMqjv4DwmpvkzK5orc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uhf154C2I1XkSel11y5cTJZpPLm475E5dg1Qt/+NI1QamnYSSta64HC0TSP6DTafN
         fy4LSmXC71/aU89mecC7LVP+0pKCcBk8T1RuUI9+2TeBSKeWNmMZH3PHb+EOehRyYj
         FbzuDpImIhQsOzvM7NWsYWj44TnZxZTIgoWrV+ygfqqK0YfbRB36y/7aj7VUuX1aK8
         FUtuKHAoSvUR2bQb/OJP9Y9+hf9DupfeAWvqKohwo9YQjOrU7Olv/wI6oy+qA44QNV
         8Uzwji50PMZHfGxs5n9V8naLSPm6oryWTjAYbYzOT2z3dWAmAjG52TFvd9jPQxrBhG
         8b4B348dn/dig==
From:   Mark Brown <broonie@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-power@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: bd9576: Fix return from bd957x_probe()
Date:   Mon, 15 Mar 2021 16:57:03 +0000
Message-Id: <161582739233.20279.17042133398382526901.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <YEsbfLJfEWtnRpoU@mwanda>
References: <YEsbfLJfEWtnRpoU@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2021 10:42:52 +0300, Dan Carpenter wrote:
> The probe() function returns an uninitialized variable in the success
> path.  There is no need for the "err" variable at all, just delete it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: bd9576: Fix return from bd957x_probe()
      commit: 320fcd6bbd2b500923db518902c2c640242d2b50

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
