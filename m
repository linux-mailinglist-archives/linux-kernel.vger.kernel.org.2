Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D8E43885C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 12:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhJXKqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 06:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhJXKqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 06:46:05 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C498C061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 03:43:45 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so9121212pji.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 03:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sVuIY4mcHQg8bRsDb3qKWmU0qyXXyyXmkLA+IGN0NwI=;
        b=HEjJqVTIQNzw08DhBqCfv+tW3y6hCDtv1GvmKg3QOHTIfhe1FL9g/e1ZjnLddvJjN4
         cwQtsosJFODLfGm7u+V7ej5df/zRxGXg/wxHL8IMMHtwtVj/gphJcL68Lo7nWmILcvi3
         d1ruUsyRY9aly2b9b2o3F3OVOf8vC7KUcmRzmf5ociYzHE24aGYI/slBxkFl3Lrb7u0N
         MtPnGMvWA9jwqxoPC+WiczNT2ttB2eLe46AWNMjqhcTJ1Uz3Te+qvzKu4FDZI9Ey2LuH
         wYAJ1iQbrCJ7W62k/mECx43Z75DWdTS3nhYJ99xO3nzyXN6ryHS2U92T+5D25wB17j8n
         uh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sVuIY4mcHQg8bRsDb3qKWmU0qyXXyyXmkLA+IGN0NwI=;
        b=ioSUJu4AbwnoAx0Og7E6FtiDQgZreglkh/Y2HhN1hHGRmhBm3/XSvXa7OfBfBxQSgf
         up1fPFVP3I0QITiGytMXMc4CBLty8x8bc+Ha+pmu0TW6PI9QjUkokszgmpHRdgC37HZE
         7Vz+6rhRZVDMJrMZtO1Jq6Qh1B0j77QOPt/ppb2uexMG5eEL8hUXrALVJ2EJDuC3N1gB
         QvjwrJTVK4f1QpYmwHGNnF0pwYbKPvSk/FWmoVSmotj5fCgnIiT74S/dub36AIdhePYA
         CFAvYJuRqNPpN29vOG/+U6urO8M9derzEbMDwZTNtDUkFnZF502yKE+oByOY4HwigTfv
         OPdQ==
X-Gm-Message-State: AOAM531lNlSTFhvI7kqtst29lQDVJOrW/8VYu31/iqEdDSePCTiieB3q
        daXvwaOFVN2AltzmfqZ8itw=
X-Google-Smtp-Source: ABdhPJyOIMQKGc3n2+20uwpIqtCRlI0hZrSZ9mGL8vhus4eKnJL8qGsXCf/9i9We2/E3xf13XaWXqQ==
X-Received: by 2002:a17:90a:c088:: with SMTP id o8mr8215040pjs.1.1635072225230;
        Sun, 24 Oct 2021 03:43:45 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (220.195.64.34.bc.googleusercontent.com. [34.64.195.220])
        by smtp.gmail.com with ESMTPSA id w5sm13043690pgp.79.2021.10.24.03.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 03:43:44 -0700 (PDT)
Date:   Sun, 24 Oct 2021 10:43:40 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Rustam Kovhaev <rkovhaev@gmail.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, djwong@kernel.org, david@fromorbit.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        dvyukov@google.com
Subject: Re: [PATCH] slob: add size header to all allocations
Message-ID: <20211024104340.GA4370@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20211015005729.GD24333@magnolia>
 <20211018033841.3027515-1-rkovhaev@gmail.com>
 <20211020114638.GA378758@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <1dfb7a79-3e66-a9fe-ee7c-1277d7ff5950@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dfb7a79-3e66-a9fe-ee7c-1277d7ff5950@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 07:36:26PM +0200, Vlastimil Babka wrote:
> On 10/20/21 13:46, Hyeonggon Yoo wrote:
> > On Sun, Oct 17, 2021 at 08:38:41PM -0700, Rustam Kovhaev wrote:
> >> Let's prepend all  allocations of (PAGE_SIZE - align_offset) and less
> >> with the size header. This way kmem_cache_alloc() memory can be freed
> >> with kfree() and the other way around, as long as they are less than
> >> (PAGE_SIZE - align_offset).
> > 
> > Hello Rustam, I measured its impact on memory usage on
> > tiny kernel configuration as SLOB is used in very small machine.
> > 
> > on x86 32 bit + tinyconfig:
> >     Before:
> >     Slab:                668 kB
> > 
> >     After:
> >     Slab:                688~692 kB
> > 
> > it adds 20~24kB.
> 
> Thanks for the measurement. That's 3.5% increase.
> 

You're welcome.

> > 
> >> 
> >> The main reason for this change is to simplify SLOB a little bit, make
> >> it a bit easier to debug whenever something goes wrong.
> >>
> > 
> > It seems acceptable But I wonder it is worth to increase memory usage
> > to allow freeing kmem_cache_alloc-ed objects by kfree()?
> 
> Not for the reason above, but for providing a useful API guarantee
> regardless of selected slab allocator IMHO yes.
> 

Mm.. that means some callers free kmem_cache_alloc-ed object using
kfree, and SLAB/SLUB already support that, and SLOB doesn't.

In what situations is freeing using kfree needed?
Wouldn't this make code confusing?

> > Thanks,
> > Hyeonggon
> > 
> >> meminfo right after the system boot, without the patch:
> >> Slab:              35500 kB
> >> 
> >> the same, with the patch:
> >> Slab:              36396 kB
> >> 
> > 
> 
