Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B22412CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242277AbhIUCvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347496AbhIUCUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 22:20:43 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552F7C1A2E8B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:44:11 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id o66so23407235oib.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=YSVdlrDBVCVVyrsd5P+CkOqJiePqjs/Ib4JDP05yk6g=;
        b=ZsvwpP2v4ozbtgRIFQq2vJIcLOO1oeeC3S05lrMD/GKvbZ+S4hSMMmUSYMlVuhCjTo
         nVqPHY0QCuPSqvt2V+wHAawRZ59em5t9cZhdAxWSuX0oTRZzwLt8mZz49UDQgDV5MYwh
         xp/wPE1UkkV0oCf/ovgIZDgy7DMYX0bVKJr4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=YSVdlrDBVCVVyrsd5P+CkOqJiePqjs/Ib4JDP05yk6g=;
        b=So+ylcu2acdL+XUL55XFzNbvuR4YPZ0SPI8dkHZdNxx2ivw60+KMC654pvOg0j+OEi
         4T2m+ZV2tzduXViKiNlEZUQZ9AxLwy7oxBPG535L+DjaehVy5uTNEtnA+GLozSXy6SB/
         725UYTrF3ajQdTPRApIubwo2OXH8V9NEWJA0N23gi7D3xFBhr68LLhmEdJYbX3BXyEqK
         +oPKmR9f5l8SfD/P0rkkmCFYxwGW1yRMgCqGdaBm/zAFNRpQ/MgT4F7XMx2QRKvPTfZ0
         slAca9uFGX16s3QDa9smVn4oMtYIAai5uIXZqAOfcnILAZ1r7E8CUn2o5qZs/Z5VaMQT
         UpPg==
X-Gm-Message-State: AOAM533WlXwpTjfkaRKP/nGEjoGCbEDMumuiC0sMoweHUlKEMXV3Jtgi
        U78G5l9VdBaCHCumBaTk+FyRNBdHn1dw8HfYsZcr7w==
X-Google-Smtp-Source: ABdhPJzFA3kPFngWBaG5f8xc286I+bRBOt7JpKdDnUJEWKoyraQKD3YnKGLjm2TbXtlTjpItZRz8lboJA8EiJUhytoU=
X-Received: by 2002:aca:3110:: with SMTP id x16mr422958oix.64.1632163450731;
 Mon, 20 Sep 2021 11:44:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Sep 2021 11:44:10 -0700
MIME-Version: 1.0
In-Reply-To: <202109201126.E9902480D9@keescook>
References: <20210601182202.3011020-1-swboyd@chromium.org> <20210601182202.3011020-5-swboyd@chromium.org>
 <202109200726.2EFEDC5@keescook> <CAE-0n50v6Wm2OBsy5-Q3B9VrNhH+_uyDDa8Ps3MeXsCLZczW3w@mail.gmail.com>
 <202109201126.E9902480D9@keescook>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 20 Sep 2021 11:44:10 -0700
Message-ID: <CAE-0n512oUhbfc9Y-8zzUkPTWcVg29W4aVMkc-fC1Y9KMai78A@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] slub: Force on no_hash_pointers when slub_debug is enabled
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kees Cook (2021-09-20 11:28:50)
> On Mon, Sep 20, 2021 at 11:23:01AM -0700, Stephen Boyd wrote:
> > Quoting Kees Cook (2021-09-20 07:29:54)
> > > On Tue, Jun 01, 2021 at 11:22:02AM -0700, Stephen Boyd wrote:
> > > > Obscuring the pointers that slub shows when debugging makes for some
> > > > confusing slub debug messages:
> > > >
> > > >  Padding overwritten. 0x0000000079f0674a-0x000000000d4dce17
> > > >
> > > > Those addresses are hashed for kernel security reasons. If we're trying
> > > > to be secure with slub_debug on the commandline we have some big
> > > > problems given that we dump whole chunks of kernel memory to the kernel
> > > > logs. Let's force on the no_hash_pointers commandline flag when
> > > > slub_debug is on the commandline. This makes slub debug messages more
> > > > meaningful and if by chance a kernel address is in some slub debug
> > > > object dump we will have a better chance of figuring out what went
> > > > wrong.
> > > >
> > > > Note that we don't use %px in the slub code because we want to reduce
> > > > the number of places that %px is used in the kernel. This also nicely
> > > > prints a big fat warning at kernel boot if slub_debug is on the
> > > > commandline so that we know that this kernel shouldn't be used on
> > > > production systems.
> > >
> > > Eeeek. I missed this patch. NAK NAK. People use slub_debug for
> > > production systems to gain redzoning, etc, as a layer of defense, and
> > > they absolutely do not want %p-hashing disabled. %p hashing is
> > > controlled by the no_hash_pointers boot param (since v5.12), and needs to stay
> > > separate from slub_debug.
> > >
> > > Can we please revert this in Linus's tree and in v5.14?
> > >
> >
> > This is fine with me as long as debugging with slub_debug on the
> > commandline is possible. Would you prefer v1 of this patch series[1]
> > that uses the printk format to print unhashed pointers in slub debugging
> > messages?
> >
> > [1] https://lore.kernel.org/r/20210520013539.3733631-1-swboyd@chromium.org
>
> I'd like to keep %px use in the kernel minimized. Seeing full pointers (%p
> hashing disabled) can be done with the no_hash_pointers boot param, and
> that's used in other debug cases as well. I'd rather keep it a global
> knob.
>

Can you elaborate on your use case where slub debugging is used for
security in production systems via redzoning? Maybe that redzoning logic
in slub debug should be moved out of CONFIG_SLUB_DEBUG into slub proper?
Or maybe the config symbol should be changed to something that doesn't
have 'debug' in the name?

The main goal of this series was to make slub debug messages I saw
useful instead of confusing given that all the pointers were hashed. If
some part of slub debugging is production critical then I wonder why
it's behind a debug named config knob and why it prints so much pointer
information on production systems.
