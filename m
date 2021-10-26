Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1774043B9F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 20:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbhJZSwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 14:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbhJZSwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 14:52:49 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBF1C061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 11:50:24 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 188so488114ljj.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 11:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r5Cx2RnmHPH+SxoKka0sJEz3NkssP3YCqbiSsqzadkQ=;
        b=XWmvXqx6E/lnwqgDlacsJYsSx9OK8zrlmcuZe075Kg2Q7afYrlM28LUphtMnNWBBss
         19rtrgtkK+y60H9M3H213OTzx4KlKQs5vTnOVoJ7FFgOi4799TI0MlAwQR64ujeGGpUF
         Ec975XRObLADp1do89z7xhEJGw/WNDenswDZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r5Cx2RnmHPH+SxoKka0sJEz3NkssP3YCqbiSsqzadkQ=;
        b=bB2z0g/4XTVAuXr4RxfumTzkUqOApoJkTQtA2AxRmD1tSn7cn9gkW1EMDk0rfOtHMv
         tw6+d4fO9wj1fVCYojT7BNH4BmiZiJdkeo56DkKsEKGM7e9/XCIB9eMWPXNxplIw8WUN
         MpxDBRjrDyn50u4Vj7SD79M7vNNcdYRgWaftsu8q/Fs3aA3ZxWZw2YvZXdRqaC8joBYC
         toKkHj6x0LNufEgC24IHlWIv9jJ5UE9Ocrj4EQLexj2xTcWvJZwHI5x8Dh594NO5/X9P
         xr1X16Be7IT/mWKxdynFxpeRkKUxiR+vwSeZ5KmrYxzIVHUYiFcBUT1aBvMBohMpR7vT
         CAxw==
X-Gm-Message-State: AOAM533XCscjoNymr0c5mi0iUe/jIkVfHIVkZQJnxewRtAfLRY01jd2r
        Y7cZqgYoiUZM9HI5/l26FkaWSNtednytatOE
X-Google-Smtp-Source: ABdhPJwZkvig/vbg2n2DFq4y0m2j/5yFbzUSOsTyAZNfV0dsJ0xvDrB4fi4l8toMzsMHj0+d2T8Rnw==
X-Received: by 2002:a05:651c:889:: with SMTP id d9mr28706877ljq.198.1635274222426;
        Tue, 26 Oct 2021 11:50:22 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id m6sm1057446lfu.82.2021.10.26.11.50.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 11:50:21 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id o11so427574ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 11:50:21 -0700 (PDT)
X-Received: by 2002:a2e:9e13:: with SMTP id e19mr4519488ljk.494.1635274221013;
 Tue, 26 Oct 2021 11:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211019134204.3382645-1-agruenba@redhat.com> <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
 <YXBFqD9WVuU8awIv@arm.com> <CAHk-=wgv=KPZBJGnx_O5-7hhST8CL9BN4wJwtVuycjhv_1MmvQ@mail.gmail.com>
 <YXCbv5gdfEEtAYo8@arm.com> <CAHk-=wgP058PNY8eoWW=5uRMox-PuesDMrLsrCWPS+xXhzbQxQ@mail.gmail.com>
 <YXL9tRher7QVmq6N@arm.com> <CAHk-=wg4t2t1AaBDyMfOVhCCOiLLjCB5TFVgZcV4Pr8X2qptJw@mail.gmail.com>
 <CAHc6FU7BEfBJCpm8wC3P+8GTBcXxzDWcp6wAcgzQtuaJLHrqZA@mail.gmail.com> <YXhH0sBSyTyz5Eh2@arm.com>
In-Reply-To: <YXhH0sBSyTyz5Eh2@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Oct 2021 11:50:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjWDsB-dDj+x4yr8h8f_VSkyB7MbgGqBzDRMNz125sZxw@mail.gmail.com>
Message-ID: <CAHk-=wjWDsB-dDj+x4yr8h8f_VSkyB7MbgGqBzDRMNz125sZxw@mail.gmail.com>
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

On Tue, Oct 26, 2021 at 11:24 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> While more intrusive, I'd rather change copy_page_from_iter_atomic()
> etc. to take a pointer where to write back an error code.

I absolutely hate this model.

The thing is, going down that rat-hole, you'll find that you'll need
to add it to *all* the "copy_to/from_user()" cases, which isn't
acceptable. So then you start doing some duplicate versions with
different calling conventions, just because of things like this.

So no, I really don't want a "pass down a reference to an extra error
code" kind of horror.

That said, the fact that these sub-page faults are always
non-recoverable might be a hint to a solution to the problem: maybe we
could extend the existing return code with actual negative error
numbers.

Because for _most_ cases of "copy_to/from_user()" and friends by far,
the only thing we look for is "zero for success".

We could extend the "number of bytes _not_ copied" semantics to say
"negative means fatal", and because there are fairly few places that
actually look at non-zero values, we could have a coccinelle script
that actually marks those places.

End result: no change in calling conventions, no change to most users,
and the (relatively few) cases where we look at the "what about
partial results", we just add a

         .. existing code ..
         ret = copy_from_user(..);
+        if (ret < 0)
+                break;  // or whatever "fatal error" situation
         .. existing  code ..

kind of thing that just stops the re-try.

(The coccinelle script couldn't actually do that, but it could add
some comment marker or something so that it's easy to find and then
manually fix up the places it finds).

             Linus
