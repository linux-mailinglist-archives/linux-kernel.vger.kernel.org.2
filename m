Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCF73AF827
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 23:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhFUWAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 18:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbhFUV77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 17:59:59 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570C6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 14:57:43 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t17so12412980lfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 14:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oy+qD2DzJ/Q9psFyct3GJuObsLbWObRTlOd/5Wjv9is=;
        b=crluo1ZkLswSihhef0gljwMPNiKDl0evBG5O5GsAh/oXrYhOO2uDZYAp3hNOQSoat/
         nTAm7I0mhjW1iZ8KQNxqfPzvijZ1MWSxTESJHnB1NHzbRvlFDYGBXXIdAedndRWopaVl
         5od7tLS0r5r8RariJkR73UkZWbZuzoHeh+X2amu7Y0cef9+bIIGAOyfzbHzhcEcare3k
         bhEsJj/RYbmf1omqnctbqmqkCciam0zq/wTGg3Fq3jw+gGIey1e2lbNJZLRkxP1i31YV
         Xv4hknOJAnhhqcRLClHZxKkW09JWCmWMbiWdHYbanuYLYp9Wo0gTLNwVAjc+XJNW7ful
         hWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oy+qD2DzJ/Q9psFyct3GJuObsLbWObRTlOd/5Wjv9is=;
        b=hC5BYZn0cxtxPLGYEs15IIFVZVREc4SBSJ7kq3z1Z/ogvUdrML63+/37KbDd+P1k7N
         pasy9k67qceyovdz5bPzAAiz6C9uSzC7zdojaDgL74QowA6YfUBlGwdRa6DCNo+Aifi3
         bIPAwtSvgpOefNq+QgcCe2XSqoL8XP1wdEdpoDHzjCaJNNMllRWPGCDpbb7J4u7ZVRMr
         w4pg62fdkHIP+qrX2+3RsAc7yyAfZ1ty/hJZp/3x0sqctZ6qXWpUReFiPSu1/ed7383U
         ZN6HhvgchpAMhTqnjiYI5QMi5J10nFymPOCPJW8d9jmP8SHBboZVW7ARCji4AF7adHdA
         yjkw==
X-Gm-Message-State: AOAM532xEaAFoU7BpSoGANCtkbippJGFkf8Shv0cZNkyw+ExVushni+C
        MRcZFglnBUQ+q7SHGANXW3QQAfW+niprjRcNnaQ/KQ==
X-Google-Smtp-Source: ABdhPJzf52gV8UjzZ7HDGa4PF7bcvBCFTtZtHDSaq1+1qSdtgGAssMvNcL4QB5k61aRM/hpEvrUPw10XbOqzc1LyQwQ=
X-Received: by 2002:a05:6512:511:: with SMTP id o17mr293108lfb.202.1624312661562;
 Mon, 21 Jun 2021 14:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210611180242.711399-1-dima@arista.com> <c9d24f64-4c34-703f-2223-113076e07b46@csgroup.eu>
In-Reply-To: <c9d24f64-4c34-703f-2223-113076e07b46@csgroup.eu>
From:   Dmitry Safonov <dima@arista.com>
Date:   Mon, 21 Jun 2021 22:57:30 +0100
Message-ID: <CAGrbwDRZ5Tgt68kwhRSFMwzfaup9HGU596X1GA2MWX4NEeFjYA@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] Add generic vdso_base tracking
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/21 10:13 AM, Christophe Leroy wrote:
>
>
> Le 11/06/2021 =C3=A0 20:02, Dmitry Safonov a =C3=A9crit :
>> v3 Changes:
>> - Migrated arch/powerpc to vdso_base
>> - Added x86/selftest for unmapped vdso & no landing on fast syscall
>> - Review comments from Andy & Christophe (thanks!)
>> - Amended s/born process/execed process/ everywhere I noticed
>> - Build robot warning on cast from __user pointer
>>
>> I've tested it on x86, I would appreciate any help with
>> Tested-by on arm/arm64/mips/powerpc/s390/... platforms.
>
> I tried it on powerpc, normal use still works.

Thank you!

> What tests can be done exactly ?

Well, for x86 I've run all vdso tests from tools/testing/selftests/x86/
(with the new one from patch 23 here, which tests exactly forced
segfault on unmapped vdso).
I think normal use on other platforms sounds good to me.

>
> We have a selftest in powerpc
> (https://github.com/linuxppc/linux/blob/master/tools/testing/selftests/po=
werpc/signal/sigreturn_vdso.c)
> but it doesn't work anymore since the split of VDSO into VDSO+VVAR.

Well, it doesn't sound very hard to fix, see the sample diff inline.

Thank you,
Dmitry

--->8---
diff --git a/tools/testing/selftests/powerpc/signal/sigreturn_vdso.c
b/tools/testing/selftests/powerpc/signal/sigreturn_vdso.c
index e282fff0fe25..a4f85ee13c4a 100644
--- a/tools/testing/selftests/powerpc/signal/sigreturn_vdso.c
+++ b/tools/testing/selftests/powerpc/signal/sigreturn_vdso.c
@@ -13,6 +13,7 @@
 #include <signal.h>
 #include <stdlib.h>
 #include <string.h>
+#include <stdbool.h>
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <unistd.h>
@@ -23,7 +24,7 @@

 #include "utils.h"

