Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294343FECFD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 13:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343647AbhIBL3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 07:29:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245652AbhIBL3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 07:29:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E5B4610A0;
        Thu,  2 Sep 2021 11:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630582125;
        bh=rCfLAh2B0f7199IX3qnnYQSRiMtH1/jQIkrV5hJSRdE=;
        h=From:To:Cc:Subject:Date:From;
        b=MKs3oawntu6/+piP+pXzuI3ki+5+nTwR/xyK5PacnDS9529K+tvmezmwLDPI0V73v
         ul0Xm49aorohSfW/YP/W0mZ8+SQ0LXMBJdDy0plQavhtCO/pt+iG01IXe8N5UAbawh
         UfkMPQtkcBfh4j2qY9LIo1FOwNDIfN92CVMmCpk+11vvrXRAp0kUe1KS79NKN2CW+a
         YBLbClkO/eDg6eUaw2NyzbD8EAA5I3DvgQP4Ge1Uyy5gSNa1Liobv/REXYWs5dgonN
         SpwI+mxazLjT46W4CylkSoCrxwIBClObt5EWVrHImz83IjDaVfTloqlGCk/xz8T/yF
         k8R+SJKBsDDrg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mLktf-0004ZL-4W; Thu, 02 Sep 2021 13:28:43 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Make USB ports to work on HiKey960/970
Date:   Thu,  2 Sep 2021 13:28:33 +0200
Message-Id: <cover.1630581434.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

It follows the patchset adding a DT schema needed to power on and to
use the integrated USB HUB found on HiKey 960 and Hikey 970 boards.

The entire series  which contains the remaining patches to support
PCI and USB on HiKey970, and USB on HiKey960 was updated at:

    https://github.com/mchehab/linux/commits/linux-next

Those patches are based on linux-next tree (next-20210831), as they
depend on some patches that will likely be merged up to v5.15-rc1.

Tested on HiKey 960:

	$ lsusb
	Bus 002 Device 002: ID 0424:5734 Standard Microsystems Corp. 
	Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
	Bus 001 Device 004: ID 0424:2740 Standard Microsystems Corp. 
	Bus 001 Device 003: ID 046d:c52b Logitech, Inc. Unifying Receiver
	Bus 001 Device 002: ID 0424:2734 Standard Microsystems Corp. 
	Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

Tested on HiKey 970:
	
	$ lsusb
	Bus 002 Device 002: ID 0451:8140 Texas Instruments, Inc. TUSB8041 4-Port Hub
	Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
	Bus 001 Device 003: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)
	Bus 001 Device 002: ID 0451:8142 Texas Instruments, Inc. TUSB8041 4-Port Hub
	Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

v3:
  - The examples at the dt-bindings were updated to reflect
    the actual DTS content and won't produce any warnings;
  - Added John Stultz SoB to Hikey960 DTS patch;
  - Added a patch for the mux hub driver for it to work with
    the newer schema;

John Stultz (1):
  arm64: dts: hisilicon: Add usb mux hub for hikey960

Mauro Carvalho Chehab (2):
  misc: hisi_hikey_usb: change the DT schema
  arm64: dts: hisilicon: Add usb mux hub for hikey970

Yu Chen (1):
  dt-bindings: misc: add schema for USB hub on Kirin devices

 .../bindings/misc/hisilicon,hikey-usb.yaml    | 108 ++++++++++++++++++
 .../boot/dts/hisilicon/hi3660-hikey960.dts    |  35 +++++-
 .../boot/dts/hisilicon/hi3670-hikey970.dts    |  23 ++++
 drivers/misc/hisi_hikey_usb.c                 |  81 ++++++-------
 4 files changed, 199 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml

-- 
2.31.1


