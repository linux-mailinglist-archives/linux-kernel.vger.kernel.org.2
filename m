Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6393569D2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351174AbhDGKkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:40:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233718AbhDGKj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:39:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06AD3613A0;
        Wed,  7 Apr 2021 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791990;
        bh=vXi6EZ5Y2mHzlJnd1Cdr7bE3o2xIcpNUrfb+ef8l96U=;
        h=From:To:Cc:Subject:Date:From;
        b=VuxvPQLFGuSeIuofyflrGKfb0z0ZFlLV2PD0hkXEQnaW1yRIr81hnEM/AdQPrRa2v
         /SHsaxG9qUq8vVAVPPcMi8nAgXcoFlQcPnVPZGIqvmhg4C0Q0nXcXRAAK3GdnyhNZI
         XWA0G5asiLG7LuydLdw4LixVHijlb6cIPrz3f0LoV5axruDM3sRvpldX0MwRo+LoHa
         Hzmo+8aaM4jiHdtR7w2ZjHl8nOHBYqfPm5NxkyJFKBCHp8r+f49qxobDW092xYiChX
         S/dBjHDBbtsG4QCYIZfdXTDZxQPWTPUNVWPKfPEKijZ5gxADxBPv/vEEZ7l/q6oLgv
         fYud+zzEe+ZqQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5b4-0000EX-67; Wed, 07 Apr 2021 12:39:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/24] USB: serial: TIOCSSERIAL fixes and generic support
Date:   Wed,  7 Apr 2021 12:39:01 +0200
Message-Id: <20210407103925.829-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TIOCSSERIAL is a horrid, underspecified, legacy interface which for most
serial devices is only useful for setting the close_delay and
closing_wait parameters.

This series fixes up the various USB serial driver implementations,
before adding generic support to core for the benefit of all USB serial
drivers.

Johan


Johan Hovold (24):
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

 drivers/usb/serial/ark3116.c          | 13 ------
 drivers/usb/serial/f81232.c           | 11 ++---
 drivers/usb/serial/f81534.c           |  7 +---
 drivers/usb/serial/ftdi_sio.c         | 35 ++++------------
 drivers/usb/serial/io_edgeport.c      | 22 ----------
 drivers/usb/serial/io_ti.c            | 24 -----------
 drivers/usb/serial/mos7720.c          | 18 --------
 drivers/usb/serial/mos7840.c          | 23 -----------
 drivers/usb/serial/opticon.c          | 18 --------
 drivers/usb/serial/option.c           |  2 -
 drivers/usb/serial/pl2303.c           | 13 ------
 drivers/usb/serial/quatech2.c         | 16 --------
 drivers/usb/serial/ssu100.c           | 16 --------
 drivers/usb/serial/ti_usb_3410_5052.c | 38 +----------------
 drivers/usb/serial/usb-serial.c       | 59 +++++++++++++++++++++++----
 drivers/usb/serial/usb-wwan.h         |  4 --
 drivers/usb/serial/usb_wwan.c         | 45 --------------------
 drivers/usb/serial/whiteheat.c        | 17 +-------
 include/linux/usb/serial.h            |  2 +-
 19 files changed, 69 insertions(+), 314 deletions(-)

-- 
2.26.3

