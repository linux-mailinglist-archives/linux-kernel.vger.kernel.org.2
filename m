Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A553FCF70
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 00:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240223AbhHaWIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 18:08:32 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:37554 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhHaWIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 18:08:31 -0400
Received: by mail-ed1-f48.google.com with SMTP id g21so802124edw.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 15:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iiqDg2IJazrjCZh7knpESd4lYmfxjk4NhNOmIuXSw2o=;
        b=Jo6kUNyzYOHivRN1EehQkSk1wmBEbZyOenZ685x4TMKRB+pwcqUkha0PZyaTR0aMy/
         RkzHJDQpVM4LjRH3eSbuB5u6ifpu16PnL0Fn1EkL4UASFUixH6W/QNfaP4V2tQu0Xnvj
         mvFJMoz4KeZNsnlI3PAs+pEtGkQpv5goF/1+jLbZw3Wgx2aVDRAZ4mk0bUEEQb7FSr2Q
         UqKfbqnd2+ojFDV/7RbMkQzq7N2gQrS6IxaaHYrktFMboXoet7aS0kcEvobOfPmVA5A1
         czLlXAyES1WXYuAg7GaLD0Bara6al0poGdXwmGLYmUPntMI1ZVfOBMVNyFRcBwZXny/E
         LZTA==
X-Gm-Message-State: AOAM533PNBKsKLqHsKevJySmCmunm6lu/yTges5RH2OewlYGddMF8qoj
        Cy2QNByCBRVhPMGsEalhbmNWZSTTMAsFkvu3Tus=
X-Google-Smtp-Source: ABdhPJwg7H/ekAtx80usOC6IeDVn6PsZ4UWG6w/201xh65/2dGIBeFF1fNty3rmbeyHRFYl11sTGHMvNbdTnrYAwbRo=
X-Received: by 2002:a05:6402:445:: with SMTP id p5mr32307788edw.208.1630447654736;
 Tue, 31 Aug 2021 15:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-13-chang.seok.bae@intel.com> <YR00U19168BGoRB9@zn.tnic>
 <CAJvTdKn09GiAOgdsOR-+ooEO=bmj8VDL9e9sSAsu2UPx73a-Mw@mail.gmail.com> <YS0bAPaDGcDKftUp@zn.tnic>
In-Reply-To: <YS0bAPaDGcDKftUp@zn.tnic>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 31 Aug 2021 18:07:23 -0400
Message-ID: <CAJvTdKm=mPQUhJax-UietFFELOuHn89he6FPNb5jUC_Mcdc_rw@mail.gmail.com>
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thiago Macieira <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 1:52 PM Borislav Petkov <bp@alien8.de> wrote:

> Well, if you preallocate everything...

Nothing prevents, say, a pthread_create() or anything
else where the kernel consumes memory on behalf of a process
from failing at run-time...  AMX does not add a unique OOM risk here.

> > The advantage of the #NM over the syscall is that the programmer
> > doesn't actually have to do anything. Also, transparently allocated
> > buffers offer a theoretical benefit that a program may have many
> > threads, but only a few may actually touch AMX, and so there is
> > savings to be had by allocating buffers only for the threads that
> > actually use the buffers.
>
> The program already asked the kernel whether it can use AMX - it can
> allocate the buffers for the threads too.

The result is that if one thread in a 1,000 task process requests
and touches AMX, the kernel would allocate 8MB, instead of 8KB
of context switch buffers for that process, no?

Len Brown, Intel Open Source Technology Center
