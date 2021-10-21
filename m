Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F18435ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 08:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhJUGWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 02:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhJUGWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:22:15 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29C7C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 23:19:59 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 145so752073ljj.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 23:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ySym1S+xM/vLmh5qD50mQk6IKKZnZMjSymPhRc8AKZU=;
        b=RmpuE9YS+Yq15CaE68H5r+Sd49/j2Y+lxFABfuvmGEPn3ZGXwaksFMZ6o9eFdJsChj
         2v/LHZpNjfudJ17zylPn7o2Z2Ux2I7bti/PND6qtRtfb26+3JS7yO0q+vWSx2CFJkuCa
         shobHsKKJNX/KQtyV6tpC+BY6SKms+67JaxlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ySym1S+xM/vLmh5qD50mQk6IKKZnZMjSymPhRc8AKZU=;
        b=FM7Jxt3RB2r5Wf5VJ/EU14vCC5Ws9f9FKfou1iwYrLzkOLR9Yg/JWAwkxhSzQwTdDl
         nku3pLdDvmlBMPXC1dBZB0A0r9qOMtIo51V9o7Ufv78P4O4wXmBPgquR8loRBL3Hxhr/
         xcAOc8UFK7TmzJZstAKo19lsU+L9Fm4Buz5LkxRP6xYvpuPTossBmVSnCJP/1ZU1LvpY
         R96Zl5BdAdlctSNI6FrCOeL0ZxIDgf6hdWaZbb6Z+7jGlrMQXFfO25GFFN9+mx2DyDYB
         3PM2VUo9p8AuyVC5QweJcPIVc7JcEhSKU8km71gupEIVXhu4vZ9VAiZRWh09qH1H7k9a
         dQMA==
X-Gm-Message-State: AOAM533LG/f40JTN3d8Hv08Sppwo6uS+BPb2QrMD21Qbb1nEwO6IJnBG
        S4cS78Sm74971/mqsVsILAcdtMbvg/CFxsJ0Yw8=
X-Google-Smtp-Source: ABdhPJwjE5Lx55sgOGZIxVuTkVxFPVVXRVFPgq+ZS6IvUl9zsG+kbiYQIwKFAU89c1Z+NpwwK/iKGw==
X-Received: by 2002:a2e:a277:: with SMTP id k23mr3787939ljm.22.1634797197818;
        Wed, 20 Oct 2021 23:19:57 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id b10sm447746ljo.14.2021.10.20.23.19.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 23:19:57 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id t9so1742564lfd.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 23:19:56 -0700 (PDT)
X-Received: by 2002:a19:ad0c:: with SMTP id t12mr3576075lfc.173.1634797196615;
 Wed, 20 Oct 2021 23:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211019134204.3382645-1-agruenba@redhat.com> <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
 <YXBFqD9WVuU8awIv@arm.com> <CAHk-=wgv=KPZBJGnx_O5-7hhST8CL9BN4wJwtVuycjhv_1MmvQ@mail.gmail.com>
 <YXCbv5gdfEEtAYo8@arm.com>
In-Reply-To: <YXCbv5gdfEEtAYo8@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Oct 2021 20:19:40 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgP058PNY8eoWW=5uRMox-PuesDMrLsrCWPS+xXhzbQxQ@mail.gmail.com>
Message-ID: <CAHk-=wgP058PNY8eoWW=5uRMox-PuesDMrLsrCWPS+xXhzbQxQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/17] gfs2: Fix mmap + page fault deadlocks
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 12:44 PM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> However, with MTE doing both get_user() every 16 bytes and
> gup can get pretty expensive.

So I really think that anything that is performance-critical had
better only do the "fault_in_write()" code path in the cold error path
where you took a page fault.

IOW, the loop structure should be


     repeat:
                take_locks();
                pagefault_disable();
                ret = do_things_with_locks();
                pagefault_enable();
                release_locks();

                // Failure path?
                if (unlikely(ret == -EFAULT)) {
                        if (fault_in_writable(..))
                                goto repeat;
                        return -EFAULT;
                }

rather than have it be some kind of "first do fault_in_writable(),
then do the work" model.

So I wouldn't worry too much about the performance concerns. It simply
shouldn't be a common or hot path.

And yes, I've seen code that does that "fault_in_xyz()" before the
critical operation that cannot take page faults, and does it
unconditionally.

But then it isn't the "fault_in_xyz()" that should be blamed if it is
slow, but the caller that does things the wrong way around.

            Linus
