Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C935534EB67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhC3PAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhC3PAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:00:17 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5975EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:00:17 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f10so11888958pgl.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/qq9/gIIEeXADeexes6T1XgVO8U+5a7euiGrNKdM3Sg=;
        b=bm/Eg6NESu4elfE4WuREbNTQh+xPdY09j3P9cbjk4TTNFOgL/jkCa7tV/Lljy4c3bW
         Px6TiZpZ/QxtVpxrnRmwEePpwNYlNZLO68NpfDPtooB2P3ONyUY8sZHZH9mqBUoyGd31
         uogFdNYOktS/c11AEHMM7Z31uiZQQS9EO/HrmSM5qghr4qIdiXFMriAoR7VDbkc8q9pi
         s8XrP3cP4GdA0tRvWzR2wfU2YsL+P/qQrTL75k6GlFZuEHj9UoCSmx1cKDrPAvXZpLZK
         bY5L8GHG12vsK2/njEz2Cs3c/KHVr5iJGGoSVSzZWtHVpgDQorvftY2Gdi+ed4513iDh
         nOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/qq9/gIIEeXADeexes6T1XgVO8U+5a7euiGrNKdM3Sg=;
        b=AsoJJVmaWV/QFdiDjjVRBEpHgiYvGgYYM/oCxzJUn7stuCH2i10XDN/5hB+0pZOXrD
         XDuI5kkvTw8FnaPTmxKQ1vL7fafU+e+GBjAc74dPfhdYBn4c1qR6aHJTeeS4QFwAdj6v
         ScvjaI4WqGdCC07pl4zdngNoDtgcAdhrwCnwFYIN6UxVxnnTy593sk4ZlXvrc9nJXWMJ
         zvQic5wPNVq6dFM1gX8RARfCr9dTRFBgCFixfDsFv0QSu2sXqKvew4lZoGP4jNcpOHku
         KbVgmakfZ+zCyJWuOQ/o5WzDfDHlUfO7qu07uR12i5CbomBVlgtSPlsEdfn/SrO9YC8u
         pWtg==
X-Gm-Message-State: AOAM533h+wJc9WSTyShH/WcbjU5l1hHKEs+fmHxlARu7HJBjH6GlUcz9
        Ky9wwmQUHqMfoMX+VRHPH34=
X-Google-Smtp-Source: ABdhPJz0rb7f8RU62drqneEGfK2vP4mE/UKEqmlWC4Af1YhpCwvHdG9jTSIFDMfSpOkQbOBReZFKAA==
X-Received: by 2002:a62:1ad0:0:b029:1f2:c7b3:3039 with SMTP id a199-20020a621ad00000b02901f2c7b33039mr31316429pfa.30.1617116416305;
        Tue, 30 Mar 2021 08:00:16 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:e1ca:cef0:ac9e:7cda])
        by smtp.gmail.com with ESMTPSA id g15sm6600625pfk.36.2021.03.30.08.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 08:00:15 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 30 Mar 2021 08:00:13 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: change size_t to unsigned int for cma_alloc
Message-ID: <YGM8/V7iv3j6JWyx@google.com>
References: <20210329182553.3129234-1-minchan@kernel.org>
 <20210329184431.GJ351017@casper.infradead.org>
 <YGI0sThJjsshpPIR@google.com>
 <6d305211-c956-ad80-5908-703d07fca441@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d305211-c956-ad80-5908-703d07fca441@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 09:58:37AM +0200, David Hildenbrand wrote:
> On 29.03.21 22:12, Minchan Kim wrote:
> > On Mon, Mar 29, 2021 at 07:44:31PM +0100, Matthew Wilcox wrote:
> > > On Mon, Mar 29, 2021 at 11:25:53AM -0700, Minchan Kim wrote:
> > > > size_t in cma_alloc is confusing since it makes people think
> > > > it's byte count, not pages. Fix it.
> > > 
> > > i think it has to be unsigned long.
> > > 
> > > 67a2e213e7e937c41c52ab5bc46bf3f4de469f6e
> 
> Right.
> 
> Fortunately, we don't have such large allocations yet via
> CMA/alloc_contig_range
> 
> > 
> > Thanks for the pinter. I wanted to have the smallest change.
> > The commit leads me to change cma_release, trace_cma_alloc,
> > cma_clear_bitmap and front_contig_range as well.(Not sure
> > we have more. Will check).
> > 
> > Ccing david@redhat.com for upcoming changing free_contig_range.
> 
> While at it, we might want to convert free_contig_range() to eat
> "unsigned long start, unsigned long end" like alloc_contig_range(), instead
> of "unsigned long pfn, unsigned int nr_pages" like alloc_contig_pages() ...

Well, I personllay tempted to change alloc_contig_range, not
free_contig_range because base_pfn with nr_pages was more
straightforward than base_pfn and end_pfn in that we don't
need to tell whether end_pfn is inclusive or exclusive.

When I look at callers of [alloc|free]_contig_range, many of them
already have used nr_pages based approach rather than start_pfn,
end_pfn. If your suggestion come from that "it's *range* API",
I'd like to rename it with "alloc_contig_pages|free_contig_pages".

Since it's beyond the goal of this patch and might be controversial, 
I will not deal with it in this patch.
