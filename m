Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F5D3B93AE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 17:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhGAPI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 11:08:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232297AbhGAPIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 11:08:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCB6561057;
        Thu,  1 Jul 2021 15:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625151955;
        bh=SGXDNAoHbDAWGJWY7tCmz8ZyyHE6AUy0PT34yR5Tr38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lCVMzb5Nssjh0nglvdx2FCaebQPZ/IJOooo/5Sp3rFhUJERIFmOsRNC2LdDd/mfrN
         lLSVVIvnwSFZDocLlRVprT1tdpZ46C/PoJRK2xbKFyMLdcw9gWC90y2DODHWYBDYV2
         SPxGbIXqCQBYEQYtfsan6yfaB3WdXr87MBDmJmCHCD0lyIvCO7G+SMn9eflUsObpNJ
         0YQnX1D5GTg/jhbtt9EJfgff62r8tEi+aL13vKh9CvYu7PqadsdcCSuhom97gBHDgi
         3Sdg4ZZaLY6gExDEIG3lk4fmZBqD581J/dfeAwyp1bDhsUXOGEl/vSYHIa+i1nPb6Z
         qbfkZTu7NVODA==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH] regulator: bd9576: Fix testing wrong flag in check_temp_flag_mismatch
Date:   Thu,  1 Jul 2021 16:05:25 +0100
Message-Id: <162514964461.20006.12568968851691518920.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210623153443.623856-1-axel.lin@ingics.com>
References: <20210623153443.623856-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2021 23:34:43 +0800, Axel Lin wrote:
> Fix trivial copy-paste typo.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: bd9576: Fix testing wrong flag in check_temp_flag_mismatch
      commit: 8888ef2304d0ae78f3d5ec19653fa7cc4ffdbd7a

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
