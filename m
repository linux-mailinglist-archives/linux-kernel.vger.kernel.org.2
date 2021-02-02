Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96ACB30C1D8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 15:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhBBOfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 09:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbhBBOcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 09:32:50 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B134DC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 06:32:06 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id sa23so13991452ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 06:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zYMXbASdXhTFMbn1FUFGa1TMGbfhRribZMrBUXn1vP8=;
        b=UbMofkpyJMli+Y7dti9+hwGj5m/ynMdTnXyBEXKb0p6oPfy0dXUk+QPMFO3ESAmARH
         6acVsJ4jIch7VgphPK4NZpBEbb5WzCxIYShO22xmD6fZRG07Tivy6aRPS07eN3Fga9yM
         oIxXnsN1trzbgoi+8UnHPAe4+B3D74NenOUPCbaCMU9oO/k/g9lK5RgOP0Ztxdf7TyEU
         FDxkhy9av+LAS6qc6WPPjDxVbPz0hWdXpGTxc899m/RiHNPLZ0965vBWG3v6Ygn3xxS4
         TN3yOyiucLu1RERGaPLnd0MVXOpW2h+XenzmqlUFQWwaznPjXzKgeIa0j9wzFH6j+eGE
         brOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zYMXbASdXhTFMbn1FUFGa1TMGbfhRribZMrBUXn1vP8=;
        b=a5Bm7uncogD0hWuweehuGkDshXqTfJgizipz046Jv++y8CuF0O/tdXwO0ICjTQlcbK
         KJmLkJt80bai3JNbMt2jzbNQmQ/IRViPTlJyNpsjge6Jy7C6/EMX9EBen74kO38HnaCz
         MhkBq3wGBsuAwCDqg68ztNwyPgl5eqEu7l/OohjIIl1jP+VGlDA6kycB0es8b8+9AWh8
         /Lnax6jYUV+FkeTwP9FzOJtgFhD3RM+1zLTnT/Smw+knRhOR9XTdtJaRzwMV2kr5U83Z
         I1eZmVashG9yUF9mZoulV5UvLa+envokX14Ykm9lwl54ngoW5gCMOJWLbrVlVIzYkVoF
         ME8g==
X-Gm-Message-State: AOAM532cndoCzlUJwMQLPiYoimwfdnMtxZHUty15geMFniQQiz+ZMeLt
        iKkkieAWyJ2KZ23ULPUF2+asyeLmsxzMXs+pk8i9DS1EvABurXae
X-Google-Smtp-Source: ABdhPJyLkXSiOMJgV4AJB+EIG7vg3T26xAK9AgUl2p5UuTsmrcahhKKNZo5DZx0wzvYE4dk2Eeig2MWlDBuvAjMxu0w=
X-Received: by 2002:a17:906:6407:: with SMTP id d7mr22210137ejm.133.1612276325127;
 Tue, 02 Feb 2021 06:32:05 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 2 Feb 2021 20:01:54 +0530
Message-ID: <CA+G9fYszbxo4giipD0_sV3XHKaq2zVq97rXoyjWf18k5oYEX4Q@mail.gmail.com>
Subject: [next] mm/gup.c:96:10: error: implicit declaration of function
 'is_zero_pfn' [-Werror,-Wimplicit-function-declaration]
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     pasha.tatashin@soleen.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, david@redhat.com,
        osalvador@suse.de, Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        James Morris <jmorris@namei.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux next tag 20210202 arm, riscv and sh builds with allnoconfig and
tinyconfig failed due to build errors.


make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=arm
CROSS_COMPILE=arm-linux-gnueabihf- 'HOSTCC=sccache clang' 'CC=sccache
clang' zImage
 mm/gup.c:96:10: error: implicit declaration of function 'is_zero_pfn'
[-Werror,-Wimplicit-function-declaration]
                             !is_pinnable_page(page)))
                              ^
 include/linux/mm.h:1133:3: note: expanded from macro 'is_pinnable_page'
                is_zero_pfn(page_to_pfn(page)))
                ^
 mm/gup.c:96:10: note: did you mean 'is_zero_ino'?
 include/linux/mm.h:1133:3: note: expanded from macro 'is_pinnable_page'
                is_zero_pfn(page_to_pfn(page)))
                ^
 include/linux/fs.h:3045:20: note: 'is_zero_ino' declared here
static inline bool is_zero_ino(ino_t ino)
                   ^
1 error generated.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

steps to reproduce:
--------------------------
# TuxMake is a command line tool and Python library that provides
# portable and repeatable Linux kernel builds across a variety of
# architectures, toolchains, kernel configurations, and make targets.
#
# TuxMake supports the concept of runtimes.
# See https://docs.tuxmake.org/runtimes/, for that to work it requires
# that you install podman or docker on your system.
#
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.

tuxmake --runtime podman --target-arch arm --toolchain clang-11
--kconfig allnoconfig

build details:
https://builds.tuxbuild.com/1nv9wkY1T8wug0sEw2kwuFKLxhK/

Regressions found on sh:

   - build/gcc-10-allnoconfig
   - build/gcc-9-tinyconfig
   - build/gcc-8-allnoconfig
   - build/gcc-10-tinyconfig
   - build/gcc-9-allnoconfig
   - build/gcc-8-tinyconfig

Regressions found on riscv:

   - build/gcc-10-allnoconfig
   - build/clang-11-tinyconfig
   - build/clang-10-allnoconfig
   - build/clang-11-allnoconfig
   - build/gcc-9-tinyconfig
   - build/gcc-8-allnoconfig
   - build/gcc-10-tinyconfig
   - build/clang-10-tinyconfig
   - build/gcc-9-allnoconfig
   - build/gcc-8-tinyconfig

Regressions found on arm:

   - build/gcc-10-allnoconfig
   - build/clang-11-tinyconfig
   - build/clang-10-allnoconfig
   - build/clang-11-allnoconfig
   - build/gcc-9-tinyconfig
   - build/gcc-8-allnoconfig
   - build/gcc-10-tinyconfig
   - build/clang-10-tinyconfig
   - build/gcc-9-allnoconfig
   - build/gcc-8-tinyconfig


- Naresh
