Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0083340DEA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhCRTMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbhCRTLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:11:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF6CC06174A;
        Thu, 18 Mar 2021 12:11:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so3637421pjb.2;
        Thu, 18 Mar 2021 12:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dofdd3BCyTPrVyna7j0j7/lNL4uZ7+QSQmrpNUXo3UQ=;
        b=SAsdPjiT2tmJ2iazM/jeLpVMitANuHcKyjL/fzaRVw2QF+KJw4lyjZo18cfXIOjcGI
         mR6kTq/ROtazh3KefG+ChFwCOCXw92vuWS/uF3C1rsXwWgO97bUha9nYCgO0HSS10kz3
         j5pUImRoZIkJfAkbDszPdHyTJY9+Jx8dYKIM4oaQau4UuK6gFfWXH+xFm9DIoLx6tsFP
         2hn12D/1S+MoETuJrbHuBI+XEo6tnSorpMyf+WZSNvzkVQUOir+/yRhYqmAUWzyzpRjv
         fXe+vAyHsrHSN5WimuhdbWnw+INYeQP2mziL6ZD3FFQa3N49j1cRaGAElWij92Zo9TXL
         0POQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dofdd3BCyTPrVyna7j0j7/lNL4uZ7+QSQmrpNUXo3UQ=;
        b=EVaAX+hDACWYfJsZMyq8jIhZd3PJLjA+NZKLooq0YtVcHg3ISNHGiYkzuipNIa9WlD
         Dzpu3qOQ1GPIUeePTBqfYvq1iZtvNEB+uMYvaovzDSgz6+GksAQ10lybajeAi5jEKOHb
         DLVjE1dKOK3JrUZ6HwsPtQiJ36emNyEZzhwOypVap71qWa9JDZoue2oYmB96YunOd9yU
         v8BHt4aWAMy9bEAsNdXvb3Zf6Lz+wHIpOnkES7lSFeODmAdVHNQgcTUeerKQ19PASXk6
         NdlduSwIeCv7xadg0/tA+VKd0HXPQuAuupn8qYjMOGDLNHFLOwb9eo6ZVNnI18nLNGre
         dQUA==
X-Gm-Message-State: AOAM530dJh4brMS0gpAPY+02lobCDsZ0Gx5PJX2UPbkcJQE0TdgqFcHW
        9jEibTZ1DnlwdfLNNYKU1++4OP/bvYM=
X-Google-Smtp-Source: ABdhPJxsu5Tc5aMjRYKgn+kQk0AcXuLxXgk3mx/W347/sslyzjIr+6/ejG8h4aGUl9jOfM4RsTVLdw==
X-Received: by 2002:a17:90a:bb95:: with SMTP id v21mr5673976pjr.30.1616094706481;
        Thu, 18 Mar 2021 12:11:46 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id na8sm3020711pjb.2.2021.03.18.12.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 12:11:46 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v6 0/2] 8250: Add driver for Broadcom UART
Date:   Thu, 18 Mar 2021 15:11:29 -0400
Message-Id: <20210318191131.35992-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v6 - A few more changes based on requests from Greg Kroah-Hartman
     - Don't save the debugfs file handle in priv because it was
       never used.
     - Change all dev_info() messages to dev_dbg() messages.
   - Fix warnings from the kernel test robot
   - Use --base with "git format-patch"
   - Fixes in the .yaml file based on requests from Rob Herring
     - Change "oneOf" to "minItems: 1".
     - Reference serial.yaml instead of using "$nodname".
     - Add missing newline.

v5 - Changes based on requests from Greg Kroah-Hartman
     - Move sysfs stats to debugfs.
     - Merge the .h file into the .c file.
     - Convert "flags" with only one flag to bool
     - Remove most dev_dbg() messages. Some can be replaced by using
       ftrace and some would cause a crash if the driver was used
       for the console.

v4 - Fix MAINTAINERS
   - Make all changes requested by Jira Slaby. The only functional
     change was to handle errors returned by brcmuart_arbitration()
     in brcmuart_resume().

v3 - remove "disable_dma" module param because it can be done
     by modifying the device tree node instead. Reduce size by
     removing some debug fuctionality that was no longer used.
   - Fix error from yaml compiler in bindings

v2 - remove the patch that modified 8250_of.c to keep it from
     registering before this driver when this driver was deferred
     as it was getting it's "clocks". This was fixed by changing
     the Device Tree entry to remove "clock-frequency". This results
     in both drivers getting "clocks" and getting same the deferral.


Al Cooper (2):
  dt-bindings: Add support for the Broadcom UART driver
  serial: 8250: Add new 8250-core based Broadcom STB driver

 .../bindings/serial/brcm,bcm7271-uart.yaml    |   95 ++
 MAINTAINERS                                   |    8 +
 drivers/tty/serial/8250/8250_bcm7271.c        | 1202 +++++++++++++++++
 drivers/tty/serial/8250/Kconfig               |   10 +
 drivers/tty/serial/8250/Makefile              |    1 +
 5 files changed, 1316 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
 create mode 100644 drivers/tty/serial/8250/8250_bcm7271.c


base-commit: bf152b0b41dc141c8d32eb6e974408f5804f4d00
-- 
2.17.1

