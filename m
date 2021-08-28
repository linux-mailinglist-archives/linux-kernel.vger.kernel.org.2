Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7649D3FA75A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 21:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhH1TiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 15:38:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:51295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230253AbhH1TiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 15:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630179427;
        bh=9W+L+zUXd/A98qjTuxdlNEMXw8/UgzhSLNYmMEnKGPc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RUJWE6P4geAA/TcBI3QGrucLme0Gdafk3dmI3y+DKdKj9+pJUBj7UHJYwUf9R9xkw
         U9c7jivOI/S8t2dmqrTo2SwqBuIvTsYqmeJA+Wh4u+Xnh5sO/Mp+3NAhw0cwJR2qWk
         lERByaaeTon1SUj73DcTgGhpGYGazLm9e8tzdF0Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.145.58]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHoNC-1mGEuj1oxi-00EwoK; Sat, 28
 Aug 2021 21:37:07 +0200
Date:   Sat, 28 Aug 2021 21:35:35 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Helge Deller <deller@gmx.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: Re: [PATCH] Fix prctl(PR_GET_NAME) to not leak random trailing bytes
Message-ID: <YSqQB9OhTuASD3ya@ls3530>
References: <YSiwLuE17BwRlI/d@ls3530>
 <aa0006e7-58b8-ab05-0599-5609e900ba4d@rasmusvillemoes.dk>
 <97a0ddcf-243d-f312-8291-01d6595260bf@gmx.de>
 <CAHk-=wjhKNB_1a6wjjPh2PvMrtjVs=DgGY5uM2jq3WBBaYMyGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjhKNB_1a6wjjPh2PvMrtjVs=DgGY5uM2jq3WBBaYMyGQ@mail.gmail.com>
