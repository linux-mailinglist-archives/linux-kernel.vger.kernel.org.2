Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0C83C91FF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbhGNUZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhGNUZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:25:09 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183B7C061764
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 13:22:17 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a12so5748526lfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 13:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AWy+35KmmWPF9vsv4/yauNLhBLPVkzMejTzAkHJGLBM=;
        b=V37VAVm5NvLVGqND/F0vTJg46VZeConitLxxTHCs1N4UC3kwCcitLTAuULgE9P0yJ7
         JxRC/pqtzVf+u3u/c8M13eOZYvvD8y4ch9aoNPL3PEyFGZfOI7/lAvcnPkfI3gFhUBhB
         KHaX4h+Jp8OCMJ7rNg+VURB4Q4FkA9BEozZbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWy+35KmmWPF9vsv4/yauNLhBLPVkzMejTzAkHJGLBM=;
        b=c3vWLxCOnLt+CnZJRuXSyGU8/hK5AVGr8d2/fItH22HP8JVdx/2Uzirjz9qURaQDM/
         4FAjH+MLbrD7zgDTTazosKiyl+hp0GrM/Z6C3iDgrjiFOgayCszbqDrNERMtm910w5Lj
         wwLufi5P3pq9A9gmIYYXW4gVUtswPLyRneM0wlqyZ0SRbSBz4g15vMxpw4TzxmCF1k/Q
         CaI673fSs737q5zf0Ax7X0OcqqWnr2GcMDII8ppNNpAE4376tZQSoyy3pyF8zA3GFhyw
         qpq3dT0AD33eQlu9tQsddQJHkur84cmK2nR2jgcf5SII/VxKMZLwbCh69twwUitC8IvW
         8CDQ==
X-Gm-Message-State: AOAM531DzInWkWtjaGIhIOII5TuJl1sNE6m/YP5AwihfMiudOd7hx75b
        tTkoUAjGIV4mzuPo2hccMSQW/KH808XQBglW
X-Google-Smtp-Source: ABdhPJxh9FdJK59B+CsAs6sFDGCnKKomQyObqJBnCpTkyjhZsEsmQPZimWqkKie8PnXG2ki9bcgRBQ==
X-Received: by 2002:ac2:54a4:: with SMTP id w4mr60634lfk.344.1626294135303;
        Wed, 14 Jul 2021 13:22:15 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id p12sm240063lft.102.2021.07.14.13.22.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 13:22:13 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id r16so5283411ljk.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 13:22:13 -0700 (PDT)
X-Received: by 2002:a2e:81c4:: with SMTP id s4mr10564675ljg.251.1626294133222;
 Wed, 14 Jul 2021 13:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210704202756.29107-1-ojeda@kernel.org> <20210704202756.29107-3-ojeda@kernel.org>
 <CAKwvOdmhRuF5eTZ2ztZBrL6BvDkA57B7OfVuvCaEMfV8nkLXCQ@mail.gmail.com>
 <CAHk-=whzXv=Fu7dQshSTyd9H1-JS5=gyKwW-GMNGccAKs4Mwpg@mail.gmail.com> <87mtqo1wv6.fsf@disp2133>
In-Reply-To: <87mtqo1wv6.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Jul 2021 13:21:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whdi_biEOrzrYn7OC+wq+ckoaa5dFAATdM=n9P7Dp0YOA@mail.gmail.com>
Message-ID: <CAHk-=whdi_biEOrzrYn7OC+wq+ckoaa5dFAATdM=n9P7Dp0YOA@mail.gmail.com>
Subject: Re: [PATCH 02/17] kallsyms: increase maximum kernel symbol length to 512
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 1:09 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Are you thinking the hashed kernel symbols need to have their types
> included in the hash?

I think the hash should be the whole mangled name. So yes, for Rust
symbols they'd have the the type information.

>  Or is this just a hash to make the names a managable size?

No, if that was the only point of it, the "just use two bytes for
length" would be simpler.

But I don't think we want to do run-time de-mangling of names in the
kernel when doing stack traces, which implies that the kallsym
information in the kernel should be the de-mangled names.

That makes the names nice and readable, and also makes this "maximum
symbol length" thing a non-issue.

BUT.

It also means that you can't use those names for linking purposes, so
you'd then need to have a "full version" for that. But as Willy
pointed out elsewhere, you might as well just use a constant-sized
hash for that, rather than have both a manged and a de-mangled name.

                   Linus
