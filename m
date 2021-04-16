Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B9E36271E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243640AbhDPRrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:47:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47599 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235877AbhDPRrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618595196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UwAq3mjTqcl8JnB7zCamgcUlnZYnBtvHAiM1ilKgZu8=;
        b=NI1HjptsDyNRS2dRcRY/EC1+6YtETYQDR5FHfFA0udAGUEMtrCb7L+jwjlsLZRzJp8X7C2
        smgpMFTiQpShRXfI8LqV23eM5cx/uuRIJyya0d8R+QkurC66DQSuSfsz/sdjlOkv8rMH3n
        fpdSeJg4U/I8wjY6JUaOvz1g4N+h3HQ=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-EzQ6tTD3NQGwVP2YyFcsbQ-1; Fri, 16 Apr 2021 13:46:34 -0400
X-MC-Unique: EzQ6tTD3NQGwVP2YyFcsbQ-1
Received: by mail-oi1-f200.google.com with SMTP id r204-20020aca44d50000b029013da91480a0so9712636oia.17
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 10:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UwAq3mjTqcl8JnB7zCamgcUlnZYnBtvHAiM1ilKgZu8=;
        b=rypNW5OSJw2zTrrR7L0gsporKyVMXvEZH9/upO3mCSB1llxLkX74P6eCXPRI17MxaI
         kcv91KO40XD1otZnHUNIkOQRrGzoInT9bscIg5Qb7K6e5vB1X5n9q8beMQoEnY01fIwc
         clPe6Fkhoy0FyNTaLa0Y0YGBFlutzTIrQyzeHxn35aJRl6QnnCiSCq0jx4AZ6rfpWVbD
         obFTTTa5THPbw7jgphsNA7994TuxCMvRmOMLzdIxkFdoERmbmri8R9KoRv8U/nmthXeP
         EwjOcX0xhElvfc/c0u+P78QZ+ij78FZZzoqclWMueXD6nxv4xKozEnpWxAZWp90D/UqZ
         wVLg==
X-Gm-Message-State: AOAM531jw03jCz+EEwqHbuAd0nNoILCxXum5bFNVh9qVHBYt5dze6aY1
        T9MKBKbOAZjSMiflaKCI29pWXTIjjmjOvy0vFIEOc4KA3TG+2+OKUlpagE/M3OGjE9cP1uW8xiw
        +Y/1/+jyHUjbPitrAKWfIfUJBGtgWic2wlxwqpes2pDnI0lAUZvzw1/v1ZvjdtpJu71n5ekgyIA
        ==
X-Received: by 2002:a9d:1d26:: with SMTP id m35mr4656008otm.266.1618595193467;
        Fri, 16 Apr 2021 10:46:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqmjn4JZgbtPJEhjtjFp39QSapQwN3qRjLDpF9oiDAS4DSPTNYxB/uSTzFnddcPY6N0Oc0UQ==
X-Received: by 2002:a9d:1d26:: with SMTP id m35mr4655978otm.266.1618595193194;
        Fri, 16 Apr 2021 10:46:33 -0700 (PDT)
Received: from [192.168.0.173] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id y2sm1365951ooa.10.2021.04.16.10.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 10:46:32 -0700 (PDT)
Subject: Re: [PATCH 00/13] [RFC] Rust support
To:     Willy Tarreau <w@1wt.eu>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Wedson Almeida Filho <wedsonaf@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210414184604.23473-1-ojeda@kernel.org>
 <YHlz54rd1YQHsOA/@hirez.programming.kicks-ass.net>
 <YHmMJWmzz2vZ3qQH@google.com>
 <YHmc2+bKQJ/XAATF@hirez.programming.kicks-ass.net>
 <YHmuX1NA5RF7C7XS@google.com> <20210416161444.GA10484@1wt.eu>
 <CANiq72nbkJFPmiJXX=L8PmkouKgKG1k-CxhZYpL1hcncYwa8JA@mail.gmail.com>
 <20210416173717.GA10846@1wt.eu>
From:   Connor Kuehl <ckuehl@redhat.com>
Message-ID: <d33dbe20-698a-7dba-2e46-ece325a1c849@redhat.com>
Date:   Fri, 16 Apr 2021 12:46:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210416173717.GA10846@1wt.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/21 12:37 PM, Willy Tarreau wrote:
> Hi Miguel,
> 
> On Fri, Apr 16, 2021 at 07:10:17PM +0200, Miguel Ojeda wrote:
>> And by having the compiler enforce this safe-unsafe split, you can
>> review safe code without having to constantly worry about UB; and be
>> extra alert when dealing with `unsafe` blocks.
> 
> I do appreciate this safe/unsafe split and a few other things I've seen
> in the language. The equivalent I'm using in C is stronger typing and
> "const" modifiers wherever possible. Of course it's much more limited,
> it's just to explain that I do value this. I just feel like "unsafe"
> is the universal response to any question "how would I do this" while
> at the same time "safe" is the best selling argument for the language.
> As such, I strongly doubt about the real benefits once facing reality
> with everything marked unsafe. Except that it will be easier to blame
> the person having written the unsafe one-liner instead of writing 60
> cryptic lines doing the functional equivalent using some lesser known
> extensions :-/
> 

It's possible that many of the questions you've been specifically asking
about, by sheer coincidence, are targeted towards the problems that would
indeed require a lower-level abstraction built within an unsafe block; meaning
you've managed to evade the tons of other upper layers that could be written
in safe Rust.

Indeed, at a certain layer, unsafe is unavoidable for the kind of work that
is done in the kernel. The goal is to shrink the unsafe blocks as much as
possible and confirm the correctness of those pieces, then build safe
abstractions on top of it.

For what it's worth, if there was some post-human apocalyptic world where
literally everything had to go inside an unsafe block, the silver lining
in a hypothetical situation like this is that unsafe does not disable all
of Rust's static analysis like the borrow checker, etc. It allows you to
do things like directly dereference a pointer, etc. Unsafe also doesn't
automatically mean that the code is wrong or that it has memory issues;
it just means that the compiler can't guarantee that it doesn't based on
what you do in the unsafe block.

Connor

