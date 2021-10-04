Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3CF4204A1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 03:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhJDB1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 21:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhJDB1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 21:27:19 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3969C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 18:25:31 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id rm6-20020a17090b3ec600b0019ece2bdd20so2994781pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 18:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=mroagGZ15tDNkaQrtQcB9E+cIqRY9GAKuA9U/CUyqV0=;
        b=lM/c+5OjZi5Lhe/KYRWElS1YYl9GUQoUs9NulLvb0SIVfStU7egPomPz30W/iAP2Na
         n6Q4yfFXyw8xR1Y+ieRuYL/3gkG1168fdVceS/78ftEaUj/ENm5Smc5mr22/DAU+iyoE
         EQAPupCp/quwAEMem5GHXi+MCIhnXXSx69d6QTzWEqVP2QkyuEg8XJOxMclYfx/kmKe9
         /wvmc5axacXD1B8jJKGPCoB++0Q2tW31XFr7K2h2l3Ui13s7GEN0+rhn8z83Yb/rbgMC
         SkO8ZPbxwWiAAOYO9/lIjfHKMWPXQFomt4bEO+nk+FIyaXYa68gQd3sehiQB8/xQLWR1
         rIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=mroagGZ15tDNkaQrtQcB9E+cIqRY9GAKuA9U/CUyqV0=;
        b=ulpMT1R5sDMfNQERFliXCioth5pn2Ws184pT8O2pJJH85hEVLQ8a0N1Gxz8qO0UHRW
         zK+kPARh9ElJUR9xXPx+ghADoO7NV8PPVAKiuQlwj0ZVK1Ytw24GNS4JJ4byqHgpytm6
         ay/awBfZdwMXRhzX9TEJSpesBU2nVWHwJ2gqA9tXSVYWqJWAwWlEZEz8OiyjqM7Yjp/w
         +oxbmpFwzpAJt1n85OtDwjBd78xXiGMl8cK1o36JS8Bw/weJDmsw1mYdAetLu6gslhQs
         VYSs3UTTqBCXONe64CWzRzgDQ3XrjavYjNQjRVnabszy7EFjJUF2FTfcP0W9WBUJaEmG
         7OHA==
X-Gm-Message-State: AOAM533agfmAjXKSk9AhlgK4V1ZrCGEPzO3w29HABPMAnjdWZ2EJENBL
        u58rV23TczqayXh7TyP5zuj42A==
X-Google-Smtp-Source: ABdhPJwX0TMxB9WjoR2rdxr47tV4Gcqfc0JkH9XfFGmVKGqjwYqnMaz+IUrMRJxWOBPvQb2g1cm4fw==
X-Received: by 2002:a17:90a:bd08:: with SMTP id y8mr27196650pjr.123.1633310730863;
        Sun, 03 Oct 2021 18:25:30 -0700 (PDT)
Received: from [2620:15c:17:3:4faa:17e6:3602:9e7d] ([2620:15c:17:3:4faa:17e6:3602:9e7d])
        by smtp.gmail.com with ESMTPSA id w185sm9500646pfd.113.2021.10.03.18.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 18:25:29 -0700 (PDT)
Date:   Sun, 3 Oct 2021 18:25:29 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] is SLAB considered legacy and deprecated?
In-Reply-To: <20211003055928.GA7643@linux.asia-northeast3-a.c.our-ratio-313919.internal>
Message-ID: <377a622-9a5e-37dc-8f8d-42ae124042b6@google.com>
References: <20210927090347.GA2533@linux.asia-northeast3-a.c.our-ratio-313919.internal> <8aa15f4b-71de-5283-5ebc-d8d1a323473d@suse.cz> <20210928111231.GA2596@linux.asia-northeast3-a.c.our-ratio-313919.internal> <b3c5bd9a-5fbc-8388-a4ab-6c20864dc7c6@suse.cz>
 <20211003055928.GA7643@linux.asia-northeast3-a.c.our-ratio-313919.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Oct 2021, Hyeonggon Yoo wrote:

> I think the points are still valid because on some workloads SLAB works
> better. especially when alloc/frees are intensive, SLUB tends to become
> bottleneck.
> 
> If we can't drop SLAB, it should be at least maintained :(
> But it has been neglected for a long time, which makes people not to
> use SLAB. Nobody likes to use a subsystem that isn't maintained.
> 
> Anyway, I'm curious about share of SLAB and SLUB and on what situations
> SLAB or SLUB is preferred. that information would help maintain both.
> 

Thanks for raising this, the discussion is always useful.  Both allocators 
have their pros and cons.

I would disagree that SLAB isn't currently maintained, I think it's 
actively maintained.  Google actually uses it for its production kernel 
although we're investigating the performance results that we can obtain 
from SLUB not that we have per-object memcg accounting.  There have been 
workloads, as you mention, that perform better with SLAB even though SLUB 
can make up for some of its degradation by throwing more memory at the 
problem (like per-cpu partial slabs).

I think the general guidance is that changes for both allocators can still 
be merged upstream if they show a significant win (improved performnace, 
maintaining performance while reducing memory footprint, code hygiene, 
etc) and there's no specific policy that we cannot make changes to 
mm/slab.c.
