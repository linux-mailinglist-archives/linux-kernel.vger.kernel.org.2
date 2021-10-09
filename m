Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB440427C3B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 19:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhJIREa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 13:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhJIRE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 13:04:29 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78269C061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 10:02:32 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id x1so10566689iof.7
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 10:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DRK8CEibrpPtSYGs2LPRW4Pd7h4LM9fCz9FDPSwkZlI=;
        b=X8wK6j5TZYswWDYRn1UnlxcsBYD2dMNNhltS4uttKwT2oOZE81plLKj/2zyxtEy3ab
         iniIIiqQpWh+p4HRVRAcQ2nhd2D6sPMm4m4dBCPJevnsTKBwLldo89uAlodXlTbyPNYh
         6kkovvFMTHBrmOpTj7uGOGPLXAbNkh84t1p8qjVgNKMdjrQChAcTGZF8oMjhE94QUlty
         Mymbrn0xHrRusHBX1Bd3DLrQdqocljKDtWybqlH8HAo0TioKm3laiiGKqF6PG75FFhg3
         5qgNexFg2fQiqszdDFbsftFJyn4J5i/9j4l29OHF7Sz+txQH9kY7L145qWAq5vh1BmYv
         lqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DRK8CEibrpPtSYGs2LPRW4Pd7h4LM9fCz9FDPSwkZlI=;
        b=MvCjP9s8NsVOirS2xQHD3b2v1Ct9YorixfCMILGQpVgQXHVu2kiHkkMp6lIkp2NvPh
         yq9ZUIC4Cychjzmy3WLgooJPklT6hcBPuJQJ7qCuKWvTpjmQnp49IcxuPETS6WlTFYEr
         NebS8B8bia0rTYQTjkuNUETAb7/FMI2IFSOT/XpCi/DZvsfsSeRzE2cjDz4Eu5RWnKXi
         uG2erARiWp6+cA6M/8OCp8jDVpO+UVR892jg0eVMs56xiiklCIhGx2L0i3p9HsjtCr+O
         5QvVyYsIwyKXMm52p5ZhEUHN/p1diDGNk9rb/ZfENfaOMBHChql1vStkds/+Wgw9uK+b
         YOHQ==
X-Gm-Message-State: AOAM530vITjgK8n1EabjgLwzDzIWgpCpYtK3RGAmidohYKElkBWw74QX
        2u7KemP7bvIVbvPloaugjQFDmxR/TEqFtyaOf24=
X-Google-Smtp-Source: ABdhPJzODLjmXpAoJI3TvRRz9VhetBLXhX1f6UcTiWe8ljvpZIGReBZdYC0o+89/tKZLKJ4PRPEEL9gqpYNocmQ2TbA=
X-Received: by 2002:a5e:9b18:: with SMTP id j24mr12412835iok.202.1633798951771;
 Sat, 09 Oct 2021 10:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <202110092004.lZWlUR2p-lkp@intel.com>
In-Reply-To: <202110092004.lZWlUR2p-lkp@intel.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 10 Oct 2021 01:01:55 +0800
Message-ID: <CALOAHbBs463r4WbGKqfq5L=h=Us-En3v0DmoQiBwO9Sh1mY1UQ@mail.gmail.com>
Subject: Re: [tip:sched/core 14/47] /bin/bash: line 1: 21320 Segmentation
 fault sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise
 -Wno-return-void -Wno-unknown-attribute -fdiagnostic-prefix
 -D__CHECK_ENDIAN__ -D__NDS32_EB__ --arch=nds32 -mbig-endian -m32 -Wp,-MMD,kernel...
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 9, 2021 at 8:05 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched=
/core
> head:   b2d5b9cec60fecc72a13191c2c6c05acf60975a5
> commit: 60f2415e19d3948641149ac6aca137a7be1d1952 [14/47] sched: Make sche=
dstats helpers independent of fair sched class
> config: nds32-randconfig-s031-20211009 (attached as .config)
> compiler: nds32le-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/com=
mit/?id=3D60f2415e19d3948641149ac6aca137a7be1d1952
>         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/gi=
t/tip/tip.git
>         git fetch --no-tags tip sched/core
>         git checkout 60f2415e19d3948641149ac6aca137a7be1d1952
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cro=
ss C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=3Dnds32
>

