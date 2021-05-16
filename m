Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D30381D81
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 11:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbhEPJCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 05:02:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhEPJCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 05:02:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 464A36103E;
        Sun, 16 May 2021 09:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621155647;
        bh=kGMfcyr10SdkyxIcTSHAHAkouzifg6qsml+5rd/q51M=;
        h=Date:From:To:Cc:Subject:From;
        b=DJkwjmb4yPmxDaz0KRZmMn2+xkdlXYzRAR9jEhrzm2xPusMr/adtI2Yv0dnnphZoB
         wskWEPEXO/x2hBcY5AqSjd6Cy3KoGvv4QyKEGlaiDJtZyVkeK2LEbW76+oTEUQUGH2
         mv4nlJKhP2k94ujZYybwSBQb/Lagi78UjKWirApo=
Date:   Sun, 16 May 2021 11:00:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fixes for 5.13-rc2
Message-ID: <YKDfPQXx0g768cw4@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.13-rc2

for you to fetch changes up to bb4031b8af804244a7e4349d38f6624f68664bd6:

  clk: Skip clk provider registration when np is NULL (2021-05-11 08:47:25 +0200)

----------------------------------------------------------------
Driver core fixes for 5.13-rc2

Here are 2 driver fixes for driver core changes that happened in
5.13-rc1.

The clk driver fix resolves a many-reported issue with booting some
devices, and the USB typec fix resolves the reported problem of USB
systems on some embedded boards.

Both of these have been in linux-next this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Saravana Kannan (1):
      usb: typec: tcpm: Don't block probing of consumers of "connector" nodes

Tudor Ambarus (1):
      clk: Skip clk provider registration when np is NULL

 drivers/base/core.c           | 3 ++-
 drivers/clk/clk.c             | 9 +++++++++
 drivers/usb/typec/tcpm/tcpm.c | 9 +++++++++
 include/linux/fwnode.h        | 1 +
 4 files changed, 21 insertions(+), 1 deletion(-)
