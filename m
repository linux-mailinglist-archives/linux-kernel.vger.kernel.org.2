Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36C84205AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 08:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbhJDGDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 02:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhJDGDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 02:03:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EBCC0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 23:01:14 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so7451796pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 23:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cxuoqPc/PmB8mcM5TuGRV+qu2o9l2KtFKmqxX/+Qr9o=;
        b=qgQrtCEaMYgsg0jjCV1DDo2tvrEUcH4DzPaBi8qTujHdIdAXmDgIa1Po8Z9Y9NuDj4
         hub+B+0tOawqxcXdf8mQB+5Ibl2uOqRE7Xks92k1DT7OH80h2vr8Pnmdd2RHxEIIUfEC
         g9Oge8Ue60JXR+sVdeFspouBp+L2LcxKkm9J72waXhHQro/RkibqFKisL1JtzBjeTaa+
         PCG+vGytmcfNgAaWuBXkvvo6Sa00J2R5VC9L3g2HNV4sO/9TvHNsSfwBoF+HmrEXWJ6W
         ttnHIF4qa6bGEn/ZP6XTRMykasTrS+g0Gb6/+Rj8fMt5kZx9qnU82cQQK8JGDN6s19w9
         EfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cxuoqPc/PmB8mcM5TuGRV+qu2o9l2KtFKmqxX/+Qr9o=;
        b=Ft6DNP2hvRCDjhiuFSXqRcYLDhns7v46i6DOzytwd2NirlgBupmhSEvtFpWzxWUSlq
         DNM+PQ0E8CjYSEHTerle8dKyX0m+TLlr2jMLNJVYxWSlmssQ6EJVy/aYtpU3dNOvFnK/
         8DOxh4Z1C3mWawhL5WPwebyGhEweqlRYeEk4iF6PrWzTi2jK8qBTzrNHLPUCis2euhfv
         s4XUqR4J156Mm8yEninhcvhqJnCp3IKIWMAYF1eIys7+nsvN3Xk+NGRgVKyJVkHFPGcn
         o8+25aGyhEyN9Hygi5YOpbyfncBNgH0GR+PLQFPaGhY6VhoW14BxlkIxdh1k5GV9DL/I
         Ti4g==
X-Gm-Message-State: AOAM531XoyX01T2CVZ8XN/L5RZNPzVsX6etb+AXR1Ghqb40WGld3mx3W
        4lOgs2ba1o3OilxJBGKEzRk=
X-Google-Smtp-Source: ABdhPJx+aSxo9lpIz8K+5iM+BjVf3OcTZG4Ob8vcG7A2msOIc7Zog6MPuLNVDe32SA2/LfMsASfHqQ==
X-Received: by 2002:a17:90b:1e02:: with SMTP id pg2mr35298336pjb.114.1633327274431;
        Sun, 03 Oct 2021 23:01:14 -0700 (PDT)
Received: from linux.asia-northeast3-a.c.our-ratio-313919.internal (252.229.64.34.bc.googleusercontent.com. [34.64.229.252])
        by smtp.gmail.com with ESMTPSA id j6sm12257166pgh.17.2021.10.03.23.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 23:01:14 -0700 (PDT)
Date:   Mon, 4 Oct 2021 06:01:09 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] is SLAB considered legacy and deprecated?
Message-ID: <20211004060109.GA2949@linux.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20210927090347.GA2533@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <8aa15f4b-71de-5283-5ebc-d8d1a323473d@suse.cz>
 <20210928111231.GA2596@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <b3c5bd9a-5fbc-8388-a4ab-6c20864dc7c6@suse.cz>
 <20211003055928.GA7643@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <377a622-9a5e-37dc-8f8d-42ae124042b6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <377a622-9a5e-37dc-8f8d-42ae124042b6@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03, 2021 at 06:25:29PM -0700, David Rientjes wrote:
> On Sun, 3 Oct 2021, Hyeonggon Yoo wrote:
> 
> > I think the points are still valid because on some workloads SLAB works
> > better. especially when alloc/frees are intensive, SLUB tends to become
> > bottleneck.
> > 
> > If we can't drop SLAB, it should be at least maintained :(
> > But it has been neglected for a long time, which makes people not to
> > use SLAB. Nobody likes to use a subsystem that isn't maintained.
> > 
> > Anyway, I'm curious about share of SLAB and SLUB and on what situations
> > SLAB or SLUB is preferred. that information would help maintain both.
> > 
> 
> Thanks for raising this, the discussion is always useful.  Both allocators 
> have their pros and cons.
>

Thanks for kind words, I was curious and wanted to help improve
SLAB

> I would disagree that SLAB isn't currently maintained, I think it's 
> actively maintained.

I thought it was not actively maintained because most of patches were
fixups and cleanups for years and as Vlastimil said, new features are
only added to SLUB. development was focused on SLUB.

> I think the general guidance is that changes for both allocators can still
> be merged upstream if they show a significant win (improved performnace, 
> maintaining performance while reducing memory footprint, code hygiene, 
> etc) and there's no specific policy that we cannot make changes to 
> mm/slab.c.

Good.

I see things to improve in SLAB and want to improve it.
I will appreciate if you review them.

Thanks,
Hyeonggon
