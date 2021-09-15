Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CB940C571
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbhIOMna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237111AbhIOMn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:43:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F1AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:42:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id o20so5848771ejd.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfLPUTv3Y98OfQk3kQ+WNWuUKVMqNIKrc6gnxKnh8fE=;
        b=B86wVuGx5nIFDLwmC8pL+9z1ED7zEa4/usZZoDjg47TPUSuAdtMjopsaUUB8HjuEtA
         HWuyrfnzGeDcfyyI2rLW2egC+NHgmOKX4loaluSqEz4jkd8pyMYsjI1ChleGAlEuswLh
         MuDazYMZXUCBCEzvZetZcacfJWKEJvZqX4RhqlLGvowL71vhw4s9WBBWtKl3O9QjzUOC
         aaTbc0kul46CHj551lD6fhh+q9uzovsPaWmfZdDGq1cMP1WWc0YxbPj10Th9tKTfQADm
         F+zGw0iNw2CxfGj8IcMZOB+BeyLZI3+0Ew0XU6YQ4AvvZfn+yQmX9PQN97/zGjiJOZin
         zpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfLPUTv3Y98OfQk3kQ+WNWuUKVMqNIKrc6gnxKnh8fE=;
        b=gFKzeUcvWr0N4NUEK01miCEpCRJ5+vNV4OboTem0bHwteWh1MKqtQU9H5VF+GWT9W1
         hT7rhiSDNju2nqIzateG6TyAdmqJYaFYuBmrCv2AyHOmchWh0WmMhM0+OS6+kIAvr7fB
         wa+sbjGqSqg4T8w617ncp/4sJwr5gk9Pu//Ca2Yad9YmYqkN+wgOzFNsPywNy8v/lJXE
         jvHMDdb6XxfblqSH/VcB4GU55y6maeYzR2WfcLF4cSG23gEpTeovwLQvf/GIdcSpLPzY
         nvJTG221e/ZUV9iisS+Ms2G+fU7h4sC7dETOymyDBuUaoRGta0oHoA7vmg8/IciZW8KR
         /9FA==
X-Gm-Message-State: AOAM533arYvasQFoxrNy2RKi2bdQjND9zDE9+StEf5VLxcmZEgQSUmLU
        m2DqP5SoMr2PfG+K2ktkLgk=
X-Google-Smtp-Source: ABdhPJySQr654wYkbz6C3QB30y1S+tDRi1ogU8sXIKxM1N0Lbm3FSwXykjjGA7sNdI2aiAv2p4JefQ==
X-Received: by 2002:a17:906:c252:: with SMTP id bl18mr24267164ejb.519.1631709728367;
        Wed, 15 Sep 2021 05:42:08 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id s3sm6394002ejm.49.2021.09.15.05.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 05:42:07 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Philip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v5 00/19] staging: r8188eu: Shorten and simplify calls chain
Date:   Wed, 15 Sep 2021 14:41:30 +0200
Message-Id: <20210915124149.27543-1-fmdefrancesco@gmail.com>
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

Changelog:

v4->v5:
        - 1-14:
                No changes;
        - 15-16:
                Fix minor formatting issues and use "Reverse Xmas Tree" style,
                according to suggestions by David Laight and Dan Carpenter;
        - 17-18:
                Pavel Skripkin found logical errors in the checks of the
                values returned by usb_control_msg_{recv,send}(), so fix them;
                Dan Carpenter suggested to do error handling before success
                handling, so change the code accordingly;
        - 19:
                Add this patch in order to get rid of the shared buffer in
                usb_read() and usb_write() and remove this field from struct
                "dvobj_priv".

v3->v4:
        - 1-14:
                Split a patch into fourteen;
        - 15-16:
                Add these patches for clean-ups of the code that is going to be
                reused in 17-18/18;
        - 17-18:
                Make some changes according to a first review of Greg
                Kroah-Hartman; furthermore, remove the unnecessary while loop
                and a couple of if' test; handle the errors returned by
                usb_control_msg_recv().

v2->v3:
        - 1:
                No changes;
        - 3:
                Fix the version number of the patch.

v1->v2:
        - 1:
                No changes;
        - 3:
                Replace parameter REALTEK_USB_VENQT_READ with REALTEK_USB_VENQT_WRITE
                in usb_control_msg_send(). More in-depth explanation at
                https://lore.kernel.org/lkml/2791328.7pjKATJfGa@localhost.localdomain/T/#m1fc1ab2f7c1f463049ad88d5df5bb1b107b37260

v1: https://lore.kernel.org/lkml/20210904150447.14659-1-fmdefrancesco@gmail.com/
v2: https://lore.kernel.org/lkml/20210904212719.11426-1-fmdefrancesco@gmail.com/
v3: https://lore.kernel.org/lkml/20210904220048.12822-1-fmdefrancesco@gmail.com/
v4: https://lore.kernel.org/lkml/20210913181002.16651-1-fmdefrancesco@gmail.com/

Fabio M. De Francesco (4):
  staging: r8188eu: hal: Clean up usbctrl_vendorreq()
  staging: r8188eu: hal: Clean up rtw_read*() and rtw_write*()
  staging: r8188eu: Shorten calls chain of rtw_read8/16/32()
  staging: r8188eu: Shorten calls chain of rtw_write8/16/32/N()

Pavel Skripkin (15):
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
  staging: r8188eu: remove shared buffer for usb requests

 drivers/staging/r8188eu/Makefile              |   1 -
 drivers/staging/r8188eu/core/rtw_io.c         | 299 ------------------
 drivers/staging/r8188eu/hal/usb_halinit.c     |   6 +-
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 261 ++++++++-------
 drivers/staging/r8188eu/include/drv_types.h   |   5 -
 drivers/staging/r8188eu/include/rtw_io.h      |  89 +-----
 drivers/staging/r8188eu/include/usb_ops.h     |   2 -
 .../staging/r8188eu/include/usb_ops_linux.h   |   8 -
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  37 +--
 .../staging/r8188eu/os_dep/usb_ops_linux.c    |  20 +-
 10 files changed, 166 insertions(+), 562 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/core/rtw_io.c

-- 
2.33.0

