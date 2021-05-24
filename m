Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E101038E5C5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbhEXLsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbhEXLsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:48:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A93DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 04:46:35 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id et19so34275415ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 04:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2Q82VtrVrpT6RPgDrZ+gcYZWvDuIiGS7uieO/KG+a5I=;
        b=bm5fPvROW9d68ckndnVjzHUu/SebhyyfhcKEfkzohn+4sjG5RBoF5ioXUkYBzTWdlr
         HTKGphgr/+ijCmRdhRjqOOVyIYAcDwaDNQEH9//VYKgjxbufymXzv1ocoHwaPWMXsyyx
         HfYv/YGS0xPOIuOmI4SXPrGLQbze1bdTImdYPrHRyvmUdW5HyX9uxL3FHVBzgrvbIXlj
         gfEtCZa7VYbZn6bXikY7Lkmp1SCuSbWDIvZKZoejan46WjKdkJRu3wqe64RBetkGhrWZ
         Gek4iueJJEDgyLh89yD3vjgHGhGY7NH47zHyZ8/RjW+A5fr4M5mteV0GWUlIyvXLIw8v
         GYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2Q82VtrVrpT6RPgDrZ+gcYZWvDuIiGS7uieO/KG+a5I=;
        b=iWAxrSckgAMMP7p2B1QPXnc9OiSBsVp8LOpqV1WmlnR9FXHWA6YtY+cris5tc41hTA
         aAK2vSiBX89NJ+QQ++hKJPFchcNZuFVfnFSTmA7BKxj3epIGnQ9L1hLFUm/EWI1QISJA
         TaZUyGCRalh+m3vQ9jyuhzBQfoqcw3NADEQ56oXLeWWv2JAtGFOyCElSZcZLnKS8TAVK
         nWNs8Rv9QRceDdWAS+CHhYUjqxSk85JHXs9M6ebkmQLMZ36Ihig83RoBt1RV1m1JU1Q1
         pZcPF1tz95PA2MmIxB8kVOs+u0VMh9SGJ4gd6M/pz3QVdZah2rv8jxBA896FhbqqBk0I
         LiQw==
X-Gm-Message-State: AOAM531toHFVDpGr9bCv8p6dH29pS9+9sqsk4clvVNHgFjaLtzJOdehY
        fLYg2/v668VObOcKDj36OrpXkqLSJZMWfNwNP1/Q8g==
X-Google-Smtp-Source: ABdhPJwbDJKtue+GKoVRNDjr8x5jngrd9hrXCCgAjXOKwbdB44t9Yw6c8ioUpbO0Q66+iDGCt5oO6Wzi2KW0jJpK1D4=
X-Received: by 2002:a17:906:f896:: with SMTP id lg22mr21667951ejb.170.1621856793678;
 Mon, 24 May 2021 04:46:33 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 24 May 2021 17:16:22 +0530
Message-ID: <CA+G9fYvFXTHPKwasdVidF7qEHdqwRht8Xg6qm6CCLL0HGaU1ew@mail.gmail.com>
Subject: x86: unistd_64.h: warning: missing whitespace after the macro name
To:     X86 ML <x86@kernel.org>, open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While building Linux next-20210524 tag with gcc 7.x the following warnings and
errors were noticed.

build log:
------------
  HOSTLD  scripts/mod/modpost
  CC      kernel/bounds.s
  CALL    /srv/oe/build/tmp-lkft-glibc/work-shared/intel-corei7-64/kernel-source/scripts/atomic/check-atomics.sh
  UPD     include/generated/bounds.h
  UPD     include/generated/timeconst.h
  CC      arch/x86/kernel/asm-offsets.s
In file included from
/srv/oe/build/tmp-lkft-glibc/work-shared/intel-corei7-64/kernel-source/arch/x86/include/asm/unistd.h:20:0,
                 from
/srv/oe/build/tmp-lkft-glibc/work-shared/intel-corei7-64/kernel-source/arch/x86/include/asm/seccomp.h:5,
                 from
/srv/oe/build/tmp-lkft-glibc/work-shared/intel-corei7-64/kernel-source/include/linux/seccomp.h:21,
                 from
/srv/oe/build/tmp-lkft-glibc/work-shared/intel-corei7-64/kernel-source/include/linux/sched.h:21,
                 from
/srv/oe/build/tmp-lkft-glibc/work-shared/intel-corei7-64/kernel-source/arch/x86/kernel/asm-offsets.c:10:
./arch/x86/include/generated/uapi/asm/unistd_64.h:4:14: warning:
missing whitespace after the macro name
 #define __NR_/usrread 0
              ^
./arch/x86/include/generated/uapi/asm/unistd_64.h:5:14: warning:
missing whitespace after the macro name
 #define __NR_/usrwrite 1
              ^
./arch/x86/include/generated/uapi/asm/unistd_64.h:5:0: warning:
"__NR_" redefined
 #define __NR_/usrwrite 1

./arch/x86/include/generated/uapi/asm/unistd_64.h:4:0: note: this is
the location of the previous definition
 #define __NR_/usrread 0

./arch/x86/include/generated/uapi/asm/unistd_64.h:6:14: warning:
missing whitespace after the macro name
 #define __NR_/usropen 2
              ^
./arch/x86/include/generated/uapi/asm/unistd_64.h:6:0: warning:
"__NR_" redefined
 #define __NR_/usropen 2

./arch/x86/include/generated/uapi/asm/unistd_64.h:5:0: note: this is
the location of the previous definition
 #define __NR_/usrwrite 1

./arch/x86/include/generated/uapi/asm/unistd_64.h:7:14: warning:
missing whitespace after the macro name
 #define __NR_/usrclose 3
              ^
./arch/x86/include/generated/uapi/asm/unistd_64.h:7:0: warning:
"__NR_" redefined
 #define __NR_/usrclose 3

./arch/x86/include/generated/uapi/asm/unistd_64.h:6:0: note: this is
the location of the previous definition
 #define __NR_/usropen 2

./arch/x86/include/generated/uapi/asm/unistd_64.h:8:14: warning:
missing whitespace after the macro name
 #define __NR_/usrstat 4
              ^
./arch/x86/include/generated/uapi/asm/unistd_64.h:8:0: warning:
"__NR_" redefined
 #define __NR_/usrstat 4

./arch/x86/include/generated/uapi/asm/unistd_64.h:7:0: note: this is
the location of the previous definition
 #define __NR_/usrclose 3

./arch/x86/include/generated/uapi/asm/unistd_64.h:9:14: warning:
missing whitespace after the macro name
 #define __NR_/usrfstat 5
              ^
./arch/x86/include/generated/uapi/asm/unistd_64.h:9:0: warning:
"__NR_" redefined
 #define __NR_/usrfstat 5

./arch/x86/include/generated/uapi/asm/unistd_64.h:8:0: note: this is
the location of the previous definition
 #define __NR_/usrstat 4

./arch/x86/include/generated/uapi/asm/unistd_64.h:10:14: warning:
missing whitespace after the macro name
 #define __NR_/usrlstat 6
              ^
./arch/x86/include/generated/uapi/asm/unistd_64.h:10:0: warning:
"__NR_" redefined
 #define __NR_/usrlstat 6

./arch/x86/include/generated/uapi/asm/unistd_64.h:9:0: note: this is
the location of the previous definition
 #define __NR_/usrfstat 5

<trim>

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Detailed build link,
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=intel-corei7-64,label=docker-buster-lkft/1032/console


--
Linaro LKFT
https://lkft.linaro.org
