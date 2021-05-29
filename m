Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EADB3949C3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 03:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhE2BF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 21:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhE2BFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 21:05:55 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990A9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 18:04:18 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a4so7433746ljd.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 18:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7TLJbSas3WgGftLzXCIE9XnAPM6dN/gE8iir4vdPP+w=;
        b=cT4KvaZvwGtBiIbawe3+jc+1fkoXYslUfHrH0H1cWQVUQtZ8xjL4of9SedIBqdqfgE
         v5DjrX/q6IKN6mpuDaSMMJX0vLxRm068wOWlW92ubPAZ+GCoYUGjQnWb+haOFa5jGnsR
         +pBMWH3gJ6rquFqZoRFYr0mL6CA+Nn24/gQzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7TLJbSas3WgGftLzXCIE9XnAPM6dN/gE8iir4vdPP+w=;
        b=nbO0dpVLvz8B3suqOGCnho5bFLV7xSGLoLgcJpXNjMiKlUtjhw/T778k3jy8AI/zaL
         lAZ34MLwkN2YD843mL23o3XivGGEEH8wCxrEQtF5f03Et7irmLvdV/jZT3kNB1QZcZyl
         I3nM5JMwK8ykX1BySdLUgqWdQLcSWxSjGpf1YejpX12NN/PKokkBdNOzNGBVR/L2uGdl
         98PaYG8ToauacF0UcsQqIDtph6WhY7vZczuuD9TZqfdjdVZsnMLV0oRocnxDvYnehOMi
         dUIki+IGnXJ0tokPPqrGJ6pjmM/lPJNshVEZlNLtTgC5LdPg9hXIZltrSoPg3IkHSLdf
         OO0Q==
X-Gm-Message-State: AOAM53323pbkQSx9oqyGE0C4/BBmjo74EQ1Uf2Mmd6+lPEbe4qhqcLQq
        /sjazOqT4jUV8GYgUAABhCRmSYen3Rp0iFIH
X-Google-Smtp-Source: ABdhPJybJU0+TkoilmoBMdrZJpeSw6CtxKwb0CG0dAzU52Y3yi0bxtdgutMPYogDQt94teZvlcS7Ug==
X-Received: by 2002:a2e:7319:: with SMTP id o25mr192406ljc.38.1622250256551;
        Fri, 28 May 2021 18:04:16 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id n7sm683666ljj.109.2021.05.28.18.04.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 18:04:15 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id q7so7842777lfr.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 18:04:14 -0700 (PDT)
X-Received: by 2002:a05:6512:1095:: with SMTP id j21mr7376406lfg.40.1622250254392;
 Fri, 28 May 2021 18:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KHbXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=@emersion.fr>
 <CAHk-=wgmGv2EGscKSi8SrQWtEVpEQyk-ZN1Xj4EoAB87Dmx1gA@mail.gmail.com>
 <20210429154807.hptls4vnmq2svuea@box> <20210429183836.GF8339@xz-x1>
 <lpi4uT69AFMwtmWtwW_qJAmYm_r0jRikL11G_zI4X7wq--6Jtpiej8kGn8gePfv0Dtn4VmzsOqT2Q5-L3ca2niDi0nlC0nVYphbFBnNJnw0=@emersion.fr>
 <CAHk-=wiAs7Ky9gmWAeqk5t7Nkueip13XPGtUcmMiZjwf-sX3sQ@mail.gmail.com>
 <hnL7s1u925fpeUhs90fXUpD3GG_4gmHlpznN8E0885tSM40QYb3VVTFGkwpmxYQ3U8HkRSUtfqw0ZfBKptA4pIw4FZw1MdRhSHC94iQATEE=@emersion.fr>
 <CAHk-=wiY1BL-UHPMEAbd7nY3vu6w41A1hhvjg1DoBXWuRt9_qw@mail.gmail.com> <7718ec5b-0a9e-ffa6-16f2-bc0b6afbd9ab@gmail.com>
In-Reply-To: <7718ec5b-0a9e-ffa6-16f2-bc0b6afbd9ab@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 May 2021 15:03:58 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjv3-eP7mSDJbuvaB+CbyyKc4g_nEzhQLcueOd0_YuiBg@mail.gmail.com>
Message-ID: <CAHk-=wjv3-eP7mSDJbuvaB+CbyyKc4g_nEzhQLcueOd0_YuiBg@mail.gmail.com>
Subject: Re: Sealed memfd & no-fault mmap
To:     "Lin, Ming" <minggr@gmail.com>, Hugh Dickins <hughd@google.com>
Cc:     Simon Ser <contact@emersion.fr>, Peter Xu <peterx@redhat.com>,
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

On Fri, May 28, 2021 at 7:07 AM Lin, Ming <minggr@gmail.com> wrote:
>
> Does something like following draft patch on the right track?

No, I don't think this can work:

> +               _dst_pte = pte_mkspecial(pfn_pte(my_zero_pfn(dst_addr),
> +                                        vma->vm_page_prot));

You can't just blindly insert the zero pfn - for a shared write
mapping, that would actually allow writes to the zeropage. That would
be horrible.

So it would have to do all the same things that it does for a page
that is inside the inode size.

I do also dislike how it's a per-inode flag - so it would affect other
mappings of the same shared memory segment too. But considering that
the page would have to be part of the page cache for that shmem inode,
that may be inevitable. But it sure does smell a bit.

Oh, and if we make this kind of magic shmem extension, Hugh Dickins
should be part of the conversation  too. Hugh, you probably saw the
original on linux-mm, but I'm adding you explicitly to the
participants here.

.. and if you didn't see the background, here it is

  https://lore.kernel.org/linux-mm/vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KHbXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=@emersion.fr/

for your edification..

           Linus
