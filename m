Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40273CB8B1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 16:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240237AbhGPOc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 10:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbhGPOc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 10:32:57 -0400
X-Greylist: delayed 134 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 16 Jul 2021 07:30:02 PDT
Received: from gmmr2.centrum.cz (gmmr2.centrum.cz [IPv6:2a00:da80:1:502::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA26FC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 07:30:02 -0700 (PDT)
Received: from gmmr-3.centrum.cz (unknown [10.255.254.22])
        by gmmr2.centrum.cz (Postfix) with ESMTP id 2A8846000328;
        Fri, 16 Jul 2021 16:27:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
        t=1626445666; bh=oBeBN4CAG/HxQRJ9DXdZkQ9aXEd6LQqHvLuXicrc5Yk=;
        h=Date:From:To:Cc:Subject:From;
        b=ipj0GQl7485zzQ/khfHOrxA2hbyvGm6QzLxHNCiA/HZMgr2bvZzxfBJXdcJ2Mc2Ey
         W0au6CIojmdAmhWRsZSM+aH156cymscVSeVlIn8fDex5Dn2ScPMa9lgdYXG6h3x4iJ
         MQNRXvVYcCbMfboJq5pYq1LHyK9dm+ssNJX0MpYM=
Received: from vm2.excello.cz (vm2.excello.cz [IPv6:2001:67c:15a0:4000::b])
        by gmmr-3.centrum.cz (Postfix) with QMQP
        id 276E810016945; Fri, 16 Jul 2021 16:27:46 +0200 (CEST)
Received: from vm2.excello.cz by vm2.excello.cz
 (VF-Scanner: Clear:RC:0(2a00:da80:0:502::7):SC:0(-0.3/5.0):CC:0:;
 processed in 0.9 s); 16 Jul 2021 14:27:46 +0000
X-VF-Scanner-ID: 20210716142745.287676.32532.vm2.excello.cz.0
X-Spam-Status: No, hits=-0.3, required=5.0
Received: from gmmr-1.centrum.cz (2a00:da80:0:502::7)
  by out1.virusfree.cz with ESMTPS (TLSv1.3, TLS_AES_256_GCM_SHA384); 16 Jul 2021 16:27:45 +0200
Received: from gm-smtp11.centrum.cz (unknown [10.255.254.39])
        by gmmr-1.centrum.cz (Postfix) with ESMTP id 3E7E52005E064;
        Fri, 16 Jul 2021 16:27:45 +0200 (CEST)
Received: from arkam (unknown [94.113.86.190])
        by gm-smtp11.centrum.cz (Postfix) with ESMTPA id 9D53B18054D28;
        Fri, 16 Jul 2021 16:27:44 +0200 (CEST)
Date:   Fri, 16 Jul 2021 16:27:42 +0200
From:   Petr =?utf-8?B?VmFuxJtr?= <arkamar@atlas.cz>
To:     Denys Vlasenko <dvlasenk@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Chanho Park <parkch98@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Khem Raj <raj.khem@gmail.com>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Mike Leach <mike.leach@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr =?utf-8?B?VmFuxJtr?= <arkamar@atlas.cz>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Stephane Eranian <eranian@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>
Subject: Unknown __always_inline in linux/swab.h
Message-ID: <YPGXXt6Z3O1W0AYS@arkam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I cannot build the kernel on my box with musl libc since release 5.12,
see the kernel 5.13.1 build log below.  Bisect points to the commit
1d509f2a6ebc ("x86/insn: Support big endian cross-compiles") merged to
5.12-rc1, but it probably only triggers the issue from different place.

I searched through the mailing list [1] and it seems that people face to
a similar issue with perf tool as well [2-5]. Related issues were also
reported in Gentoo [6] and alpinelinux [7]. Both distributions basically
fixed it with the patch from [3] which works for me and it is the best
solution, in my opinion. I believe it should be applied to the upstream
and backported to 5.12 and 5.13.

Systems with glibc are not affected because glibc defines its own
__always_inline in sys/cdefs.h which is indirectly included with stdio.h
and/or stdlib.h in top of tools/objtool/arch/x86/decode.c file.

Note: I CCed you because your address was mentioned in [2-5] or in
bisected commit.

Thanks,
Petr

References:

[1] https://lore.kernel.org/lkml/?q=swab+__always_inline
[2] https://lore.kernel.org/lkml/20210204005810.GZ854763@kernel.org/
[3] https://lore.kernel.org/lkml/1514973450-12447-1-git-send-email-matt.redfearn@mips.com/
[4] https://lore.kernel.org/lkml/20181213180129.1373-1-raj.khem@gmail.com/
[5] https://lore.kernel.org/lkml/20201210144844.72580-1-chanho61.park@samsung.com/
[6] https://bugs.gentoo.org/791364
[7] https://gitlab.alpinelinux.org/alpine/aports/-/issues/11119

Build log:

make[1]: Entering directory '/var/tmp/portage/linux'
  GEN     Makefile
  DESCEND objtool
  CALL    /usr/src/linux-5.13.1-gentoo/scripts/atomic/check-atomics.sh
  CALL    /usr/src/linux-5.13.1-gentoo/scripts/checksyscalls.sh
  CC      /var/tmp/portage/linux/tools/objtool/arch/x86/decode.o
  CC      /var/tmp/portage/linux/tools/objtool/str_error_r.o
  CC      /var/tmp/portage/linux/tools/objtool/librbtree.o
In file included from /usr/include/linux/byteorder/little_endian.h:13,
                 from /usr/include/asm/byteorder.h:5,
                 from /usr/src/linux-5.13.1-gentoo/tools/arch/x86/include/asm/insn.h:10,
                 from arch/x86/decode.c:10:
/usr/include/linux/swab.h:136:23: error: expected ';' before 'unsigned'
  136 | static __always_inline unsigned long __swab(const unsigned long y)
      |                       ^~~~~~~~~
      |                       ;
/usr/include/linux/swab.h:171:8: error: unknown type name '__always_inline'
  171 | static __always_inline __u16 __swab16p(const __u16 *p)
      |        ^~~~~~~~~~~~~~~
/usr/include/linux/swab.h:171:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__swab16p'
  171 | static __always_inline __u16 __swab16p(const __u16 *p)
      |                              ^~~~~~~~~
/usr/include/linux/swab.h:184:8: error: unknown type name '__always_inline'
  184 | static __always_inline __u32 __swab32p(const __u32 *p)
      |        ^~~~~~~~~~~~~~~
/usr/include/linux/swab.h:184:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__swab32p'
  184 | static __always_inline __u32 __swab32p(const __u32 *p)
      |                              ^~~~~~~~~
/usr/include/linux/swab.h:197:8: error: unknown type name '__always_inline'
  197 | static __always_inline __u64 __swab64p(const __u64 *p)
      |        ^~~~~~~~~~~~~~~
/usr/include/linux/swab.h:197:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__swab64p'
  197 | static __always_inline __u64 __swab64p(const __u64 *p)
      |                              ^~~~~~~~~
/usr/include/linux/swab.h:252:23: error: expected ';' before 'void'
  252 | static __always_inline void __swab32s(__u32 *p)
      |                       ^~~~~
      |                       ;
/usr/include/linux/swab.h:265:23: error: expected ';' before 'void'
  265 | static __always_inline void __swab64s(__u64 *p)
      |                       ^~~~~
      |                       ;
In file included from /usr/include/asm/byteorder.h:5,
                 from /usr/src/linux-5.13.1-gentoo/tools/arch/x86/include/asm/insn.h:10,
                 from arch/x86/decode.c:10:
/usr/include/linux/byteorder/little_endian.h:44:8: error: unknown type name '__always_inline'
   44 | static __always_inline __le64 __cpu_to_le64p(const __u64 *p)
      |        ^~~~~~~~~~~~~~~
/usr/include/linux/byteorder/little_endian.h:44:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_le64p'
   44 | static __always_inline __le64 __cpu_to_le64p(const __u64 *p)
      |                               ^~~~~~~~~~~~~~
/usr/include/linux/byteorder/little_endian.h:48:8: error: unknown type name '__always_inline'
   48 | static __always_inline __u64 __le64_to_cpup(const __le64 *p)
      |        ^~~~~~~~~~~~~~~
/usr/include/linux/byteorder/little_endian.h:48:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__le64_to_cpup'
   48 | static __always_inline __u64 __le64_to_cpup(const __le64 *p)
      |                              ^~~~~~~~~~~~~~
/usr/include/linux/byteorder/little_endian.h:52:8: error: unknown type name '__always_inline'
   52 | static __always_inline __le32 __cpu_to_le32p(const __u32 *p)
      |        ^~~~~~~~~~~~~~~
/usr/include/linux/byteorder/little_endian.h:52:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_le32p'
   52 | static __always_inline __le32 __cpu_to_le32p(const __u32 *p)
      |                               ^~~~~~~~~~~~~~
/usr/include/linux/byteorder/little_endian.h:56:8: error: unknown type name '__always_inline'
   56 | static __always_inline __u32 __le32_to_cpup(const __le32 *p)
      |        ^~~~~~~~~~~~~~~
/usr/include/linux/byteorder/little_endian.h:56:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__le32_to_cpup'
   56 | static __always_inline __u32 __le32_to_cpup(const __le32 *p)
      |                              ^~~~~~~~~~~~~~
/usr/include/linux/byteorder/little_endian.h:60:8: error: unknown type name '__always_inline'
   60 | static __always_inline __le16 __cpu_to_le16p(const __u16 *p)
      |        ^~~~~~~~~~~~~~~
/usr/include/linux/byteorder/little_endian.h:60:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_le16p'
   60 | static __always_inline __le16 __cpu_to_le16p(const __u16 *p)
      |                               ^~~~~~~~~~~~~~
/usr/include/linux/byteorder/little_endian.h:64:8: error: unknown type name '__always_inline'
   64 | static __always_inline __u16 __le16_to_cpup(const __le16 *p)
      |        ^~~~~~~~~~~~~~~
/usr/include/linux/byteorder/little_endian.h:64:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__le16_to_cpup'
   64 | static __always_inline __u16 __le16_to_cpup(const __le16 *p)
      |                              ^~~~~~~~~~~~~~
/usr/include/linux/byteorder/little_endian.h:68:8: error: unknown type name '__always_inline'
   68 | static __always_inline __be64 __cpu_to_be64p(const __u64 *p)
      |        ^~~~~~~~~~~~~~~
/usr/include/linux/byteorder/little_endian.h:68:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_be64p'
   68 | static __always_inline __be64 __cpu_to_be64p(const __u64 *p)
      |                               ^~~~~~~~~~~~~~
/usr/include/linux/byteorder/little_endian.h:72:8: error: unknown type name '__always_inline'
   72 | static __always_inline __u64 __be64_to_cpup(const __be64 *p)
      |        ^~~~~~~~~~~~~~~
/usr/include/linux/byteorder/little_endian.h:72:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__be64_to_cpup'
   72 | static __always_inline __u64 __be64_to_cpup(const __be64 *p)
      |                              ^~~~~~~~~~~~~~
/usr/include/linux/byteorder/little_endian.h:76:8: error: unknown type name '__always_inline'
   76 | static __always_inline __be32 __cpu_to_be32p(const __u32 *p)
      |        ^~~~~~~~~~~~~~~
/usr/include/linux/byteorder/little_endian.h:76:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_be32p'
   76 | static __always_inline __be32 __cpu_to_be32p(const __u32 *p)
      |                               ^~~~~~~~~~~~~~
/usr/include/linux/byteorder/little_endian.h:80:8: error: unknown type name '__always_inline'
   80 | static __always_inline __u32 __be32_to_cpup(const __be32 *p)
      |        ^~~~~~~~~~~~~~~
/usr/include/linux/byteorder/little_endian.h:80:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__be32_to_cpup'
   80 | static __always_inline __u32 __be32_to_cpup(const __be32 *p)
      |                              ^~~~~~~~~~~~~~
/usr/include/linux/byteorder/little_endian.h:84:8: error: unknown type name '__always_inline'
   84 | static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
      |        ^~~~~~~~~~~~~~~
/usr/include/linux/byteorder/little_endian.h:84:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_be16p'
   84 | static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
      |                               ^~~~~~~~~~~~~~
/usr/include/linux/byteorder/little_endian.h:88:8: error: unknown type name '__always_inline'
   88 | static __always_inline __u16 __be16_to_cpup(const __be16 *p)
      |        ^~~~~~~~~~~~~~~
/usr/include/linux/byteorder/little_endian.h:88:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__be16_to_cpup'
   88 | static __always_inline __u16 __be16_to_cpup(const __be16 *p)
      |                              ^~~~~~~~~~~~~~
make[5]: *** [/usr/src/linux-5.13.1-gentoo/tools/build/Makefile.build:97: /var/tmp/portage/linux/tools/objtool/arch/x86/decode.o] Error 1
make[4]: *** [/usr/src/linux-5.13.1-gentoo/tools/build/Makefile.build:139: arch/x86] Error 2
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [Makefile:56: /var/tmp/portage/linux/tools/objtool/objtool-in.o] Error 2
make[2]: *** [Makefile:69: objtool] Error 2
make[1]: *** [/usr/src/linux-5.13.1-gentoo/Makefile:1974: tools/objtool] Error 2
make[1]: Leaving directory '/var/tmp/portage/linux'
make: *** [Makefile:215: __sub-make] Error 2
