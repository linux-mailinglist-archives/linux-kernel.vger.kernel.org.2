Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E575336F41
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhCKJvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbhCKJu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:50:56 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8B6C061574;
        Thu, 11 Mar 2021 01:50:56 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id f12so1084383wrx.8;
        Thu, 11 Mar 2021 01:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=v7u+/xV3QKdov9B1WTObPx2BzVZdwCg4jskV5OYGlkA=;
        b=hF3fIxsLGBJ0FEzYEV2W0GgU8/yJ4EPnKKr5hHsn/iDmPV+8KsQSMfxJ+OTMQThVtC
         RY0tfBY4NE4TAYr1tf7BIl4Z+Kno8Tpkfz2vb5XixlZNbg11LvtG5faVxDpgoMO9MmqK
         Brj8ZU+duoetl0hjqJenU+0GK19niUzotwQ+ymvc+BeW0bd2AkkTQKB/VSQSx2UG9V6y
         p8xZgfVtRB2dO8YoZEURxlLGa/qsjWGCy/boWbEzk1Stm9E+AjCGu2zDvyP7bV/BxiUV
         09GOb+Wo6s9dMXGTl+LFZV3/j2TxP50KHWlv+1ZFtCseP7QyOl0Jgt0FRGlEn7yOPGzt
         3tog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v7u+/xV3QKdov9B1WTObPx2BzVZdwCg4jskV5OYGlkA=;
        b=oUdtnbJT83q8dnubaHZX1jqa5e6Frt61CBTPvG6hTf4HemNYgDyhJZtEheLA9s9G9v
         UJnG/CkTDYuSZbEnX8od7Ggwu0KAksEwQrPrHvTZsomz3AtfpVCD7tOrZLLcC0R6pnuc
         yAJMpeUA+WfvQSQmk263XNydH7sjT9g+DPYr+lmAJEeYfarcsRMwJTkuC7y6bBfFqLQa
         erTATKMNc5xzn5aB3XGM+hufea0D1YltM7+zanXm46rWTZBV2GoXdysC4MM+Swzg3dQ9
         OwSHJD7JIE9OaxKjLENYw+ujQoWuBcEcL67X6h10Jh9gyhCUFnugRshDQ41QXjYfsoWH
         cCHA==
X-Gm-Message-State: AOAM532FG4hQ87kvnySZYGhGxvT9nAlaDSs5hO94+KmOdnVfjvsX6+wJ
        LMku3jvzxHUhvwPY+bifrhE=
X-Google-Smtp-Source: ABdhPJx4iMjO1sLKUxIXX9hQKu0kZ/uv2L0MOdqIBzz26tGDyHhy3RPEEJ3CIU180z4XHlznGD8qKQ==
X-Received: by 2002:a5d:4e83:: with SMTP id e3mr7858865wru.82.1615456255306;
        Thu, 11 Mar 2021 01:50:55 -0800 (PST)
Received: from ruhe.localdomain (93-173-65-134.bb.netvision.net.il. [93.173.65.134])
        by smtp.gmail.com with ESMTPSA id h22sm3270337wmb.36.2021.03.11.01.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 01:50:54 -0800 (PST)
From:   eli.billauer@gmail.com
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, dan.carpenter@oracle.com,
        Eli Billauer <eli.billauer@gmail.com>
Subject: [PATCH v4 0/2] Submission of XillyUSB driver
Date:   Thu, 11 Mar 2021 11:50:31 +0200
Message-Id: <20210311095033.20956-1-eli.billauer@gmail.com>
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

