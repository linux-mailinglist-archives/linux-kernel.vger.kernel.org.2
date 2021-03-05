Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE3E32E410
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 09:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhCEI6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 03:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhCEI6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 03:58:12 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEE8C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 00:58:11 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id z190so1231236qka.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 00:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=229AXg85Pog+hgsT/zw/Y21FmddYbB2y/IxgWdPynj4=;
        b=POZV7tLmJDkKZQeFDC7/oKLuDHMWEOfI4OYkqUcKyWEv1vcyzHKMTPF1VzZ/7d4wvd
         4vLV3OBwIDUaFHmxcV3uwkpaZUrZVzMy5LyuBLuQBNhvMk4oKFvMaYN1YXsmp2N4MJE3
         /F3J7Z3Xa3/arvgoRyXAx6dNu8h0T0X4nrWkSE261B+NIDBeK43KgpS4cJsAm6HUIt24
         1/QZ0h3ZaToGboUaTlnV1clvJPNzb6XGjePk4kQJYhI8+3l5KRaQaklqpxecofVY9Ukr
         2xI3aAHgc5GkntSAnlrX13gwl5AacnxCw3L0lL3bD1D2K9yL4H6AofIjNJpUJZ/6ZiVV
         yr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=229AXg85Pog+hgsT/zw/Y21FmddYbB2y/IxgWdPynj4=;
        b=qDJeb+DgSkUsOQqZtd1xmY11eKXKRhad1ssfm5y2Jm+B8Vsb7EdoFR0TLBpsKMCCfz
         1XfbJYCNILEZWA69f9xuuqMGyb03kYrUtDdAv7p3uLg4sMMvtatFUcOjVFIZ6WlAGZmV
         vc8RmxNhiAueYirmuK5VoVjNT+kjMP6dsdpxa+Ur/UBws7md3pPDa0f1C8NPGD9W+ICD
         sSEjUodGcplg1Vpfq3kEenRgQJn/PTMSbOGEt5LZ5qV9+0Bk+W1uZKDUbMIHVBAsFSA5
         MhMH7kYE1AwGJiAOqKOdHa3OxPPMH8LS94WvK4i9IFSmc4xLNEMD5jzBwCRfzUdhZbGF
         wOfg==
X-Gm-Message-State: AOAM5305u8NthTyxvEkaKvxw3jPLAqxWAjIkfDjqOokXhCVALsAiugcF
        xj24PMh0NQqrDvIrpjKpkrVdFOPtiUqj+5s3l/6M3A==
X-Google-Smtp-Source: ABdhPJxfVndZMBttXrZUePQ54he8IGrHNhocsLR4F26Lt5PGY6NiSB6pmBKZYkQzPOHBoj9T6lpZQCYZvHQqY4q2O8E=
X-Received: by 2002:a05:620a:1353:: with SMTP id c19mr8364887qkl.392.1614934690350;
 Fri, 05 Mar 2021 00:58:10 -0800 (PST)
MIME-Version: 1.0
References: <20210304205256.2162309-1-elver@google.com> <CAG_fn=XVAFjgkFCj8kc6Bz4rvBwCeE4HUcJPBTWQcNjrBLaT=g@mail.gmail.com>
 <20210304173132.6696eb2a357edf835a5033ee@linux-foundation.org>
In-Reply-To: <20210304173132.6696eb2a357edf835a5033ee@linux-foundation.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 5 Mar 2021 09:57:58 +0100
Message-ID: <CAG_fn=Um2FW2m9y0iZ6J4L63-2bBVVrgu3hMQ0-GLwHxU6Hiiw@mail.gmail.com>
Subject: Re: [PATCH mm] kfence, slab: fix cache_alloc_debugcheck_after() for
 bulk allocations
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitriy Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 2:31 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 4 Mar 2021 22:05:48 +0100 Alexander Potapenko <glider@google.com> wrote:
>
> > On Thu, Mar 4, 2021 at 9:53 PM Marco Elver <elver@google.com> wrote:
> > >
> > > cache_alloc_debugcheck_after() performs checks on an object, including
> > > adjusting the returned pointer. None of this should apply to KFENCE
> > > objects. While for non-bulk allocations, the checks are skipped when we
> > > allocate via KFENCE, for bulk allocations cache_alloc_debugcheck_after()
> > > is called via cache_alloc_debugcheck_after_bulk().
> >
> > @Andrew, is this code used by anyone?
> > As far as I understand, it cannot be enabled by any config option, so
> > nobody really tests it.
> > If it is still needed, shall we promote #if DEBUGs in slab.c to a
> > separate config option, or maybe this code can be safely removed?
>
> It's all used:

Got it, sorry for being too hasty!
