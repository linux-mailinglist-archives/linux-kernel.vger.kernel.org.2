Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62147326EF3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 21:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhB0U3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 15:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhB0U3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 15:29:21 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEA7C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 12:28:41 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id e6so8459114pgk.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 12:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=6/MfqjLb24HQitH0CWHO5yYdg1Z2JdjddfODgAO/Qns=;
        b=W4Hs0OEKPFwC6I5a9SYR81jRXoebfOXWbwz6yl3eZ+0kDD7TnlJS3KLPJEPtoAwUam
         tZC+PpFVanESW75Ij1tf1bstjzdGnvc7xlF52pCHy/xWcIEecu1YPV9m3q45/t7K9n6a
         pAG0+wFIJWDnBssTU1IxHDOj4riwt06f2gPZP3LRtN6VF3axgdLajWRc31TkrR3QNdzF
         DvO5vRi6ilJ8JGPjJ+b+4uZEHcmOp2Q7gzjk2snCeNMjJOWO/TtliZ9bjj9FxPo+S+i8
         iZ4FW2sOqXSLtyiROhdT0kLgGIJ27O9ne/WU5zq2SD20M9GoPiBeaIFhRxyOfHiU9y2c
         AUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=6/MfqjLb24HQitH0CWHO5yYdg1Z2JdjddfODgAO/Qns=;
        b=noFx3BsxXSk3Ymnb+cVKcWs8Bg+jMKtVKyl2co/efvOvoFO/JJguGKGWerSiVNLEoa
         NjX+CKuxIkq7vwfrjwYVAHRp/6gAURBQuVefsIxQOYp72VUz99MWoGcIx4a8gf2KO7Tt
         EKSX1tWlQ0zvmK32FUUCUBB2ga8ttyvS77Wgm88qh+DWSLVVG+c9xehpmMULM+v70sJQ
         LfnqT2sWcuVPmnDUcCx+Pjg6fIZk5DdNCB5WsPoaNOX06L8zCnQYPVzN2+xqrBgbeM/d
         2mKIW+QNkf5IEjJQbYc0tQbXHiext4spN86pyMbuTJHQ5k4rwz9vsien1wlCaOBpHJ9S
         SHHA==
X-Gm-Message-State: AOAM533yktPScDUzmUaEgH0iUTmucKFbl9vEfZNZDfzY56oSJ78Jg2Lq
        He3p5BsnTqhiyU8XIFbIxZzXEuCsfcd6CoZ4
X-Google-Smtp-Source: ABdhPJyq3hRaBF4lM+CWWtVGJs8ZJFhYR0nb0FbNk0ijhTb9sf/+YQZmAMD3MhMuXyxlGfIJku2GTg==
X-Received: by 2002:a65:4203:: with SMTP id c3mr7789175pgq.65.1614457720098;
        Sat, 27 Feb 2021 12:28:40 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k69sm13228495pfd.4.2021.02.27.12.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 12:28:39 -0800 (PST)
Date:   Sat, 27 Feb 2021 12:28:39 -0800 (PST)
X-Google-Original-Date: Sat, 27 Feb 2021 12:28:35 PST (-0800)
Subject: [GIT PULL] RISC-V Patches for the 5.12 Merge Window, Part 2
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-bd8c36a3-301b-4412-b3cd-a6eebd336f6c@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged tag 'riscv-for-linus-5.12-mw0'
The following changes since commit 8b83369ddcb3fb9cab5c1088987ce477565bb630:

  Merge tag 'riscv-for-linus-5.12-mw0' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2021-02-26 10:28:35 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.12-mw1

for you to fetch changes up to dd2d082b57602156e0c587ddb5ba04d0d624a6df:

  riscv: Cleanup setup_bootmem() (2021-02-26 21:25:17 -0800)

----------------------------------------------------------------
RISC-V Patches for the 5.12 Merge Window, Part 2

I have a pair of patches that slipped through the cracks:

* CPU hotplug has been enabled in the defconfigs
* Some cleanups to setup_bootmem.

There's also a single fix

* Force NUMA to depend on SMP.  This fixes some randconfig build
  failures.

----------------------------------------------------------------
Anup Patel (1):
      RISC-V: Enable CPU Hotplug in defconfigs

Kefeng Wang (1):
      riscv: Cleanup setup_bootmem()

Palmer Dabbelt (1):
      RISC-V: Make NUMA depend on SMP

 arch/riscv/Kconfig                |  1 +
 arch/riscv/configs/defconfig      |  1 +
 arch/riscv/configs/rv32_defconfig |  1 +
 arch/riscv/mm/init.c              | 21 ++-------------------
 4 files changed, 5 insertions(+), 19 deletions(-)
