Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C5B457F7B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 17:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbhKTQZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 11:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhKTQZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 11:25:40 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45093C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 08:22:37 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so5047342wmj.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 08:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iqPS7tLe01tDe9iygYerB62+d1G1Gd8/4mEjghWg59s=;
        b=epGrx4vddGzB/Xj9gSasid7EfAFHsNutvA4Hk9xWz+4q52hfXjIwALnLHENqJQEnEV
         iQZjASp6SaaeR8SPmbVQ+HTS2bhRYSj6y8PYzL5KbgIQ4+Bc105LkLUkPqRPv2747sbr
         ecvGqGCz0Ho7RDqo/PBXnPwGHi8f8QusqKNzPQ8seFjY0XXBt9+8kNd+tPbT6AkShMOp
         CELrNZX9ph8cS5Ny0bxcRKSANTRQ7s1tudrI4OPXam0wf+Ms0WLBQiytGD9gwKqIOoZE
         ys+od/vjzqhCnfqaybiWnR+ihg0e82KAqI0L6NfrS8fLYQvlwqqb/XSubO4tWkJLoK9E
         AOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iqPS7tLe01tDe9iygYerB62+d1G1Gd8/4mEjghWg59s=;
        b=kBxCre9m79SNNwlGGbZA16sid+rqk9WqdxOH8Op9bJCCPK/p/wdRLC9b6nEKU5SJdP
         7EYrmEYDzty42RK3yaggJ+ciK9DBgClGr1rXRexEpCLLjGDnjJpHf1UeaPgaGao0Gqhq
         qWkFzCqXXSrJYC+kQww0dMJvtfS+krLtQxWbuqNbXP1IwJIOVZMbE/RAFphQZMkeyx5r
         KoJJpw2duqvmDteqjWx+OJ6c19rj6HLrwTfDhzv04tpejMrjwyWls3ZjoGaTjwoG2AJr
         Lj4Xutb0Viuavw9X2kLf/Op+sYqR+6U73rlK/miI3+Wl+uGTeMz7g1COXigpGldjHplb
         0liQ==
X-Gm-Message-State: AOAM531sWgoQftq7/qxWS78+F4OHdyCr0sAj/1MnShbgQ+fQXmwmrGf6
        7g7dvyISAeZodBQRv82BMfL5EAZb75JRDw==
X-Google-Smtp-Source: ABdhPJyyj6PnNANFKCNiFIRWOYF5mNbjhSBu1yfIf6O8RHkCrR2/lbI9EmrVPIqXpgrHMnRjQdqjhw==
X-Received: by 2002:a7b:cf0f:: with SMTP id l15mr11551342wmg.92.1637425355813;
        Sat, 20 Nov 2021 08:22:35 -0800 (PST)
Received: from [10.168.10.170] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id n8sm2993777wrp.95.2021.11.20.08.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Nov 2021 08:22:35 -0800 (PST)
Message-ID: <6c4181ac-b089-1e13-7c86-ae2fddf55dc6@gmail.com>
Date:   Sat, 20 Nov 2021 17:22:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 01/20] linux/stddef.h, linux/offsetof.h: Split
 offsetof() into a separate header
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
 <20211120130104.185699-2-alx.manpages@gmail.com>
 <CAHp75Vd8SKA+mu-5AXWJufsitpeNGnBms4nOzDjOD2g04cjpeg@mail.gmail.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <CAHp75Vd8SKA+mu-5AXWJufsitpeNGnBms4nOzDjOD2g04cjpeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 11/20/21 17:14, Andy Shevchenko wrote:
> On Sat, Nov 20, 2021 at 3:02 PM Alejandro Colomar
> <alx.manpages@gmail.com> wrote:
>>
>> Include <linux/offsetof.h> from <linux/stddef.h> for compatibility.
>>
>>  From <linux/offsetof.h>:
>>          Include the same exact deps that <linux/stddef.h> had.
>>          Changing that in any way broke my compilation.
> 
> The commit message does not explain why you are doing this, what's the
> problem it fixes.
> 

Hmm, yes, after many attempts,
that one doesn't fix anything.
I think I should drop the split of offsetof[end](),
since I'm forced to include the same headers indirectly anyway.


For the rest,
such as sizeof_field(),
I'm allowed to include just a tiny header with the definition
in the following cases:

