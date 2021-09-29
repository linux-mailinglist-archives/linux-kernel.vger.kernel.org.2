Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA59F41BC34
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 03:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243615AbhI2BiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 21:38:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30448 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229505AbhI2BiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 21:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632879403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xmXXQz14OHu7NQNRzC6miY+wGBVQ4lf/YmhSvfWG8yE=;
        b=GD2qRIKo4rr5J0XWoDY/GbqPCI7v7uviQL+xD+TedIpXexFhV1qHe1WwO0eo6tlcmz+HS4
        s07WKRWupfm0c4jnekzaM8bztmtLzV3hMESltSnE6z5RJP/jiut9eTfzJ2EhmRMJ3kFJGE
        gRERJwxuRgejOmhDTqTgUnTr4y3klWU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-nBPzP1pGNLW_6i8H980IpQ-1; Tue, 28 Sep 2021 21:36:42 -0400
X-MC-Unique: nBPzP1pGNLW_6i8H980IpQ-1
Received: by mail-qt1-f197.google.com with SMTP id b20-20020ac87fd4000000b002a69ee90efbso3224952qtk.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 18:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xmXXQz14OHu7NQNRzC6miY+wGBVQ4lf/YmhSvfWG8yE=;
        b=0KMYxXspCOgoqvaoWfzQg9ZafWZTOMxy59ES9Lmzadal403OScTDjhhokFVR7VQQR6
         te44HZ6vkKtpKNhIWCqWvzyt6Hd0UN7536CEoDUDEGnhirbyRre1OKIfj3zdEOODKi2T
         HeB21Wh6J+BIkLABhucFVv228kutsRsSPUDIcV6t1MWM3foOuREAVVqFWhBwadEua81o
         VoIfkaJBQF821N9sIlAEgei654P+chk/9IcoFu3THIWqS2ozHFF2CquHiL/g8e/EMclj
         29fFdC3IIXDc+S48nVODttGfczz7oMIfby7HuK7CuRkW45Afb7yAxp+lnmhXho1QFHRF
         ZodQ==
X-Gm-Message-State: AOAM532PN+rz/7KYcCNSOYQmUik3VEwLFG/DHozAUGr9M4G2SjCDDXKi
        nx9wY8gKJI/rDtO4bhDt760u91QThqXUelKjEPaxyon6jFjj/GvLP484DUAL5/GeJIXp7BebhXf
        qvjgnC8ZLT6D2PE8m5ne3whgx
X-Received: by 2002:ac8:4a10:: with SMTP id x16mr9383330qtq.97.1632879401445;
        Tue, 28 Sep 2021 18:36:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLnW/cM1Suo+FWTs6RJKI1CQo3+FE+UoEL65KNdGKxlIxeo2lntNMs+HgoTajpWesWkIg/PQ==
X-Received: by 2002:ac8:4a10:: with SMTP id x16mr9383313qtq.97.1632879401228;
        Tue, 28 Sep 2021 18:36:41 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id p19sm622628qkk.83.2021.09.28.18.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 18:36:40 -0700 (PDT)
Date:   Tue, 28 Sep 2021 18:36:37 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+488ddf8087564d6de6e2@syzkaller.appspotmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        will@kernel.org, x86@kernel.org
Subject: Re: [syzbot] upstream test error: KASAN: invalid-access Read in
 __entry_tramp_text_end
Message-ID: <20210929013637.bcarm56e4mqo3ndt@treble>
References: <000000000000a3cf8605cb2a1ec0@google.com>
 <CACT4Y+aS6w1gFuMVY1fnAG0Yp0XckQTM+=tUHkOuxHUy2mkxrg@mail.gmail.com>
 <20210921165134.GE35846@C02TD0UTHF1T.local>
 <CACT4Y+ZjRgb57EV6mvC-bVK0uT0aPXUjtZJabuWasYcshKNcgw@mail.gmail.com>
 <20210927170122.GA9201@C02TD0UTHF1T.local>
 <20210927171812.GB9201@C02TD0UTHF1T.local>
 <CACT4Y+actfuftwMMOGXmEsLYbnCnqcZ2gJGeoMLsFCUNE-AxcQ@mail.gmail.com>
 <20210928103543.GF1924@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210928103543.GF1924@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 11:35:43AM +0100, Mark Rutland wrote:
> > In the other x86 thread Josh Poimboeuf suggested to use asm goto to a
> > cold part of the function instead of .fixup:
> > https://lore.kernel.org/lkml/20210927234543.6waods7rraxseind@treble/
> > This sounds like a more reliable solution that will cause less
> > maintenance burden. Would it work for arm64 as well?
> 
> Maybe we can use that when CC_HAS_ASM_GOTO_OUTPUT is avaiable, but in
> general we can't rely on asm goto supporting output arguments (and IIRC
> GCC doesn't support that at all), so we'd still have to support the
> current fixup scheme.

Even without CC_HAS_ASM_GOTO_OUTPUT it should still be possible to hack
something together if you split the original insn asm and the extable
asm into separate statements, like:

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 6b52182e178a..8f62469f2027 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -137,20 +139,21 @@ static inline unsigned long long native_read_msr_safe(unsigned int msr,
 {
 	DECLARE_ARGS(val, low, high);
 
-	asm volatile("2: rdmsr ; xor %[err],%[err]\n"
-		     "1:\n\t"
-		     ".section .fixup,\"ax\"\n\t"
-		     "3: mov %[fault],%[err]\n\t"
-		     "xorl %%eax, %%eax\n\t"
-		     "xorl %%edx, %%edx\n\t"
-		     "jmp 1b\n\t"
-		     ".previous\n\t"
-		     _ASM_EXTABLE(2b, 3b)
-		     : [err] "=r" (*err), EAX_EDX_RET(val, low, high)
-		     : "c" (msr), [fault] "i" (-EIO));
+	*err = 0;
+	asm volatile("417: rdmsr\n"
+		     : EAX_EDX_RET(val, low, high)
+		     : "c" (msr));
+	asm_volatile_goto(_ASM_EXTABLE(417b, %l[Efault]) :::: Efault);
+
+done:
 	if (tracepoint_enabled(read_msr))
 		do_trace_read_msr(msr, EAX_EDX_VAL(val, low, high), *err);
 	return EAX_EDX_VAL(val, low, high);
+
+Efault:
+	*err = -EIO;
+	ZERO_ARGS(val, low, high);
+	goto done;
 }
 
 /* Can be uninlined because referenced by paravirt */

