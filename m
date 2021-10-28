Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8277143E9CF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 22:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhJ1Uoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 16:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhJ1Uog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 16:44:36 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680AEC061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 13:42:09 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p18so1981361plf.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 13:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mb/mWw8HAiK6lwVPCHL9I1kcRE7UYBim01+6DNM+U2o=;
        b=VmGwAq85nazzr23K6C1YnUPNR0Nc4o4CCUMv8SS811F81xRod2iIlDfsYm9jQL6wGo
         OkDnRt0mjseEgenzNWKb4WcrDpZQj633Qwjjvc08WOiptim/r+0uHf/uftiGGWXghcju
         CiY/p5U300wCXKVlPjGWpByMryqXfSRBHBlhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mb/mWw8HAiK6lwVPCHL9I1kcRE7UYBim01+6DNM+U2o=;
        b=4CFgZ1/2DzgDxWPExbKikeFDJ3/pNGWtV/lKkT2IkRTSbZNQZWD3XZwqC6YasHiyjs
         VKKamBE+7OXExxaI998xo3yfaPjHz5ZfXQwg9wZSMPk43Dwfs/Sbr301PIlt1tkg3DEB
         6oJ+yjH+jJaa8nvetmtpmwiAaDF+ApCa2EQq5ksOirty0xS3CeKi+gS5J3Zk2CHCvnIN
         7WOhXNZDyPleSx+QQuXLh4T//rt52rJWb9t6/rHkHDWSemeOZ1sc5EAx67FLha0VFy0F
         8sNuaoMtHN3X+wnqWBfT1UYn/gNGfc9MkA4RKiMg/ctr4CWTBKamkMAA7S4opOsGEu9r
         i+tA==
X-Gm-Message-State: AOAM5324aQtMTXt9AdANUWzb72QPQuItIgSYJSTTriHu/87yf/yBMNPq
        e4RKtgvqJNkVjDRM7SqjCVcxsg==
X-Google-Smtp-Source: ABdhPJyacBcVTIrxQhqzTVhzpHTjk/+EXzvPVleAxcwhFltK0MGOmvy8hS1Z3zuaGutm0mZ0uPb2YA==
X-Received: by 2002:a17:902:a412:b0:140:a4a:4ba with SMTP id p18-20020a170902a41200b001400a4a04bamr5906072plq.52.1635453728984;
        Thu, 28 Oct 2021 13:42:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 125sm4230631pfv.155.2021.10.28.13.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 13:42:08 -0700 (PDT)
Date:   Thu, 28 Oct 2021 13:42:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chomium.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kasan: test: use underlying string helpers
Message-ID: <202110281341.8479EC4759@keescook>
References: <20211013150025.2875883-1-arnd@kernel.org>
 <b35768f5-8e06-ebe6-1cdd-65f7fe67ff7a@arm.com>
 <721BDA47-9998-4F0B-80B4-F4E4765E4885@chromium.org>
 <20211028131526.d63d1074a8faa20e1de5e209@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028131526.d63d1074a8faa20e1de5e209@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 01:15:26PM -0700, Andrew Morton wrote:
> On Thu, 14 Oct 2021 19:40:45 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > 
> > 
> > On October 14, 2021 1:12:54 AM PDT, Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:
> > >
> > >
> > >On 10/13/21 5:00 PM, Arnd Bergmann wrote:
> > >> From: Arnd Bergmann <arnd@arndb.de>
> > >> 
> > >> Calling memcmp() and memchr() with an intentional buffer overflow
> > >> is now caught at compile time:
> > >> 
> > >> In function 'memcmp',
> > >>     inlined from 'kasan_memcmp' at lib/test_kasan.c:897:2:
> > >> include/linux/fortify-string.h:263:25: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object (1st parameter)
> > >>   263 |                         __read_overflow();
> > >>       |                         ^~~~~~~~~~~~~~~~~
> > >> In function 'memchr',
> > >>     inlined from 'kasan_memchr' at lib/test_kasan.c:872:2:
> > >> include/linux/fortify-string.h:277:17: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object (1st parameter)
> > >>   277 |                 __read_overflow();
> > >>       |                 ^~~~~~~~~~~~~~~~~
> > >> 
> > >> Change the kasan tests to wrap those inside of a noinline function
> > >> to prevent the compiler from noticing the bug and let kasan find
> > >> it at runtime.
> > >> 
> > >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > >Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > 
> > How about just explicitly making the size invisible to the compiler?
> > 
> > I did this for similar issues in the same source:
> > 
> > https://lore.kernel.org/linux-hardening/20211006181544.1670992-1-keescook@chromium.org/T/#u

This is already fixed in your tree with:

"kasan: test: consolidate workarounds for unwanted __alloc_size() protection"

which was based on this original patch (and my comments).

-- 
Kees Cook
