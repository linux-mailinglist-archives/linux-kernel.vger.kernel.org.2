Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8635F367CE4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhDVItz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:49:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235588AbhDVItx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:49:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3883761461;
        Thu, 22 Apr 2021 08:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619081359;
        bh=E+dWfMj/nLpw2VFslOXJHcISeam8xkkzk4UUIUMxH28=;
        h=Date:From:To:Cc:Subject:From;
        b=lZKQpE82zoj6126RPErpdEyobxdowFR1VrprFNU9bmqgKTwfsM97zbZN4Y/5+ciTA
         HPmDMZYDB6nkqz7Kr5Gis2ZSzlNZt53W03vpHkqUiuwbszCGjlndkx/PK6yYFXsqyf
         P/sTfDzxkDPXzniTy/yxu2YXtmJ+rnHFHSm1Xbqrw34gjBWDHfy2izeQ+ot9frJA5o
         bwYWZzZBZboDDZrX7K/1+2P61hEFWi6Vhj3oUeTnIwAm4nwm7CJWo6kgwPJxRhckSQ
         pKkunefbv/ScZpg4HIZTx2jnnuvIL/YMJ2WG+zSZ8mY+pry5Eo/EEfM6MS00ijD5qj
         Bg25mph6a+nlQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZV1Y-0007gi-0b; Thu, 22 Apr 2021 10:49:24 +0200
Date:   Thu, 22 Apr 2021 10:49:24 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial updates for 5.13-rc1
Message-ID: <YIE4lPAcXV1qYT64@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git usb-serial-5.13-rc1

for you to fetch changes up to 039b81d50a4822edfc07a7c2e6963823e993b2f0:

  USB: cdc-acm: add more Maxlinear/Exar models to ignore list (2021-04-13 18:37:22 +0200)

----------------------------------------------------------------
USB-serial updates for 5.13-rc1

Here are the USB-serial updates for 5.13-rc1, including:

 - better type detection for pl2303
 - support for more line speeds for pl2303 (TA/TB)
 - fixed CSIZE handling for the new xr driver
 - core support for multi-interface functions
 - TIOCGSERIAL and TIOCSSERIAL fixes
 - generic TIOCSSERIAL support (e.g. for closing_wait)
 - fixed return value for unsupported ioctls
 - support for gpio valid masks in cp210x
 - drain-delay fixes and improvements
 - support for multi-port devices for xr
 - generalisation of the xr driver to support three new device classes
   (XR21B142X, XR21B1411 and XR2280X)

Included are also various clean ups.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Colin Ian King (1):
      USB: serial: iuu_phoenix: remove redundant variable 'error'

Jiri Slaby (2):
      USB: serial: keyspan: drop unneeded forward declarations
      USB: serial: io_edgeport: drop unneeded forward declarations

