Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EE443A929
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 02:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbhJZAUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 20:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbhJZAUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 20:20:21 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12A6C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 17:17:58 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id g184so12326706pgc.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 17:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8SzW5TJvKJhLV5Zb7k2R+KxmVSWy5yO4Y3SYbKAXh8Y=;
        b=jUSJH9FB1tQe74x33ZsBbEMJRUwlkMpP2TT6GO7KJQf1dWq9E8iu/VGwfwSTCqfPZ4
         An3XWfhGyxe5rotkQV0Lev2wj7RbjRdVvxLMq0NjH6jJarolN1T0mcxM5/KMUVMw88ie
         1rh+0GNZH8lBRHYRp4TICNUoXnUdvNTd6DdpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8SzW5TJvKJhLV5Zb7k2R+KxmVSWy5yO4Y3SYbKAXh8Y=;
        b=exqQ2w55Y9suuQV3BvXJu+bjKmOMhZwpz/6ZdSbmACi+V6+v3hmrZnoXRI8DriIwOC
         QnKRUMfwHZcR2XP7eCOWDAWksP5OQbWXOzItNm/fNNMZKpqZ7b3msjaDjaIvRGG7j+e4
         k+5bbFwXK1P1wRPhEFXi4O94G01KyEqJ+n1ZC3vNW3lqNvIHUdbOU4oQ6jVkEFmP+x4S
         1U7RY1CTo+Es7NfF7aUmH5Zdwo1L2AaMS6ohQJNWzQFQKPTviSS/Won3l59/5eMZfDuF
         YsObWp7ca7GGlKouHh11wbaYvGkyRLZR/JEQakSSg+a8iQJz0GBSsuI4dDh/aB1m/W9P
         G/fQ==
X-Gm-Message-State: AOAM530F4q/8HWzwi4pX9J63dV7SWow5pWGR7ifnshB43FNeTGd8uO9O
        8E73R3alObtSFWi1zB8qWV41iHKasNM=
X-Google-Smtp-Source: ABdhPJyEdi3xPL0NDkl6Hyn+8btHTGELKeAAX9vWElqHXOKofWKODgkdIRn1+plw8MBs2/Pc+oylqw==
X-Received: by 2002:a63:1406:: with SMTP id u6mr16303404pgl.106.1635207478435;
        Mon, 25 Oct 2021 17:17:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d17sm7971251pfj.98.2021.10.25.17.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 17:17:57 -0700 (PDT)
Date:   Mon, 25 Oct 2021 17:17:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Jordy Zomer <jordy@pwning.systems>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] secretmem: Prevent secretmem_users from wrapping to zero
Message-ID: <202110251706.BBEE1428@keescook>
References: <20211025181634.3889666-1-willy@infradead.org>
 <202110251225.D01841AE67@keescook>
 <YXcKzKVX7NTAtvPh@casper.infradead.org>
 <202110251402.ADFA4D41BF@keescook>
 <CAHk-=wgvb72urgEM5q_SpXFv1OXnDGY8VFs8QmZPt9_n1bH0CQ@mail.gmail.com>
 <202110251438.1762406A5@keescook>
 <CAHk-=wj9j8KnWzTTFCXi_xWyytFbtZ71hu32eB=nHR++X+UY=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj9j8KnWzTTFCXi_xWyytFbtZ71hu32eB=nHR++X+UY=A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 04:37:01PM -0700, Linus Torvalds wrote:
> If we want other semantics, it should be a new type.

Okay, that's reasonable.

> > I see that is more like a "shared resource usage count" where the shared
> > resource doesn't necessarily disappear when we reach "no users"?
> 
> So I think that's really "atomic_t".
> 
> And instead of saturating, people should always check such shared
> resources for limits.

Right, but people make mistakes, etc. I agree about the limit being much
more sane than saturating (though in the cases of "missed decrement"),
we get to the same place: an open-coded check for the limit that never
goes down doesn't matter if it's refcount_t nor atomic_t. :)

> > i.e. there is some resource, and it starts its life with no one using it
> > (count = 1).
> 
> You are already going off into the weeds.
> 
> That's not a natural thing to do. It's already confusing. Really. Read
> that sentence yourself, and read it like an outsider.
> 
> "No one is using it, so count == 1" is a nonsensican statement on the
> face of it.
> 
> You are thinking of a refcount_t trick, not some sane semantics.
> 
> Yes, we have played off-by-one games in the kernel before. We've done
> it for various subtle reasons.

Right, sure, but it's not a rare pattern. Given that it exists, and that
it _does_ get used for allocation management (e.g. module loader), it
seems worth constructing a proper type for it so that all the open coded
stuff around these instances can be consolidated, and the API can be
defined in a way that will behave sanely.

> I really don't see what's wrong with 'atomic_t', and just checking for limits.

It's that last part. :) If we go through atomic_dec() see a zero and do
something, okay, fine. But these places need to check for insane
conditions too ("we got a -1 back -- this means there's a bug but what
do we do?"). Same for atomic_inc(): "oh, we're at our limit, do
something", but what above discovering ourselves above the limit?
There's nothing about using the atomic_t primitives that enforces these
kinds of checks. (And there likely shouldn't be for atomic_t -- it's a
plain type.) But we likely need something that fills in this API gap
between atomic_t and refcount_t.

> So if a user can ever trigger a saturating counter, that's a big big
> problem in itself.

Yes! It is. :) But they don't get to gain control over a Use-after-Free.
The risk to the system is DoS instead of loss of execution control.
That's a meaningful risk downgrade.

So, what's the right semantics for an atomic type that could be used in
the module loader, that would catch kernel counting bugs in a safe manner?

The "refcount_t but 1-based" is close, but clearly not the right name. :)

-- 
Kees Cook
