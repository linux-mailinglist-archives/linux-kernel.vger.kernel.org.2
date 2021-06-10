Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5063A23B0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 07:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhFJFEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 01:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhFJFEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 01:04:16 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C486C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 22:02:08 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id u30so26117481qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 22:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cSluU5vaKyfQiGUNwoWJ6esHMBjkTpv/z4K50iX3xfw=;
        b=BvOwp8Y0h0rJPGsATmsyRpC6YyvgN1D4LChGHFOu2R7Lo6uiuJCd9M6paoB/HJqa8c
         shnQb/XnpDRA0EJGAxp1s0EycgSk5KnPgPMtSerQ7PVKKG687972fLF4U61dIyCJKCgM
         RrmQiJxEBUtebMVzX5yuY6NY0dF+pSjS8glRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cSluU5vaKyfQiGUNwoWJ6esHMBjkTpv/z4K50iX3xfw=;
        b=h5qx15hC0pPAH4MO/sSRtZo/wBbHdV0Kb4xK61xXCy43cUr99R8Dwb96wrMtuQv+9+
         Bf5NYD0ElKMRWSfP44p8RE5dlXDz9LjPUo5dsqpOdZHr2SzGdyiWIspP18xMknNeHJsX
         8h9bq9K1i4XEhenKTg9ltv6E7hvK6xF6V/A+IiI9j30ae01JLwmasVJIAaUb6xZLsDSu
         LYx1x6MXOajcU/YECFWNdThW8qfwrcejAOldEZVr4EhMAWnpBtPMARHMyd5dL6Q4h/Ns
         FoTpC6JySC2fCv0Mj5CjBZKukBnXGc3yZ64DnqVHMIw5xhrAVcL4K7AVlk09VGd74PWo
         JJBQ==
X-Gm-Message-State: AOAM533l86snVkOYROy1KbgXFo2UuWZ7Wjf+4uBNzJibgr/rPDRyP43u
        fg0acckXdm3UFV5L2Yd3dXGIS9qg7L1TLm6TWcs=
X-Google-Smtp-Source: ABdhPJzvuUTG906oGbIOJ0/7P8kr0G5X/T+pARvy7b3JMKDgJYmzFH7KIvGz8pO/VL/RCxx6/O5XCNiteAO5xIwWxoM=
X-Received: by 2002:a05:620a:2099:: with SMTP id e25mr2994655qka.487.1623301326541;
 Wed, 09 Jun 2021 22:02:06 -0700 (PDT)
MIME-Version: 1.0
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 10 Jun 2021 05:01:55 +0000
Message-ID: <CACPK8XencP__O6v28e+v0PD8wOTpfRRu_oyV-rin0tA64kdP7A@mail.gmail.com>
Subject: [GIT PULL] fsi changes for v5.14
To:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Jeffery <andrewrjeffery@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

Here are some FSI changes that I'd like you to take through the driver
tree for v5.14.

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git tags/fsi-for-v5.14

for you to fetch changes up to 9ab1428dfe2c66b51e0b41337cd0164da0ab6080:

  fsi/sbefifo: Fix reset timeout (2021-06-04 16:06:57 +0930)

----------------------------------------------------------------
FSI changes for v5.14

 - Bug fixes for the OCC, SCOM and SBEFIFO drivers

 - Performance fix for aspeed fsi master

 - Small fixes from the mailing lists

----------------------------------------------------------------
Colin Ian King (1):
      fsi: core: Fix return of error values on failures

Eddie James (6):
      fsi: scom: Reset the FSI2PIB engine for any error
      fsi: occ: Don't accept response from un-initialized OCC
      fsi: occ: Log error for checksum failure
      hwmon: (occ) Start sequence number at one
      hwmon: (occ) Print response status in first poll error message
      fsi: Aspeed: Reduce poll timeout

Joachim Fenkes (2):
      fsi/sbefifo: Clean up correct FIFO when receiving reset request from SBE
      fsi/sbefifo: Fix reset timeout

Joel Stanley (2):
      fsi: aspeed: Emit fewer barriers in opb operations
      fsi: scom: Remove retries

Yangtao Li (1):
      fsi: aspeed: convert to devm_platform_ioremap_resource

Zhen Lei (1):
      fsi: master-ast-cf: Remove redundant error printing in
fsi_master_acf_probe()

Zou Wei (1):
      fsi: Add missing MODULE_DEVICE_TABLE

 drivers/fsi/fsi-core.c          |   4 +-
 drivers/fsi/fsi-master-aspeed.c |  33 ++++++++-----
 drivers/fsi/fsi-master-ast-cf.c |   2 +-
 drivers/fsi/fsi-master-gpio.c   |   1 +
 drivers/fsi/fsi-occ.c           |  12 +++--
 drivers/fsi/fsi-sbefifo.c       |  10 ++--
 drivers/fsi/fsi-scom.c          | 105 +++++++++++++++-------------------------
 drivers/hwmon/occ/common.c      |   7 ++-
 8 files changed, 82 insertions(+), 92 deletions(-)
