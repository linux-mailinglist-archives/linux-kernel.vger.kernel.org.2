Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E9D3D2EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 23:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhGVUXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 16:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231140AbhGVUXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 16:23:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7CB760EB0;
        Thu, 22 Jul 2021 21:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626987857;
        bh=jbfan/ad4AtRbhtiZPyjs39W0powLCWM992EzKzxNNc=;
        h=Date:From:To:Cc:Subject:From;
        b=gbo/Ef+FPAp6uIgzm5+lEHczmGasiPNtEqVkwNdRAKnU1zatoCtKZPnzQFhnaMrNY
         lG6HRp0goLKV5Yn9PeEG93vMBSTFN/OGbFpE9IUpNH5uwCy5trw1d/wrWxGfDKtTpj
         u06Ihkgv6iv16cFZJm4R2BXUJg6Insn7n006sCQmY9jPEcYKJzN+bc1C1F9xmQHezN
         p5GYqBW3Lw+JVGCRjIk9iev4qhBy0uyhjcPKicPxCOoyFGvICL5jJzwhEBBxOE5Jmb
         wiWdi1ORKfqZ4CNaBM3dAJ7airKIz4tqkQ77q3U6Zcjc46R91sQ3WKek3Vrqg16UdH
         QTXuPIA0DsaQQ==
Date:   Thu, 22 Jul 2021 16:06:39 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] array-bounds fixes for 5.14-rc3
Message-ID: <20210722210639.GA38674@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/array-bounds-fixes-5.14-rc3

for you to fetch changes up to 8d4abca95ecc82fc8c41912fa0085281f19cc29f:

  media: ngene: Fix out-of-bounds bug in ngene_command_config_free_buf() (2021-07-19 19:33:46 -0500)

----------------------------------------------------------------
array-bounds fixes for 5.14-rc3

Hi Linus,

Please, pull the following patch that fixes a couple of out-of-bounds
warnings in the media subsystem. This is part of the ongoing efforts
to globally enable -Warray-bounds.

Thanks!

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      media: ngene: Fix out-of-bounds bug in ngene_command_config_free_buf()

 drivers/media/pci/ngene/ngene-core.c |  2 +-
 drivers/media/pci/ngene/ngene.h      | 14 ++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)
