Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C0442AB63
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 19:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhJLSBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhJLSBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:01:08 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93CEC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 10:59:06 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u18so357937lfd.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fqSNsVOtXYPiifkp+lepAhAhHgqhsFkG1XDADIpg/Pc=;
        b=FY/BRNyYSoeaiJSrAAHQ3BrZLM0CaAv9w/dXHHjnPfLhtbC9gLNZ9O9rgLQDmfFZ9o
         8Mgo15NFVUl5gkJg7VmqhjBEsMkyCryU/OfNnkqXoLyp/rMiFDeur2O6jhe6h/s3zLwA
         o2kFQw8ViM/udeGTcQaOp6dV30r8PdS4IHCjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fqSNsVOtXYPiifkp+lepAhAhHgqhsFkG1XDADIpg/Pc=;
        b=A18A9zuNWCrrcmHOc+X5QqnWgUxT9c+8oTJ9p4IMbNdU1MrKsCEgYoGu6vQMiomj1a
         nll9pHGa/GzEnSdNkmeLWX161du6vPpv5i4kNwddTZHMp7VcaCZi8ibrtNNIX73GASOJ
         6PQkF52rBBbPrremleAmVlPGOMi2Xu4dao7YJrnAdJsBwrZPktOAcI32KVr0yugQoRWw
         gqIu39zH+jH9I5IUvaQy62PmMbfDPAvtjm9GrK7QYjJL703BcZJI+YVUHiqh839+Llep
         b0856U3mfelNb2axE+2TfLDOTIQqQxEnwfjNaQO0Lzx/hgyf+jU0blx+wOYi7mjhU7Jr
         NaNg==
X-Gm-Message-State: AOAM533+vEnxNZ/OUeiugPw3IZ7rvq7/FpM5CruzBt0yHXv89Txf8kbE
        whj6/wD9GNvnlqegSq1ix32jMzVyFiT/D/9Q
X-Google-Smtp-Source: ABdhPJzWr+h36RUqWGWMsBYRDpEyKRpIp1Yu46eU8YXW/f7c6aWn6XlquT6jru6pq1GNMNgXE59/Hw==
X-Received: by 2002:a2e:94cd:: with SMTP id r13mr30971436ljh.529.1634061544893;
        Tue, 12 Oct 2021 10:59:04 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id h10sm1186688ljb.60.2021.10.12.10.59.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 10:59:03 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id t9so582400lfd.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 10:59:02 -0700 (PDT)
X-Received: by 2002:a05:6512:10d0:: with SMTP id k16mr2835560lfg.150.1634061542163;
 Tue, 12 Oct 2021 10:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
 <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk> <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSqOUb7yZ7kBoKRY@zeniv-ca.linux.org.uk> <YS40qqmXL7CMFLGq@arm.com>
 <YS5KudP4DBwlbPEp@zeniv-ca.linux.org.uk> <YWR2cPKeDrc0uHTK@arm.com>
 <CAHk-=wjvQWj7mvdrgTedUW50c2fkdn6Hzxtsk-=ckkMrFoTXjQ@mail.gmail.com>
 <YWSnvq58jDsDuIik@arm.com> <CAHk-=wiNWOY5QW5ZJukt_9pHTWvrJhE2=DxPpEtFHAWdzOPDTg@mail.gmail.com>
 <YWXFagjRVdNanGSy@arm.com>
In-Reply-To: <YWXFagjRVdNanGSy@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Oct 2021 10:58:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg3prAnhWZetJvwZdugn7A7CpP4ruz1tdewha=8ZY8AJw@mail.gmail.com>
Message-ID: <CAHk-=wg3prAnhWZetJvwZdugn7A7CpP4ruz1tdewha=8ZY8AJw@mail.gmail.com>
Subject: Re: [RFC][arm64] possible infinite loop in btrfs search_ioctl()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 10:27 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> Apart from fault_in_pages_*(), there's also fault_in_user_writeable()
> called from the futex code which uses the GUP mechanism as the write
> would be destructive. It looks like it could potentially trigger the
> same infinite loop on -EFAULT.

Hmm.

I think the reason we do fault_in_user_writeable() using GUP is that

 (a) we can avoid the page fault overhead

 (b) we don't have any good "atomic_inc_user()" interface or similar
that could do a write with a zero increment or something like that.

We do have that "arch_futex_atomic_op_inuser()" thing, of course. It's
all kinds of crazy, but we *could* do

       arch_futex_atomic_op_inuser(FUTEX_OP_ADD, 0, &dummy, uaddr);

instead of doing the fault_in_user_writeable().

That might be a good idea anyway. I dunno.

But I agree other options exist:

> I wonder whether we should actually just disable tag checking around the
> problematic accesses. What these callers seem to have in common is using
> pagefault_disable/enable(). We could abuse this to disable tag checking
> or maybe in_atomic() when handling the exception to lazily disable such
> faults temporarily.

Hmm. That would work for MTE, but possibly be very inconvenient for
other situations.

> A more invasive change would be to return a different error for such
> faults like -EACCESS and treat them differently in the caller.

That's _really_ hard for things like "copy_to_user()", that isn't a
single operation, and is supposed to return the bytes left.

Adding another error return would be nasty.

We've had hacks like "squirrel away the actual error code in the task
structure", but that tends to be unmaintainable because we have
interrupts (and NMI's) doing their own possibly nested atomics, so
even disabling preemption won't actually fix some of the nesting
issues.

All of these things make me think that the proper fix ends up being to
make sure that our "fault_in_xyz()" functions simply should always
handle all faults.

Another option may be to teach the GUP code to actually check
architecture-specific sub-page ranges.

        Linus
