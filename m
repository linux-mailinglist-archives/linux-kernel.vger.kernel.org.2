Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276E840CE8C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhIOVMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhIOVMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:12:38 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF51C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:19 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t6so8520279edi.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oY3HGbrOF2mt1BGRMipDyincASpxkHi2fa1P9CCKn98=;
        b=UWhHDP4TFkZlolbythk/tC1BCOEUC0tdeXllzWskzXnrW45nyHs79dEbOBWrqE5EA2
         hdTk3SPt/NdXmwbLl92AmXLnSJz7egRBNOS5uX5jUb3ugH/ED84Tv7YbT07QK4HdhVc/
         xUc+JcacGgHOEa/2cGorLkqgeMM8Xm1GkgwGnL6RA9h+u++EyH5XF250xpT81TjDSqSS
         fHzq0xDPMCnOn1EPHFWA0p2uzYpnhJaaC3KEos3qdb0ZiWXLXj4J8Nig5W1NlkJEXB/3
         pISVwXA+7Y8nuOYEtatp4bKiHWMc4a1r7XOGF+mm6wd/6ps8EX7dQu1SdGzKBmNp9ewj
         7iGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oY3HGbrOF2mt1BGRMipDyincASpxkHi2fa1P9CCKn98=;
        b=gk3LeaACRY02RrhXKer68Otb6WAkl78ivbD5Ti1SFj5n9RcPc2x5xG3NkkOxPO2yyZ
         mDQ126bGB8BRMJ4HPx4SpTTo/V5ZCLFKznDR0cTrII2bh0cVAsN7zNlOi5d9qGqV1sWQ
         f3ZDowPHTyksF5q2Rcfru04WjYBaBp0Pe9pZDViAUfXYGrJp9/fmabrx9FUxRZehZNf7
         9jlhvF8sFbfuid86bAQNw5Nbs9fKKSwNQRQ/+nLs1v0TBdEnJNoDmqxnNNLukOHLIkhb
         o3D1+n7omv+Mg6Bad/2CmiR0reGelqEyDNyJqirgxc4iR36hekpL74EXi7kTnqbX6zwa
         HFFA==
X-Gm-Message-State: AOAM530Kqg7OY6TYG9Djk5+qfoAIlxXdtOaHfXVc7LFDV9yW6LHJVs0c
        uOnsYKFXdC0+Oz+9Z7VDsFw=
X-Google-Smtp-Source: ABdhPJzmjbd+2afGOT5gExnCyvOaVzU0/g0nY52JsN3kLUH5lDNbWhvMPeTuYaWo/Q81yPPPtDX8pA==
X-Received: by 2002:a05:6402:14c3:: with SMTP id f3mr2295146edx.312.1631740276984;
        Wed, 15 Sep 2021 14:11:16 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-105-169.retail.telecomitalia.it. [95.235.105.169])
        by smtp.gmail.com with ESMTPSA id t3sm511618edt.61.2021.09.15.14.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 14:11:16 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v6 00/19] staging: r8188eu: Shorten and simplify calls chains
Date:   Wed, 15 Sep 2021 23:10:44 +0200
Message-Id: <20210915211103.18001-1-fmdefrancesco@gmail.com>
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

Fabio M. De Francesco (4):
  staging: r8188eu: Clean up usbctrl_vendorreq()
  staging: r8188eu: Clean up rtw_read8/16/32() and rtw_write8/16/32/N()
  staging: r8188eu: Shorten calls chains of rtw_read8/16/32()
  staging: r8188eu: Shorten calls chains of rtw_write8/16/32/N()

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

