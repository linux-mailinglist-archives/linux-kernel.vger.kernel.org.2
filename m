Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740A036BE30
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 06:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhD0EMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 00:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbhD0EMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 00:12:30 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811ECC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 21:11:45 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w9so7749800lfr.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 21:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xSbYF6YmB+6Po+HsrmYDOpI6TtqeP+AMbaRD22AzlKI=;
        b=iO53A6Zb7PcYh/T3a3JH5aBVwk/mWU8zPtZ8LHjq9CDwqrY+wgUIAUI6GCtNGett3a
         9YOBhkdQdORaqDS3iFyB3RMzMUmhtr2omR3et0XpSA/u3QFySPS5NAea3FD+yBBJfPAz
         XQjxXHd2nMnStBxUsFB3oG8sFNsxdXB79p7s+A7Swiov76ZdY19a2qVwLWKbrX59bmcG
         D/u4diG6TLNnEeBncOIyM/khN/IsvyFRC+hiFBsuNTySOj+dZFhuI2DIQAkc1mt7nkFZ
         NnXMW58mxx50adoY8y2IfFS9jD95YBPJlWezY4lEwImRbZwptzfRBpuSoY6k1auXMGEu
         rTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xSbYF6YmB+6Po+HsrmYDOpI6TtqeP+AMbaRD22AzlKI=;
        b=WBA+Uac9+b2KGvt/v7U34GeJNzem9obZg0001buir+fwb+R4hwFhAffZVB/oqCfxvk
         KcI5u3MHDHI9msVtRYHcn384ZootOz4DHimNCrTII03F4r+9dx3YWN7D9rJi8E1+Mq6C
         fEs/imOhOSIvHG7xWH0xdQw6PQSLxU4Lv8cX+ikZx70GxPGTnf8tTT03WOOFWj+Swupx
         Y7Fo/8VzSFFUli8SH2QPlJCqfzSDPVnVknXm37z82HSrCpn3ar3WhsfwTjlyM/0Ociov
         IyYwT6JzKGyc3FGNgpKSiTsGWjcw26IFrVCj0va6TtD6A1k8QnMkvN/8IXr8I8AXFwr4
         AkxQ==
X-Gm-Message-State: AOAM531OpvTlY8f7vM2OPwO3zx+yPrYqlGDaiK1S/xznOJrSF667uv/U
        x+vesVlmlRJpv2tfzBk1wKl4Zsgl9KgMEhZ/aY8=
X-Google-Smtp-Source: ABdhPJzYfDrrUdy6qUwDE9BULCvak/gZnwodwRAHBNJNzbbB0BEKQTUbuz7dtVc9efTktTYSbkx2W2Cf7qK/GtnjvCk=
X-Received: by 2002:ac2:5042:: with SMTP id a2mr14687807lfm.650.1619496703957;
 Mon, 26 Apr 2021 21:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <1619491400-1904-1-git-send-email-sxwjean@me.com>
 <20210427025358.GV235567@casper.infradead.org> <CAEVVKH_wZJvNAgFEF1OxThxN3AC4mopZ+Pu2GC0Hn_-2JOfC5Q@mail.gmail.com>
 <20210427033632.GW235567@casper.infradead.org>
In-Reply-To: <20210427033632.GW235567@casper.infradead.org>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Tue, 27 Apr 2021 12:11:17 +0800
Message-ID: <CAEVVKH8ZOt3XSPy1VA1n+MKmqucgcnxjusfhoTbwkitOkErrrw@mail.gmail.com>
Subject: Re: [PATCH] mm: append __GFP_COMP flag for trace_malloc
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Xiongwei Song <sxwjean@me.com>, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 11:36 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Apr 27, 2021 at 11:29:32AM +0800, Xiongwei Song wrote:
> > On Tue, Apr 27, 2021 at 10:54 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Tue, Apr 27, 2021 at 10:43:20AM +0800, Xiongwei Song wrote:
> > > > From: Xiongwei Song <sxwjean@gmail.com>
> > > >
> > > > When calling kmalloc_order, the flags should include __GFP_COMP here,
> > > > so that trace_malloc can trace the precise flags.
> > >
> > > I suppose that depends on your point of view.
> > Correct.
> >
> > Should we report the
> > > flags used by the caller, or the flags that we used to allocate memory?
> > > And why does it matter?
> > When I capture kmem:kmalloc events on my env with perf:
> > (perf record -p my_pid -e kmem:kmalloc)
> > I got the result below:
> >      0.08%  call_site=ffffffff851d0cb0 ptr=0xffff8c04a4ca0000
> > bytes_req=10176 bytes_alloc=16384
> > gfp_flags=GFP_ATOMIC|__GFP_NOWARN|__GFP_NOMEMALLOC
>
> Hmm ... if you have a lot of allocations about this size, that would
> argue in favour of adding a kmem_cache of 10880 [*] bytes.  That way,
> we'd get 3 allocations per 32kB instead of 2.
I understand you. But I don't think our process needs this size. This size
may be a bug in our code or somewhere, I don't know the RC for now.

> [*] 32768 / 3, rounded down to a 64 byte cacheline
>
> But I don't understand why this confused you.  Your caller at
> ffffffff851d0cb0 didn't specify __GFP_COMP.  I'd be more confused if
> this did report __GFP_COMP.
>
I just wanted to save some time when debugging.

Regards
