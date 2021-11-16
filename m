Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BFD453BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 22:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhKPVaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 16:30:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36713 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230413AbhKPVas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 16:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637098071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bG84hpn6W1Ce0UZLXpoqOhyDwS32BUv6DCCBEZ7b4bY=;
        b=SUOwUDJ8Sh6xg0z0vO+szchmEs0GBLMoILRseCdvkM2FzNkjEW+8KMedvU/7bg/BMpoltr
        +l7RzHutzPHNv8ejYYrMHxNqvXydNgwj1SVllQGu95fxef7EgbSWcqoCup8DGW5pjl48iG
        zF9obTfyRcudyfAQ5iy3irxk+Tnkawo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-mpNPWQ_aOFWkTYuWFRuAEQ-1; Tue, 16 Nov 2021 16:27:49 -0500
X-MC-Unique: mpNPWQ_aOFWkTYuWFRuAEQ-1
Received: by mail-qv1-f70.google.com with SMTP id ke1-20020a056214300100b003b5a227e98dso606461qvb.14
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 13:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bG84hpn6W1Ce0UZLXpoqOhyDwS32BUv6DCCBEZ7b4bY=;
        b=5kTGnuGD1bV8olQdkoK1hu4SSvll8nKWg7bCO8YI9S7iZQThKPsob5O8UKD5L8zEOi
         YwkwQD3DINkc+V9m7U+L4eD0SUeg3lhXg7zVDC1tDT17k4+L2NIa+uJTNNQXA6Qb08yW
         +ZdmAeXDmwOdSSEwCamcrIM1sjV6OS3DLnknjRuS2lA7musPjaRnYDGTjzKtFVDc8JsK
         ObKL7lCtrDe0Udf9PNqsqH8uzwoMssewThYCNI6E1iJwBtC785NyEgpcCPIglD05BvnA
         5h2smx7xzT9GznexlB5k6wdkkecHuOEn6TIW2PgfWEgRzcwG1ESn7EkzqNyoTwFbQ2Xu
         4MUA==
X-Gm-Message-State: AOAM531XJ1X9AtTdDVPF9C16DkBcKH9rmIv55eyeU27Ehxhynw+apC5c
        BA1xgN7r5iLEHLU9qNCgMaYKwrjt99t7gLgq4xssYaCOTdAZit7nKY+ozU2AyuOeYtqyfGBVFKy
        91bugD4+HV69j1BSLRn7tzhCw
X-Received: by 2002:ac8:5f84:: with SMTP id j4mr11562274qta.271.1637098069420;
        Tue, 16 Nov 2021 13:27:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0St0o43XIqlBNq/4XHEmss+fFXxHlpXC9ZaRAk6a4tHpGQiJkuUzVvVz/UKpde8JY+mNI6Q==
X-Received: by 2002:ac8:5f84:: with SMTP id j4mr11562242qta.271.1637098069203;
        Tue, 16 Nov 2021 13:27:49 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id j22sm5655991qko.68.2021.11.16.13.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 13:27:48 -0800 (PST)
Date:   Tue, 16 Nov 2021 13:27:45 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        live-patching@vger.kernel.org
Subject: Re: [PATCH 20/22] x86,word-at-a-time: Remove .fixup usage
Message-ID: <20211115230737.27gqnzwvkaxoi7es@treble>
References: <YYov8SVHk/ZpFsUn@hirez.programming.kicks-ass.net>
 <CAKwvOdn8yrRopXyfd299=SwZS9TAPfPj4apYgdCnzPb20knhbg@mail.gmail.com>
 <20211109210736.GV174703@worktop.programming.kicks-ass.net>
 <f6dbe42651e84278b44e44ed7d0ed74f@AcuMS.aculab.com>
 <YYuogZ+2Dnjyj1ge@hirez.programming.kicks-ass.net>
 <2734a37ebed2432291345aaa8d9fd47e@AcuMS.aculab.com>
 <20211112015003.pefl656m3zmir6ov@treble>
 <YY408BW0phe9I1/o@hirez.programming.kicks-ass.net>
 <20211113053500.jcnx5airbn7g763a@treble>
 <alpine.LSU.2.21.2111151353550.29981@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2111151353550.29981@pobox.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 01:59:36PM +0100, Miroslav Benes wrote:
> On Fri, 12 Nov 2021, Josh Poimboeuf wrote:
> 
> > If the child schedules out, and then the parent gets patched, things can
> > go off-script if the child later jumps back to the unpatched version of
> > the parent, and then for example the old parent tries to call another
> > patched function with a since-changed ABI.
> 
> ...
>  
> > I don't know about other patch creation tooling, but I'd imagine they
> > also need to know about .cold functions, unless they have that
> > optimization disabled.  Because the func and its .cold counterpart
> > always need to be patched together.
> 
> We, at SUSE, solve the issue differently... the new patched parent would 
> call that another patched function with a changed ABI statically in a live 
> patch. So in that example, .cold child would jump back to the unpatched 
> parent which would then call, also, the unpatched function.

So if I understand correctly, if a function's ABI changes then you don't
patch it directly, but only patch its callers to call the replacement?

Is there a reason for that?

-- 
Josh

