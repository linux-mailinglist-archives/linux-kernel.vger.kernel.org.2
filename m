Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EA4394CF9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 17:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhE2PqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 11:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhE2Pp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 11:45:58 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BA6C061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 08:44:20 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id r5so9872763lfr.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 08:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Px0k6uGG2CnOum+p/ZWgGxzncHuTfKCARvtckW6PHDs=;
        b=hYJ5sA/+8PZo8Zuy8hAFVJE7Dugd0xm/7egwKn8DEQsakaaek0tGdIJ+irzSataFeA
         TVuOaz1OeyI1ughj61bKh9aQLN+ZpNpZdmrVcIh/Y9u9khLamSF8Jj2rYRAXKP+YUodN
         RbdvVhrO2rlWpvC9GSSIBZDfaT1cxxMKYNAz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Px0k6uGG2CnOum+p/ZWgGxzncHuTfKCARvtckW6PHDs=;
        b=QI8cwoXf8QzOqtScipAoMYMwDI+lmnvFtMlmLi5CbzCi/w7UYnoExMGDrWco7HVsQN
         hoOguRgVp1aJLu1XYwR4O1/3GbPponsv4VrpxzyMJjgcfa+VGYcBZ1IF74k+yzVeTlUJ
         zhROUQeeFBk22qFIbvRyRXiGx2ETm/02s/IC1la+yJiytJPiCWVgTbBhVHeRE8/m7cNh
         6tN8j59KnMdVg5685Cw658AjTZ2sn57pU5G+UiLAV3YNWo127yIyC5fsFpZubuKSf3Gb
         8E0tdCvlXrGgWTGhDSeWYKS0shD3GLDrEL9L9WbPgZC5Sc7KNWorVTlsN7zl0yh5f0oU
         8x0w==
X-Gm-Message-State: AOAM530apbRhoivE7XOkZGFmYqJXYUuW1rYQ5Tbg9IU12m4LyY6+5zFX
        kKkTW4COQS2DwoKfnARatQQVAXPNigPqBqRsF/c=
X-Google-Smtp-Source: ABdhPJxk4A56gQUduK77/CxLevIfvVfbUKKJuInovyyeewpfFL/6LKoOW5kywMUMWMtFg5JKNbCAWA==
X-Received: by 2002:ac2:4e91:: with SMTP id o17mr9419323lfr.417.1622303058324;
        Sat, 29 May 2021 08:44:18 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id n13sm768507lfi.14.2021.05.29.08.44.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 May 2021 08:44:17 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id q1so9881912lfo.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 08:44:17 -0700 (PDT)
X-Received: by 2002:a05:6512:36c5:: with SMTP id e5mr9308841lfs.41.1622303056980;
 Sat, 29 May 2021 08:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KHbXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=@emersion.fr>
 <CAHk-=wgmGv2EGscKSi8SrQWtEVpEQyk-ZN1Xj4EoAB87Dmx1gA@mail.gmail.com>
 <20210429154807.hptls4vnmq2svuea@box> <20210429183836.GF8339@xz-x1>
 <lpi4uT69AFMwtmWtwW_qJAmYm_r0jRikL11G_zI4X7wq--6Jtpiej8kGn8gePfv0Dtn4VmzsOqT2Q5-L3ca2niDi0nlC0nVYphbFBnNJnw0=@emersion.fr>
 <CAHk-=wiAs7Ky9gmWAeqk5t7Nkueip13XPGtUcmMiZjwf-sX3sQ@mail.gmail.com>
 <hnL7s1u925fpeUhs90fXUpD3GG_4gmHlpznN8E0885tSM40QYb3VVTFGkwpmxYQ3U8HkRSUtfqw0ZfBKptA4pIw4FZw1MdRhSHC94iQATEE=@emersion.fr>
 <CAHk-=wiY1BL-UHPMEAbd7nY3vu6w41A1hhvjg1DoBXWuRt9_qw@mail.gmail.com>
 <7718ec5b-0a9e-ffa6-16f2-bc0b6afbd9ab@gmail.com> <CAHk-=wjv3-eP7mSDJbuvaB+CbyyKc4g_nEzhQLcueOd0_YuiBg@mail.gmail.com>
 <80c87e6b-6050-bf23-2185-ded408df4d0f@gmail.com>
In-Reply-To: <80c87e6b-6050-bf23-2185-ded408df4d0f@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 29 May 2021 05:44:01 -1000
X-Gmail-Original-Message-ID: <CAHk-=whSGS=R8PtrfNcDTkCKOengEqygqeWjOZa2b8QkuOueDg@mail.gmail.com>
Message-ID: <CAHk-=whSGS=R8PtrfNcDTkCKOengEqygqeWjOZa2b8QkuOueDg@mail.gmail.com>
Subject: Re: Sealed memfd & no-fault mmap
To:     "Lin, Ming" <minggr@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>, Simon Ser <contact@emersion.fr>,
        Peter Xu <peterx@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <greg@kroah.com>,
        "tytso@mit.edu" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 9:31 PM Lin, Ming <minggr@gmail.com> wrote:
>
> I should check the vma is not writable.
>
> -               if (!IS_NOFAULT(inode))
> +               if (!IS_NOFAULT(inode) || (vma->vm_flags & VM_WRITE))
>                          return -EINVAL;

That might be enough, yes.

But if this is sufficient for the compositor needs, and the rule is
that this only works for read-only mappings, then I think the flag in
the inode becomes the wrong thing to do.

Because if it's a read-only mapping, and we only ever care about
inserting zero pages into the page tables - and they never become part
of the shared memory region itself, then it really is purely about
that mmap, not about the shm inode.

So then it really does become purely about one particular mmap, and it
really should be a "madvise()" issue, not a "mark inode as no-fault".

I'd almost be inclined to just add a new "flags" field to the vma.
We've been running out of vma flags for a long time, to the point that
some of them are only available on 64-bit architectures.

I get the feeling that we should just bite the bullet and make
"vm_flags" be an u64. Or possibly make it two explicitly 32-bit
entities (vm_flags and vm_extra). Get rid of the silly 64-bit-only
"high" flags, and get rid of our artificial "we don't have enough
bits".

Because we already in practice *do* have enough bits, we've just
artificially limited ourselves to "on 32-bit architectures we only
have 32 bits in that field".

But all of this is very much dependent on that "this NOFAULT case
really only works for reads, not for writes".

(Alternatively, we could allow the *mapping* itself to be writable,
but always fault on writes, and only insert a read-only zero page)

              Linus
