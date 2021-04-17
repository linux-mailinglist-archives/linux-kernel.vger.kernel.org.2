Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAEE362D2F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 05:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbhDQD0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 23:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhDQD0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 23:26:07 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1D0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 20:25:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id w3so44908061ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 20:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WiTsWqeV3t2x9ikLj20hBA8e/9UUZ/sS0LIdWopzgJw=;
        b=zZi1DYhYfCAX8+wpHDkgCFrEaVlN8lv6zgnzOfAywVOZyAVUtqcx5SZ5MQzrLD+MIg
         ht+jGsPDLzCUxkj+v5smSoFrluIFa+zMtIfr6IcKisYQcah9MmjQhhisXimcrKDmj8rg
         bB39uI7NS0gpD8FCXUZU+5sZxjBsvy2XTr4dYolxNk3TPRjA0K88fFwkLkC92ZvCTps0
         vgWojhbFszNfJvSipnqO5bAuDEO48IbUWlNzd2L73stQ/7zEli/TdAmuFFc5k6k4ux7d
         vJp9BNY/9bSNsMFE5YotlZXZIOgU6yHXk0OYeln3AUXFRd5hv9PjDR1LOoE2K7aLAReB
         vgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WiTsWqeV3t2x9ikLj20hBA8e/9UUZ/sS0LIdWopzgJw=;
        b=ffVwnPZZtJipT5G75fwhZZPN0ItF9nCNN9kMJWMMAbYp9YMhYgQ2peYddbyZbledlu
         dZH41ywgkS/DtzIvyRwi8xZNhPYixzQIMhOUBleqtS0TPblARK24hLyGuHnblPlTD71L
         O38URNj+Lt8TvvIRTAPCUXXx4kdqEviXxN++RuDr3k5jmyJKALaZ5C/5KRMwtC9A0ZRF
         t9kSjNdHt3kEUFU5ZJstKC/iB3342vCSEzT4O1PKpIyu1loMN1KOOsqDEeTjgGX+UlYS
         uxqVd1Ofm6QwVdNDB8DgjA4i6k/XCaRTv3GiBMDAaYd0jWCqx+QNMWkYPrOPApYa6/MT
         jrEA==
X-Gm-Message-State: AOAM532M5G/El74RbeRVrC/yOCQmlS/FC/IhcQaqhOJsWnhhYEeLzTzS
        rtm+uU8GTmQTHnVMAyOaWxIVxKKA4vUp3m/2wuTbNxnzhqikcg==
X-Google-Smtp-Source: ABdhPJzhP/d5r5MCA8c5O3EKtsr6nKURNW9JgWhqYU0ARu+Tgyy09rsNfRCnS7qLLeEgVIGM4c4UU+UTtDfSkZ5pAeA=
X-Received: by 2002:a17:906:ef2:: with SMTP id x18mr11475415eji.323.1618629938929;
 Fri, 16 Apr 2021 20:25:38 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 16 Apr 2021 20:25:28 -0700
Message-ID: <CAPcyv4iUPPY7XpwwY1zK3VGUY72p+zZckSCwgWuvJa183Y_QBA@mail.gmail.com>
Subject: [GIT PULL] libnvdimm fixes for v5.12-rc8 / final
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

...to receive a handful of libnvdimm fixups.

The largest change is for a regression that landed during -rc1 for
block-device read-only handling. Vaibhav found a new use for the
ability (originally introduced by virtio_pmem) to call back to the
platform to flush data, but also found an original bug in that
implementation. Lastly, Arnd cleans up some compile warnings in dax.

This has all appeared in -next with no reported issues.

---

The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:

  Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-for-5.12-rc8

for you to fetch changes up to 11d2498f1568a0f923dc8ef7621de15a9e89267f:

  Merge branch 'for-5.12/dax' into libnvdimm-fixes (2021-04-09 22:00:09 -0700)

----------------------------------------------------------------
libnvdimm fixes for v5.12-rc8

- Fix a regression of read-only handling in the pmem driver.

- Fix a compile warning.

- Fix support for platform cache flush commands on powerpc/papr

----------------------------------------------------------------
Arnd Bergmann (1):
      dax: avoid -Wempty-body warnings

Dan Williams (2):
      libnvdimm: Notify disk drivers to revalidate region read-only
      Merge branch 'for-5.12/dax' into libnvdimm-fixes

Vaibhav Jain (1):
      libnvdimm/region: Fix nvdimm_has_flush() to handle ND_REGION_ASYNC

 drivers/dax/bus.c            |  6 ++----
 drivers/nvdimm/bus.c         | 14 ++++++--------
 drivers/nvdimm/pmem.c        | 37 +++++++++++++++++++++++++++++++++----
 drivers/nvdimm/region_devs.c | 16 ++++++++++++++--
 include/linux/nd.h           |  1 +
 5 files changed, 56 insertions(+), 18 deletions(-)
