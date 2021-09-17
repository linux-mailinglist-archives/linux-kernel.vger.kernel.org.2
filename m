Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5CE40F307
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbhIQHUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbhIQHUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:20:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80B9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:18:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c22so26412275edn.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vGE7DIiMh4Pf00LyduFfQ056mAGVsV2zVfLa9OmRkZc=;
        b=S9H9tO3IFlKPCUqDvW0JzMk8oJSldnjkTiJuhlPvrNUsU5VF7lHHOR5/4kLpF0t3jv
         5cf0gppQovznrrtdbJ5Jz+wc3GHduxD65epTGjLnKMeQiTaFN6J9QIBas/+6XqfR3fgL
         g7U9xm2OvDYgcBoTUeQdQMRY1uMUmE11pt1EALdXc3AdmBLuCnQMCAvyLUE1TqJb3sU2
         EinY8fHA4QPU8bccS5xm7T8UEvIUCrMCX0CS7CffYGJwEtxwndpTX/w64ig3ROLnPaSR
         nU93E1B2DMxkCpAwmqz4YCkISUWqm3Qi+xwPYKQMigqM2vAnNXgEtohk5zkTI/LcRPJ7
         Ltqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vGE7DIiMh4Pf00LyduFfQ056mAGVsV2zVfLa9OmRkZc=;
        b=Z1UqEjuESSfKbG6T6Noy8tviewshvimjoxW9r6GAseKFOelDFl1ro4BGmIuQaWzZwX
         Hs3P8D+zoJabml+KlhvC3hJ7llpxLoVunvdhT6kJog+xHMjkLElStMrSN/9bVrXRdBji
         tx7zT0CujUHuEA7+kNENZI6qrhYX4+bLyqGUDVQ8lGud3g9ET3i2m+uZDHGlCNX9lcmx
         /NxbOBf9mYErgwjQ4Z95aLrATn+JkCs9BTb2I2WjH1pgWt73HLk5JVWIskMFp0dXkHn0
         4Oo/WXWYDO8BIKXrrgWHwa1hcK2I/aNg8zSlLz1om7ScfTKLEAA+p0RALhQIOCfkQdhM
         tSdQ==
X-Gm-Message-State: AOAM532fcez9P5IrqvZnFhxSW8kwSVq6OXE36eSaPBBEhGkqRcREv0bn
        8tvn98T1ztaxziItlen9fRU=
X-Google-Smtp-Source: ABdhPJxu7w5+6CfZbMruB7rYcL1Vv6ClbYyZieIQ9M1pU4NFbnCHGw8OIT95WY0gYScTRA59p5Vx3g==
X-Received: by 2002:a17:906:c249:: with SMTP id bl9mr10576930ejb.225.1631863138262;
        Fri, 17 Sep 2021 00:18:58 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id q19sm2297140edc.74.2021.09.17.00.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 00:18:57 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v7 00/19] staging: r8188eu: shorten and simplify calls chains
Date:   Fri, 17 Sep 2021 09:18:18 +0200
Message-Id: <20210917071837.10926-1-fmdefrancesco@gmail.com>
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

v6->v7:
	- 1-14: 
		Add Dan Carpenter's "Reviewed-by" tag. No code changes;
	- 15:
		Add a list of clean-up changes to the commit messages
		and restore an empty line inadvertently deleted in a
		previous version;
	- 16:
		Add a list of clean-up changes to the commit messages;
	- 17-18:
		No changes;
	- 19:
		Delete an unnecessary test.	

v5->v6:
        - 1-14:
                Minimal changes to patch subjects to achieve consistent
                style;
        - 15:
                Fix a mistake in the checks of values returned by
                usb_control_msg();
        - 16-19:
                No changes.

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
        - 1-2:
                No changes;
        - 3:
                Fix the version number of the patch.

v1->v2:
        - 1-2:
                No changes;
        - 3:
                Replace parameter REALTEK_USB_VENQT_READ with REALTEK_USB_VENQT_WRITE
                in usb_control_msg_send().

v1: https://lore.kernel.org/lkml/20210904150447.14659-1-fmdefrancesco@gmail.com/
v2: https://lore.kernel.org/lkml/20210904212719.11426-1-fmdefrancesco@gmail.com/
v3: https://lore.kernel.org/lkml/20210904220048.12822-1-fmdefrancesco@gmail.com/
v4: https://lore.kernel.org/lkml/20210913181002.16651-1-fmdefrancesco@gmail.com/
v5: https://lore.kernel.org/lkml/20210915124149.27543-1-fmdefrancesco@gmail.com/
v6: https://lore.kernel.org/lkml/20210915211103.18001-1-fmdefrancesco@gmail.com/

Fabio M. De Francesco (4):
  staging: r8188eu: clean up usbctrl_vendorreq()
  staging: r8188eu: clean up rtw_read*() and rtw_write*()
  staging: r8188eu: shorten calls chain of rtw_read{8,16,32}()
  staging: r8188eu: shorten calls chain of rtw_write{8,16,32,N}()

Pavel Skripkin (15):
  staging: r8188eu: remove usb_{read,write}_mem()
  staging: r8188eu: remove the helpers of rtw_read8()
  staging: r8188eu: remove the helpers of rtw_read16()
  staging: r8188eu: remove the helpers of rtw_read32()
  staging: r8188eu: remove the helpers of usb_write8()
  staging: r8188eu: remove the helpers of usb_write16()
  staging: r8188eu: remove the helpers of usb_write32()
  staging: r8188eu: remove the helpers of usb_writeN()
  staging: r8188eu: remove the helpers of usb_read_port()
  staging: r8188eu: remove the helpers of usb_write_port()
  staging: r8188eu: remove the helpers of usb_read_port_cancel()
  staging: r8188eu: remove the helpers of usb_write_port_cancel()
  staging: r8188eu: remove core/rtw_io.c
  staging: r8188eu: remove struct _io_ops
  staging: r8188eu: remove shared buffer for usb requests

 drivers/staging/r8188eu/Makefile              |   1 -
 drivers/staging/r8188eu/core/rtw_io.c         | 299 ------------------
 drivers/staging/r8188eu/hal/usb_halinit.c     |   6 +-
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 261 ++++++++-------
 drivers/staging/r8188eu/include/drv_types.h   |   5 -
 drivers/staging/r8188eu/include/rtw_io.h      |  89 +-----
 drivers/staging/r8188eu/include/usb_ops.h     |   2 -
 .../staging/r8188eu/include/usb_ops_linux.h   |   8 -
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  48 +--
 .../staging/r8188eu/os_dep/usb_ops_linux.c    |  20 +-
 10 files changed, 167 insertions(+), 572 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/core/rtw_io.c

-- 
2.33.0