X-Provags-ID: V03:K1:2hGIvINzgWRiayn3IwnN/EkVTqrIOQvGiq5m8zH2Fw7wJ7vNUBu
 xVm0gYeaHKr+l1LUp+TzC2GXQICuT+HTGPvcdbjaB0bf/LsmLPlPVCTsLVXA8iSi5DqiM5u
 wVAR7t88sUC32KCokhzwcP2l9e/tkMnZXfVXVkAcnw4XxKFuCCxdpXrSsoihMsiBZ1Y09LX
 ESMUyVJKRmfUM1+Zddn2A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zq4zzJ5Gnog=:7XrZUczu8h8/CX52qpHGtM
 tBpAuZg98A36XSmyAAjsNO4xQ8THezARacYy4OEu0QTixb5FrO3k8aouWqYV3PcZa4nGHTUiD
 MJjvdpm/glQrxrA/oIHF4+mpnl2NEctbgyav+HqZpyMpwP/4tWmlY34e5fUyy6Di9HHChQ3mF
 bCUaGUkrIdLdfhMpW4uDjNQ68TZ+LR1eLhAG9j2JtL+nYv4eXEhCvpviixIoISL65n7U9yeZK
 2M1bGMix1txm8HKNgU+BHMGMq42qq1RsQluRnyADNAuBfOhFIPhUM1ENN6nF+X9L04vbB1E2p
 RU7y1cFYEixnVd4M8B377S0Ha141MwTwJopR2ldQs6V0gFQY4SAhnFhAOIrkD/wBhWZtY933U
 FSvgt1rF6Sc8EGxHm+uWQMxHW0YtozyLFvt+n3rGZRpsm03CB4DMsls0JPgRPBFDMrp0wduuy
 7/EymfidBDpb/+KVe7NAyOgn2Ke/7MIoCbyyUrWET9715bHUf4hf8QLxZzUGNIb9gWBeSVabK
 GP9rLr0bHZdNRr3jhG4taenGul6ek3VhVUEiMaibxkwiUqHJm5/b/ZPYK573sTGS5mORHGQuT
 9cbk0PAwqoXYV7XSbJh28iHHhY7BZjxPgZMxK4WuLy+oudhRHclFy++jzf2c9R+x0kLT3UcAQ
 fCKBd7Yz+fjeYQyA3UTG6Ums73hIT+wc219E1vAFnUGl25eLtRxP6srBaECXT0/duXZURhJGJ
 CnxE1FACsV2qXrH+iT7yty7wLATbJAlUcnxkS7suW1UeUh6KLUkC2ly5ipZAFwV62W1GDx93W
 x+EpuA6GAXW6eG0NSrZ66qJpXyT1DOcXKg4WiQ8h58blbHR9OkhCladTMzUS6mIPP8CuyQMJy
 hLOOCihY9cy1ryofQ1uvwXbq90khgP+FCZ2MLOTHrxSS63ykpq357Jwjl1imCX7EsxdX9S9Q1
 b342PvQ5kw2MxLiJToDj42n5A/TomIBBIvKzabhNvWZ0RCZ7RJ1mGx6I/eZnkNV3jN0bS0MNs
 8IgBatJoY7+rZkdRZ/rOB54Uv+fwbfg/d5M7GQrJd7dAeU7PFXrYTE3GFWZm/zzAqCOFO5Sqg
 7Xl0MyVpFfqaN24Nr2y3n+5Dt4D2bYxA7IM
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds <torvalds@linux-foundation.org>:
> On Fri, Aug 27, 2021 at 5:19 AM Helge Deller <deller@gmx.de> wrote:
> >
> > Oh, the parisc strncpy() asm does NOT zero-fill the target address !!
> > That's the bug.
> > I thought strncpy would just copy up to given number of chars.
>
> Yeah, strncpy() is a horrible horrible function.
>
> It doesn't copy any NUL character at all if the source length was
> longer than the 'n', so it doesn't necessarily result in a
> NUL-terminated string.
>
> And it fills the target with NUL characters at the end, which is
> usually horribly inefficient and means that you should never ever use
> it with big destination buffers. So it can be a surprisingly bad
> function to use for the - not all that unusual situation - where you
> have lots of space in the destination buffer, and use the 'n' version
> of strcpy() just to be safe for odd situations. It will zero-fill all
> that space, usually for no good reason.
>
> Very different from the other 'n' functions like snprintf() and
> friends that people use for that same "destination buffer safety"
> reason.
>
> So it's almost never the right thing to use, even if it's the most
> traditional, most common and - by name - most obvious "copy string of
> at most length 'n'" function.
>
> It so happens that "comm[]" is probably one of *very* few situations
> in the kernel where we really do want to use strncpy(), and where we
> don't just NUL-terminate, but NUL-fill the buffer.
>
> Of course, that "comm[]" behavior is unusual these days, but I think
> it was a lot more usual back in the early 70's, when that whole
> "small, fixed-size string buffer" model was much much more common than
> it is today.
>
> It is, after all, the exact same reason why the C language linker
> rules for identifiers were historically "only the first 7 letters are
> necessarily significant". Because "use a fixed 8-byte buffer for a
> string" made sense at the time in ways it doesn't necessarily make all
> that much sense today.
>
> So that odd and nasty behavior of strncpy() makes a lot more sense in
> the historical context - it's just that that context is 50 years ago.
>
> While mentioning all the oddities of 'strncpy()', it's also worth
> noting that despite the similarities in the name,
> "strncpy_from_user()" does *not* fill the end of the destination
> buffer with NUL characters, and does *not* act like strncpy(). The
> user string copy function obviously also has a very very different
> return value, which hopefully makes it more obvious that it's a very
> different beast.
>
> Most of the time, if you actually want to copy a string, and have a
> limited destination buffer, you should use 'strscpy()'. Of the
> "limited size string" routines, it's pretty much the only sane one,
> and it guarantees - as long as the target size is non-zero - that the
> target is NUL-terminated without doing the NUL filling.
>
> (The BSD 'strlcpy()' is horribly broken because the return value
> semantics means that it will have to find the terminating NUL of the
> *source* string, even if the source string is horribly long, or
> untrusted and unterminated).

