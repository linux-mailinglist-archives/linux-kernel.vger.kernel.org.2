Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75943FE329
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 21:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245024AbhIATjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 15:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhIATjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 15:39:19 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24632C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 12:38:22 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id a5so543360qvq.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 12:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Dxph7jDfwhIBjNqQGxaXPIRH+igFALi9zvpnJtxMvJI=;
        b=h5vuSLIWMVHLnRPsuMnItEcjoo6EhjfXlcfdEmLufhZVW1l90CkWqsQtEsbmyYAH1L
         VRdMz4MGMGSCLO6CQx+HG+Q1f8nYvkubXsqSNPwYWHrXRLGm2R2lZgEOKwYwkn+buTGZ
         aSKHkyq/wOuGsE6/ucgHH4cBS9ZIIg8o9Nt5TriLb7mddeC+qMRHYIk8Gh63pQp0Y6o7
         vshYj3bLl7xH9s3CU3sF1mLKcDBT23jINs5Asf9/M935lJpLu2fkflTA5aEQRyXmwn8o
         12xXAtDw2toaEEI6y+gVy/WUwdleMcSh9JLyTcxwIvQWdA1v6n9L2RJ7/CR+JXHgVtIf
         7O+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Dxph7jDfwhIBjNqQGxaXPIRH+igFALi9zvpnJtxMvJI=;
        b=qcadSAwSaQp+aBaOzOI3MpAtB5IiRKEbTM0NUHM2/W/nfKDT27hQaHmNpezaK5j4xx
         1IHC+Bu/pVritASb70KlOKFhiEv2rQqZoz4PddkCP98cK1l3BCGDCbFarcWlJ/1PAtmN
         wZSbLjID+UKJAQZk623xV5YipKyjsFcjZapHug/6LBBL8eZrWjOJn6SS7Jk+OBsiDCN/
         h85sZwcebt++9YV0pPDynyBzKondG5dyuR43C9jZTQivT/UGI9D8+X4VFq5E47Y9rS7X
         fxJTykaEOyPwgoIHigHBjbKdlmWVD7OpoDI5HZ1A+V3ur3+rzNP+/Gonpw7woSSbtFEC
         6hWw==
X-Gm-Message-State: AOAM530SU33sYIp1CfGIRHhqLJ4mZFqatyXl37HLBb0eyBvPtaD5/ozE
        XE5oIvWirlqAd7sAaXRQsMP7+w==
X-Google-Smtp-Source: ABdhPJxEcd/IEZnsmVevnzzhpk4LBHFZUkU3kunOs4J3EV4EO6BJs7ize5brSSbHKBNFunPSnhetcw==
X-Received: by 2002:ad4:4ab2:: with SMTP id i18mr973208qvx.44.1630525101359;
        Wed, 01 Sep 2021 12:38:21 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id c2sm375373qkd.57.2021.09.01.12.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 12:38:20 -0700 (PDT)
Date:   Wed, 1 Sep 2021 15:40:06 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        stable@kernel.org, Chris Down <chris@chrisdown.name>
Subject: Re: [PATCH] mm,vmscan: fix divide by zero in get_scan_count
Message-ID: <YS/XFjkJhEUS+rN+@cmpxchg.org>
References: <20210826220149.058089c6@imladris.surriel.com>
 <YS1EA3U4XXH7X0qz@cmpxchg.org>
 <YS39aci6yhjIplLx@dhcp22.suse.cz>
 <a6ee1edfb13e1b666789f1857842c4ac025b1f40.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6ee1edfb13e1b666789f1857842c4ac025b1f40.camel@surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 11:48:28AM -0400, Rik van Riel wrote:
> On Tue, 2021-08-31 at 11:59 +0200, Michal Hocko wrote:
> > On Mon 30-08-21 16:48:03, Johannes Weiner wrote:
> > 
> > 
> > > Or go back to not taking the branch in the first place when there
> > > is
> > > no protection in effect...
> > > 
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index 6247f6f4469a..9c200bb3ae51 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -2547,7 +2547,7 @@ static void get_scan_count(struct lruvec
> > > *lruvec, struct scan_control *sc,
> > >                 mem_cgroup_protection(sc->target_mem_cgroup, memcg,
> > >                                       &min, &low);
> > >  
> > > -               if (min || low) {
> > > +               if (min || (!sc->memcg_low_reclaim && low)) {
> > >                         /*
> > >                          * Scale a cgroup's reclaim pressure by
> > > proportioning
> > >                          * its current usage to its memory.low or
> > > memory.min
> > 
> > This is slightly more complex to read but it is also better than +1
> > trick.
> 
> We could also fold it into the helper function, with
> mem_cgroup_protection deciding whether to use low or
> min for the protection limit, and then we key the rest
> of our decisions off that.
> 
> Wait a minute, that's pretty much what mem_cgroup_protection
> looked like before f56ce412a59d ("mm: memcontrol: fix occasional
> OOMs due to proportional memory.low reclaim")
> 
> Now I'm confused how that changeset works.
> 
> Before f56ce412a59d, mem_cgroup_protection would return
> memcg->memory.emin if sc->memcg_low_reclaim is true, and
> memcg->memory.elow when not.
> 
> After f56ce412a59d, we still do the same thing. We just
> also set sc->memcg_low_skipped so we know to come back
> if we could not hit our target without skipping groups
> with memory.low protection...

Yeah, I just bubbled the sc->memcg_low_reclaim test up into vmscan.c
so we can modify sc->memcg_low_skipped based on it. Because
scan_control is vmscan.c-scope and I tried to retain that; and avoid
doing things like passing &sc->memcg_low_skipped into memcg code.
