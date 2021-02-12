Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C0231A490
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 19:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhBLSar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 13:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhBLSap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 13:30:45 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBDBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 10:30:05 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id x136so44445pfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 10:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=JbomQHAoZoGv/4dMz0OTiHTIjl0YKCnX4ahvGqfOTls=;
        b=gJnkxOsSoZ2/JOP8KjcKuuCyb+HmaeSo5Drk7PMd6QZDHfXeUUPvMx2g0oFZzR5vxW
         LSQFNKj5a90o+u9NejB+HKxwuBf2AMhG0kSDqZr/SmuWQHashrRrMPiXFTODQzpFYLcK
         VVlvNrYCqt1mjxGSHRmU/C22SDY06N3DrBCC1puGBxpmO+8elfMiIRmkRTWKZXVdWFh2
         56VqWXjPc1EhxRRdmeArKU6bNPem+FwTGd8Rz1m+pAuAi2d3CFrsE5Pc3wiaW6eIPjtk
         N7vsK4JKyrZPYh7XPVMIqmfB7wMlRexyFREA79f6/B7UonKNQ92r8ClNtHi1I7yr94TP
         9r2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=JbomQHAoZoGv/4dMz0OTiHTIjl0YKCnX4ahvGqfOTls=;
        b=OhODKb0FVe62RK6JQ07XoeumnVVwMB0y+k+Ra4g75vr6RjXTIwFckjmsZNGgrXQHwl
         0vnTR9YMDfGuPsfrXGID+sW6g/q+rjNIkb0ZmnEKTZgCylwKj45Dqi8YfWExLetfmz6p
         CIBK2hHmIL5oIMzw+YU4qGJDtr0Pb8APmM7md7Ne0/UImCwGRu/8FxGKf6IJKbhramTV
         08i4h0Sft279jF68VQ/vLcVbQlKdc4sUa8hImtNWXUqJeaSkKoo4C0xn1FX/iGtbuGDt
         ceq/phoy6RLrK4gzAgqC9ugH8JtFTKrpWBym+JKAk+NGAiWKfPfbmTUeZKrtgVMuZaRt
         HPFQ==
X-Gm-Message-State: AOAM531+W5bw/phX4QsdzBBdFmlrh1viipkJSY7v2aHmlID0u0FkfYkQ
        JryipVXJ5mJckjTSluwaTfbtGQ==
X-Google-Smtp-Source: ABdhPJyCPSCJ8NaI5QTRkdam3hFkx5ohbtF9rmTgKCa3fOsZYUGWHytJsmzBRjzmcULh1Cz3Xs5IcA==
X-Received: by 2002:a63:c84f:: with SMTP id l15mr4438612pgi.170.1613154604747;
        Fri, 12 Feb 2021 10:30:04 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id s1sm9180166pfe.151.2021.02.12.10.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 10:30:04 -0800 (PST)
Date:   Fri, 12 Feb 2021 10:30:04 -0800 (PST)
X-Google-Original-Date: Fri, 12 Feb 2021 10:29:58 PST (-0800)
Subject: [GIT PULL] A Single RISC-V Fix for 5.11-rc8 (or 5.11)
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-30cf4392-0de1-4d1c-89f6-d260a072350d@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 92bf22614b21a2706f4993b278017e437f7785b3:

  Linux 5.11-rc7 (2021-02-07 13:57:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.11-rc8

for you to fetch changes up to 3da3cc1b5f47115b16b5ffeeb4bf09ec331b0164:

  Revert "dts: phy: add GPIO number and active state used for phy reset" (2021-02-10 16:06:14 -0800)

----------------------------------------------------------------
A Single RISC-V Fix for 5.11-rc8 (or 5.11)

I have a single fix this week:

* The removal of the GPIO reset method for the Ethernet phy on the
  HiFive Unleashed.  This returns to relying on the bootloader's phy
  reset sequence, which we'll have to cintune doing until we can sort
  out how to get the Linux phy driver to perform the special reset
  dance required for this phy.

----------------------------------------------------------------
Palmer Dabbelt (1):
      Revert "dts: phy: add GPIO number and active state used for phy reset"

 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 1 -
 1 file changed, 1 deletion(-)
