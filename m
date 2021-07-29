Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EFD3DAABD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 20:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhG2SF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 14:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231741AbhG2SFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 14:05:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0255D60F48;
        Thu, 29 Jul 2021 18:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627581951;
        bh=8zGF+OBoP8ttiKmrQ7W7ZNfkGg4xx8z7Inx+6zv+QcA=;
        h=Date:From:To:Cc:Subject:From;
        b=HBFKmVYg+GW2yxpX1XqqkIhpQG9De+xExuYAE96Sn6X4cR1/5OM/+xdo1M7j7dKbb
         RdGT7Jwhp004Ul13WwlCxTWa5MzvDG+YbO5cq3M2FZeHpWyF0at4hu7v5N0JpkbzGS
         ybCeHa2hFTxJF1KK356Al9/PNB7U1kBZqv2pziDdFMeUkJo/hPW5KePPAdC6jAOkZg
         5r2vwbmCOFJXeTOoPqzGZyhA+8nFusy+ZIe//tpKu9pkzHkJCxHujAdPho3sPP7Vy5
         nkWLkeHUukL7FRySu8BmHK0ZU50EW1nIhLglK/laR96rFGXFWC9abohC4l4cYFcg8s
         f+8oFVQ+RVWhw==
Date:   Thu, 29 Jul 2021 13:08:23 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] fallthrough fixes for Clang for 5.14-rc4
Message-ID: <20210729180823.GA7908@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ff1176468d368232b684f75e82563369208bc371:

  Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-fixes-clang-5.14-rc4

for you to fetch changes up to cb163627e6d32dbaca4d89b2292788cee895b06d:

  scsi: fas216: Fix fall-through warning for Clang (2021-07-29 12:51:16 -0500)

----------------------------------------------------------------
fallthrough fixes for Clang for 5.14-rc4

Hi Linus,

Please, pull the following patches that fix some fall-through warnings
when building with Clang and -Wimplicit-fallthrough on ARM.

Thanks

----------------------------------------------------------------
Gustavo A. R. Silva (3):
      ARM: riscpc: Fix fall-through warning for Clang
      scsi: acornscsi: Fix fall-through warning for clang
      scsi: fas216: Fix fall-through warning for Clang

 arch/arm/mach-rpc/riscpc.c   | 1 +
 drivers/scsi/arm/acornscsi.c | 1 +
 drivers/scsi/arm/fas216.c    | 1 +
 3 files changed, 3 insertions(+)