a91eb933173e tools/virtio/: Don't redefine container_of()
836786f021cc tools/usb/: Don't redefine container_of()
f51e3d656990 tools/testing/selftests/rcutorture/: Don't redefine 
container_of()
99aa6a86fb21 samples/bpf/: Don't redefine container_of()
0463de8c8e86 tools/testing/selftests/vm/: Don't redefine ARRAY_SIZE()
9cda268b981d tools/testing/selftests/timens/: Don't redefine ARRAY_SIZE()
02efb34c1afa tools/testing/selftests/sparc/: Don't redefine ARRAY_SIZE()
4973f19407f0 tools/testing/selftests/seccomp/: Don't redefine ARRAY_SIZE()
ecaee90a1b3c tools/testing/selftests/rseq/: Don't redefine ARRAY_SIZE()
2392de0d71f2 tools/testing/selftests/openat2/: Don't redefine ARRAY_SIZE()
bbc657cb231d tools/testing/selftests/net/: Don't redefine ARRAY_SIZE()
f5eae2dee077 tools/testing/selftests/landlock/: Don't redefine ARRAY_SIZE()
c35ca31451ef tools/testing/selftests/kselftest_harness.h: Don't redefine 
ARRAY_SIZE()
76fce3e8f3bd tools/testing/selftests/ir/: Don't redefine ARRAY_SIZE()
4f7f4632effd tools/testing/selftests/core/: Don't redefine ARRAY_SIZE()
71352d2db882 tools/testing/selftests/cgroup/: Don't redefine ARRAY_SIZE()
d2f0dc48706b tools/testing/selftests/bpf/: Don't redefine ARRAY_SIZE()
11760b380c35 tools/testing/selftests/arm64/: Don't redefine ARRAY_SIZE()
ea04d7799b42 tools/vm/: Don't redefine ARRAY_SIZE()
d5e54883d374 tools/virtio/: Don't redefine ARRAY_SIZE()
ab4f6b9fb71b tools/usb/: Don't redefine ARRAY_SIZE()
dfa264d3150d tools/spi/: Don't redefine ARRAY_SIZE()
0513d57ad00e tools/power/: Don't redefine ARRAY_SIZE()
418a8fa44788 tools/lib/traceevent/: Don't redefine ARRAY_SIZE()
bb9b11f95249 tools/iio/: Don't redefine ARRAY_SIZE()
3350c5b02479 tools/gpio/: Don't redefine ARRAY_SIZE()
dab0e175d727 tools/firewire/: Don't redefine ARRAY_SIZE()
a7457639b307 tools/bpf/: Don't redefine ARRAY_SIZE()
c651930196f1 tools/arch/: Don't redefine ARRAY_SIZE()
a2ba541db10c samples/seccomp/: Don't redefine ARRAY_SIZE()
ed5609ed8785 samples/bpf/: Don't redefine ARRAY_SIZE()
9b568cd21579 lib/zstd/: Don't redefine ARRAY_SIZE()
4f2d185b6ccc lib/mpi/: Don't redefine ARRAY_SIZE()
a14b402ce8dc include/acpi/: Don't redefine ARRAY_SIZE()
34dc6551c0a4 fs/unicode/: Don't redefine ARRAY_SIZE()
7ac3580d0d03 fs/orangefs/: Don't redefine ARRAY_SIZE()
9ff567cbf6d3 drivers/net/ethernet/: Don't redefine ARRAY_SIZE()
a8c503ade00a arch/um/: Don't redefine ARRAY_SIZE()
b5ffd6f335d2 arch/powerpc/: Don't redefine ARRAY_SIZE()
f5acf6fd58b1 arch/mips/: Don't redefine ARRAY_SIZE()
78347d718990 tools/testing/selftests/bpf/: Don't redefine NULL
d6ecbed02c1c include/acpi/: Don't redefine NULL
f6bd9b2ddfa2 drivers/video/: Don't redefine NULL
f9b15eccf7ba drivers/net/: Don't redefine NULL
eb07b8abb7b9 drivers/media/: Don't redefine NULL
f3e8e2322350 crypto/: Don't redefine NULL
888c3a451ba1 arch/parisc/: Don't redefine NULL
95a5dd02310d arch/mips/: Don't redefine NULL
0e1f3fb47007 tools/testing/selftests/bpf/: Don't redefine sizeof_field()
ddfa13d5dd76 tools/testing/selftests/bpf/: Don't redefine offsetofend()
bd393bf9fd41 tools/usb/: Don't redefine offsetof()
fd17a1d549f1 tools/testing/selftests/bpf/: Don't redefine offsetof()
f32aed18c34d samples/bpf/: Don't redefine offsetof()
b2755f698986 drivers/staging/: Don't redefine offsetof()


That is the draft that I have for patch set 2.

As an example, let me show you one of those commits:

$ git show 0e1f3fb47007
commit 0e1f3fb47007ca93df6f2b998868c892258e6ea9
Author: Alejandro Colomar <alx.manpages@gmail.com>
Date:   Fri Nov 19 18:28:30 2021 +0100

     tools/testing/selftests/bpf/: Don't redefine sizeof_field()

     Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>

diff --git a/tools/testing/selftests/bpf/bpf_util.h 
b/tools/testing/selftests/bpf/bpf_util.h
index 28c29292bacd..394377e4aa14 100644
--- a/tools/testing/selftests/bpf/bpf_util.h
+++ b/tools/testing/selftests/bpf/bpf_util.h
@@ -8,6 +8,7 @@
  #include <errno.h>
  #include <bpf/libbpf.h> /* libbpf_num_possible_cpus */
  #include <linux/offsetofend.h>
+#include <linux/sizeof_field.h>

  static inline unsigned int bpf_num_possible_cpus(void)
  {
@@ -32,9 +33,5 @@ static inline unsigned int bpf_num_possible_cpus(void)
  # define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
  #endif

-#ifndef sizeof_field
-#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
-#endif
-

  #endif /* __BPF_UTIL__ */
diff --git a/tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c 
b/tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c
index 5f4e87ee949a..5fafb54910cd 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c
@@ -6,6 +6,7 @@
  #include <stdbool.h>
  #include <sys/types.h>
  #include <sys/socket.h>
+#include <linux/sizeof_field.h>
  #include <linux/tcp.h>
  #include <linux/socket.h>
  #include <linux/bpf.h>
@@ -15,9 +16,6 @@
  #define BPF_PROG_TEST_TCP_HDR_OPTIONS
  #include "test_tcp_hdr_options.h"

-#ifndef sizeof_field
-#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
-#endif

  __u8 test_kind = TCPOPT_EXP;
  __u16 test_magic = 0xeB9F;


-- 
Alejandro Colomar
Linux man-pages comaintainer; http://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
