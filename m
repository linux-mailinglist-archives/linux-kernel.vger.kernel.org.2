Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B29430404
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 19:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244457AbhJPRzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 13:55:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40312 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240631AbhJPRzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 13:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634406820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YRkFwm3tEdyVj4faYV5tH5DTLEkbFSaiBRQ19GNqPNI=;
        b=CexakwoOPrdHNHTb6XThUIJNG0CYs1PLsKAwP5DCPQRUp4PfpZhjHxOrrtSpouByz5P/3F
        72zhqEYBmL6wkCHEek7Ih5u8UjsOwx9LjrDXPgv9HrHyk58NmUQhemtLMdAgaBwyvYLDT1
        zJAr8dRa8ebMAH+8qYCtZ7X0NIBOivA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-A5CBhgiYMZysIkvBMAzmHA-1; Sat, 16 Oct 2021 13:53:39 -0400
X-MC-Unique: A5CBhgiYMZysIkvBMAzmHA-1
Received: by mail-wm1-f72.google.com with SMTP id h22-20020a7bc936000000b0030d998aa15eso1752876wml.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 10:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YRkFwm3tEdyVj4faYV5tH5DTLEkbFSaiBRQ19GNqPNI=;
        b=lBoDiGvBKYQVJ1i9FtTrMAzJyRK20S6vqQhRzLDqUJMaaOt0bCIrCsCFOH+BgRaJzs
         pZFWi71GTb048F9qGnYyMAaDOlAJWFPcYcHUnvza+/gcEmn3JM0baV4fajNdldMwJ/Gl
         HJF/87BHUDcHp+qdkV8YvLzIRji54g7LDR0CYGkxfsWqMw+VZRkk9QxmVm6q5aZhrTbB
         TvWwm7wfI5S9SSzozS4ZrcQBy+17u/nJeifp381BkdSjArdNl0A4XcO8bHXCXL5YsryH
         mxXHi3Ey3d5X2dafGhzXNAprWt4OnKVXL798JWvSDC6VblxwmL5nK9HinsHQJmCvCjMJ
         BYiQ==
X-Gm-Message-State: AOAM530PtSa7IYgQb7a2T3sCZQFVgCNqm98AXITENGUD+qKR2mFgAu59
        UmgKQcusvaPkIWX01rj4Rmty4rm99kyTHEdBIQAXTjRNM8WB2ewqkE3O4o2JsoSKCuRm0XPXhbv
        x0OEcQGjVjn4dqPwxraLiIO4/
X-Received: by 2002:a05:6000:1889:: with SMTP id a9mr23905479wri.400.1634406818162;
        Sat, 16 Oct 2021 10:53:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyk3Fx/ay/cz+YUuGkGHAC+9ByjoSXkgkPYf95wPtAmqul6aRAX2lJjQQ+e6V9i+wGzauc0LQ==
X-Received: by 2002:a05:6000:1889:: with SMTP id a9mr23905459wri.400.1634406817885;
        Sat, 16 Oct 2021 10:53:37 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p18sm8598586wrt.54.2021.10.16.10.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Oct 2021 10:53:37 -0700 (PDT)
Message-ID: <510287f2-84ae-b1d2-13b5-22e847284588@redhat.com>
Date:   Sat, 16 Oct 2021 19:53:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] mm: allow huge kvmalloc() calls if they're accounted to
 memcg
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Willy Tarreau <w@1wt.eu>, Kees Cook <keescook@chromium.org>,
        syzbot+e0de2333cbf95ea473e8@syzkaller.appspotmail.com
References: <20211016064302.165220-1-pbonzini@redhat.com>
 <CAHk-=wijGo_yd7GiTMcgR+gv0ESRykwnOn+XHCEvs3xW3x6dCg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAHk-=wijGo_yd7GiTMcgR+gv0ESRykwnOn+XHCEvs3xW3x6dCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/21 17:39, Linus Torvalds wrote:
> The big allocation warnings are not about whether we have the memory
> or not, or about whether it's accounted or not.
> It's about bugs and overflows. Which we've had.

Yes, I understand that...

> At least GFP_NOWARN would be somewhat sensible - although still wrong.

... and it also seemed wrong to overload GFP_NOWARN.

> It should really be about "I've been careful with growing my
> allocations", not about whether accounting or similar should be
> disabled. If the allocations really are expected to be that big, and
> it's actually valid, just do vmalloc(), which doesn't warn.
Sounds good, and you'll get a pull request for that tomorrow.  Then I'll 
send via Andrew a patch to add __vcalloc, so that the accounting is 
restored.

Paolo

