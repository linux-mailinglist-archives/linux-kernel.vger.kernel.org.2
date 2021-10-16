Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE6A430415
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 20:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244522AbhJPSNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 14:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbhJPSMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 14:12:49 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13A1C061766
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 11:10:38 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id n8so56362609lfk.6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S09Oa/SsybBsJJzF//y2gn5/V4eOIeQCpxOLB6Oazhg=;
        b=eUGVkktStc21n/ufKU/i96QrXSi7kX/unwoGwYFVu2l58jPH2/H5fX/vLmY2F98f3e
         3ASeoDQELyFiqjRf0y2913aVUpjY+35srDZBQFQG7hFxVvWWYk7JK1RGkaLR+RNMpyX0
         QLsqd+NCSgMSKuFvlMJTUnjY1bypKZAzBwib0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S09Oa/SsybBsJJzF//y2gn5/V4eOIeQCpxOLB6Oazhg=;
        b=pqGavxC6iRWBMSMlROPZDfq2tgL7S0XpqWDWtnqipVoEBuYD5TKlRX858ahv/c+/RJ
         3iTmbbyK5KkSLK9QDjegiqAZUEwmz/JVTUYpK6LlkJuKUlVA27jN80WRIeh4CERYQaa1
         FABv33iLOzj5d4kjP9SKVfNIYVZg/Vax58gHToCZ1obnUjRVuFvL87g9bvYfNWeSft98
         GLOCU+3+dsra2xIKG+TZ/7JP46trGst93f/m3IA6O0XYB7vslpHQDSt4EmsSjfjsX274
         KpPjeF8WLVnIOChEhiz5vHzx/ISznBuzUJfmKn5RBNdT629udFWC6lrwhJAdZht7d7VA
         wNwQ==
X-Gm-Message-State: AOAM530cy3qlBLdSn1cLg+NSyDlaTEm0JfMpHCWYGqVbMw1iFVcfrCVK
        YBr6psktVaSetQcc8o3l4axILCXTEV+PCjic
X-Google-Smtp-Source: ABdhPJyPr8BIKoVYdkkp0CA2k/hyIw0NNw/+/wbGC3RRYBEJiSX4FUNYScC4z35FYRN1wc1hO9RGLw==
X-Received: by 2002:a05:6512:3c8:: with SMTP id w8mr16342544lfp.424.1634407836280;
        Sat, 16 Oct 2021 11:10:36 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id t16sm912700lfd.159.2021.10.16.11.10.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Oct 2021 11:10:35 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id o26so214729ljj.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 11:10:35 -0700 (PDT)
X-Received: by 2002:a2e:a407:: with SMTP id p7mr22028098ljn.68.1634407835055;
 Sat, 16 Oct 2021 11:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211016064302.165220-1-pbonzini@redhat.com> <CAHk-=wijGo_yd7GiTMcgR+gv0ESRykwnOn+XHCEvs3xW3x6dCg@mail.gmail.com>
 <510287f2-84ae-b1d2-13b5-22e847284588@redhat.com>
In-Reply-To: <510287f2-84ae-b1d2-13b5-22e847284588@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 16 Oct 2021 11:10:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZ+iCW5yMc3zuTpZrZzjb082xtVyzk3rV+S0SUNrtAAw@mail.gmail.com>
Message-ID: <CAHk-=whZ+iCW5yMc3zuTpZrZzjb082xtVyzk3rV+S0SUNrtAAw@mail.gmail.com>
Subject: Re: [PATCH] mm: allow huge kvmalloc() calls if they're accounted to memcg
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Willy Tarreau <w@1wt.eu>, Kees Cook <keescook@chromium.org>,
        syzbot+e0de2333cbf95ea473e8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 10:53 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Sounds good, and you'll get a pull request for that tomorrow.  Then I'll
> send via Andrew a patch to add __vcalloc, so that the accounting is
> restored.

Ahh. So you used kvmalloc() mainly because the regular vmalloc()
doesn't do the gfp-flags.

We do have that "__vmalloc()" thing, but the double underscore naming
makes it a bit unfortunate (since it tends to mean "local special use
only").

I suspect you could just make "vcalloc()".

That said, I also do wonder if we could possibly change "kvcalloc()"
to avoid the warning. The reason I didn't like your patch is that
kvmalloc_node() only takes a "size_t", and the overflow condition
there is that "MAX_INT".

But the "kvcalloc()" case that takes a "number of elements and size"
should _conceptually_ warn not when the total size overflows, but when
either number or the element size overflows.

So I would also accept a patch that just changes how "kvcalloc()"
works (or how "kvmalloc_array()" works).

It's a bit annoying how we've ended up losing that "n/size"
information by the time we hit kvmalloc().

               Linus
