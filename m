Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5CC3E39FD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 13:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhHHLbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 07:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhHHLbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 07:31:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 037ED6101D;
        Sun,  8 Aug 2021 11:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628422288;
        bh=92qWD8sTNHhxOHQgDUsVIP6UvOBYfIM2nmUo8Ta8Ftc=;
        h=Date:From:To:Cc:Subject:From;
        b=2C85e8YCglK8Eevp4s86/Nx+wzJzgVXqM4xRR1+emW/fFqyhtvGjD8i8LppQ3IvKc
         KOgB1WcYwr0cloz/S7xkxcbVWszIS613xcmnIXIre64G9cUSHv7EjyhUOlTWSn7k/q
         EDWu1fcrV/fQTgkMGB/VnWMwtERyXyJ1V+LSJk5M=
Date:   Sun, 8 Aug 2021 13:31:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver fixes for 5.14-rc5
Message-ID: <YQ/AjpNS3y41k/uT@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.14-rc5

for you to fetch changes up to c7b65650c7f41d3946c4e2f0bb56dfdb92cfe127:

  staging: mt7621-pci: avoid to re-disable clock for those pcies not in use (2021-07-27 15:48:43 +0200)

----------------------------------------------------------------
Staging driver fixes for 5.14-rc5

Here are a few small staging driver fixes for 5.14-rc5 to resolve some
reported problems.  They include:
	- mt7621 driver fix
	- rtl8723bs driver fixes
	- rtl8712 driver fixes.
Nothing major, just small problems resolved.

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      staging: rtl8723bs: select CONFIG_CRYPTO_LIB_ARC4

Pavel Skripkin (2):
      staging: rtl8712: get rid of flush_scheduled_work
      staging: rtl8712: error handling refactoring

Sergio Paracuellos (1):
      staging: mt7621-pci: avoid to re-disable clock for those pcies not in use

Xiangyang Zhang (1):
      staging: rtl8723bs: Fix a resource leak in sd_int_dpc

 drivers/staging/mt7621-pci/pci-mt7621.c   |  1 -
 drivers/staging/rtl8712/hal_init.c        | 30 ++++++++++++------
 drivers/staging/rtl8712/rtl8712_led.c     |  8 +++++
 drivers/staging/rtl8712/rtl871x_led.h     |  1 +
 drivers/staging/rtl8712/rtl871x_pwrctrl.c |  8 +++++
 drivers/staging/rtl8712/rtl871x_pwrctrl.h |  1 +
 drivers/staging/rtl8712/usb_intf.c        | 51 ++++++++++++++-----------------
 drivers/staging/rtl8723bs/Kconfig         |  1 +
 drivers/staging/rtl8723bs/hal/sdio_ops.c  |  2 ++
 9 files changed, 64 insertions(+), 39 deletions(-)
