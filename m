Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7928033242C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 12:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCILfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 06:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhCILfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 06:35:01 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5694FC06174A;
        Tue,  9 Mar 2021 03:35:01 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso5770207wmi.0;
        Tue, 09 Mar 2021 03:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=v7u+/xV3QKdov9B1WTObPx2BzVZdwCg4jskV5OYGlkA=;
        b=V3WI0GPWQyIGcjgIYQCtrZRV27jeHk3iMSBwP1Cv17RuVNXd/NOQ8N4WCzIicAYSOb
         dRqEj2GojMv4RHd3PE5cfT5Rps7cHljV7OebKreEV4g5yFG1KkdfjAQ/vZXS/Clr0IRP
         AKu03Orwk2RliqOGWAu7rHnQ7BtdhOj8XC4q6x7dmxwF1u9oGY7PmhIW9wnhlASunaF0
         1+TYGg7NG6x2qAKVk4fS/zmf8xmz+b54tVpftoY7oPZ8rhG50rVnBbhErmmNEGdE4+2A
         bURc+S+aH9PQPLyQZN/f9pbE4Pev+fysf2dbUJkwtNNeQmla4Pt8lU+drkBR23MJseXt
         KxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v7u+/xV3QKdov9B1WTObPx2BzVZdwCg4jskV5OYGlkA=;
        b=Mjh4ks9DPIf0pfTNZp3pOor1CBhuhIfNKDvhbxlQG313WbiGQvxgqFXbuM4//7muxy
         jErTkbwnCeMbAZHIo8D1EKU7alzYTrcve9/LmIZqKwiBzcfyXt+C1jHfRxR/Y2sae7Go
         rBy2Uve7EYB39By9o4srKu8X6ZUn13iRu/AfUIkrZ05KOncfZQtu1kZC0QPRMRHNGmWU
         97SeGrAq9wOMYimNZuq36YJ1UfJvo0lq6wQ82CAh4IZbNHYALVcPz1v1vIt1rGLe12MP
         XFIELZOILWHA0SovIRRssNlHsSYPvaWlCR3gBG9ci+OFETxosn1FnD+Y5ov/vHYEBEOF
         TCpA==
X-Gm-Message-State: AOAM531OQ1NIyZ274E7cSImmVU/7fb+4Z98GQTal0yhRzxA9QTQtaWMm
        Rb3pRDrrTpNow1TvopyGiTswgnTr+u2ngQ==
X-Google-Smtp-Source: ABdhPJwnYdVZJ5jrOI4hEsR5AxDGFNsDTBe5tPOyb01A8o3AIB7nCJHhFd8acUwm7yFKdUv0kuFWHg==
X-Received: by 2002:a1c:cc08:: with SMTP id h8mr3570871wmb.188.1615289700128;
        Tue, 09 Mar 2021 03:35:00 -0800 (PST)
Received: from ruhe.localdomain (93-173-65-134.bb.netvision.net.il. [93.173.65.134])
        by smtp.gmail.com with ESMTPSA id z1sm23654327wru.95.2021.03.09.03.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 03:34:59 -0800 (PST)
From:   eli.billauer@gmail.com
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
Subject: [PATCH v3 0/2] Submission of XillyUSB driver
Date:   Tue,  9 Mar 2021 13:34:23 +0200
Message-Id: <20210309113425.61296-1-eli.billauer@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eli Billauer <eli.billauer@gmail.com>

This is a resubmission of the XillyUSB driver, which is the USB
variant of the existing Xillybus driver.

Because these driver share some API related functions, this submission
consists of two patches:

(1) A patch moving away Xillybus' class related functions to a
    separate module file.
(2) A patch adding the new XillyUSB driver, based upon this new
    separate module.

As far as I can tell, the shared code between the Xillybus and XillyUSB
drivers covers everything that makes sense to share. I submit XillyUSB as a
staging driver, with the hope for a detailed review on this issue, as well
as a general code audit.

Thanks,
   Eli

Eli Billauer (2):
  char: xillybus: Move class-related functions to new xillybus_class.c
  staging: Add driver for XillyUSB (Xillybus variant for USB)

 MAINTAINERS                            |    1 +
 drivers/char/xillybus/Kconfig          |    4 +
 drivers/char/xillybus/Makefile         |    1 +
 drivers/char/xillybus/xillybus.h       |   10 +-
 drivers/char/xillybus/xillybus_class.c |  263 +++
 drivers/char/xillybus/xillybus_core.c  |  181 +-
 drivers/staging/Kconfig                |    2 +
 drivers/staging/Makefile               |    1 +
 drivers/staging/xillyusb/Kconfig       |   20 +
 drivers/staging/xillyusb/Makefile      |    6 +
 drivers/staging/xillyusb/TODO          |   13 +
 drivers/staging/xillyusb/xillyusb.c    | 2184 ++++++++++++++++++++++++
 include/linux/xillybus_class.h         |   30 +
 13 files changed, 2549 insertions(+), 167 deletions(-)
 create mode 100644 drivers/char/xillybus/xillybus_class.c
 create mode 100644 drivers/staging/xillyusb/Kconfig
 create mode 100644 drivers/staging/xillyusb/Makefile
 create mode 100644 drivers/staging/xillyusb/TODO
 create mode 100644 drivers/staging/xillyusb/xillyusb.c
 create mode 100644 include/linux/xillybus_class.h

-- 
2.17.1

