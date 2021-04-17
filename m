Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992EB362D10
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 05:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhDQDKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 23:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhDQDKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 23:10:47 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE70C061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 20:10:21 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z1so34475787edb.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 20:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=85gK/G/W5iMoBK0GkeseBpRLSu6iilna997G3wOYzKA=;
        b=HZTGTUKH8dKDQI2cGgMS1199JU9pwVvYvJfVz2X/jLUwSNcdlBWa0RFaUmv1m7HrbG
         z64NOSpbvXOlflEQYZ6uGqMlG1AwvqN+gQumUEt8f1ZQk1Dm2HO6ZhyoJf+M/FC18UmC
         OwiJXRZnahH0CfG5nXtLVX75mf4BrOIupIPP6WYUKKYhqFixVzS7fe1CfrDOk0ZLl4i+
         JE+Z2KBJj+tu+BP72yw3A4pLlfv8F5SWEgWFGHwjAEHJiKRVXwnyCFKwRqR5SxIHRxmp
         NAlb9m3KZZCQxrMWTIGqNEuawCL32Zt0VZQB7mKOOKgbIjuzFpDpgAqLW0mdgjQLAgda
         58Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=85gK/G/W5iMoBK0GkeseBpRLSu6iilna997G3wOYzKA=;
        b=ICl+D4CbxtdQ16KnzRtDhUu41XQvFKCBBUTdIEUoevld2K7mMc7Hd19UE7oQnbYZAq
         f3TtP/9SrkIv1w/PFNekT03tR6MCCin2cZyagHDuMRaItbQ3t6Ne3WngQKF4iwHehGut
         CxDIvYyiWZwiwxfIc14wdpRUMXW8w6X2b179htwa3FB21Izzdhjx2KDsxKxcspgGEkNg
         eSVQe/4q9YEj2ZUMF6QsYPl1Wi+WZwa51wiKTtatGS4wTZpEnQfVHQ4eBxLQ6mmFmDk0
         guxMcTT4MPiyctZbHnoIW6Dq1EGEzk4b8NWRyT0ylA34GN7UkkkJoMzyf764nELMQ7/6
         Ns/w==
X-Gm-Message-State: AOAM533jjGOZPKBGXdyTNBraj0s4MqE8oFldhkdMCPx0ti68a29JNkni
        GTcv18XhqZR5TPf62fV3E3NQwA1rLCwwA45JFyoBOvSkcSGpyg==
X-Google-Smtp-Source: ABdhPJxibDvYnm5jZXB9xL9ugC35IBQa+u4EFVMOU0vRSWJYShmZ2JivPrMhNxQMTyH10JMPgfRru09bLKGrLW14XRc=
X-Received: by 2002:a50:e607:: with SMTP id y7mr13698021edm.18.1618629020103;
 Fri, 16 Apr 2021 20:10:20 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 16 Apr 2021 20:10:09 -0700
Message-ID: <CAPcyv4imrTM21eU+3ippyLcmHAo5V8_MtmyL49Z01-L1pg6HQQ@mail.gmail.com>
Subject: [GIT PULL] cxl fixes for v5.12-rc8 / final
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl
tags/cxl-fixes-for-5.12-rc8

...to receive a collection of fixes for the CXL memory class driver
introduced in v5.12-rc1.

The driver was primarily developed on a work-in-progress QEMU
emulation of the interface and we have since found a couple places
where it hid spec compat bugs in the driver, or had a spec
implementation bug itself. The biggest change here is replacing a
percpu_ref with an rwsem to cleanup a couple bugs in the error unwind
path during ioctl device init. Lastly there were some minor cleanups
to not export the power-management sysfs-ABI for the ioctl device, use
the proper sysfs helper for emitting values, and prevent subtle bugs
as new administration commands are added to the supported list.

The bulk of it has appeared in -next save for the top commit which was
found today and validated on a fixed-up QEMU model.

---

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl
tags/cxl-fixes-for-5.12-rc8

for you to fetch changes up to fae8817ae804a682c6823ad1672438f39fc46c28:

  cxl/mem: Fix memory device capacity probing (2021-04-16 18:21:56 -0700)

----------------------------------------------------------------
cxl for 5.12-rc8

- Fix support for CXL memory devices with registers offset from the BAR
  base.

- Fix the reporting of device capacity.

- Fix the driver commands list definition to be disconnected from the
  UAPI command list.

- Replace percpu_ref with rwsem to fix initialization error path.

- Fix leaks in the driver initialization error path.

- Drop the power/ directory from CXL device sysfs.

- Use the recommended sysfs helper for attribute 'show' implementations.

----------------------------------------------------------------
Ben Widawsky (1):
      cxl/mem: Fix register block offset calculation

Dan Williams (5):
      cxl/mem: Use sysfs_emit() for attribute show routines
      cxl/mem: Fix synchronization mechanism for device removal vs
ioctl operations
      cxl/mem: Do not rely on device_add() side effects for
dev_set_name() failures
      cxl/mem: Disable cxl device power management
      cxl/mem: Fix memory device capacity probing

Robert Richter (1):
      cxl/mem: Force array size of mem_commands[] to CXL_MEM_COMMAND_ID_MAX

 drivers/cxl/mem.c | 152 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 89 insertions(+), 63 deletions(-)
