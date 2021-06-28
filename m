Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D9E3B69F2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 22:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbhF1VA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 17:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235991AbhF1VAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 17:00:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1182861CED;
        Mon, 28 Jun 2021 20:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624913878;
        bh=URL1jLAaNUk666AjBfkuIHGK7AVn9XByCzXInmJ6Nuk=;
        h=Date:From:To:Cc:Subject:From;
        b=MTahtqDhkFSIeCipWZcl7+tofHQKB0XPRIQYK1Ln9L1wUYF9etdRTSLHxgLIJfRuq
         mlK9Jg8bQIzQzz58qAz8BZcjvnpdQBFYcsqb1D+I78v8Mxo+MBycgodI8TuPE03sWI
         OQYCK0nkynBLvvZqLEoONcrNgeiQ6fDRSjWahh1dYtHTrbSzSi/Kfmh0bO9e29p4If
         coNh14E5/qPwNaGInD2j6YjlZiYWSS17Lr6tOHSEIQQvmJ3ffOLBBLq8najpiZUKQU
         ZB74pu0CY9nstfy/Anxwa4xQxylpkLXDbPbQ50XFRO3XMC8Hk2tlsiduBPmJJdIdxd
         Ra7b19oW1pEog==
Date:   Mon, 28 Jun 2021 15:59:47 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] fallthrough fixes for Clang for 5.14-rc1
Message-ID: <20210628205947.GA10869@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-fixes-clang-5.14-rc1

for you to fetch changes up to 40e67c120093a918037b6ec589bafd5d96b522a3:

  rxrpc: Fix fall-through warnings for Clang (2021-06-04 17:40:04 -0500)

----------------------------------------------------------------
fallthrough fixes for Clang for 5.14-rc1

Hi Linus,

Please, pull the following patches that fix many fall-through warnings
when building with Clang 12.0.0 and this[1] change reverted. Notice
that in order to enable -Wimplicit-fallthrough for Clang, such change[1]
is meant to be reverted at some point. So, these patches help to move
in that direction.

Thanks!

[1] commit e2079e93f562c ("kbuild: Do not enable -Wimplicit-fallthrough for clang for now")

----------------------------------------------------------------
Gustavo A. R. Silva (26):
      tee: Fix fall-through warnings for Clang
      atm: fore200e: Fix fall-through warnings for Clang
      watchdog: Fix fall-through warnings for Clang
      vxge: Fix fall-through warnings for Clang
      reiserfs: Fix fall-through warnings for Clang
      nfp: Fix fall-through warnings for Clang
      netxen_nic: Fix fall-through warnings for Clang
      bnxt_en: Fix fall-through warnings for Clang
      qlcnic: Fix fall-through warnings for Clang
      ipv4: Fix fall-through warnings for Clang
      braille_console: Fix fall-through warnings for Clang
      firewire: core: Fix fall-through warnings for Clang
      hwmon: (corsair-cpro) Fix fall-through warnings for Clang
      hwmon: (max6621) Fix fall-through warnings for Clang
      ide: Fix fall-through warnings for Clang
      net: netrom: Fix fall-through warnings for Clang
      net/packet: Fix fall-through warnings for Clang
      rds: Fix fall-through warnings for Clang
      sctp: Fix fall-through warnings for Clang
      tipc: Fix fall-through warnings for Clang
      xfrm: Fix fall-through warnings for Clang
      xfs: Fix fall-through warnings for Clang
      drm/nouveau: Fix fall-through warnings for Clang
      drm/nouveau/therm: Fix fall-through warnings for Clang
      drm/nouveau/clk: Fix fall-through warnings for Clang
      rxrpc: Fix fall-through warnings for Clang

 drivers/accessibility/braille/braille_console.c      | 1 +
 drivers/atm/fore200e.c                               | 1 +
 drivers/firewire/core-topology.c                     | 1 +
 drivers/gpu/drm/nouveau/nouveau_bo.c                 | 1 +
 drivers/gpu/drm/nouveau/nouveau_connector.c          | 1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.c       | 1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c    | 1 +
 drivers/hwmon/corsair-cpro.c                         | 1 +
 drivers/hwmon/max6621.c                              | 2 +-
 drivers/ide/siimage.c                                | 1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c            | 1 +
 drivers/net/ethernet/neterion/vxge/vxge-config.c     | 1 +
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c    | 1 +
 drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c | 1 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c       | 1 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c     | 1 +
 drivers/tee/tee_core.c                               | 1 +
 drivers/watchdog/machzwd.c                           | 1 +
 fs/reiserfs/namei.c                                  | 1 +
 fs/xfs/libxfs/xfs_ag_resv.c                          | 4 ++--
 fs/xfs/libxfs/xfs_alloc.c                            | 2 +-
 fs/xfs/libxfs/xfs_da_btree.c                         | 2 +-
 fs/xfs/scrub/agheader.c                              | 1 +
 fs/xfs/scrub/bmap.c                                  | 2 +-
 fs/xfs/scrub/btree.c                                 | 2 +-
 fs/xfs/scrub/common.c                                | 6 +++---
 fs/xfs/scrub/dabtree.c                               | 2 +-
 fs/xfs/scrub/repair.c                                | 2 +-
 fs/xfs/xfs_bmap_util.c                               | 2 +-
 fs/xfs/xfs_export.c                                  | 4 ++--
 fs/xfs/xfs_file.c                                    | 2 +-
 fs/xfs/xfs_inode.c                                   | 2 +-
 fs/xfs/xfs_ioctl.c                                   | 4 ++--
 fs/xfs/xfs_iomap.c                                   | 2 +-
 fs/xfs/xfs_log.c                                     | 1 +
 fs/xfs/xfs_trans_buf.c                               | 2 +-
 net/ipv4/ah4.c                                       | 1 +
 net/ipv4/esp4.c                                      | 1 +
 net/ipv4/fib_semantics.c                             | 1 +
 net/ipv4/ip_vti.c                                    | 1 +
 net/ipv4/ipcomp.c                                    | 1 +
 net/netrom/nr_route.c                                | 4 ++++
 net/packet/af_packet.c                               | 1 +
 net/rds/tcp_connect.c                                | 1 +
 net/rds/threads.c                                    | 2 ++
 net/rxrpc/af_rxrpc.c                                 | 1 +
 net/sctp/input.c                                     | 3 ++-
 net/tipc/link.c                                      | 1 +
 net/xfrm/xfrm_interface.c                            | 1 +
 49 files changed, 59 insertions(+), 22 deletions(-)
