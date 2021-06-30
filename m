Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF7A3B7E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 09:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbhF3Hoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 03:44:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232573AbhF3Hoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 03:44:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEF7261D12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 07:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625038945;
        bh=cjfMqlvm/KvJKzCzyRAA/75kkZfk7xbN6T0wJUzy51s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E5KRwN9STfJH5A6sSNQaFzPPlLC+HLEg0lJjVpB28QkbVTAXLoLB9lQ+Rh4aZ6OdX
         UZaVIFJ68amAxadPjraVw/StwsgUtqMZUsbGbt8+NB5EArQXbcAriAn4FE5BvXSbK+
         L30wGnLk0e23RNZpPSWq8T88Vh9Ywb+5Am67eHUCfy8GoiiCv48F+6YgsGZOqP1kF/
         XZeWmaQ8cTf8jfmVLsVIFH+Ucd7x9eKGaEr+jiQAtv6pXgWqmZGrbCaEnDzp8uGcuC
         nWTO3RKQVfkRUPqIfoNV0kzdex4e1svZg2lOZpSNWmo4fK21amPmpNMwA6xOlho/c7
         vOrL+reeIvoqA==
Received: by mail-oo1-f53.google.com with SMTP id v3-20020a4ac9030000b029024c9d0bff49so419238ooq.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 00:42:25 -0700 (PDT)
X-Gm-Message-State: AOAM530A+N5jkJZacCJGJmH7jgITe8Abcae2s0zEH6CwtV99cWEPshaq
        8TA74kgVHLn2Wqa9XjAikpqihArrWjG5T/Y7Gz8=
X-Google-Smtp-Source: ABdhPJzjRGSA4n9r5WRvyYFEDgD4rP0aZ4f5diqdxVPRn9C96ekwd0qF/Nym5fonEDj2BXtfJLrV9VYxeht1T2TKOtA=
X-Received: by 2002:a4a:2f87:: with SMTP id p129mr7413740oop.41.1625038944910;
 Wed, 30 Jun 2021 00:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f3e94a05c5d8686f@google.com> <b7f0725f-2731-24af-f15d-1054d6398749@intel.com>
In-Reply-To: <b7f0725f-2731-24af-f15d-1054d6398749@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 30 Jun 2021 09:42:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGTV+U-oy=wyHf2KmuzjmaaPJaLBY4mx09tWjL6gCC=rQ@mail.gmail.com>
Message-ID: <CAMj1kXGTV+U-oy=wyHf2KmuzjmaaPJaLBY4mx09tWjL6gCC=rQ@mail.gmail.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in __fdget_pos
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     syzbot <syzbot+5d1bad8042a8f0e8117a@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, jpa@git.mail.kapsi.fi,
        kan.liang@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2021 at 16:46, Dave Hansen <dave.hansen@intel.com> wrote:
>
> ... adding Ard who was recently modifying some of the
> kernel_fpu_begin/end() sites in the AESNI crypto code.
>
> On 6/28/21 12:22 PM, syzbot wrote:
> > console output: https://syzkaller.appspot.com/x/log.txt?x=170e6c94300000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=42ecca11b759d96c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=5d1bad8042a8f0e8117a
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> ...
> > BUG: sleeping function called from invalid context at kernel/locking/mutex.c:938
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 29652, name: syz-executor.0
> > no locks held by syz-executor.0/29652.
> > Preemption disabled at:
> > [<ffffffff812aa454>] kernel_fpu_begin_mask+0x64/0x260 arch/x86/kernel/fpu/core.c:126
> > CPU: 0 PID: 29652 Comm: syz-executor.0 Not tainted 5.13.0-rc7-syzkaller #0
>
> There's a better backtrace in the log before the rather useless
> backtrace from lockdep:
>
> > [ 1341.360547][T29635] FAULT_INJECTION: forcing a failure.
> > [ 1341.360547][T29635] name failslab, interval 1, probability 0, space 0, times 0
> > [ 1341.374439][T29635] CPU: 1 PID: 29635 Comm: syz-executor.0 Not tainted 5.13.0-rc7-syzkaller #0
> > [ 1341.374712][T29630] FAT-fs (loop2): bogus number of reserved sectors
> > [ 1341.383571][T29635] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > [ 1341.383591][T29635] Call Trace:
> > [ 1341.383603][T29635]  dump_stack+0x141/0x1d7
> > [ 1341.383630][T29635]  should_fail.cold+0x5/0xa
> > [ 1341.383651][T29635]  ? skcipher_walk_next+0x6e2/0x1680
> > [ 1341.383673][T29635]  should_failslab+0x5/0x10
> > [ 1341.383691][T29635]  __kmalloc+0x72/0x330
> > [ 1341.383720][T29635]  skcipher_walk_next+0x6e2/0x1680
> > [ 1341.383744][T29635]  ? kfree+0xe5/0x7f0
> > [ 1341.383776][T29635]  skcipher_walk_first+0xf8/0x3c0
> > [ 1341.383805][T29635]  skcipher_walk_virt+0x523/0x760
> > [ 1341.445438][T29635]  xts_crypt+0x137/0x7f0
> > [ 1341.449689][T29635]  ? aesni_encrypt+0x80/0x80
>
> There's one suspect-looking site in xts_crypt():
>
> >       kernel_fpu_begin();
> >
> >       /* calculate first value of T */
> >       aesni_enc(aes_ctx(ctx->raw_tweak_ctx), walk.iv, walk.iv);
> >
> >       while (walk.nbytes > 0) {
> >               int nbytes = walk.nbytes;
> >
> >               ...
> >
> >               err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
> >
> >               kernel_fpu_end();
> >
> >               if (walk.nbytes > 0)
> >                       kernel_fpu_begin();
> >       }
>
> I wonder if a slab allocation failure could leave us with walk.nbytes==0.

The code is actually the other way around: kernel_fpu_end() comes
before the call to skcipher_walk_done().

So IIUC, this code forces an allocation failure, and checks whether
the code deals with this gracefully, right?

The skcipher walk API guarantees that walk.nbytes == 0 if an error is
returned, so the pairing of FPU begin/end looks correct to me. And
skcipher_walk_next() should not invoke anything that might sleep from
this particular context.

Herbert, any ideas?
