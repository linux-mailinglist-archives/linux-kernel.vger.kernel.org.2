Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0E1419207
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 12:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhI0KNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 06:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbhI0KNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 06:13:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3174C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 03:11:23 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id bb10so11442121plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 03:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XNQWM8vHtyvzzujjIn2e0jTxEShB8PjsFdGS9LUBmPI=;
        b=TjJPhKgqdaCdcrfvFnIKZiAAZwwGAKuSVhx3CczAUD6hFiA8zjoIUhDHIkye40/Oym
         PPRmVlIAFP3JD8QjBRWzkhkP8wPYFITH6Gfpbeed3AzPcNYx+qxkSRiaiblfQbqYnlVN
         LTnP3lP2lDV0sxbpgqd/vjIgmtDBkVzvLmN7Cm+eKfOKiXEIlbTrtE/6wIcRy1OVKW2U
         vse9pIYGBEDgbRjfkSK1hA2Xp00rBkk+UI7Fob00Wc5yKL2g3UKveCsm6PHPnXzSruRS
         GUdjZvX+bG4Jz5mB2B+yKsRngj8yVzRQAGJjGIdeG/H5WOgZtXmH8ObF4i5NTdI2P8Ua
         SliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XNQWM8vHtyvzzujjIn2e0jTxEShB8PjsFdGS9LUBmPI=;
        b=IBeE1Y9o67SUhHICN8q+mhcrMsApcB8r8CnruuuahVs8NkQs9oUe1UPugjfSoMIYen
         HOEyxDwhlvYPTsyGinJU6hDO+LQpKUaX/hg7ZhYZAKXzvbnwUr+6LOuDyqqJIFR9dNtg
         0sawgl+VO3qc9V5LlojWXSV3QielQamga9avjkwgXTxpipU3vZDW7MDN5M9SB9ly4jER
         1J2LgUCNrH4JkFlH2lzhkVwrCBQ+MiWunWSupkTAsz6/ZLJdT126dROujvJxp0FcXpxk
         eKdbaCHYE1FQdjJ7Oc3wPUICAYjCZ3BJruC+uWMWz5iBJg+v6xCsd6qIZ/OrWxX6Gh6/
         qSRA==
X-Gm-Message-State: AOAM5321FE9A5bVz63ud2etqCr9P5XPsV2PsFbtIzlysClkwFM4Q/hRz
        VEtK9+qAOO/POXC/Wq18ylo=
X-Google-Smtp-Source: ABdhPJy4jklaP6MvZd9i3vVF/X/TOTlo7d2xrM3/h/uVG8+J2TQb8Ncp/5HZ02HjnnhyR6p7FytfoA==
X-Received: by 2002:a17:90a:3b09:: with SMTP id d9mr17056586pjc.128.1632737483118;
        Mon, 27 Sep 2021 03:11:23 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id c18sm17670890pge.69.2021.09.27.03.11.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Sep 2021 03:11:22 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH 1/8] mm/madvise: propagate vma->vm_end changes
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20210927090852.sc5u65ufwvfx57rl@box.shutemov.name>
Date:   Mon, 27 Sep 2021 03:11:20 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A923D77C-8C45-41B0-A1B2-55F68168D058@gmail.com>
References: <20210926161259.238054-1-namit@vmware.com>
 <20210926161259.238054-2-namit@vmware.com>
 <20210927090852.sc5u65ufwvfx57rl@box.shutemov.name>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 27, 2021, at 2:08 AM, Kirill A. Shutemov <kirill@shutemov.name> =
wrote:
>=20
> On Sun, Sep 26, 2021 at 09:12:52AM -0700, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> The comment in madvise_dontneed_free() says that vma splits that =
occur
>> while the mmap-lock is dropped, during userfaultfd_remove(), should =
be
>> handled correctly, but nothing in the code indicates that it is so: =
prev
>> is invalidated, and do_madvise() will therefore continue to update =
VMAs
>> from the "obsolete" end (i.e., the one before the split).
>>=20
>> Propagate the changes to end from madvise_dontneed_free() back to
>> do_madvise() and continue the updates from the new end accordingly.
>=20
> Could you describe in details a race that would lead to wrong =
behaviour?

Thanks for the quick response.

For instance, madvise(MADV_DONTNEED) can race with mprotect() and cause
the VMA to split.

Something like:

  CPU0				CPU1
  ----				----
  madvise(0x10000, 0x2000, MADV_DONTNEED)
  -> userfaultfd_remove()
   [ mmap-lock dropped ]
				mprotect(0x11000, 0x1000, PROT_READ)
				[splitting the VMA]

				read(uffd)
				[unblocking userfaultfd_remove()]

   [ resuming ]
   end =3D vma->vm_end
   [end =3D=3D 0x11000]

   madvise_dontneed_single_vma(vma, 0x10000, 0x11000)

  Following this operation, 0x11000-0x12000 would not be zapped.


> If mmap lock was dropped any change to VMA layout can appear. We can =
have
> totally unrelated VMA there.

Yes, but we are not talking about completely unrelated VMAs. If
userspace registered a region to be monitored using userfaultfd,
it expects this region to be handled as any other region. This is
a change of behavior that only affects regions with uffd.

The comment in the code explicitly says that this scenario should be
handled:

                        /*
                         * Don't fail if end > vma->vm_end. If the old
                         * vma was split while the mmap_lock was
                         * released the effect of the concurrent
                         * operation may not cause madvise() to
                         * have an undefined result. There may be an
                         * adjacent next vma that we'll walk
                         * next. userfaultfd_remove() will generate an
                         * UFFD_EVENT_REMOVE repetition on the
                         * end-vma->vm_end range, but the manager can
                         * handle a repetition fine.
                         */

Unless I am missing something, this does not happen in the current
code.

>=20
> Either way, if userspace change VMA layout for a region that is under
> madvise(MADV_DONTNEED) it is totally broken. I don't see a valid =
reason to
> do this.
>=20
> The current behaviour looks reasonable to me. Yes, we can miss VMAs, =
but
> these VMAs can also be created just after madvise() is finished.

Again, we are not talking about newly created VMAs.

Alternatively, this comment should be removed and perhaps the
documentation should be updated.

