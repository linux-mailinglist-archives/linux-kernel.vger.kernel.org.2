Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0715D3E324F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 02:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhHGA2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 20:28:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25573 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229587AbhHGA2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 20:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628296071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tZ3lnrh2CwfspNnWsRa151N5FtNbghVO47moRJzJ0CI=;
        b=a4c0dPmBlX0SuBZS2KuaWCwhljcivuGLtz7LUTX8yxVMrCM51xvBq++QqYIB6aBbbqkYaJ
        23Lvb2SsadQXLy8dLSJlOmCUpOhpmsk2UuUElUStoXJC82AwWvtYtb4MPbm11wZiN2TzPe
        3LSh2LNrN+s+rWZkW5w7NDxwtRZom2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-w_-Aa5FtNpq9-kVvBb0N6Q-1; Fri, 06 Aug 2021 20:27:48 -0400
X-MC-Unique: w_-Aa5FtNpq9-kVvBb0N6Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9781593A8;
        Sat,  7 Aug 2021 00:27:46 +0000 (UTC)
Received: from jsavitz.bos.com (unknown [10.22.8.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB64B69FAD;
        Sat,  7 Aug 2021 00:27:45 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>, Lee Jones <lee.jones@linaro.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rpi-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Charles Mirabile <cmirabil@redhat.com>,
        Mwesigwa Guma <mguma@redhat.com>
Subject: [RFC PATCH 0/3] Raspberry Pi Sense HAT driver
Date:   Fri,  6 Aug 2021 20:27:19 -0400
Message-Id: <20210807002722.2634585-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

A couple of tests are available for this driver in this repo:
https://github.com/underground-software/sensehat/tree/master/tests
	- color_test displays various solid colors on the LED panel
	- framebuffer_test diplays a single lit cell that is
	  controllable via the arrow keys or the joystick

Though the driver is split into three modules, they are interdependent
and meaningless in isolation. As such, we have grouped them together.

This is a request for comments. Please let us know if you
have any suggestions, complements, or harsh criticism. ;)

Known issue:
- We do not know how to integrate the device tree overlay into mainline
  Linux. Fortunately, most Linux distrubtions designed for the Raspberry
  Pi already include the approriate device tree overlay as a part of
  their importation of all overlays from the downstream Raspberry Pi
  kernel. Suggestions are welcome and appreciated.

For more information about the Sense HAT, visit:
https://www.raspberrypi.org/products/sense-hat/

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>

Joel Savitz (3):
  drivers/mfd: rpisense: Raspberry Pi senseHAT core driver
  drivers/mfd: rpisense: Raspberry Pi senseHAT joystick driver
  drivers/mfd: rpisense: Raspberry Pi senseHAT 8x8 LED matrix display
    driver

 drivers/mfd/Kconfig            |  10 ++
 drivers/mfd/Makefile           |   3 +
 drivers/mfd/rpisense-core.c    | 170 +++++++++++++++++++++++
 drivers/mfd/rpisense-display.c | 242 +++++++++++++++++++++++++++++++++
 drivers/mfd/rpisense-js.c      | 132 ++++++++++++++++++
 include/linux/mfd/rpisense.h   |  55 ++++++++
 6 files changed, 612 insertions(+)
 create mode 100644 drivers/mfd/rpisense-core.c
 create mode 100644 drivers/mfd/rpisense-display.c
 create mode 100644 drivers/mfd/rpisense-js.c
 create mode 100644 include/linux/mfd/rpisense.h

-- 
2.27.0

