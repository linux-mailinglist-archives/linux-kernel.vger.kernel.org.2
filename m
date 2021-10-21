Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B9C436E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhJUXlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31108 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231777AbhJUXlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634859538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WqubQX+KjTkC2vCpdxocGaht9394l669HgXzqP3nsGk=;
        b=VKsc7qcgPK7aA616egRCO388Ver8+AylJzhyFpYCDUHd5Facw0xTimlCIOYxcMV4vzEdYD
        pdHPPC3GcajFZ95BUwv/v3ZIJFLAJztBjcseCEVVjS0Nb6V+EYr5G3X8VxCB2pl/exDvcH
        UOqhNekwnWmEoYx0M4endviiQCFLLiw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-j4KlAUgHNjqLdUiXnW8RdQ-1; Thu, 21 Oct 2021 19:38:56 -0400
X-MC-Unique: j4KlAUgHNjqLdUiXnW8RdQ-1
Received: by mail-qk1-f198.google.com with SMTP id b189-20020a3799c6000000b0045eb0c29072so1678563qke.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 16:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WqubQX+KjTkC2vCpdxocGaht9394l669HgXzqP3nsGk=;
        b=cTfgdmQTTOiYLOMnmkKfHq54DJb/an/kvF0zX2axpj2usVCh0eAyFJ5BazzuSADqXP
         a08AFIidxERcQulbCNN3KvEbjRvYo4qrPWYewy74S+IbOPJcEb5FdHOBXQw23EHYLv7O
         O1+WdtqZRwie9+/vop+kWBeox1XJD/U0PYvMaSffQhzDyFV7/IHJM9cQhCim3UA35RV5
         DqZeSTvehnoxZ+NNRD2i3YIdCJuRMGzawxrKAsOlzDpXEdoZoOLufeZNZC14ghjxXrJG
         GZsqiEk06ZWV8CqFCpbogLqIljdw/mEgokqC1HDrXPHJoe/QnP9b/MM6DL9PiYOaclUs
         KmNg==
X-Gm-Message-State: AOAM531sZUGuRY/YM/XCOvnrsINAXydwMz2jZm9uKrboY/gFajc18pVF
        jK4NWfRFSxFZGxZlgmL0Q9NUdXkM1tfk2dNx3IgihXGpMeLzIV1kVnRfSl4YNNfP5XAapyC5jLg
        H5btzf4B1ev5oZfWmCuhw6OZz
X-Received: by 2002:a37:4553:: with SMTP id s80mr7140055qka.489.1634859536392;
        Thu, 21 Oct 2021 16:38:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZ50mxqIsbIggxTzTVv0SnbGTeNVj4OaFqzddYueB2tm+JgTb+I/dfqDNynyVSHsbuN/7ANw==
X-Received: by 2002:a37:4553:: with SMTP id s80mr7140037qka.489.1634859536201;
        Thu, 21 Oct 2021 16:38:56 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id s189sm3236528qka.100.2021.10.21.16.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 16:38:55 -0700 (PDT)
Date:   Thu, 21 Oct 2021 16:38:52 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
Message-ID: <20211021233852.gbkyl7wpunyyq4y5@treble>
References: <20211020104442.021802560@infradead.org>
 <20211020105843.345016338@infradead.org>
 <YW/4/7MjUf3hWfjz@hirez.programming.kicks-ass.net>
 <20211021000502.ltn5o6ji6offwzeg@ast-mbp.dhcp.thefacebook.com>
 <YXEpBKxUICIPVj14@hirez.programming.kicks-ass.net>
 <CAADnVQKD6=HwmnTw=Shup7Rav-+OTWJERRYSAn-as6iikqoHEA@mail.gmail.com>
 <20211021223719.GY174703@worktop.programming.kicks-ass.net>
 <CAADnVQ+cJLYL-r6S8TixJxH1JEXXaNojVoewB3aKcsi7Y8XPdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQ+cJLYL-r6S8TixJxH1JEXXaNojVoewB3aKcsi7Y8XPdQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 04:24:33PM -0700, Alexei Starovoitov wrote:
> On Thu, Oct 21, 2021 at 3:40 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Oct 21, 2021 at 11:03:33AM -0700, Alexei Starovoitov wrote:
> >
> > > > I nicked it from emit_bpf_tail_call() in the 32bit jit :-) It seemed a
> > > > lot more robust than the 64bit one and I couldn't figure out why the
> > > > difference.
> > >
> > > Interesting. Daniel will recognize that trick then :)
> >
> > > > Is there concurrency on the jit?
> > >
> > > The JIT of different progs can happen in parallel.
> >
> > In that case I don't think the patch is safe. I'll see if I can find a
> > variant that doesn't use static storage.
> 
> The variable can only change from one fixed value to another fixed value.
> Different threads will compute the same value. So I think it's safe
> as-is. READ_ONCE/WRITE_ONCE won't hurt though.

But the size of the generated code differs based on the
emit_bpf_tail_call_indirect() args: 'callee_regs_used' and
'stack_depth'.  So the fixed value can change.

-- 
Josh

