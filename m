Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C141E43A915
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 02:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbhJZAGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 20:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236078AbhJZAFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 20:05:20 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC2EC061231
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 17:02:38 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u5so15311725ljo.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 17:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+mnm+OfMKcKUtkfqrC5M97FE+bDqSMISDz0T80M6Naw=;
        b=Zr8T+v06R2K3WXZXA/rUZs6WfYMvfmtXk94m5JBLVuXUlLBJpGx736SF8nwtXTYl0c
         kU+TL3h/XLlQCjRn5C6XVoEDuOrGftxepbTasP56kMLo/Bz0I51EmdYXyfWQ96Odv9SC
         q6xT7IH8kr9CoZttMVB4amc+2gZey1z7kz+VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+mnm+OfMKcKUtkfqrC5M97FE+bDqSMISDz0T80M6Naw=;
        b=2372b4SJih2780qhnZMsfYoaGiNzHtYy2uMxr++krEKJRFieTWc37ysrE5y9OQJxLU
         oW29yQMnOihmgUMsUWDsMVSgchVmv2q+4h1oUO4GRWOT0S3e4LEjV0baBRV91TXJEJ0D
         6N0th7P1ew8w2iiDcAE2/KsK+o8JODsvRxJj/RRJlPNgB4pWw9HnhAi9zOZOdAlUjvvI
         BxuJlGwJHybzJjXvo4GtYreZOwluoun0g13UKJBgi6IicnAsv+dZ3uoyVQk0nvbO+5CW
         yR378qA4OqnbnilPO0f0PXSSZx8paMqztHn8DQkxDKCyOyVWcfbVOKWNs9HVJ/JjuHDa
         nmUg==
X-Gm-Message-State: AOAM531jpU9bUo/QMXX5Ytr778qIeG1XE9uypKvyBC3d7FiBWE8INt75
        IQwl9/GgDAJt13EvnXR5/Aj2S7lEpzsdAA==
X-Google-Smtp-Source: ABdhPJw481Px/2uqAE9EODTww62TAeNhLOsLUSXlV+clrA/rmOvqLd5S01uGBz3P72hiBf+XImRNFQ==
X-Received: by 2002:a2e:8545:: with SMTP id u5mr23333338ljj.178.1635206556067;
        Mon, 25 Oct 2021 17:02:36 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id e4sm1849364ljn.131.2021.10.25.17.02.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 17:02:35 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id y26so13038682lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 17:02:35 -0700 (PDT)
X-Received: by 2002:a19:ad0c:: with SMTP id t12mr19319386lfc.173.1635206555059;
 Mon, 25 Oct 2021 17:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211025181634.3889666-1-willy@infradead.org> <202110251225.D01841AE67@keescook>
 <YXcKzKVX7NTAtvPh@casper.infradead.org> <202110251402.ADFA4D41BF@keescook>
 <CAHk-=wgvb72urgEM5q_SpXFv1OXnDGY8VFs8QmZPt9_n1bH0CQ@mail.gmail.com>
 <202110251438.1762406A5@keescook> <CAHk-=wj9j8KnWzTTFCXi_xWyytFbtZ71hu32eB=nHR++X+UY=A@mail.gmail.com>
In-Reply-To: <CAHk-=wj9j8KnWzTTFCXi_xWyytFbtZ71hu32eB=nHR++X+UY=A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Oct 2021 17:02:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgAwmd2jiCpuQq7ofPQQvBW5FtkRaoRt08EqjJ1-EeNig@mail.gmail.com>
Message-ID: <CAHk-=wgAwmd2jiCpuQq7ofPQQvBW5FtkRaoRt08EqjJ1-EeNig@mail.gmail.com>
Subject: Re: [PATCH] secretmem: Prevent secretmem_users from wrapping to zero
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Jordy Zomer <jordy@pwning.systems>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 4:37 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Stop thinking that refcount_t is a good type. Start realizing the
> downsides. Start understanding that saturation is a HORRENDOUSLY BAD
> solution, and horrible QoI.

Basically, refcount_t should be used purely for internal kernel data
structures - it makes perfect sense for things like the 'struct
device' resource handling, for example.

In fact, there it is good for two reasons:

 - it's not counting some user resource, so users shouldn't have any
way to trigger overflow and saturation which causes problems

 - it's used by random driver stuff, which is often where kernel bugs
happen and testing is fundamentally limited by hw availability etc

but in general, anything that is user-accountable needs to have
_limits_, not saturation. It's why the page count is a "atomic_t" even
if the name of the field is "_refcount". Because refcount_t is the
INFERIOR TYPE.

Using an atomic_t properly is actually the much better option. It's
just that "properly" might be a bit more code, involving actual limit
checking.

'refcount_t' is basically a shorthand for "I didn't bother doing this
right, so I'm using this type that adds debugging, warns and stops
working and might DoS the kernel".

It's a crutch. It's not the alpha and the omega of counting types. It
has its place, but I really want to stress how people should
ABSOLUTELY not think "oh, refcount_t is better than atomic_t".

              Linus
