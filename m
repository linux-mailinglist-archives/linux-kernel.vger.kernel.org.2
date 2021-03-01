Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12A132A058
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239929AbhCBEQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:16:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346156AbhCAXiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 18:38:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 823376024A;
        Mon,  1 Mar 2021 23:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614641851;
        bh=giRNibx8UMkg76ubdWLBG8i0Hm5P8hvlHVh8cF1awrk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=X2pAH5QKtQHCBP3xTkRq4rgHqjEnKIH8LRADOJHHti/Yltgqm0tO6DbTBwzS9+BYp
         UFuvTzKWbnNY29jyshdCv02elfiachBnPQ/MVZ3AWcYGMWYlRdirsYcpn8tTVZ2FzR
         m+S7CAnvfzDAf1DtHEI2gaUVjo0zFWwJPoiDoPqIiOzml3TwWnwaswHGfZ/HnsWmfV
         IEJojZlCicGp9iFIw/ME3XquWCiuEeeR8KjM+KscREMBOqbZxEs0kJGzILENOkz1bV
         jl2WsheKeczbK//tjjRA7asSts/slN0v+UHRmEEQzaYHMGWcmkjAkL8ZGllYLD9hM8
         B93zX7AzvGUNA==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, dingsenjie@163.com, lgirdwood@gmail.com,
        perex@perex.cz
Cc:     linux-kernel@vger.kernel.org, dingsenjie <dingsenjie@yulong.com>,
        alsa-devel@alsa-project.org
In-Reply-To: <20210224085407.22120-1-dingsenjie@163.com>
References: <20210224085407.22120-1-dingsenjie@163.com>
Subject: Re: [PATCH] sound: soc/uniphier: Simplify the return expression of uniphier_aio_startup
Message-Id: <161464168096.31144.10521204916240412508.b4-ty@kernel.org>
Date:   Mon, 01 Mar 2021 23:34:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021 16:54:07 +0800, dingsenjie@163.com wrote:
> Simplify the return expression in the aio-cpu.c.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sound: soc/uniphier: Simplify the return expression of uniphier_aio_startup
      commit: e3fdb6288dd08d965dea4bf00186e20f79153b2b

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
