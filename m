Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E733420BD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhCSPTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhCSPTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:19:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA8DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:19:20 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id b9so10329930ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ESHJ/xpoPLprVXdQr5aaOZYnopxfXbBpJirRzC/e87Y=;
        b=E1MyGjANCGe2v1YDOi96jNvi7AX9CiZZmnHh1dSazPD1exZJyAptoayn8NzA5DugW2
         S9Bq3IxiqzonMdby7vQqkLZymeQ/YqoQKl6AHc1DIs74zoWGSinBLjNjpW/wgApb5JWR
         NTgx2Luub+h+oYIdTdrmV16G45JfxJCMAoreKRCpkkh7wIa9JiBUovV2I3jO/eRL9BYe
         +JM9GSDfCUxIQkNFnfGWclE0C8KqDnkSwA86q/8JV8M9zZcWSm/+eUZHrtCUkq/w29Jp
         7wPTc2ntAdVDdoocZ2GaWP/RvQyE8jADbYDJ2Hz8FgLm3bYrcMf+jcS9iOhlxknUN2Cd
         jl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ESHJ/xpoPLprVXdQr5aaOZYnopxfXbBpJirRzC/e87Y=;
        b=ZsQFLUHoFMnkWSZnRUInfy7o8EsEAfMISzxrQ4a7AwXtp0INb4FqOfateFVguICqwW
         v6+P6dRsw5MD1FV3Drj8ff7NjNNlorCN7m1FKEVOKyrL1rWwThLIxFpH8r+XpiBCn1QR
         y+XhSFa74parP9SDY/Y3wJCuQwZst38fUdqjvj8mRPQeqoWVFOcJ68prZjRcrl5Cw0uw
         Q/snYiYxc0sTVkgFDELjPupKVZ31cYC757yDfVQDUB3L/4hrx+RJhkp7EveuBaHSDOCI
         RWJ4jNFjsvtzY9L5tuilIW0QiHdUQRiki22bMMXj9CB/yJ7HUf2Kr3IHX6HAdGQ7/BF7
         kqCA==
X-Gm-Message-State: AOAM532jOTdB6iI9rlqQRJ3Up3FXifjSmf/rptBHsVRFo4YE8Ghbq49N
        +sFSqlCcKFR3G22A/8MPuPWuST7VvtNTUWJsCSlJaw==
X-Google-Smtp-Source: ABdhPJwf2apA+WfsgXrym8IqCYDGSzycBSor+WUmQjtqmk0mRHE7fsQ5goyIyML5cG3xukXE3lSGhjODQL4SmWPmlLo=
X-Received: by 2002:a17:906:4c85:: with SMTP id q5mr4861822eju.375.1616167158632;
 Fri, 19 Mar 2021 08:19:18 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 19 Mar 2021 20:49:07 +0530
Message-ID: <CA+G9fYu-t_JwoBVXKhiDUY-FRdX3F3LgbDw9bFeiuciwC70TaQ@mail.gmail.com>
Subject: arm64: compiler_types.h:320:38: error: call to __compiletime_assert_417
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, glittao@gmail.com,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[This email landed to Spam for some reason, sending it again with modified
subject]

While building arm64 kernel modules the following kernel warnings /
errors noticed on linux next 20210318 tag the gcc version is 7.3.0.
Build PASS with gcc-8, gcc-9 and gcc-10.

 In file included from <command-line>:0:0:
 In function 'resiliency_test',
     inlined from 'test_slub_init' at   lib/test_slub.c:120:2:
   include/linux/compiler_types.h:320:38: error: call to
'__compiletime_assert_417' declared with attribute error: BUILD_BUG_ON
failed: KMALLOC_MIN_SIZE > 16 | KMALLOC_SHIFT_HIGH < 10
   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                       ^
   include/linux/compiler_types.h:301:4: note: in definition of macro
'__compiletime_assert'
     prefix ## suffix();    \
     ^~~~~~
   include/linux/compiler_types.h:320:2: note: in expansion of macro
'_compiletime_assert'
   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
   ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro
'compiletime_assert'
  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                      ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:2: note: in expansion of macro
'BUILD_BUG_ON_MSG'
   BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
   ^~~~~~~~~~~~~~~~
   lib/test_slub.c:101:2: note: in expansion of macro 'BUILD_BUG_ON'
   BUILD_BUG_ON(KMALLOC_MIN_SIZE > 16 | KMALLOC_SHIFT_HIGH < 10);
   ^~~~~~~~~~~~
 make[2]: *** [  scripts/Makefile.build:273: lib/test_slub.o] Error 1
 make[1]: *** [  Makefile:1980: lib] Error 2

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=juno,label=docker-buster-lkft/984/consoleFull

https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=juno,label=docker-buster-lkft/984/consoleFull

--
Linaro LKFT
https://lkft.linaro.org
