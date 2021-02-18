Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637AF31EE88
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhBRSmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbhBRQUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 11:20:09 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2AEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 08:19:53 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id l18so1780751pji.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 08:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ye8wp6gAsTsRY1pVTSfX6rW4u9/tlEXevai2QqUsZZI=;
        b=jpbijh7rMln+JE6JQGs/aHCbmfNfFD4SH68Dj2gvE1Dp614ZYyS7Zb3y07AmHxJzO2
         tKW8NTW0UJ0CsAdVlRIc5DNkku1Ns5pjh2TBhHhIUSPGcD6YN0WuaIWtEdF5xvNq4bI7
         syRyo8LSa7T6XHWAaoUa4Uq9hASMByJOqnU6guS3PaQQxX7sgrF+MMrXEGB/Bc2zKogj
         l5NN205luTtuoxTjvAsN7cmOkvoutM+y1DnpbWM5/ZIdyQwp9q7NbGvQWBHzhhATsyXC
         hRCYk92raiIGTcNKMmiWwmTt97VziHkTrhhH/wIyxRnyP4ytR0VfK80n86amI45VNwgK
         t54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Ye8wp6gAsTsRY1pVTSfX6rW4u9/tlEXevai2QqUsZZI=;
        b=sRsQ0j7fHPJOjQ9OAy+1k0rFCMleK341ZM0wck6+EbTGhSUB7mm9JwZ83C+QPvjRGp
         iyiAvvyys+tgKCietXQXq8dzLFFTMLv1kzI/9nipOirby2sdd6hzrm53RhJ60tGLfl2v
         1ugghKGHYo9E6I+uVSQ1OuvhfsvipYtupS1XtkLCjwT0dB3yLI4cpswly5Vi0tYmx8Au
         OPO/hmKnh9kBBPQ45lUMN/r0snVdxDGyQTNgXfknBd3C7yuFeQTH98FdlY3npGJ9DLOJ
         9H5bfpfCKdNY3d8AXx1+ajap97wNcIHJApXbwjW8uwdHuLdV34iBLcamsgu06/Gacqah
         2HJA==
X-Gm-Message-State: AOAM532BgmsxbB9kCWpq3Ar0baR9gX0rPzL4SmdgE9oa1OfnBq8yNzAw
        vpw45sIfsdzMvwnwgi496l6ML7zxrSU=
X-Google-Smtp-Source: ABdhPJyuxAzni/k4vC7B838CrijtSO2Pac/plUlYng+gBqaxsku1oGe0oxsJTmFN0PuG0pZAUWbuMA==
X-Received: by 2002:a17:90a:883:: with SMTP id v3mr4727363pjc.66.1613665193213;
        Thu, 18 Feb 2021 08:19:53 -0800 (PST)
Received: from google.com ([2620:15c:211:201:157d:8a19:5427:ea9e])
        by smtp.gmail.com with ESMTPSA id q15sm5979199pja.22.2021.02.18.08.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 08:19:52 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 18 Feb 2021 08:19:50 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
Message-ID: <YC6TpqT26dSy11fU@google.com>
References: <20210217163603.429062-1-minchan@kernel.org>
 <YC4rsr9zkNAvdL4T@dhcp22.suse.cz>
 <2f167b3c-5f0a-444a-c627-49181fc8fe0d@redhat.com>
 <YC402s1vqvC4q041@dhcp22.suse.cz>
 <fa8195f9-4d1b-7a77-1a02-d69710f4208b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa8195f9-4d1b-7a77-1a02-d69710f4208b@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 10:43:21AM +0100, David Hildenbrand wrote:
> On 18.02.21 10:35, Michal Hocko wrote:
> > On Thu 18-02-21 10:02:43, David Hildenbrand wrote:
> > > On 18.02.21 09:56, Michal Hocko wrote:
> > > > On Wed 17-02-21 08:36:03, Minchan Kim wrote:
> > > > > alloc_contig_range is usually used on cma area or movable zone.
> > > > > It's critical if the page migration fails on those areas so
> > > > > dump more debugging message like memory_hotplug unless user
> > > > > specifiy __GFP_NOWARN.
> > > > 
> > > > I agree with David that this has a potential to generate a lot of output
> > > > and it is not really clear whether it is worth it. Page isolation code
> > > > already has REPORT_FAILURE mode which currently used only for the memory
> > > > hotplug because this was just too noisy from the CMA path - d381c54760dc
> > > > ("mm: only report isolation failures when offlining memory").
> > > > 
> > > > Maybe migration failures are less likely to fail but still.
> > > 
> > > Side note: I really dislike that uncontrolled error reporting on memory
> > > offlining path we have enabled as default. Yeah, it might be useful for
> > > ZONE_MOVABLE in some cases, but otherwise it's just noise.
> > > 
> > > Just do a "sudo stress-ng --memhotplug 1" and see the log getting flooded
> > 
> > Anyway we can discuss this in a separate thread but I think this is not
> > a representative workload.
> 
> Sure, but the essence is "this is noise", and we'll have more noise on
> alloc_contig_range() as we see these calls more frequently. There should be
> an explicit way to enable such *debug* messages.

alloc_contig_range already has gfp_mask and it respects __GFP_NOWARN.
Why shouldn't people use it if they don't care the failure?
Semantically, it makes sense to me.

About the messeage flooding, shouldn't we go with ratelimiting?
I see those two problem are orthgonal.
