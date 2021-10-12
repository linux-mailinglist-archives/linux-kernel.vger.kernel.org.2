Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6918542AFEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 01:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbhJLXEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 19:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbhJLXE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 19:04:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5066C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 16:02:25 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so787102pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 16:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amikom.ac.id; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NKBbs/bTesD2WYOSqLA0rpb9W1UUowr+/nHC1DH4F5w=;
        b=FWLWUpvLeMVTrlItpohCiGQSTO613dil9KdbQBrRJEDNTgBGgp7az/5Rv5rpSMDLVa
         pHQ9tZf7d4PqgFEYStu+AbLqh+Zq9r6vGDw49vn3+II2n9ll4u481URrJ/cWmKb5LAaP
         oUunJFwSsy9bBWCmRnnV8CPXokfhlmk7LfMpQ5G25gSrsWj3XbugBYFYbFkMd1DjiffU
         RCjKzTFUu2GH9OfJZHwLDGqdXqVYvPINWRwV6dol73qB2MGgvq3w8CwiPk7Q13mHVOfr
         W93Zt+agfgTNTt0EXgCECF0Lb31yPvkarQaxr+trSLHMB4uasMg6BSJmX6xsdec66x1j
         vYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NKBbs/bTesD2WYOSqLA0rpb9W1UUowr+/nHC1DH4F5w=;
        b=KJMXFvYwW2wvffEZyv8J41OzKiyLs7jkpVt+nFZAgf5Q6urYWJ89Tfp4rcHNH7Tmvz
         Wsn8JprpEtGQVsXYco4BSECztIG5muIzEq75xXKQV73pSO+/qg+nV5DhVs1EYzN8Pchu
         TOSW5/1VVti3LFSHz96YMd+756wxTgaGAXuVNIdyEXK0H1U1+6kFMdWnTJAHTyBOaD/7
         NjfaynI3Gwm0sD76mqoamsQhwqCGacBfURjebZbN2sLsbQbLvIUVDy4GGzMfnT26PPQQ
         +08T40nwsQwSBmVnZu4Wb3b2uhSMaqFUAnIQZRMoZaHfznvZNnCabUZJjrQKTbRPHDZW
         4QUQ==
X-Gm-Message-State: AOAM533ixwbONJNBMU9vcl4c200kA9SVgz6B/r+Q6cU/7rAvJ4KFj4+y
        dT9pqfzNSitY+qoCOsCPYce5Kg==
X-Google-Smtp-Source: ABdhPJwgVYqFmwCKcLlJ99MvLvqN+j/wHZU+fUxiPGgYTeKgDpfPfPp2CXBwr+/iRYhtNEUUysR6ow==
X-Received: by 2002:a17:902:9a43:b0:13e:6386:d720 with SMTP id x3-20020a1709029a4300b0013e6386d720mr32322031plv.29.1634079745328;
        Tue, 12 Oct 2021 16:02:25 -0700 (PDT)
Received: from integral.. ([182.2.71.100])
        by smtp.gmail.com with ESMTPSA id z24sm12954678pgu.54.2021.10.12.16.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 16:02:24 -0700 (PDT)
From:   Ammar Faizi <ammar.faizi@students.amikom.ac.id>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Willy Tarreau <w@1wt.eu>, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Subject: RE: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the clobber list
Date:   Wed, 13 Oct 2021 06:02:04 +0700
Message-Id: <20211012230204.587193-1-ammar.faizi@students.amikom.ac.id>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <40f6f29f26f14b5b88076f5b12e1ecaa@AcuMS.aculab.com>
References: <40f6f29f26f14b5b88076f5b12e1ecaa@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 4:21 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Willy Tarreau
> > Sent: 12 October 2021 10:07
> >
> > On Tue, Oct 12, 2021 at 03:36:44PM +0700, Ammar Faizi wrote:
> > > I have tried to search for the documentation about this one, but I
> > > couldn't find any. Checking at `Documentation/x86/entry_64.rst`, but
> > > it doesn't tell anything relevant.
> > (...)
> >
> > OK thanks for the detailed story, thus I didn't miss any obvious
> > reference.
> >
> > > My stance comes from SO, Telegram group discussion, and reading source
> > > code. Therefore, I don't think I can attach the link to it as
> > > "authoritative information". Or can I?
> >
> > You're right, that's not exactly what we can call authoritative :-)
>
> Given the cost of a system call the code benefit from telling
> gcc that r8 to r10 are preserved is likely to be noise.
> Especially since most syscalls are made from C library stubs
> so the application calling code will assume they are trashed.
>
> There may even be a bigger gain from the syscall exit code just
> setting the registers to zero (instead of restoring them).

