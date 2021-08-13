Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B2F3EBC93
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 21:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhHMTeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 15:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbhHMTeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 15:34:08 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5758EC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 12:33:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso17440176pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 12:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KzcsNenF8dXOGQSBNs6EZcHNFmBVObd7GPXf/XX1Dlo=;
        b=LeeC8ATq8yx1DilhzoKmodV0apQswrvt2IFmSsds+CBLGPmZHeHm3wk0sSYqmHJq0Q
         WjOdXacTvo/13e05ACskRGJD5Gli8autrBIMD4HpEmdS00Qv9eAUO1jNO6ant6HkAXvn
         sYf31zwr6KwCPusN/8j6sRU004I7hpRnpCFZN3avrUsZz/Z+7ejly4Rw0KCdNEtxVNqj
         Ztw58COUwJoc4IFYrqO4hPryT498krXEO4+PQOREOy4kQ2/B3lKMiDlZMxD1BPjD1Yp/
         xjShlOasA3/8rbcbOE0MIui1sGhNOrh6KUnHheRi3btFGDeZYe8SdFbOGvtDtjaMbOoL
         bHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KzcsNenF8dXOGQSBNs6EZcHNFmBVObd7GPXf/XX1Dlo=;
        b=neI2sabsyGukfhrstpMDyyTcc5gvwuFdALNNeK3zkwzNSWS5hWe9nllCsJU8fIdReC
         yebKWP19KpNPrR36qwv8BQ/RA23FOIyG1sQ13B1rz9Y6lYWC2hxs2UGWE0EqsyowbBO6
         SIjBQ8XSCi6Ngh4HT/Me1qbdDhebKUuEAZA7C14/PaXfcyU4Vqad4QIJsk8oEQBGoQ8U
         6bfFhmwx/viMleAoDFymacGtcOE89me4NrbMVQmDmE9bVVlJd37d+dKJN4kGOWSh8xUE
         pvMjPs6bexO68j7FhQmW64xQyEcADKKqQgPXOFEyG/YV0DJfde8O28nBejroZovcwZNW
         m6RQ==
X-Gm-Message-State: AOAM533DmZf8UcqNQtloPpZ9QfjAChS5+GltoMGCe8CkKEbFjrXBKET6
        MGT6OXaKT3fl+tQo3es4ErTzl3IlxtIHK2nqge0=
X-Google-Smtp-Source: ABdhPJz5H5IvnjztYIcFisFbZlnQPRayhaGO8Jx3RhC1jTBda3KzOMeJ5fvll+QWpe96r2ODxz3kxU+G3Oh1IUaivAw=
X-Received: by 2002:a17:90b:33c5:: with SMTP id lk5mr4136087pjb.129.1628883220907;
 Fri, 13 Aug 2021 12:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210813151734.1236324-1-jim.cromie@gmail.com>
 <20210813151734.1236324-4-jim.cromie@gmail.com> <YRaU6fbGjcV7BGC/@smile.fi.intel.com>
 <CAJfuBxzkWuK-Xh-2gynmLeHx+gb6bwhbKTG02pydYvQzNBiPjA@mail.gmail.com>
In-Reply-To: <CAJfuBxzkWuK-Xh-2gynmLeHx+gb6bwhbKTG02pydYvQzNBiPjA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 13 Aug 2021 22:33:04 +0300
Message-ID: <CAHp75Vf5ZGg77OSXSbL8b03g41AKUUtaXwcEEqFXtSvV2aubmQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/9] dyndbg: add DEFINE_DYNAMIC_DEBUG_CATEGORIES and callbacks
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 8:54 PM <jim.cromie@gmail.com> wrote:
> > > There is still plenty of bikeshedding to do.
> >
> > > ---
> > > v4+:
> > >
> > > . rename to DEFINE_DYNAMIC_DEBUG_CATEGORIES from DEFINE_DYNDBG_BITMAP
> > > . in query, replace hardcoded "i915" w kp->mod->name
> > > . static inline the stubs
> > > . const *str in structs, const array. -Emil
> > > . dyndbg: add do-nothing DEFINE_DYNAMIC_DEBUG_CATEGORIES if !DD_CORE
> > > . call MOD_PARM_DESC(name, "$desc") for users
> > > . simplify callback, remove bit-change detection
> > > . config errs reported by <lkp@intel.com>
> > >
> > > ddh-helpers
> >
> > > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> >
> > So, it is signed or not? I didn't get (perhaps due to misplaced changlog?).
> >
>
> It might be my --- snip, and reliance on format-patch -s
>
> would it work if I used --  2char snip ?

The right thing to do is to have

SoB ...
'--- ' line
Changelog is _here_


-- 
With Best Regards,
Andy Shevchenko
