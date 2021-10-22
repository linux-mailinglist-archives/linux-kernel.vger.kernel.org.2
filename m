Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54489436EB5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 02:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhJVAN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 20:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhJVAN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 20:13:26 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4EBC061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 17:11:10 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id n2so2150765qta.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 17:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SHgmv1v605fk5zNuH6uTEOFWKB7wqQcKdt5cOhA/r1s=;
        b=ZPwK1RmhChCuQcUrP2kI3we4RxK7VZFGTRa2tXqF8Ywa2QVqCBTZpk+WZzl7vOMjVs
         6zFT2swN8oS1a+Kq4N2BZ/QPIsF290kOTdartZm0c6oK82h2igyJjjhlTHEwr0B9VWZS
         vyGS+/BDQbPNhYDtlnON6zPmpBkDMmyTaXSGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SHgmv1v605fk5zNuH6uTEOFWKB7wqQcKdt5cOhA/r1s=;
        b=PwCmwbRzbFbzavWi+xjhlEbQI7NiMsTueQWeaxW3ZxXN/Yyud3B1gbxXerPHEhtI3w
         YOtpxebPY26JcT5TXCqQKada1hiy2LlAEWlOXM5XtijtgPyEuiwAKp5fLOYQL/5bFMTV
         /lGKnj01/75cOuM/zDGzDdMgcN1wr3IaNZVC02LmyrkID9L8XY39aVV6y1ryTGh61oe1
         MaXK0UbZ2lWEf8IcZM40LqNY0BXHVFWeT30hmfvSAtddk3qjWsPWmxq/QkHxGwOdlgVK
         8tqffAPKcXPEm38J/vkAjJ4ujww9pJ39vPLR+n0DpqhHP/B7Us7WCtormrvQc3ytiOxs
         DsSg==
X-Gm-Message-State: AOAM531hUw0PJigP+AixUgmbVgTLi6GTHjYWsvEk1wg2FK8WlU9kU+Lw
        fP5ekbBTfzXuAR694yMRU1Hh/2/tVp4RVqUCdWQ=
X-Google-Smtp-Source: ABdhPJzQcZ8v30IbQO86b+PGUaVh5DsZgSOA8qAVVpb/DaSSFIXzeCBHBPGCuMRIU8LkxgxFpvuZa37JTPTIsQIoTC8=
X-Received: by 2002:ac8:5e49:: with SMTP id i9mr9307371qtx.145.1634861469391;
 Thu, 21 Oct 2021 17:11:09 -0700 (PDT)
MIME-Version: 1.0
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 22 Oct 2021 00:10:58 +0000
Message-ID: <CACPK8Xf0_D6P8ru5-UyqXQsF9uTejks8E1O06+1qTs7_R7No1w@mail.gmail.com>
Subject: [GIT PULL] fsi changes for v5.16
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrewrjeffery@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

Here are a set of FSI changes targeting the v5.16 merge window. They
have been through a few cycles of review on the list and appear ready
to be merged.

There are some dependent hwmon changes that Guenter has acked and
indicated he is ok with them going through the fsi tree.

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git tags/fsi-for-v5.16

for you to fetch changes up to 7cc2f34e1f4da07c791737cc6b3d965b31815ea0:

  fsi: sbefifo: Use interruptible mutex locking (2021-10-22 09:54:33 +1030)

----------------------------------------------------------------
FSI changes for v5.16

 - SBEFIFO usersapce interfaces to perform FFDC (First Failure
   Data Capture) and detect timeouts

 - A fix to handle multiple messages in flight

----------------------------------------------------------------
Eddie James (9):
      fsi: occ: Force sequence numbering per OCC
      hwmon: (occ) Remove sequence numbering and checksum calculation
      fsi: occ: Use a large buffer for responses
      fsi: occ: Store the SBEFIFO FFDC in the user response buffer
      docs: ABI: testing: Document the OCC hwmon FFDC binary interface
      hwmon: (occ) Provide the SBEFIFO FFDC in binary sysfs
      docs: ABI: testing: Document the SBEFIFO timeout interface
      fsi: sbefifo: Add sysfs file indicating a timeout error
      fsi: sbefifo: Use interruptible mutex locking

 .../ABI/testing/sysfs-bus-fsi-devices-sbefifo      |  10 +
 .../testing/sysfs-bus-platform-devices-occ-hwmon   |  13 ++
 drivers/fsi/fsi-occ.c                              | 218 ++++++++++++---------
 drivers/fsi/fsi-sbefifo.c                          |  28 ++-
 drivers/hwmon/occ/common.c                         |  30 ++-
 drivers/hwmon/occ/common.h                         |   3 +-
 drivers/hwmon/occ/p8_i2c.c                         |  15 +-
 drivers/hwmon/occ/p9_sbe.c                         |  90 ++++++++-
 include/linux/fsi-occ.h                            |   2 +
 9 files changed, 282 insertions(+), 127 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-fsi-devices-sbefifo
 create mode 100644
Documentation/ABI/testing/sysfs-bus-platform-devices-occ-hwmon