Hi kernel test robot,

When I'm trying to reproduce it, I find there're lots of "Segmentation
fault sparse" errors even without my commit,

for example,

/bin/sh: line 1: 85051 Segmentation fault      (core dumped) sparse
-D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise
-Wno-return-void -Wno-unknown-attribute -fdiagnostic-prefix
-D__CHECK_ENDIAN__ -D__NDS32_EB__ --arch=3Dnds32 -mbig-endian -m32
-Wp,-MMD,init/.main.o.d -nostdinc -isystem
/root/0day/gcc-11.2.0-nolibc/nds32le-linux/bin/../lib/gcc/nds32le-linux/11.=
2.0/include
-I./arch/nds32/include -I./arch/nds32/include/generated -I./include
-I./arch/nds32/include/uapi -I./arch/nds32/include/generated/uapi
-I./include/uapi -I./include/generated/uapi -include
./include/linux/compiler-version.h -include ./include/linux/kconfig.h
-include ./include/linux/compiler_types.h -D__KERNEL__
-fmacro-prefix-map=3D./=3D -Wall -Wundef -Werror=3Dstrict-prototypes
-Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE
-Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int
-Werror=3Dreturn-type -Wno-format-security -std=3Dgnu89
-mno-sched-prolog-epilog -mcmodel=3Dlarge -mno-ext-fpu-sp
-mno-ext-fpu-dp -mfloat-abi=3Dsoft -EB -fno-delete-null-pointer-checks
-Wno-frame-address -Wno-format-truncation -Wno-format-overflow
-Wno-address-of-packed-member -O2 -fno-allow-store-data-races
-fno-reorder-blocks -fno-ipa-cp-clone -fno-partial-inlining
-Wframe-larger-than=3D1024 -fno-stack-protector -Wimplicit-fallthrough=3D5
-Wno-main -Wno-unused-but-set-variable -Wno-unused-const-variable
-fomit-frame-pointer -fno-stack-clash-protection
-fzero-call-used-regs=3Dused-gpr -fno-inline-functions-called-once
-falign-functions=3D64 -Wdeclaration-after-statement -Wvla
-Wno-pointer-sign -Wno-stringop-truncation -Wno-zero-length-bounds
-Wno-array-bounds -Wno-stringop-overflow -Wno-restrict
-Wno-maybe-uninitialized -fno-strict-overflow -fno-stack-check
-fconserve-stack -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types
-Werror=3Ddesignated-init -Wno-packed-not-aligned -fno-function-sections
-fno-data-sections -DKBUILD_MODFILE=3D'"init/main"'
-DKBUILD_BASENAME=3D'"main"' -DKBUILD_MODNAME=3D'"main"'
-D__KBUILD_MODNAME=3Dkmod_main init/main.c

/bin/sh: line 1: 88064 Segmentation fault      (core dumped) sparse
-D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise
-Wno-return-void -Wno-unknown-attribute -fdiagnostic-prefix
-D__CHECK_ENDIAN__ -D__NDS32_EB__ --arch=3Dnds32 -mbig-endian -m32
-Wp,-MMD,kernel/events/.core.o.d -nostdinc -isystem
/root/0day/gcc-11.2.0-nolibc/nds32le-linux/bin/../lib/gcc/nds32le-linux/11.=
2.0/include
-I./arch/nds32/include -I./arch/nds32/include/generated -I./include
-I./arch/nds32/include/uapi -I./arch/nds32/include/generated/uapi
-I./include/uapi -I./include/generated/uapi -include
./include/linux/compiler-version.h -include ./include/linux/kconfig.h
-include ./include/linux/compiler_types.h -D__KERNEL__
-fmacro-prefix-map=3D./=3D -Wall -Wundef -Werror=3Dstrict-prototypes
-Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE
-Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int
-Werror=3Dreturn-type -Wno-format-security -std=3Dgnu89
-mno-sched-prolog-epilog -mcmodel=3Dlarge -mno-ext-fpu-sp
-mno-ext-fpu-dp -mfloat-abi=3Dsoft -EB -fno-delete-null-pointer-checks
-Wno-frame-address -Wno-format-truncation -Wno-format-overflow
-Wno-address-of-packed-member -O2 -fno-allow-store-data-races
-fno-reorder-blocks -fno-ipa-cp-clone -fno-partial-inlining
-Wframe-larger-than=3D1024 -fno-stack-protector -Wimplicit-fallthrough=3D5
-Wno-main -Wno-unused-but-set-variable -Wno-unused-const-variable
-fomit-frame-pointer -fno-stack-clash-protection
-fzero-call-used-regs=3Dused-gpr -fno-inline-functions-called-once
-falign-functions=3D64 -Wdeclaration-after-statement -Wvla
-Wno-pointer-sign -Wno-stringop-truncation -Wno-zero-length-bounds
-Wno-array-bounds -Wno-stringop-overflow -Wno-restrict
-Wno-maybe-uninitialized -fno-strict-overflow -fno-stack-check
-fconserve-stack -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types
-Werror=3Ddesignated-init -Wno-packed-not-aligned
-DKBUILD_MODFILE=3D'"kernel/events/core"' -DKBUILD_BASENAME=3D'"core"'
-DKBUILD_MODNAME=3D'"core"' -D__KBUILD_MODNAME=3Dkmod_core
kernel/events/core.c

