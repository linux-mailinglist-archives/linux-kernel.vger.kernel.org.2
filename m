Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9776E315F12
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 06:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhBJFbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 00:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhBJFbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 00:31:04 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB189C061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 21:30:23 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id b9so1680198ejy.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 21:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=MICJlJ29tnK0OfCyoQ6hy5raS8MLx1t0pMdT44oGdyg=;
        b=nfbBML/4y70ovJ2kiP9RG4GcxYkTO+D3LyhbGrYmbdYX7rKrIpX6minKQOhPHiNfVf
         ycrDDxo78Yn4BzEYDPu66bkXO+MyRZ+XJfiIEX6eAmCK7Ubo6u6uU+pkzcufzqcgX5HL
         jsHZlagsshooCK1KC0HIgZYZkvmlZOsbBwCzbrl/ixW7WlnNGy5dGyqqRgjcUdhVmmkT
         tCQ0O1OyhgTyBA7T9xH1+ABwCHlABqisavBE7ffDIVSYjpOSJWwFBYTyx6g+uvGHkYsu
         d1Pecs/8/PGPQC06MBB9T1yLCJZ7/KNGEZXAKroDC1N1+fTESJhsrqouMLi+mC/80Pzs
         DCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=MICJlJ29tnK0OfCyoQ6hy5raS8MLx1t0pMdT44oGdyg=;
        b=GQnvIF6Bcu60fu+uPqvpP80WmMcna/U+wiH1mvTIvqHgKiXJX7/ZsYyW344evACW30
         0Of/D4t7H3JE1YF3cAPOgO4eG8BXpXI9yGrOhsgmQmceRicZM8SLvGAmRwwyZl91h+tE
         yG3d5IfE71vsVGrcvbiLVCx90XDHzqdiPq8yNiDmNA5u7dahGZO3UPJYPEIiBgT14hit
         RjHW7ANhuFGTOhPrGujwQpH+4tePsbMbHPTLYx22wTd8jHic1gfZnUc+ghU5feOyaOnK
         oWTgSLdqGiIYx3zKqeuzW5ixAnm0b5sI0wPibOGigPNu9L9XhPEyqfyx8Ue5UDuNBQwD
         5dWw==
X-Gm-Message-State: AOAM533NosjTZZA0y/D0z4uHRAButTd4K+waKVwEisvoN4tQL8ndSe5+
        srSoWWkaM+oaVMCkGF74uCrcHeVMHUmAgXqNDwB6gk2Dw11oqqmd
X-Google-Smtp-Source: ABdhPJxEoJqFS1/67jseq2Ryw8nAFmbH3a+Jxs2FDMzSngVK9VYGXMqwMiOfqb1G8wgBu2idtECavM8knM8Y8m+9beE=
X-Received: by 2002:a17:906:a153:: with SMTP id bu19mr1269611ejb.287.1612935022534;
 Tue, 09 Feb 2021 21:30:22 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 10 Feb 2021 11:00:11 +0530
Message-ID: <CA+G9fYtkWdeL7-nfXW8+VbaCK7swinU_Ksn67RW4FFD+cx8VYg@mail.gmail.com>
Subject: [next] [mips] spinlock.h:17:28: error: redefinition of 'queued_spin_unlock'
To:     linux-mips@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Paul Burton <paul.burton@mips.com>, Will Deacon <will@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While building Linux next tag 20210209 mips uImage.gz failed with below configs

  - mips (cavium_octeon_defconfig) with gcc-8, gcc-9 and gcc-10 - FAILED
  - mips (malta_defconfig) with gcc-8, gcc-9 and gcc-10 - FAILED
  - mips (nlm_xlp_defconfig) with gcc-8, gcc-9 and gcc-10 - FAILED
  - mips (defconfig) with gcc-8, gcc-9 and gcc-10 - FAILED

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=mips
CROSS_COMPILE=mips-linux-gnu- 'CC=sccache mips-linux-gnu-gcc'
'HOSTCC=sccache gcc' uImage.gz
In file included from /include/linux/spinlock.h:90,
                 from /include/linux/ipc.h:5,
                 from /include/uapi/linux/sem.h:5,
                 from /include/linux/sem.h:5,
                 from /include/linux/compat.h:14,
                 from /arch/mips/kernel/asm-offsets.c:12:
/arch/mips/include/asm/spinlock.h:17:28: error: redefinition of
'queued_spin_unlock'
   17 | #define queued_spin_unlock queued_spin_unlock
      |                            ^~~~~~~~~~~~~~~~~~

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

build link,
https://builds.tuxbuild.com/1oF9lkBAeWM2WvR11O2Yun8ERNT/

-- 
Linaro LKFT
https://lkft.linaro.org
