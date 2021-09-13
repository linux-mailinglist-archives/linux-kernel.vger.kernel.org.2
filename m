Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2882F409BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346634AbhIMSLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346615AbhIMSLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:11:40 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85401C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:10:23 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id x11so23019878ejv.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W9vZwmlkrDBjvEWyCMDm/dnLCct5DvZtNMR1EOH464M=;
        b=O+XyRFkRhNILNdeUWZgUoamaUVDiY4Van3n3NvBFXRPsO/RNK3cBvycVR5kV5P4A1C
         0LIVBpLG6/ihvlIP+w3eaB9judjq+TEFuK+e8Ld04dr7PdMqwJeYqxlcpeBmELzGYYj3
         msFdvvAbG6wrDaEtX6A09Cq14sX6lTccRUb7ptWguk8/yt/q1G4UqP5i7Ilv5L1hQSdz
         eBJ5W5I+U5EP6JGKSDWgorAJIoLGcvoUdK2nRYgg1THK1ndbLcy8Alb/CAzpdRe6bcTp
         Su2UjZJskkUVZwcjwOKg2lzX8/lTY5SIGD0BJZmPMVO5koGfBlmDeGqEDS2FuWwQJ7eb
         f2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W9vZwmlkrDBjvEWyCMDm/dnLCct5DvZtNMR1EOH464M=;
        b=uPZl71SUqj++KKck/ucWfTZpArEP432/b7cKxZfg07DAwOovPuRVTUlxvfOpNVnc/A
         3p+iHcN9rg63LBz7uEzb5Tk2DaXiD+9pIiKIJ8urVQ8MU3UXigMmsed8MObDcybE760E
         F+xCvWUgisZ/wQhoUX83YLjuftzH402Fba8W/PfHXdrexNZO8DOjFReSG8rH5/OM51Z6
         +KMC9ZLAdJATfsdSfj01hAdxWCR0/MF//ZUYo0EjuOkynV1GQtG1SJ61DWD+M41zlq8a
         oLGhzh25vUnLCcYHsk0blDLX3R5Vx1U4xVVottTcJTFK1oZn8yGb+YLHNXg53BqfX9z+
         BEGA==
X-Gm-Message-State: AOAM532xmxtzU6Mbl5nHGuaarb6L9vS0RP1122R6Rcs//O3A5SBUt4dm
        eepC4Cr8mI+Fp0+mlzn4bas=
X-Google-Smtp-Source: ABdhPJyCAxJTcYtbPJOTf3H833YeEg4AAyF8nk4KVRiBXBpuEs0lBnPEOJJafFv4DQ5K4SAMD/8W5A==
X-Received: by 2002:a17:906:2bc7:: with SMTP id n7mr13605981ejg.238.1631556622092;
        Mon, 13 Sep 2021 11:10:22 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id d25sm4258999edt.33.2021.09.13.11.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:10:21 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v4 00/18] staging: r8188eu: Shorten and simplify calls chain
Date:   Mon, 13 Sep 2021 20:09:44 +0200
Message-Id: <20210913181002.16651-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

io_ops abstraction is useless in this driver, since there is only one ops
registration. Without io_ops we can get rid of indirect calls mess and
shorten the calls chain.

Shorten the calls chain of rtw_read8/16/32() down to the actual reads.
For this purpose unify the three usb_read8/16/32 into the new
usb_read(); make the latter parameterizable with 'size'; embed most of
the code of usbctrl_vendorreq() into usb_read() and use in it the new
usb_control_msg_recv() API of USB Core.

Shorten the calls chain of rtw_write8/16/32() down to the actual writes.
For this purpose unify the four usb_write8/16/32/N() into the new
usb_write(); make the latter parameterizable with 'size'; embed most of
the code of usbctrl_vendorreq() into usb_write() and use in it the new
usb_control_msg_send() API of USB Core.

The code with the modifications was thoroughly tested by Pavel Skripkin
using a TP-Link TL-WN722N v2 / v3 [Realtek RTL8188EUS] and by Fabio M.
De Francesco using a ASUSTek Computer, Inc. Realtek 8188EUS [USB-N10 Nano].

Fabio M. De Francesco (4):
  staging: r8188eu: hal: Clean up usbctrl_vendorreq()
  staging: r8188eu: hal: Clean up rtw_read*() and rtw_write*()
  staging: r8188eu: Shorten calls chain of rtw_read8/16/32()
  staging: r8188eu: Shorten calls chain of rtw_write8/16/32/N()

Pavel Skripkin (14):
  staging: r8188eu: remove usb_{read,write}_mem
  staging: r8188eu: remove the helpers of rtw_read8()
  staging: r8188eu: remove the helpers of rtw_read16()
  staging: r8188eu: remove the helpers of rtw_read32()
  staging: r8188eu: remove the helpers of usb_write8
  staging: r8188eu: remove the helpers of usb_write16
  staging: r8188eu: remove the helpers of usb_write32
  staging: r8188eu: remove the helpers of usb_writeN
  staging: r8188eu: remove the helpers of usb_read_port
  staging: r8188eu: remove the helpers of usb_write_port
  staging: r8188eu: remove the helpers of usb_read_port_cancel
  staging: r8188eu: remove the helpers of usb_write_port_cancel
  staging: r8188eu: remove core/rtw_io.c
  staging: remove struct _io_ops

 drivers/staging/r8188eu/Makefile              |   1 -
 drivers/staging/r8188eu/core/rtw_io.c         | 299 ------------------
 drivers/staging/r8188eu/hal/usb_halinit.c     |   6 +-
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 250 ++++++++-------
 drivers/staging/r8188eu/include/rtw_io.h      |  89 +-----
 drivers/staging/r8188eu/include/usb_ops.h     |   2 -
 .../staging/r8188eu/include/usb_ops_linux.h   |   8 -
 drivers/staging/r8188eu/os_dep/usb_intf.c     |   8 +-
 .../staging/r8188eu/os_dep/usb_ops_linux.c    |  20 +-
 9 files changed, 157 insertions(+), 526 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/core/rtw_io.c

-- 
2.33.0