/bin/sh: line 1: 88141 Segmentation fault      (core dumped) sparse
-D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise
-Wno-return-void -Wno-unknown-attribute -fdiagnostic-prefix
-D__CHECK_ENDIAN__ -D__NDS32_EB__ --arch=3Dnds32 -mbig-endian -m32
-Wp,-MMD,mm/.balloon_compaction.o.d -nostdinc -isystem
/root/0day/gcc-11.2.0-nolibc/nds32le-linux/bin/../lib/gcc/nds32le-linux/11.=
2.0/include
-I./arch/nds32/include -I./arch/nds32/include/generated -I./include
-I./arch/nds32/include/uapi -I./arch/nds32/include/generated/uapi
-I./include/uapi -I./include/generated/uapi -include
./include/linux/compiler-version.h -include ./include/linux/kconfig.h
-include ./include/linux/compiler_types.h -D__KERNEL__
-fmacro-prefix-map=3D./=3D -Wall -Wundef -Werror=3Dstrict-prototypes
-Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE
-Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int
-Werror=3Dreturn-type -Wno-format-security -std=3Dgnu89
-mno-sched-prolog-epilog -mcmodel=3Dlarge -mno-ext-fpu-sp
-mno-ext-fpu-dp -mfloat-abi=3Dsoft -EB -fno-delete-null-pointer-checks
-Wno-frame-address -Wno-format-truncation -Wno-format-overflow
-Wno-address-of-packed-member -O2 -fno-allow-store-data-races
-fno-reorder-blocks -fno-ipa-cp-clone -fno-partial-inlining
-Wframe-larger-than=3D1024 -fno-stack-protector -Wimplicit-fallthrough=3D5
-Wno-main -Wno-unused-but-set-variable -Wno-unused-const-variable
-fomit-frame-pointer -fno-stack-clash-protection
-fzero-call-used-regs=3Dused-gpr -fno-inline-functions-called-once
-falign-functions=3D64 -Wdeclaration-after-statement -Wvla
-Wno-pointer-sign -Wno-stringop-truncation -Wno-zero-length-bounds
-Wno-array-bounds -Wno-stringop-overflow -Wno-restrict
-Wno-maybe-uninitialized -fno-strict-overflow -fno-stack-check
-fconserve-stack -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types
-Werror=3Ddesignated-init -Wno-packed-not-aligned
-DKBUILD_MODFILE=3D'"mm/balloon_compaction"'
-DKBUILD_BASENAME=3D'"balloon_compaction"'
-DKBUILD_MODNAME=3D'"balloon_compaction"'
-D__KBUILD_MODNAME=3Dkmod_balloon_compaction mm/balloon_compaction.c

....