Johan Hovold (67):
      USB: serial: pl2303: clean up type detection
      USB: serial: pl2303: amend and tighten type detection
      USB: serial: pl2303: rename legacy PL2303H type
      USB: serial: pl2303: tighten type HXN (G) detection
      USB: serial: pl2303: add device-type names
      USB: serial: xr: fix CSIZE handling
      USB: serial: drop unused suspending flag
      USB: serial: refactor endpoint classification
      USB: serial: add support for multi-interface functions
      USB: serial: xr: claim both interfaces
      USB: serial: ark3116: fix TIOCGSERIAL implementation
      USB: serial: f81232: fix TIOCGSERIAL implementation
      USB: serial: f81534: fix TIOCGSERIAL implementation
      USB: serial: ftdi_sio: fix TIOCGSERIAL implementation
      USB: serial: io_edgeport: fix TIOCGSERIAL implementation
      USB: serial: io_ti: fix TIOCGSERIAL implementation
      USB: serial: mos7720: fix TIOCGSERIAL implementation
      USB: serial: mos7840: fix TIOCGSERIAL implementation
      USB: serial: opticon: fix TIOCGSERIAL implementation
      USB: serial: pl2303: fix TIOCGSERIAL implementation
      USB: serial: quatech2: fix TIOCGSERIAL implementation
      USB: serial: ssu100: fix TIOCGSERIAL implementation
      USB: serial: ti_usb_3410_5052: fix TIOCGSERIAL implementation
      USB: serial: ti_usb_3410_5052: fix TIOCSSERIAL permission check
      USB: serial: usb_wwan: fix TIOCSSERIAL jiffies conversions
      USB: serial: usb_wwan: fix unprivileged TIOCCSERIAL
      USB: serial: usb_wwan: fix TIOCGSERIAL implementation
      USB: serial: whiteheat: fix TIOCGSERIAL implementation
      USB: serial: fix return value for unsupported ioctls
      USB: serial: add generic support for TIOCSSERIAL
      USB: serial: stop reporting legacy UART types
      USB: serial: ftdi_sio: ignore baud_base changes
      USB: serial: ftdi_sio: simplify TIOCGSERIAL permission check
      USB: serial: ftdi_sio: clean up TIOCSSERIAL
      USB: serial: io_ti: drop closing_wait module parameter
      USB: serial: io_ti: switch to 30-second closing wait
      USB: serial: ti_usb_3410_5052: drop closing_wait module parameter
      USB: serial: ti_usb_3410_5052: switch to 30-second closing wait
      USB: serial: io_edgeport: drop unused definitions
      USB: serial: do not use tty class device for debugging
      USB: serial: cp210x: provide gpio valid mask
      USB: serial: cp210x: add gpio-configuration debug printk
      USB: serial: f81232: drop time-based drain delay
      USB: serial: io_ti: document reason for drain delay
      USB: serial: ti_usb_3410_5052: reduce drain delay to one char
      USB: serial: ti_usb_3410_5052: drop drain delay for 3410
      USB: serial: io_ti: clean up vendor-request helpers
      USB: serial: io_ti: add send-port-command helper
      USB: serial: io_ti: add read-port-command helper
      USB: serial: io_ti: use kernel types consistently
      USB: serial: io_ti: drop unnecessary packed attributes
      USB: serial: ti_usb_3410_5052: drop unnecessary packed attributes
      USB: serial: ti_usb_3410_5052: clean up vendor-request helpers
      USB: serial: ti_usb_3410_5052: add port-command helpers
      USB: serial: ti_usb_3410_5052: use kernel types consistently
      USB: serial: ti_usb_3410_5052: clean up termios CSIZE handling
      USB: serial: xr: add support for XR21V1412 and XR21V1414
      USB: serial: xr: rename GPIO-mode defines
      USB: serial: xr: rename GPIO-pin defines
      USB: serial: xr: move pin configuration to probe
      USB: serial: xr: drop type prefix from shared defines
      USB: serial: xr: add type abstraction
      USB: serial: xr: add support for XR21B1421, XR21B1422 and XR21B1424
      USB: serial: xr: add support for XR21B1411
      USB: serial: xr: add support for XR22801, XR22802, XR22804
      USB: serial: xr: reset FIFOs on open
      USB: serial: xr: add copyright notice

Mauro Carvalho Chehab (1):
      USB: cdc-acm: add more Maxlinear/Exar models to ignore list

Michael G. Katzmann (1):
      USB: serial: pl2303: TA & TB alternate divider with non-standard baud rates

 drivers/usb/class/cdc-acm.c           |  14 +-
 drivers/usb/serial/ark3116.c          |  13 -
 drivers/usb/serial/cp210x.c           |  31 +-
 drivers/usb/serial/f81232.c           |  12 +-
 drivers/usb/serial/f81534.c           |   7 +-
 drivers/usb/serial/ftdi_sio.c         |  35 +-
 drivers/usb/serial/io_edgeport.c      |  67 +--
 drivers/usb/serial/io_edgeport.h      |  68 ---
 drivers/usb/serial/io_ti.c            | 210 ++++------
 drivers/usb/serial/io_ti.h            |  38 +-
 drivers/usb/serial/iuu_phoenix.c      |   4 +-
 drivers/usb/serial/keyspan.c          |  20 -
 drivers/usb/serial/metro-usb.c        |   4 +-
 drivers/usb/serial/mos7720.c          |  18 -
 drivers/usb/serial/mos7840.c          |  23 --
 drivers/usb/serial/opticon.c          |  18 -
 drivers/usb/serial/option.c           |   2 -
 drivers/usb/serial/pl2303.c           | 188 ++++++---
 drivers/usb/serial/quatech2.c         |  16 -
 drivers/usb/serial/ssu100.c           |  16 -
 drivers/usb/serial/ti_usb_3410_5052.c | 213 ++++------
 drivers/usb/serial/upd78f0730.c       |   7 +-
 drivers/usb/serial/usb-serial.c       | 226 +++++++---
 drivers/usb/serial/usb-wwan.h         |   4 -
 drivers/usb/serial/usb_wwan.c         |  45 --
 drivers/usb/serial/whiteheat.c        |  17 +-
 drivers/usb/serial/xr_serial.c        | 754 +++++++++++++++++++++++++++-------
 include/linux/usb/serial.h            |  10 +-
 28 files changed, 1158 insertions(+), 922 deletions(-)
