Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A801D3AA14D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbhFPQb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbhFPQb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:31:27 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F26C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 09:29:20 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id q20so5330560lfo.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 09:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YkHWZdOJ4eKpmiNbLDcjXIKJtKDecWvikhN4M+R2kvo=;
        b=JxnWVbuRB3VsapeDk3cTF4LBx8E/4o12zS7evfMX4Kjsjqv6fW9fXUvXtldc9Lbwa4
         OWLKBb5Np3i2eJ36CLJnfbv0dpmQWa8gV1CcMLB9OnpV5nSckpeBhULvyumtP3sHddpT
         HAGJnep5fG2GyVLcp6TbXSqVZh4OHkU/5TP9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YkHWZdOJ4eKpmiNbLDcjXIKJtKDecWvikhN4M+R2kvo=;
        b=TvVfXtKPBJ1ptnNwn36bMqCLlRR8ScoVCH1+vE/hdNuwPz/X8tOdClDZMJv4AJYfLN
         00ZnjE9+qA1L7Ij7K3gVdUKZOgQj9a28M65aG9uD8z3H/LOEvEWI2kOemn4O2L+7LzMf
         5bmKQW3YFds2b6IPvaBIHJbZdtAD5pSSWnueUxTEDr6pzgrQQCvUOUbER2Y9kleaWHyP
         Vi+QhhWOMf4kfgpI4RZmBwAKkIV95tn87zMkWAr6aUZZLUFB4KtLVfm3uwl2UgfTbLib
         csGTegNweeIA9d30yBLHERIlQKmVjL+OJ5KGjAl6BlWyqOLUCw9i6qM1Ipa6Pe8KO/Nk
         Nb0g==
X-Gm-Message-State: AOAM531Py01PE/wViI7jiBlNTPIf1eS4HLS0qqBaKOikPaMmC3GfTvTV
        oZpfOQyJde82J50aKIHJItLxCPXJ1SHPqkXlbT0=
X-Google-Smtp-Source: ABdhPJwujLrcG2xTeMu7XCI/rpWHqCODs71LIVKNdDlxEZWUouv+e3TLaB12CutPQfKQdzQLkh4uxw==
X-Received: by 2002:a05:6512:3a4:: with SMTP id v4mr383261lfp.127.1623860958600;
        Wed, 16 Jun 2021 09:29:18 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id w17sm292656lfd.126.2021.06.16.09.29.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 09:29:17 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id l4so4784308ljg.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 09:29:17 -0700 (PDT)
X-Received: by 2002:a2e:2ac6:: with SMTP id q189mr589148ljq.61.1623860957409;
 Wed, 16 Jun 2021 09:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <162375813191.653958.11993495571264748407.stgit@warthog.procyon.org.uk>
 <CAHk-=whARK9gtk0BPo8Y0EQqASNG9SfpF1MRqjxf43OO9F0vag@mail.gmail.com>
 <f2764b10-dd0d-cabf-0264-131ea5829fed@infradead.org> <CAHk-=whPPWYXKQv6YjaPQgQCf+78S+0HmAtyzO1cFMdcqQp5-A@mail.gmail.com>
 <c2002123-795c-20ae-677c-a35ba0e361af@infradead.org> <051421e0-afe8-c6ca-95cd-4dc8cd20a43e@huawei.com>
 <200ea6f7-0182-9da1-734c-c49102663ccc@redhat.com> <CAHk-=wjEThm5Kyockk1kJhd_K-P+972t=SnEj-WX9KcKPW0-Qg@mail.gmail.com>
 <9d7873b6-e35c-ae38-9952-a1df443b2aea@redhat.com>
In-Reply-To: <9d7873b6-e35c-ae38-9952-a1df443b2aea@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Jun 2021 09:29:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgW6yfsLUtepANX2PVkADR_7WDzk05YVhtw1ZBmDEGT2Q@mail.gmail.com>
Message-ID: <CAHk-=wgW6yfsLUtepANX2PVkADR_7WDzk05YVhtw1ZBmDEGT2Q@mail.gmail.com>
Subject: Re: [PATCH] afs: fix no return statement in function returning non-void
To:     Tom Rix <trix@redhat.com>
Cc:     Zheng Zengkai <zhengzengkai@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Hulk Robot <hulkci@huawei.com>, linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 9:22 AM Tom Rix <trix@redhat.com> wrote:
>
> to fix, add an unreachable() to the generic BUG()
>
> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> index f152b9bb916f..b250e06d7de2 100644
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -177,7 +177,10 @@ void __warn(const char *file, int line, void
> *caller, unsigned taint,
>
>   #else /* !CONFIG_BUG */
>   #ifndef HAVE_ARCH_BUG
> -#define BUG() do {} while (1)
> +#define BUG() do {                                             \
> +               do {} while (1);                                \
> +               unreachable();                                  \
> +       } while (0)
>   #endif

I'm a bit surprised that the compiler doesn't make that code after an
infinite loop automatically be marked "unreachable". But at the same I
can imagine the compiler doing some checks without doing real flow
analysis, and doing "oh, that conditional branch is unconditional".

So this patch at least makes sense to me and I have no objections to
it, even if it makes me go "silly compiler, we shouldn't have to tell
you this".

So Ack from me on this.

           Linus
