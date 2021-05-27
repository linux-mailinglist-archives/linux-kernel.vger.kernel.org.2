Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEEC0392518
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 04:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbhE0Cx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 22:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbhE0Cx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 22:53:28 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B0AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:51:54 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p39so2517213pfw.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 19:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D9m5HFb8leU14rBoJH9HeAj1juzBFPxGY68vNNZoXG4=;
        b=wZSqNswK/P2AvhAXVxEiPlPd82P/u3CpBa+URRl8gUOd/uTQBUmqez9UTX+WVrmljj
         NNcEEhmYVqoJhf+zGwYR1/p8U5/ihpeoPlry0a9pVvtgjJsSaotA5vFNn0EngVsxkyOA
         8KqAxwpm3tL9+JcDtZEhEloBxAirq1hXuYna8wPjANCNozx+obu5sja3mouDIkPtptmk
         zP81cJejXTpVQsLWuW3YUEw2I1bH9aJDIQhCOVoLGl6rWjqXHDb97aEwiTwpir4VZ3U0
         XW8tPjUjvvZGqOHHJz3ZZqNVOK+bcpBY3UHB+/7sCc+RN2cje+QtINuQJJslx3vKmK+s
         1GpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D9m5HFb8leU14rBoJH9HeAj1juzBFPxGY68vNNZoXG4=;
        b=dQ9XsHu3IfU/Qhm9wNinJjQ/yPPevWl/0ge7HKw8SowMtZ1xIEeAxKAbVr/I/scX8I
         KEdna1bKzWZ8IEvwrH2R8Tw33oJa7FGMtqeWBE8XaBJVMx3UNH1DjGzt0WGTcwWHdGuz
         4VC82CDwEbJF+k8WmMbJYIpU3TGtpNzuDQQdnd3mWjitF+JCBnlMwgo/WMXwS+JNrm8a
         vTzingODu1sFlDnQMLxdal1n7Crd/EB5r0KHi5KWojl0o4nDK9dFMEueerBYU3/l7kgW
         ZB+7CEUT9xyhAfla1GpCSw7/pjeUoNSb5IrWoX3G2KOQMVdjcAxmdCS3FhBNMBdrysPj
         C+WA==
X-Gm-Message-State: AOAM532JXQnZM2H8YlKKItPzFqCQS61GTf1d1AZOphblLjjH9htqZXe9
        3s8dDOzQ/5DRZmwh/gBCgoLw6FUSFY62w1t+WzHV1w==
X-Google-Smtp-Source: ABdhPJyxcexXsugE1m+I8Rfx9Y6j9VCWne3erTHCHADhrzsKsFule1A+ScJsVC/GsrhNUUrN2wN4AEHdhEYR6RvpiGE=
X-Received: by 2002:a63:6547:: with SMTP id z68mr1591428pgb.341.1622083914474;
 Wed, 26 May 2021 19:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210526025625.601023-1-swboyd@chromium.org> <20210526025625.601023-2-swboyd@chromium.org>
 <CAMZfGtVdzwjJLuUvcmgivKZNU1TK+ePFH9wgcm6jH86FWFHbJA@mail.gmail.com>
 <d6a4c360-0bbc-e36f-0824-04562c92f411@suse.cz> <CAE-0n512-XLKetgOo61reSBu=27zTttC1YK2iRjNuGrLBu+q5w@mail.gmail.com>
In-Reply-To: <CAE-0n512-XLKetgOo61reSBu=27zTttC1YK2iRjNuGrLBu+q5w@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 27 May 2021 10:51:18 +0800
Message-ID: <CAMZfGtW9yp60p=wTob3oX2Gasy7a9RQPoCuV85zHA=kjCA8mUA@mail.gmail.com>
Subject: Re: [External] [PATCH v2 1/4] slub: Restore slub_debug=- behavior
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 4:20 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Vlastimil Babka (2021-05-26 03:39:54)
> > On 5/26/21 6:04 AM, Muchun Song wrote:
> > > On Wed, May 26, 2021 at 10:56 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > >>
> > >> Passing slub_debug=- on the kernel commandline is supposed to disable
> > >> slub debugging. This is especially useful with CONFIG_SLUB_DEBUG_ON
> > >> where the default is to have slub debugging enabled in the build. Due to
> > >> some code reorganization this behavior was dropped, but the code to make
> > >> it work mostly stuck around. Restore the previous behavior by disabling
> > >> the static key when we parse the commandline and see that we're trying
> > >> to disable slub debugging.
> > >>
> > >> Cc: Vlastimil Babka <vbabka@suse.cz>
> > >> Fixes: e17f1dfba37b ("mm, slub: extend slub_debug syntax for multiple blocks")
> >
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> >
> > >
> > > Is it caused by the commit ca0cab65ea2b ("mm, slub: introduce static
> > > key for slub_debug()")?
> >
> > Yep, looks like a better Fixes: candidate.
> >
>
> Fixed it. Thanks.

With that fix. Please feel free to add:

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
