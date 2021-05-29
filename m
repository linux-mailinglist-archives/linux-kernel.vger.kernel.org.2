Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C82394C81
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 16:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhE2O3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 10:29:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229798AbhE2O3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 10:29:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 378C961157;
        Sat, 29 May 2021 14:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622298461;
        bh=CEJszfmwt9KEme6y1tv68Z4DEm1xyYLgqmPhEF6z+0A=;
        h=Date:From:To:Cc:Subject:From;
        b=hvcxkgd4p+Jx35DNpP4HxcNaLDpolLp8rRHsbVV/+Ej/xtX9AeOKNyLevxNHSDoNl
         xUtLZHhz4eW8ay+VG6vS/lK2bScdreDyIzIIH+YpxBwLfNAdpVibs5rL31hpu3vcrD
         NX3bg0sZ2pzl2P6Cnmp6jN+TILsvOW6ZENZhUBqY=
Date:   Sat, 29 May 2021 16:27:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.13-rc4
Message-ID: <YLJPW4hAf5CAbXwh@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 50f09a3dd5877bda888fc25c3d98937dcfb85539:

  Merge tag 'char-misc-5.13-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc (2021-05-20 06:31:52 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.13-rc4

for you to fetch changes up to bbf0a94744edfeee298e4a9ab6fd694d639a5cdf:

  mei: request autosuspend after sending rx flow control (2021-05-27 15:17:19 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 5.13-rc4

Here are some tiny char/misc driver fixes for 5.13-rc4.

Nothing huge here, just some tiny fixes for reported issues:
	- 2 interconnect driver fixes
	- kgdb build warning fix for gcc-11
	- hgafb regression fix
	- soundwire driver fix
	- mei driver fix

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Usyskin (1):
      mei: request autosuspend after sending rx flow control

Anirudh Rayabharam (1):
      video: hgafb: correctly handle card detect failure during probe

Greg Kroah-Hartman (3):
      Merge tag 'soundwire-5.13-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire into char-misc-linus
      kgdb: fix gcc-11 warnings harder
      Merge tag 'icc-5.13-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-linus

Srinivas Kandagatla (1):
      soundwire: qcom: fix handling of qcom,ports-block-pack-mode

Subbaraman Narayanamurthy (1):
      interconnect: qcom: bcm-voter: add a missing of_node_put()

Zou Wei (1):
      interconnect: qcom: Add missing MODULE_DEVICE_TABLE

 drivers/interconnect/qcom/bcm-voter.c |  4 +++-
 drivers/misc/kgdbts.c                 |  3 ++-
 drivers/misc/mei/interrupt.c          |  3 +++
 drivers/soundwire/qcom.c              | 12 ++++++++++--
 drivers/video/fbdev/hgafb.c           |  2 +-
 5 files changed, 19 insertions(+), 5 deletions(-)
