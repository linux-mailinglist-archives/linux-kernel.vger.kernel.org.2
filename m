Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2233944359E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 19:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbhKBSdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 14:33:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235090AbhKBSdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 14:33:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03A6661050;
        Tue,  2 Nov 2021 18:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635877834;
        bh=1yFmPUSLjQ6coZuPz6HKIjZgNys614LuubH4dIqXbWU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=siESjPkSKl5UHDw6/omsoUlDt0CmvEesN3M5wkcOwGnfcf4wwWFFNnkN13oVZtiMc
         QlagBst37O5BzgWx+qH0UdSGgmM8p5GMqlo7D4660ML+pAy9vG012pdci8tI/Wo39h
         Z54Rr+JowHJ3JyOj7Exeb+Hjj3WIozlHoa0D1Sa4esMB/q3ObBQgeWteLgs/1Jpx8Y
         wmZ1UWKqOraj9ZD81fb1Hr2SWZEbnPKrNHHVi/hv6vi084yrCGd91TZTxSxC0UZ/YA
         Gn/1Ut6c1K8N9Yus/5sPonk1KXqZJ7boRreHh3dV9SvFjS8f7OAd/3nqRExsil0Km5
         aFjwQ+nBNP7wA==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com,
        kuninori.morimoto.gx@renesas.com, tiwai@suse.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        perex@perex.cz, lgirdwood@gmail.com, mikhail_durnev@mentor.com,
        joe@perches.com
Cc:     kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <4c0e893cbfa21dc76c1ede0b6f4f8cff42209299.1634586167.git.christophe.jaillet@wanadoo.fr>
References: <4c0e893cbfa21dc76c1ede0b6f4f8cff42209299.1634586167.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: rsnd: Fix an error handling path in 'rsnd_node_count()'
Message-Id: <163587783174.970357.16497711772885268572.b4-ty@kernel.org>
Date:   Tue, 02 Nov 2021 18:30:31 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 21:44:16 +0200, Christophe JAILLET wrote:
> If we return before the end of the 'for_each_child_of_node()' iterator, the
> reference taken on 'np' must be released.
> 
> Add the missing 'of_node_put()' call.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rsnd: Fix an error handling path in 'rsnd_node_count()'
      commit: 173632358fde7a567f28e07c4549b959ee857986

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
