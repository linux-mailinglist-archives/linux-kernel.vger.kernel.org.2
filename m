Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B77441B78
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 14:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhKANHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 09:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhKANHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 09:07:12 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225F4C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 06:04:39 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id bk22so9655689qkb.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 06:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition;
        bh=WQPqQDiLhvV/d5Bc04mAhXoz4A2BL7RcUTO6TGSjmEw=;
        b=HEmGsizsOZBkvFuXHbws2/UxahAgPrscHmi6kLvwo+SyPMwpQbI69XPwG061/kc83O
         GQQ4g0svbPYw1Gk1OTStv6AxOAtOkaZegPbordviF/qq1/z+orjT7e33ZIWpwOnREDwL
         sD4ovDOs4jUeaaq99Ug1u4RXmF/slUpXuz1EaZknQ9nm6WTl2ssDXJgaA1myn9WraZUG
         WA/GR7a1qRruGBB57EUkJOhytmyzXXFjSCKGvPOfJQoF7Xsj0fEHeols9pAlmsENq1Qd
         vt+pzcnhL7pwKrcX4ujD1Jt4UpwcMtHkvhpC0UZJy0zy5aE/dtwuKUufYh4GGKCrXSqe
         Zu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition;
        bh=WQPqQDiLhvV/d5Bc04mAhXoz4A2BL7RcUTO6TGSjmEw=;
        b=w+MzM0JoEDQ+67uJyFqWkjJZZIzKFt4S5lrtN75LKxNtW1b/w5mp4xZtKBHWqZaHxn
         0oWSFPAtOk+sApeZsupsEmhEv6NVxP6qu/gOHyFD2B4L4LUSyDOBJFfWiG4G3edI26Ai
         HVH9qudXGolSUvog201Ta4gEo0U/uL5RuFSAELKpyBlljhSCRp2E1vzlwshNkI8fST/3
         p879EsjxAahN/SfNYfu4Jy8FhmoRYTQO8fheGec3WyI3prFb+Qj2C4lIT7FHx0LrVyym
         /bBUBpMtENbx3WhWEkPyrjym+CiVunZxXux01xgFXTSmfM1o8QVOpANK4chwGh5q/C4r
         5N2A==
X-Gm-Message-State: AOAM530DBaOXhI6pZK8TFEvlcUefK5+OO4OAaadlyN8VQZIkXGwLkzOy
        I8y4tnMcFv1gg7ROa5pFbQ==
X-Google-Smtp-Source: ABdhPJwPaO7ME9at+u556vFuMsrehpzQrj8P+WW8MY0JNOS0aZyDsSWCUbAyPsfSEvm29FtJsNt7rA==
X-Received: by 2002:a05:620a:4250:: with SMTP id w16mr22601599qko.485.1635771878221;
        Mon, 01 Nov 2021 06:04:38 -0700 (PDT)
Received: from serve.minyard.net ([47.184.156.158])
        by smtp.gmail.com with ESMTPSA id y8sm10289574qko.36.2021.11.01.06.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 06:04:37 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:cfe:2000:592b:61b1])
        by serve.minyard.net (Postfix) with ESMTPSA id 32E501800BA;
        Mon,  1 Nov 2021 13:04:36 +0000 (UTC)
Date:   Mon, 1 Nov 2021 08:04:35 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes and enhancements for 5.16
Message-ID: <20211101130435.GG4667@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.16-1

for you to fetch changes up to f281d010b87454e72475b668ad66e34961f744e0:

  ipmi: kcs_bmc: Fix a memory leak in the error handling path of 'kcs_bmc_serio_add_device()' (2021-10-29 07:23:59 -0500)

----------------------------------------------------------------
Updates for the IPMI driver

A new type of low-level IPMI driver is added for direct communication
over the IPMI message bus without a BMC between the driver and the bus.

Other than that, lots of little bug fixes and enhancements.

----------------------------------------------------------------
Christophe JAILLET (1):
      ipmi: kcs_bmc: Fix a memory leak in the error handling path of 'kcs_bmc_serio_add_device()'

Colin Ian King (1):
      ipmi: ipmb: Fix off-by-one size check on rcvlen

Corey Minyard (12):
      ipmi:watchdog: Set panic count to proper value on a panic
      ipmi: Disable some operations during a panic
      ipmi:devintf: Return a proper error when recv buffer too small
      ipmi: Check error code before processing BMC response
      ipmi: Fix a typo
      ipmi: Export ipmb_checksum()
      ipmi: Add support for IPMB direct messages
      ipmi:ipmb: Add initial support for IPMI over IPMB
      ipmi: Add docs for IPMB direct addressing
      ipmi: Add docs for the IPMI IPMB driver
      ipmi:ssif: Use depends on, not select, for I2C
      ipmi:ipmb: Add OF support

Joel Stanley (2):
      ipmi: bt-bmc: Use registers directly
      ipmi: bt: Add ast2600 compatible string

Randy Dunlap (1):
      ipmi: ipmb: fix dependencies to eliminate build error

Ye Guojin (1):
      char: ipmi: replace snprintf in show functions with sysfs_emit

 .../bindings/ipmi/aspeed,ast2400-ibt-bmc.txt       |   1 +
 .../devicetree/bindings/ipmi/ipmi-ipmb.yaml        |  59 +++
 Documentation/driver-api/ipmi.rst                  |  64 ++-
 drivers/char/ipmi/Kconfig                          |  11 +-
 drivers/char/ipmi/Makefile                         |   1 +
 drivers/char/ipmi/bt-bmc.c                         |  69 +--
 drivers/char/ipmi/ipmi_devintf.c                   |   8 +-
 drivers/char/ipmi/ipmi_ipmb.c                      | 539 +++++++++++++++++++++
 drivers/char/ipmi/ipmi_msghandler.c                | 330 +++++++++++--
 drivers/char/ipmi/ipmi_si_intf.c                   |   8 +-
 drivers/char/ipmi/ipmi_ssif.c                      |   4 +-
 drivers/char/ipmi/ipmi_watchdog.c                  |  25 +-
 drivers/char/ipmi/kcs_bmc_serio.c                  |   4 +-
 include/linux/ipmi.h                               |   3 +
 include/linux/ipmi_smi.h                           |  59 +++
 include/uapi/linux/ipmi.h                          |  16 +-
 16 files changed, 1078 insertions(+), 123 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ipmi/ipmi-ipmb.yaml
 create mode 100644 drivers/char/ipmi/ipmi_ipmb.c