And those Segmentation fault of sparse can also be found in dmesg,
[ 5540.785485] sparse[91520]: segfault at 0 ip 0000000000417bff sp
00007ffe318f1e80 error 4 in sparse[400000+53000]
[ 5540.785489] Code: ff ff ff e9 dc fd ff ff 0f 1f 00 48 8b 7f 20 e8
97 fc ff ff 48 3b 43 20 48 89 c5 0f 85 3f fd ff ff e9 be fd ff ff 48
8b 6f 28 <80> 7d 00 18 0f 85 9b fd ff ff 4c 8b 77 08 4c 8b 6f 20 31 ff
e8 38
[ 5541.924384] sparse[91643]: segfault at 0 ip 0000000000417bff sp
00007ffc4f408a30 error 4 in sparse[400000+53000]
[ 5541.924389] Code: ff ff ff e9 dc fd ff ff 0f 1f 00 48 8b 7f 20 e8
97 fc ff ff 48 3b 43 20 48 89 c5 0f 85 3f fd ff ff e9 be fd ff ff 48
8b 6f 28 <80> 7d 00 18 0f 85 9b fd ff ff 4c 8b 77 08 4c 8b 6f 20 31 ff
e8 38
[ 5542.836875] sparse[91748]: segfault at 0 ip 0000000000417bff sp
00007ffdebd5d880 error 4 in sparse[400000+53000]
[ 5542.836881] Code: ff ff ff e9 dc fd ff ff 0f 1f 00 48 8b 7f 20 e8
97 fc ff ff 48 3b 43 20 48 89 c5 0f 85 3f fd ff ff e9 be fd ff ff 48
8b 6f 28 <80> 7d 00 18 0f 85 9b fd ff ff 4c 8b 77 08 4c 8b 6f 20 31 ff
e8 38
[ 5543.763152] sparse[91855]: segfault at 0 ip 0000000000417bff sp
00007ffd4b9789c0 error 4 in sparse[400000+53000]
[ 5543.763158] Code: ff ff ff e9 dc fd ff ff 0f 1f 00 48 8b 7f 20 e8
97 fc ff ff 48 3b 43 20 48 89 c5 0f 85 3f fd ff ff e9 be fd ff ff 48
8b 6f 28 <80> 7d 00 18 0f 85 9b fd ff ff 4c 8b 77 08 4c 8b 6f 20 31 ff
e8 38
[ 5545.193189] sparse[91999]: segfault at 0 ip 0000000000417bff sp
00007ffcfa153710 error 4 in sparse[400000+53000]
[ 5545.193216] Code: ff ff ff e9 dc fd ff ff 0f 1f 00 48 8b 7f 20 e8
97 fc ff ff 48 3b 43 20 48 89 c5 0f 85 3f fd ff ff e9 be fd ff ff 48
8b 6f 28 <80> 7d 00 18 0f 85 9b fd ff ff 4c 8b 77 08 4c 8b 6f 20 31 ff
e8 38
....

Doesn't that mean there is a bug in the sparse ?


> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    kernel/sched/fair.c: note: in included file (through include/linux/ww_=
mutex.h, include/linux/seqlock.h, include/linux/hrtimer.h, ...):
>    include/linux/rtmutex.h:70:65: sparse: sparse: Expected ) in function =
declarator
>    include/linux/rtmutex.h:70:65: sparse: sparse: got $
>    kernel/sched/fair.c: note: in included file (through include/linux/sch=
ed.h, kernel/sched/sched.h):
>    include/linux/seccomp.h:96:63: sparse: sparse: Expected ) in function =
declarator
>    include/linux/seccomp.h:96:63: sparse: sparse: got $
>    include/linux/seccomp.h:99:1: sparse: sparse: Expected ; at the end of=
 type declaration
