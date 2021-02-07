Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C895312670
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 18:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhBGRiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 12:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhBGRiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 12:38:00 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C1FC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 09:37:19 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id r13so5946033qvm.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 09:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=j9qX/HSwLIMkP63Z3KVtmxMD254RgIGqBGNpCVomjWY=;
        b=nNNMJeBi0mPrn9xvenzjb7nX0r7+1vTZVgnpiPdsvMEYsbPxm577zKBfHWm1WnZ0I6
         d+3OwFjhKKyKbJP46sku5okjjhHvffxRGy8cqlkwDuRUzQ0XCMMKEVQ6AgCWPExndX71
         iV/F/MxRqhLEVIW7PCyQVdwxaFFoXgExBvu8sYrNURdElojS1mGJiXG9sabighuYGzQU
         0wWIWHzgN8BnvfcPJjQf3+xcdeyTYuPqQLXwkqiII5Ijfv0+VK66zfGu0J+OLQWHBlrr
         Kw2EdENjXfdhW5dSrS4JoV0AYReI4rMEoi1srVgbWsGwO+gkYbaR63jGH+RAAwEVIjYG
         6mWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=j9qX/HSwLIMkP63Z3KVtmxMD254RgIGqBGNpCVomjWY=;
        b=RjvmxLpLEPflCIJBtxYTwDHXjPLWaTq3zgLziUwc0So+Z0jghSJ/IhniUDq5jtiPsJ
         sT80sWYH+31xrnZOD4VuZnXplVG45HhoPKdbJAjJrqL2gqODLnU58eMt1VerD3lOtoyx
         q7CgTkbf4NoM2yirm8Dp7k+zLa6URSX6tlhAJXhHzF4DO9TCdOW7Ze7HWB3pkjxFHmTM
         ByPA/wE2m/ic45NT1/fVNSrzg5hv4OVg1alCo3NBYwvaVorJIxbePzutR+FJBq9/yjgs
         TETxqXJlP1QeUr/FbVA6RXHJpij4CHqmjwywUkIfGI8RnA+nOAfPThyqr5UjUA8Z1cS4
         wnUA==
X-Gm-Message-State: AOAM530wHr7YDYzyMmFdBwY0XugWMx4rIbAEq5s9AXe//pZQWOyeEx23
        ybV3jqjLktsJgUNcBdjtaBtq6f2nxlIPmnu7PuNuBszuYwfj+g==
X-Google-Smtp-Source: ABdhPJxCjzPVfc2g1XZxDZvYSY4IV7O7SVX3xJakIAGZzxobmpJJpZpBIB0BY2mm1CSY2CXwv2rPdWyqlr2BrsTWol4=
X-Received: by 2002:ad4:584b:: with SMTP id de11mr12935044qvb.19.1612719438769;
 Sun, 07 Feb 2021 09:37:18 -0800 (PST)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 7 Feb 2021 09:37:21 -0800
Message-ID: <CAPcyv4j++J_ra8zWkvVovmwmYCERp8vKsVSZn9x4PYGoJa-XOA@mail.gmail.com>
Subject: [GIT PULL] libnvdimm fixes for v5.11-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.11-rc7

...to receive a fix for a crash scenario that has been present since
the initial merge, a minor regression in sysfs attribute visibility,
and a fix for some flexible array warnings. The bulk of this pull is
an update to the libnvdimm unit test infrastructure to test non-ACPI
platforms. Given there is zero regression risk for test updates, and
the tests enable validation of bits headed towards the next merge
window, I saw no reason to hold the new tests back. Santosh originally
submitted this before the v5.11 window opened.

This has all appeared in -next with no reported issues.

---

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.11-rc7

for you to fetch changes up to 7018c897c2f243d4b5f1b94bc6b4831a7eab80fb:

  libnvdimm/dimm: Avoid race between probe and available_slots_show()
(2021-02-01 16:20:40 -0800)

----------------------------------------------------------------
libnvdimm for 5.11-rc7
- Fix a crash when sysfs accesses race 'dimm' driver probe/remove.

- Fix a regression in 'resource' attribute visibility necessary for
  mapping badblocks and other physical address interrogations.

- Fix some flexible array warnings

- Expand the unit test infrastructure for non-ACPI platforms

----------------------------------------------------------------
Dan Williams (3):
      ACPI: NFIT: Fix flexible_array.cocci warnings
      libnvdimm/namespace: Fix visibility of namespace resource attribute
      libnvdimm/dimm: Avoid race between probe and available_slots_show()

Jianpeng Ma (1):
      libnvdimm/pmem: Remove unused header

Santosh Sivaraj (7):
      testing/nvdimm: Add test module for non-nfit platforms
      ndtest: Add compatability string to treat it as PAPR family
      ndtest: Add dimms to the two buses
      ndtest: Add dimm attributes
      ndtest: Add regions and mappings to the test buses
      ndtest: Add nvdimm control functions
      ndtest: Add papr health related flags

 drivers/acpi/nfit/core.c            |   75 +--
 drivers/nvdimm/dimm_devs.c          |   18 +-
 drivers/nvdimm/namespace_devs.c     |   10 +-
 drivers/nvdimm/pmem.c               |    1 -
 tools/testing/nvdimm/config_check.c |    3 +-
 tools/testing/nvdimm/test/Kbuild    |    6 +-
 tools/testing/nvdimm/test/ndtest.c  | 1129 +++++++++++++++++++++++++++++++++++
 tools/testing/nvdimm/test/ndtest.h  |  109 ++++
 8 files changed, 1293 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/nvdimm/test/ndtest.c
 create mode 100644 tools/testing/nvdimm/test/ndtest.h
