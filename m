Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15930440527
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 23:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhJ2V4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 17:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37735 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230381AbhJ2V4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 17:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635544463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hqgiy2ZH+OFAPRITbn1OlFeu92K40RHfxkqwflCZe4I=;
        b=DSPR0p5y0AtkOjgqQ2GAelXOoGn3J0Bd+w2nC/6ObGXS9bub+GcPY4PKroV6KxWeYNFqXU
        JFwsjz6lJEYmNNmr/1cNusKKJgE2xIKKep6Av1VuPNiCpdjKiS1cqj0InpnXVy/6TSSjiE
        NNOdAbKJK9JU2HfWf369xcYLuKN4Uag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-bdhcYVAoOsGI_iIr4TGmIA-1; Fri, 29 Oct 2021 17:54:19 -0400
X-MC-Unique: bdhcYVAoOsGI_iIr4TGmIA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9B04362F8;
        Fri, 29 Oct 2021 21:54:18 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.8.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C06F18351;
        Fri, 29 Oct 2021 21:54:17 +0000 (UTC)
From:   Charles Mirabile <cmirabil@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Charles Mirabile <cmirabil@redhat.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rpi-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH 0/5] Raspberry Pi Sense HAT driver
Date:   Fri, 29 Oct 2021 17:55:11 -0400
Message-Id: <20211029215516.801593-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a set of drivers for operating the Sense HAT
peripheral device. This board is an add on for the Raspberry Pi that is
designed to connect using the GPIO connector via I2C.

It features:
	- a joystick
	- an 8x8 RGB LED matrix display
	- a whole bunch of environmental sensors with their own drivers
	  (those are already in upstream Linux)

This is a refactor of the work of Serge Schneider, the author of a
version of this driver that is currently in the Raspberry Pi downstream
kernel. We modified his code to make it suitable for upstream Linux.

A couple of tests are available for the driver in this repo:
https://github.com/underground-software/sensehat/tree/master/tests
	- color_test displays various solid colors on the LED panel
	- framebuffer_test diplays a single lit cell that is
	  controllable via the arrow keys or the joystick

For more information about the Sense HAT, visit:
https://www.raspberrypi.org/products/sense-hat/

Changes since v2:
	- We included a device tree binding in yaml form
	- Switched to regmap for all i2c communications
	- Fixed a few places where we had the old rpisense
	  name that we missed when renaming for v2

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>

Charles Mirabile (5):
  drivers/mfd: sensehat: Raspberry Pi Sense HAT core driver
  drivers/input/joystick: sensehat: Raspberry Pi Sense HAT joystick
    driver
  drivers/auxdisplay: senshat: Raspberry Pi Sense HAT display driver
  Documentation: bindings/mfd: sensehat: Raspberry Pi Sense HAT device
    tree binding
  MAINTAINERS: Add sensehat driver authors to MAINTAINERS

 .../bindings/mfd/raspberrypi,sensehat.yaml    |  50 ++++
 MAINTAINERS                                   |  11 +
 drivers/auxdisplay/Kconfig                    |   7 +
 drivers/auxdisplay/Makefile                   |   1 +
 drivers/auxdisplay/sensehat-display.c         | 258 ++++++++++++++++++
 drivers/input/joystick/Kconfig                |   8 +
 drivers/input/joystick/Makefile               |   1 +
 drivers/input/joystick/sensehat-joystick.c    | 135 +++++++++
 drivers/mfd/Kconfig                           |   8 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/sensehat-core.c                   | 164 +++++++++++
 include/linux/mfd/sensehat.h                  |  64 +++++
 12 files changed, 708 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
 create mode 100644 drivers/auxdisplay/sensehat-display.c
 create mode 100644 drivers/input/joystick/sensehat-joystick.c
 create mode 100644 drivers/mfd/sensehat-core.c
 create mode 100644 include/linux/mfd/sensehat.h

-- 
2.31.1