>    include/linux/seccomp.h:99:1: sparse: sparse: got }
>    include/linux/seccomp.h:103:1: sparse: sparse: Expected ; at the end o=
f type declaration
>    include/linux/seccomp.h:103:1: sparse: sparse: got }
>    include/linux/seccomp.h:116:1: sparse: sparse: Expected ; at the end o=
f type declaration
>    include/linux/seccomp.h:116:1: sparse: sparse: got }
>    include/linux/seccomp.h:122:1: sparse: sparse: Expected ; at the end o=
f type declaration
>    include/linux/seccomp.h:122:1: sparse: sparse: got }
>    kernel/sched/fair.c: note: in included file (through include/linux/nod=
emask.h, include/linux/sched.h, kernel/sched/sched.h):
>    include/linux/numa.h:50:1: sparse: sparse: Expected ; at the end of ty=
pe declaration
>    include/linux/numa.h:50:1: sparse: sparse: got }
>    include/linux/numa.h:54:1: sparse: sparse: Expected ; at the end of ty=
pe declaration
>    include/linux/numa.h:54:1: sparse: sparse: got }
>    include/linux/numa.h:58:1: sparse: sparse: Expected ; at the end of ty=
pe declaration
>    include/linux/numa.h:58:1: sparse: sparse: got }
>    kernel/sched/fair.c: note: in included file (through include/linux/sch=
ed.h, kernel/sched/sched.h):
>    include/linux/nodemask.h:98:54: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:98:54: sparse: sparse: got }
>    include/linux/nodemask.h:99:19: sparse: sparse: Expected ; at end of d=
eclaration
>    include/linux/nodemask.h:99:19: sparse: sparse: got _unused_nodemask_a=
rg_
>    include/linux/nodemask.h:109:68: sparse: sparse: Expected ) in functio=
n declarator
>    include/linux/nodemask.h:109:68: sparse: sparse: got *
>    include/linux/nodemask.h:112:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:112:1: sparse: sparse: got }
>    include/linux/nodemask.h:116:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:116:1: sparse: sparse: got }
>    include/linux/nodemask.h:131:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:131:1: sparse: sparse: got }
>    include/linux/nodemask.h:137:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:137:1: sparse: sparse: got }
>    include/linux/nodemask.h:143:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:143:1: sparse: sparse: got }
>    include/linux/nodemask.h:149:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:149:1: sparse: sparse: got }
>    include/linux/nodemask.h:159:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:159:1: sparse: sparse: got }
>    include/linux/nodemask.h:167:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:167:1: sparse: sparse: got }
>    include/linux/nodemask.h:175:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:175:1: sparse: sparse: got }
>    include/linux/nodemask.h:183:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:183:1: sparse: sparse: got }
>    include/linux/nodemask.h:191:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:191:1: sparse: sparse: got }
>    include/linux/nodemask.h:199:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:199:1: sparse: sparse: got }
>    include/linux/nodemask.h:207:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:207:1: sparse: sparse: got }
>    include/linux/nodemask.h:215:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:215:1: sparse: sparse: got }
>    include/linux/nodemask.h:223:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:223:1: sparse: sparse: got }
>    include/linux/nodemask.h:229:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:229:1: sparse: sparse: got }
>    include/linux/nodemask.h:235:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:235:1: sparse: sparse: got }
>    include/linux/nodemask.h:241:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:241:1: sparse: sparse: got }
>    include/linux/nodemask.h:249:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:249:1: sparse: sparse: got }
>    include/linux/nodemask.h:257:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:257:1: sparse: sparse: got }
>    include/linux/nodemask.h:265:16: sparse: sparse: Expected ) in nested =
declarator
>    include/linux/nodemask.h:265:16: sparse: sparse: got <
>    include/linux/nodemask.h:265:16: sparse: sparse: Expected ; at the end=
 of type declaration
>    include/linux/nodemask.h:265:16: sparse: sparse: got }
>    include/linux/nodemask.h:266:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:266:1: sparse: sparse: got }
>    include/linux/nodemask.h:271:16: sparse: sparse: Expected ) in nested =
declarator
>    include/linux/nodemask.h:271:16: sparse: sparse: got <
>    include/linux/nodemask.h:271:16: sparse: sparse: Expected ; at the end=
 of type declaration
>    include/linux/nodemask.h:271:16: sparse: sparse: got }
>    include/linux/nodemask.h:272:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:272:1: sparse: sparse: got }
>    include/linux/nodemask.h:281:53: sparse: sparse: Expected ) in functio=
n declarator
>    include/linux/nodemask.h:281:53: sparse: sparse: got *
>    include/linux/nodemask.h:284:9: sparse: sparse: Expected ) in function=
 declarator
>    include/linux/nodemask.h:284:9: sparse: sparse: got (
>    include/linux/nodemask.h:285:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:285:1: sparse: sparse: got }
>    include/linux/nodemask.h:301:16: sparse: sparse: Expected ) in nested =
declarator
>    include/linux/nodemask.h:301:16: sparse: sparse: got <
>    include/linux/nodemask.h:301:16: sparse: sparse: Expected ; at the end=
 of type declaration