Thanks for the explanations!


> > Interestingly the kernel runs quite well and we don't see any bigger b=
reakage.
>
> Yeah, almost nothing actually cares about the odd NUL filling that -
> as you - few people realize is even part of strncpy().
>
> > Anyway, the function needs fixing.
>
> I'd suggest you just use the default one in lib/string.c and not
> override it with __HAVE_ARCH_STRNCPY.

Yes, that's probably the best idea.

Would you be willing to apply the attached patch for v5.14 ?

It reverts the original commit in which I introduced the
assembly str*() functions and adjusts the SPDX header tag.
It has been in my for-next tree since yesterday.

Thanks,
Helge

=2D-

From: Helge Deller <deller@gmx.de>
Date: Fri, 27 Aug 2021 20:42:57 +0200
Subject: [PATCH] Revert "parisc: Add assembly implementations for memset,
 strlen, strcpy, strncpy and strcat"

This reverts commit 83af58f8068ea3f7b3c537c37a30887bfa585069.

It turns out that at least the assembly implementation for strncpy() was
buggy.  Revert the whole commit and return back to the default coding.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org> # v5.4+

diff --git a/arch/parisc/include/asm/string.h b/arch/parisc/include/asm/st=
ring.h
index 4a0c9dbd62fd..f6e1132f4e35 100644
=2D-- a/arch/parisc/include/asm/string.h
+++ b/arch/parisc/include/asm/string.h
@@ -8,19 +8,4 @@ extern void * memset(void *, int, size_t);
 #define __HAVE_ARCH_MEMCPY
 void * memcpy(void * dest,const void *src,size_t count);

-#define __HAVE_ARCH_STRLEN
-extern size_t strlen(const char *s);
-
-#define __HAVE_ARCH_STRCPY
-extern char *strcpy(char *dest, const char *src);
-
-#define __HAVE_ARCH_STRNCPY
-extern char *strncpy(char *dest, const char *src, size_t count);
-
-#define __HAVE_ARCH_STRCAT
-extern char *strcat(char *dest, const char *src);
-
-#define __HAVE_ARCH_MEMSET
-extern void *memset(void *, int, size_t);
-
 #endif
diff --git a/arch/parisc/kernel/parisc_ksyms.c b/arch/parisc/kernel/parisc=
_ksyms.c
index 8ed409ecec93..e8a6a751dfd8 100644
=2D-- a/arch/parisc/kernel/parisc_ksyms.c
+++ b/arch/parisc/kernel/parisc_ksyms.c
@@ -17,10 +17,6 @@

 #include <linux/string.h>
 EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(strcpy);
-EXPORT_SYMBOL(strncpy);
-EXPORT_SYMBOL(strcat);

 #include <linux/atomic.h>
 EXPORT_SYMBOL(__xchg8);
diff --git a/arch/parisc/lib/Makefile b/arch/parisc/lib/Makefile
index 2d7a9974dbae..7b197667faf6 100644
=2D-- a/arch/parisc/lib/Makefile
+++ b/arch/parisc/lib/Makefile
@@ -3,7 +3,7 @@
 # Makefile for parisc-specific library files
 #

-lib-y	:=3D lusercopy.o bitops.o checksum.o io.o memcpy.o \
-	   ucmpdi2.o delay.o string.o
+lib-y	:=3D lusercopy.o bitops.o checksum.o io.o memset.o memcpy.o \
+	   ucmpdi2.o delay.o

 obj-y	:=3D iomap.o