-static int search_proc_maps(char *needle, unsigned long *low,
unsigned long *high)
+static int search_proc_maps(char *needle, unsigned long *low,
unsigned long *high, unsigned long *size)
 {
     unsigned long start, end;
     static char buf[4096];
@@ -52,6 +53,7 @@ static int search_proc_maps(char *needle, unsigned
long *low, unsigned long *hig
         if (strstr(name, needle)) {
             *low =3D start;
             *high =3D end - 1;
+            *size =3D end - start;
             rc =3D 0;
             break;
         }
@@ -71,9 +73,12 @@ static void sigusr1_handler(int sig)

 int test_sigreturn_vdso(void)
 {
-    unsigned long low, high, size;
+    unsigned long stack_start, stack_end, stack_size;
+    unsigned long vdso_start, vdso_end, vdso_size;
+    unsigned long vvar_start, vvar_end, vvar_size;
+    char *vdso_parking, *vvar_parking;
     struct sigaction act;
-    char *p;
+    bool vvar_present;

     act.sa_handler =3D sigusr1_handler;
     act.sa_flags =3D 0;
@@ -82,36 +87,56 @@ int test_sigreturn_vdso(void)
     assert(sigaction(SIGUSR1, &act, NULL) =3D=3D 0);

     // Confirm the VDSO is mapped, and work out where it is
-    assert(search_proc_maps("[vdso]", &low, &high) =3D=3D 0);
-    size =3D high - low + 1;
-    printf("VDSO is at 0x%lx-0x%lx (%lu bytes)\n", low, high, size);
+    assert(search_proc_maps("[vdso]", &vdso_start, &vdso_end,
&vdso_size) =3D=3D 0);
+    printf("VDSO is at 0x%lx-0x%lx (%lu bytes)\n", vdso_start,
vdso_end, vdso_size);
+    // On older kernels there's only vdso, on newer vdso/vvar pair
+    if (search_proc_maps("[vvar]", &vvar_start, &vvar_end, &vvar_size) =3D=
=3D 0) {
+        vvar_present =3D true;
+        printf("VVAR is at 0x%lx-0x%lx (%lu bytes)\n",
+                vvar_start, vvar_end, vvar_size);
+    } else {
+        vvar_present =3D false;
+        vvar_size =3D 0;
+    }

     kill(getpid(), SIGUSR1);
     assert(took_signal =3D=3D 1);
     printf("Signal delivered OK with VDSO mapped\n");

-    // Remap the VDSO somewhere else
-    p =3D mmap(NULL, size, PROT_READ|PROT_WRITE,
MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
-    assert(p !=3D MAP_FAILED);
-    assert(mremap((void *)low, size, size,
MREMAP_MAYMOVE|MREMAP_FIXED, p) !=3D MAP_FAILED);
-    assert(search_proc_maps("[vdso]", &low, &high) =3D=3D 0);
-    size =3D high - low + 1;
-    printf("VDSO moved to 0x%lx-0x%lx (%lu bytes)\n", low, high, size);
+    // Remap the VDSO and VVAR somewhere else
+    vdso_parking =3D mmap(NULL, vdso_size + vvar_size,
PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+    assert(vdso_parking !=3D MAP_FAILED);
+
+    if (vvar_present) {
+        // The relative position of vdso/vvar must always stay the same
+        if (vvar_start > vdso_start) {
+            vvar_parking =3D vdso_parking + vdso_size;
+        } else {
+            vvar_parking =3D vdso_parking;
+            vdso_parking =3D vvar_parking + vvar_size;
+        }
+        assert(mremap((void *)vvar_start, vvar_size, vvar_size,
MREMAP_MAYMOVE|MREMAP_FIXED, vvar_parking) !=3D MAP_FAILED);
+    }
+    assert(mremap((void *)vdso_start, vdso_size, vdso_size,
MREMAP_MAYMOVE|MREMAP_FIXED, vdso_parking) !=3D MAP_FAILED);
+
+    assert(search_proc_maps("[vdso]", &vdso_start, &vdso_end,
&vdso_size) =3D=3D 0);
+    printf("VDSO moved to 0x%lx-0x%lx (%lu bytes)\n", vdso_start,
vdso_end, vdso_size);
+    assert(search_proc_maps("[vvar]", &vvar_start, &vvar_end,
&vvar_size) =3D=3D 0);
+    printf("VVAR moved to 0x%lx-0x%lx (%lu bytes)\n", vvar_start,
vvar_end, vvar_size);

     kill(getpid(), SIGUSR1);
     assert(took_signal =3D=3D 2);
     printf("Signal delivered OK with VDSO moved\n");

-    assert(munmap((void *)low, size) =3D=3D 0);
+    assert(munmap((void *)vdso_start, vdso_size) =3D=3D 0);
     printf("Unmapped VDSO\n");

     // Confirm the VDSO is not mapped anymore
-    assert(search_proc_maps("[vdso]", &low, &high) !=3D 0);
+    assert(search_proc_maps("[vdso]", &vdso_start, &vdso_end,
&vdso_size) !=3D 0);

     // Make the stack executable
-    assert(search_proc_maps("[stack]", &low, &high) =3D=3D 0);
-    size =3D high - low + 1;
-    mprotect((void *)low, size, PROT_READ|PROT_WRITE|PROT_EXEC);
+    assert(search_proc_maps("[stack]", &stack_start, &stack_end,
&stack_size) =3D=3D 0);
+    mprotect((void *)stack_start, stack_size, PROT_READ|PROT_WRITE|PROT_EX=
EC);
     printf("Remapped the stack executable\n");

     kill(getpid(), SIGUSR1);