>    include/linux/nodemask.h:301:16: sparse: sparse: got }
>    include/linux/nodemask.h:303:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:303:1: sparse: sparse: got }
>    include/linux/nodemask.h:337:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:337:1: sparse: sparse: got }
>    include/linux/nodemask.h:343:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:343:1: sparse: sparse: got }
>    include/linux/nodemask.h:351:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:351:1: sparse: sparse: got }
>    include/linux/nodemask.h:359:1: sparse: sparse: Expected ; at the end =
of type declaration
>    include/linux/nodemask.h:359:1: sparse: sparse: too many errors
> >> /bin/bash: line 1: 21320 Segmentation fault      sparse -D__linux__ -D=
linux -D__STDC__ -Dunix -D__unix__ -Wbitwise -Wno-return-void -Wno-unknown-=
attribute -fdiagnostic-prefix -D__CHECK_ENDIAN__ -D__NDS32_EB__ --arch=3Dnd=
s32 -mbig-endian -m32 -Wp,-MMD,kernel/sched/.fair.o.d -nostdinc -isystem /o=
pt/cross/gcc-11.2.0-nolibc/nds32le-linux/bin/../lib/gcc/nds32le-linux/11.2.=
0/include -Iarch/nds32/include -I./arch/nds32/include/generated -Iinclude -=
I./include -Iarch/nds32/include/uapi -I./arch/nds32/include/generated/uapi =
-Iinclude/uapi -I./include/generated/uapi -include include/linux/compiler-v=
ersion.h -include include/linux/kconfig.h -include include/linux/compiler_t=
ypes.h -D__KERNEL__ -fmacro-prefix-map=3D=3D -DKBUILD_EXTRA_WARN1 -Wall -Wu=
ndef -Werror=3Dstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-c=
ommon -fshort-wchar -fno-PIE -Werror=3Dimplicit-function-declaration -Werro=
r=3Dimplicit-int -Werror=3Dreturn-type -Wno-format-security -std=3Dgnu89 -m=
no-sched-prolog-epilog -mcmodel=3Dlarge -mno-ext-fpu-sp -mno-ext-fpu-dp -mf=
loat-abi=3Dsoft -EB -fno-delete-null-pointer-checks -Wno-frame-address -Wno=
-format-truncation -Wno-format-overflow -Wno-address-of-packed-member -O2 -=
fno-allow-store-data-races -fno-reorder-blocks -fno-ipa-cp-clone -fno-parti=
al-inlining -Wframe-larger-than=3D1024 -fno-stack-protector -Wimplicit-fall=
through=3D5 -Wno-main -Wno-unused-but-set-variable -Wno-unused-const-variab=
le -fomit-frame-pointer -fno-stack-clash-protection -fzero-call-used-regs=
=3Dused-gpr -fno-inline-functions-called-once -falign-functions=3D64 -Wdecl=
aration-after-statement -Wvla -Wno-pointer-sign -Wno-stringop-truncation -W=
no-zero-length-bounds -Wno-array-bounds -Wno-stringop-overflow -Wno-restric=
t -Wno-maybe-uninitialized -fno-strict-overflow -fno-stack-check -fconserve=
-stack -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types -Werror=3Dd=
esignated-init -Wno-packed-not-aligned -Wextra -Wunused -Wno-unused-paramet=
er -Wmissing-declarations -Wmissing-format-attribute -Wmissing-prototypes -=
Wold-style-definition -Wmissing-include-dirs -Wunused-but-set-variable -Wun=
used-const-variable -Wpacked-not-aligned -Wstringop-truncation -Wno-missing=
-field-initializers -Wno-sign-compare -Wno-type-limits -I kernel/sched -I .=
/kernel/sched -DKBUILD_MODFILE=3D'"kernel/sched/fair"' -DKBUILD_BASENAME=3D=
'"fair"' -DKBUILD_MODNAME=3D'"fair"' -D__KBUILD_MODNAME=3Dkmod_fair kernel/=
sched/fair.c
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



--=20
Thanks
Yafang