diff --git a/arch/parisc/lib/memset.c b/arch/parisc/lib/memset.c
new file mode 100644
index 000000000000..133e4809859a
=2D-- /dev/null
+++ b/arch/parisc/lib/memset.c
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include <linux/types.h>
+#include <asm/string.h>
+
+#define OPSIZ (BITS_PER_LONG/8)
+typedef unsigned long op_t;
+
+void *
+memset (void *dstpp, int sc, size_t len)
+{
+  unsigned int c =3D sc;
+  long int dstp =3D (long int) dstpp;
+
+  if (len >=3D 8)
+    {
+      size_t xlen;
+      op_t cccc;
+
+      cccc =3D (unsigned char) c;
+      cccc |=3D cccc << 8;
+      cccc |=3D cccc << 16;
+      if (OPSIZ > 4)
+	/* Do the shift in two steps to avoid warning if long has 32 bits.  */
+	cccc |=3D (cccc << 16) << 16;
+
+      /* There are at least some bytes to set.
+	 No need to test for LEN =3D=3D 0 in this alignment loop.  */
+      while (dstp % OPSIZ !=3D 0)
+	{
+	  ((unsigned char *) dstp)[0] =3D c;
+	  dstp +=3D 1;
+	  len -=3D 1;
+	}
+
+      /* Write 8 `op_t' per iteration until less than 8 `op_t' remain.  *=
/
+      xlen =3D len / (OPSIZ * 8);
+      while (xlen > 0)
+	{
+	  ((op_t *) dstp)[0] =3D cccc;
+	  ((op_t *) dstp)[1] =3D cccc;
+	  ((op_t *) dstp)[2] =3D cccc;
+	  ((op_t *) dstp)[3] =3D cccc;
+	  ((op_t *) dstp)[4] =3D cccc;
+	  ((op_t *) dstp)[5] =3D cccc;
+	  ((op_t *) dstp)[6] =3D cccc;
+	  ((op_t *) dstp)[7] =3D cccc;
+	  dstp +=3D 8 * OPSIZ;
+	  xlen -=3D 1;
+	}
+      len %=3D OPSIZ * 8;
+
+      /* Write 1 `op_t' per iteration until less than OPSIZ bytes remain.=
  */
+      xlen =3D len / OPSIZ;
+      while (xlen > 0)
+	{
+	  ((op_t *) dstp)[0] =3D cccc;
+	  dstp +=3D OPSIZ;
+	  xlen -=3D 1;
+	}
+      len %=3D OPSIZ;
+    }
+
+  /* Write the last few bytes.  */
+  while (len > 0)
+    {
+      ((unsigned char *) dstp)[0] =3D c;
+      dstp +=3D 1;
+      len -=3D 1;
+    }
+
+  return dstpp;
+}
diff --git a/arch/parisc/lib/string.S b/arch/parisc/lib/string.S
deleted file mode 100644
index 4a64264427a6..000000000000
=2D-- a/arch/parisc/lib/string.S
+++ /dev/null
@@ -1,136 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *    PA-RISC assembly string functions
- *
- *    Copyright (C) 2019 Helge Deller <deller@gmx.de>
- */
-
-#include <asm/assembly.h>
-#include <linux/linkage.h>
-
-	.section .text.hot
-	.level PA_ASM_LEVEL
-
-	t0 =3D r20
-	t1 =3D r21
-	t2 =3D r22
-
-ENTRY_CFI(strlen, frame=3D0,no_calls)
-	or,COND(<>) arg0,r0,ret0
-	b,l,n	.Lstrlen_null_ptr,r0
-	depwi	0,31,2,ret0
-	cmpb,COND(<>) arg0,ret0,.Lstrlen_not_aligned
-	ldw,ma	4(ret0),t0
-	cmpib,tr 0,r0,.Lstrlen_loop
-	uxor,nbz r0,t0,r0
-.Lstrlen_not_aligned:
-	uaddcm	arg0,ret0,t1
-	shladd	t1,3,r0,t1
-	mtsar	t1
-	depwi	-1,%sar,32,t0
-	uxor,nbz r0,t0,r0
-.Lstrlen_loop:
-	b,l,n	.Lstrlen_end_loop,r0
-	ldw,ma	4(ret0),t0
-	cmpib,tr 0,r0,.Lstrlen_loop
-	uxor,nbz r0,t0,r0
-.Lstrlen_end_loop:
-	extrw,u,<> t0,7,8,r0
-	addib,tr,n -3,ret0,.Lstrlen_out
-	extrw,u,<> t0,15,8,r0
-	addib,tr,n -2,ret0,.Lstrlen_out
-	extrw,u,<> t0,23,8,r0
-	addi	-1,ret0,ret0
-.Lstrlen_out:
-	bv r0(rp)
-	uaddcm ret0,arg0,ret0
-.Lstrlen_null_ptr:
-	bv,n r0(rp)
-ENDPROC_CFI(strlen)
-
-
-ENTRY_CFI(strcpy, frame=3D0,no_calls)
-	ldb	0(arg1),t0
-	stb	t0,0(arg0)
-	ldo	0(arg0),ret0
-	ldo	1(arg1),t1
-	cmpb,=3D	r0,t0,2f
-	ldo	1(arg0),t2
-1:	ldb	0(t1),arg1
-	stb	arg1,0(t2)
-	ldo	1(t1),t1
-	cmpb,<> r0,arg1,1b
-	ldo	1(t2),t2
-2:	bv,n	r0(rp)
-ENDPROC_CFI(strcpy)
-
-
-ENTRY_CFI(strncpy, frame=3D0,no_calls)
-	ldb	0(arg1),t0
-	stb	t0,0(arg0)
-	ldo	1(arg1),t1
-	ldo	0(arg0),ret0
-	cmpb,=3D	r0,t0,2f
-	ldo	1(arg0),arg1
-1:	ldo	-1(arg2),arg2
-	cmpb,COND(=3D),n r0,arg2,2f
-	ldb	0(t1),arg0
-	stb	arg0,0(arg1)
-	ldo	1(t1),t1
-	cmpb,<> r0,arg0,1b
-	ldo	1(arg1),arg1
-2:	bv,n	r0(rp)
-ENDPROC_CFI(strncpy)
-
-
-ENTRY_CFI(strcat, frame=3D0,no_calls)
-	ldb	0(arg0),t0
-	cmpb,=3D	t0,r0,2f
-	ldo	0(arg0),ret0
-	ldo	1(arg0),arg0
-1:	ldb	0(arg0),t1
-	cmpb,<>,n r0,t1,1b
-	ldo	1(arg0),arg0
-2:	ldb	0(arg1),t2
-	stb	t2,0(arg0)
-	ldo	1(arg0),arg0
-	ldb	0(arg1),t0
-	cmpb,<>	r0,t0,2b
-	ldo	1(arg1),arg1
-	bv,n	r0(rp)
-ENDPROC_CFI(strcat)
-
-
-ENTRY_CFI(memset, frame=3D0,no_calls)
-	copy	arg0,ret0
-	cmpb,COND(=3D) r0,arg0,4f
-	copy	arg0,t2
-	cmpb,COND(=3D) r0,arg2,4f
-	ldo	-1(arg2),arg3
-	subi	-1,arg3,t0
-	subi	0,t0,t1
-	cmpiclr,COND(>=3D) 0,t1,arg2
-	ldo	-1(t1),arg2
-	extru arg2,31,2,arg0
-2:	stb	arg1,0(t2)
-	ldo	1(t2),t2
-	addib,>=3D -1,arg0,2b
-	ldo	-1(arg3),arg3
-	cmpiclr,COND(<=3D) 4,arg2,r0
-	b,l,n	4f,r0
-#ifdef CONFIG_64BIT
-	depd,*	r0,63,2,arg2
-#else
-	depw	r0,31,2,arg2
-#endif
-	ldo	1(t2),t2
-3:	stb	arg1,-1(t2)
-	stb	arg1,0(t2)
-	stb	arg1,1(t2)
-	stb	arg1,2(t2)
-	addib,COND(>) -4,arg2,3b
-	ldo	4(t2),t2
-4:	bv,n	r0(rp)
-ENDPROC_CFI(memset)
-
-	.end