Setting those registers to zero on "syscall_return_via_sysret" would
need to edit entry_64.S and that apparently breaks the userspace and
results in an ABI change.

>
> There are probably even bigger gains from zeroing the AVX
> registers (which, IIRC, are all caller-saved) somewhere
> between syscall entry and the process sleeping.
> (This can't be done for non-syscall kernel entry.)
>

I copy and paste my message just to clarify the misunderstanding here. We
don't intend to change the ABI, so we can only strive for gaining more
profit to optimize what we can do based on the current situation.

I know for a fact that every "syscall" in the libc is wrapped with a
function call.

However, that is not the case for nolibc.h, because we have a potential
to inline the "syscall" instruction (0f 05) to the user functions.

All syscalls in the nolibc.h are written as a static function with inline
ASM and are likely always inline if we use optimization flag, so this is
a profit not to have r8, r9 and r10 in the clobber list (currently we 
have them).

FWIIW, I created an example where this matters.

```
#include "tools/include/nolibc/nolibc.h"

#define read_abc(a, b, c) __asm__ volatile(""::"r"(a),"r"(b),"r"(c))

int main(void)
{
    int a = 0xaa;
    int b = 0xbb;
    int c = 0xcc;

    read_abc(a, b, c);
    write(1, "test\n", 5);
    read_abc(a, b, c);

    return 0;
}
```

Compile with:
    gcc -Os test.c -o test -nostdlib


With r8, r9, r10 in the clobber list, results in this:

0000000000001000 <main>:
    1000:	f3 0f 1e fa          	endbr64 
    1004:	41 54                	push   %r12
    1006:	41 bc cc 00 00 00    	mov    $0xcc,%r12d
    100c:	55                   	push   %rbp
    100d:	bd bb 00 00 00       	mov    $0xbb,%ebp
    1012:	53                   	push   %rbx
    1013:	bb aa 00 00 00       	mov    $0xaa,%ebx
    1018:	b8 01 00 00 00       	mov    $0x1,%eax
    101d:	bf 01 00 00 00       	mov    $0x1,%edi
    1022:	ba 05 00 00 00       	mov    $0x5,%edx
    1027:	48 8d 35 d2 0f 00 00 	lea    0xfd2(%rip),%rsi
    102e:	0f 05                	syscall 
    1030:	31 c0                	xor    %eax,%eax
    1032:	5b                   	pop    %rbx
    1033:	5d                   	pop    %rbp
    1034:	41 5c                	pop    %r12
    1036:	c3                   	ret 

GCC thinks that syscall will clobber r8, r9, r10. So it spills 0xaa,
0xbb and 0xcc to callee saved registers (r12, rbp and rbx). This is 
clearly extra memory access and extra stack size for preserving them.

But syscall does not actually clobber them, so this is a missed
optimization.

Now without r8, r9, r10 in the clobber list, results in better ASM code:

0000000000001000 <main>:
    1000:   f3 0f 1e fa             endbr64 
    1004:   41 b8 aa 00 00 00       mov    $0xaa,%r8d
    100a:   41 b9 bb 00 00 00       mov    $0xbb,%r9d
    1010:   41 ba cc 00 00 00       mov    $0xcc,%r10d
    1016:   b8 01 00 00 00          mov    $0x1,%eax
    101b:   bf 01 00 00 00          mov    $0x1,%edi
    1020:   ba 05 00 00 00          mov    $0x5,%edx
    1025:   48 8d 35 d4 0f 00 00    lea    0xfd4(%rip),%rsi
    102c:   0f 05                   syscall 
    102e:   31 c0                   xor    %eax,%eax
    1030:   c3                      ret  

Does that make sense?

-- 
Ammar Faizi
