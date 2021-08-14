Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F473EC3EE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 18:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbhHNQv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 12:51:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233116AbhHNQvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 12:51:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A87CD60FC1;
        Sat, 14 Aug 2021 16:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628959850;
        bh=iiuMofXzRk6v81QnjzS89U7OMiEid8a03rKgMEXE3SU=;
        h=Date:From:To:Cc:Subject:From;
        b=pwkbJyyfYCt5FauavwpFMY9380wHxURzWRZFGPGTLRPID6gRDhYUWpSIutD3bTP1Y
         zW2YO2EqBpPuQQkeHY9+4Zm/OxsSfrM2gkyqeKtxYXXZ/X9LRCih1it9KMdQQStl9N
         RKTvmvTRAh4RcA4byHZzBtVHKW1jDXrUXmjM53Mg=
Date:   Sat, 14 Aug 2021 18:50:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] IIO driver fixes for 5.14-rc6
Message-ID: <YRf0Zwu0SySEe2g9@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 36a21d51725af2ce0700c6ebcb6b9594aac658a6:

  Linux 5.14-rc5 (2021-08-08 13:49:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.14-rc6

for you to fetch changes up to a5056c0bc24f6c9982cfe6f4e3301f3c7d682191:

  Merge tag 'iio-fixes-5.14a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2021-08-10 08:54:36 +0200)

----------------------------------------------------------------
IIO fixes for 5.14-rc6

Here are some small IIO driver fixes for reported problems for 5.14-rc6
(no staging driver fixes at the moment).

All of them resolve reported issues and have been in linux-next all week
with no reported problems.  Full details are in the shortlog.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Antti Keränen (1):
      iio: adis: set GPIO reset pin direction

Arnd Bergmann (1):
      iio: accel: fxls8962af: fix i2c dependency

Chris Lesiak (1):
      iio: humidity: hdc100x: Add margin to the conversion time

Colin Ian King (1):
      iio: adc: Fix incorrect exit of for-loop

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-5.14a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus

Maxime Ripard (1):
      dt-bindings: iio: st: Remove wrong items length check

Sean Nyekjaer (1):
      iio: accel: fxls8962af: fix potential use of uninitialized symbol

Uwe Kleine-König (1):
      iio: adc: ti-ads7950: Ensure CS is deasserted after reading channels

 .../devicetree/bindings/iio/st,st-sensors.yaml     | 41 ----------------------
 drivers/iio/accel/Kconfig                          |  2 ++
 drivers/iio/accel/fxls8962af-core.c                |  2 +-
 drivers/iio/adc/palmas_gpadc.c                     |  4 +--
 drivers/iio/adc/ti-ads7950.c                       |  1 -
 drivers/iio/humidity/hdc100x.c                     |  6 ++--
 drivers/iio/imu/adis.c                             |  3 +-
 7 files changed, 10 insertions(+), 49 deletions(-)
