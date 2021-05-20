Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E4A38B5F2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 20:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbhETSZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 14:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbhETSZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 14:25:39 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E66FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 11:24:17 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id c10so13474949qtx.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 11:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1s5Dsz7vse2deNA6SMMU0kbqW1ES7IG9klI1lUdnBBg=;
        b=du0uGiNN2aHIPskO4+egQDuFjF5ZSMIfrhxJ+iadWI9R296iYrT38J52IC2ujD5NdY
         h+vjjfif5YPHTpE3DTMzDGW2QCGbAzAObnnGomtCi0UlrOFGj236Kfa1Wg5b1YmEKT3T
         2iNv31ww8xbEL3g/qzTDJ8TOgdo4VQNpQiyrHzPyVumdX/8zw3iMjMbXaO8LRSicsjud
         XYaSIty6Bc8gh4J9JMH1T3DBUloVYJ0i+mOEnA1075zWs2W0UusWppqhoMlon4GKTLlm
         CvK/wTiTRHy6LHPE+SEqvCtI3ZkW5jauwebD8pSR5hPZ4MLo/Izc3MT6g87+h5GrQxT8
         EasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1s5Dsz7vse2deNA6SMMU0kbqW1ES7IG9klI1lUdnBBg=;
        b=jCNY58rv2WFPAHVP2aweEOI0UNVCURq9PlmAx854bmsak8m1boxu1b1xB43oZIgzR8
         7bHqTZorjIPp3uYnkGZjp5o6Pa6PByeUaePszUlj6AJERrG697h6Ck9Kv1rNiBFz6iMV
         xp98y1IWH7/yvbp08hE6wY9YR2Bry2ex6h3NmZqpt823hSdQbcdOp1OkpNA+8xocP9Qn
         xVFgGUGrlXakigq0jCxdW5o90TyQQpcSSPDjKG3K962XrsUWDHokyo+w7GfQ9kCI1d6p
         zlfY6zCA66S7XyufilNhL/DL5uaEmD1r5HiyX3rjVjIDBURO0LusRNauftPw5RKXguVc
         +L/g==
X-Gm-Message-State: AOAM531qJ2V+8v7Lr/lbvjipD/XUkHc41xVrtXLA/wGUL6/5c70Z690/
        t/U2a9aH4t9VqFKqyAN5a/5vA0Gpb5BWUPeMolgxtybB9sQEBA==
X-Google-Smtp-Source: ABdhPJzQIqydEluuiZ+gsCfR8EoFruiir97R4iNWc7F9aFJDAu0Uymbr2sq3UpFFgzWq0x40zB+qmsHAP9fwKKABJwk=
X-Received: by 2002:aed:3169:: with SMTP id 96mr6689774qtg.164.1621535056348;
 Thu, 20 May 2021 11:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210430150438.GA57205@C02TD0UTHF1T.local> <20210520151854.3632129-1-derrick.mckee@gmail.com>
 <20210520160035.GP17233@C02TD0UTHF1T.local>
In-Reply-To: <20210520160035.GP17233@C02TD0UTHF1T.local>
From:   Derrick McKee <derrick.mckee@gmail.com>
Date:   Thu, 20 May 2021 14:24:04 -0400
Message-ID: <CAJoBWHyUkP4nkgxHJAZr+291GLy2UCOhC-cn=ez416N4xWSk=w@mail.gmail.com>
Subject: Re: [PATCH] Ensure kernel AI key is not changed on fork
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Nathan Harrison Burow <Nathan.Burow@ll.mit.edu>,
        Yianni Giannaris <yiannig@mit.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 12:00 PM Mark Rutland <mark.rutland@arm.com> wrote:

> On the kernel side, we use a unique IA key per kernel thread, and while
> this must remain the same *for that kernel thread*, the kernel IA key
> should differ across kernel threads when a fork() occurs.

Thank you for the clarification.

> I think you're trying to use the keys in a different way than upstream
> intends to, and we do not need this change as-is.
>
> So NAK to this patch as it stands.

Given the above discussion, I agree with the NAK.

>
> > ---
> >  arch/arm64/include/asm/pointer_auth.h | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
> > index d50416be99be..9748413e72fd 100644
> > --- a/arch/arm64/include/asm/pointer_auth.h
> > +++ b/arch/arm64/include/asm/pointer_auth.h
> > @@ -69,10 +69,13 @@ static inline void ptrauth_keys_init_user(struct ptrauth_keys_user *keys)
> >       ptrauth_keys_install_user(keys);
> >  }
> >
> > -static __always_inline void ptrauth_keys_init_kernel(struct ptrauth_keys_kernel *keys)
> > +static __always_inline void
> > +ptrauth_keys_init_kernel(struct ptrauth_keys_kernel *keys)
> >  {
> > -     if (system_supports_address_auth())
> > -             get_random_bytes(&keys->apia, sizeof(keys->apia));
> > +     if (keys->apia.lo == 0 && keys->apia.hi == 0) {
> > +             if (system_supports_address_auth())
> > +                     get_random_bytes(&keys->apia, sizeof(keys->apia));
> > +     }
> >  }
> >
> >  static __always_inline void ptrauth_keys_switch_kernel(struct ptrauth_keys_kernel *keys)
> > --
> > 2.31.1
> >



-- 
Derrick McKee
Phone: (703) 957-9362
Email: derrick.mckee@gmail.com
