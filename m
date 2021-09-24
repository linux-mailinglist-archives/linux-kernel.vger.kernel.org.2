Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC5C4169B9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 03:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243858AbhIXB7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 21:59:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41335 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243798AbhIXB7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 21:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632448672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IoRro96R5pPs/rroh/4ORzYp+dzp3ciowxNhmxImRts=;
        b=gtsIctlLJjyM1+j7UbnaKY+hg+ZmNzcpTM8IjFpdk/CiFvy3k4lMN53dlXGcjbs1hOPpOU
        qalDGYsUHQnDVhm7+hNJ+gSDIffmuxsI1mkoGqj7Z2YVfC+z+6D2iFCccdkdQO5JTD9Umn
        dSCQv+NRERYi7YFDdEBotAiDz8a0/Mk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-rVjj5ErwPZGJ-xCCHvmrtw-1; Thu, 23 Sep 2021 21:57:49 -0400
X-MC-Unique: rVjj5ErwPZGJ-xCCHvmrtw-1
Received: by mail-pj1-f69.google.com with SMTP id z8-20020a17090acb0800b001996f635e3bso5317781pjt.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 18:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IoRro96R5pPs/rroh/4ORzYp+dzp3ciowxNhmxImRts=;
        b=icRXsXwGE1fJ2eNfueYt3vMtU1w+UyIU+OkxCJFt/EhMUQkDKotmqoqGMuddCWIru5
         Wxbo6PNB9fnErbMPO7/AS8QzGKQiLEsoq6cYJgGUy2uyFdwhWie/sILywkmzlVmZQrfD
         5ADT/YE9d6ijGyrZr7kiPCPn1yVDRgO56SEZKE7ehIE2PkkLGJeQbv1oZAjrQYZEeC8m
         USFJFUiu5H4+c+JcyivJZV81U6+vXiGYzD/QFCSttbOhFngX6Pvl7sMYfsQFAnFIdESJ
         QWNuiM0uHRsKgZYCwhe53aBM9aCIFn/R9/iU2hrgv+8nenod3dI/9ykwA8xfTusAg+yg
         ZSUA==
X-Gm-Message-State: AOAM530Qj07+eCHaxE8DBJwLkhNr2Q8l0OOB51fN5lQk3MJD43OMfWUA
        6OKiexHazwP1wlkcuYCuHdNg16kxMfJja/c3we2D5ljBYn5a1NUNeJxKoNxB3qoottSYRfsPqx3
        4gFyw4xnuBEwUfRyJit/GppMq
X-Received: by 2002:a62:1e43:0:b0:447:cb0b:4c6e with SMTP id e64-20020a621e43000000b00447cb0b4c6emr7346128pfe.1.1632448668059;
        Thu, 23 Sep 2021 18:57:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMdHLKnRiz6wcEQQ/rY3ClrEtVFxYVtMmco37qWFXC6IE9NJmQ9++pONAvcRtgFcTMWawxHA==
X-Received: by 2002:a62:1e43:0:b0:447:cb0b:4c6e with SMTP id e64-20020a621e43000000b00447cb0b4c6emr7346105pfe.1.1632448667724;
        Thu, 23 Sep 2021 18:57:47 -0700 (PDT)
Received: from treble ([50.231.97.170])
        by smtp.gmail.com with ESMTPSA id m28sm7716768pgl.9.2021.09.23.18.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 18:57:47 -0700 (PDT)
Date:   Thu, 23 Sep 2021 18:57:44 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH] x86, vmlinux.lds: Add debug option to force all data
 sections aligned
Message-ID: <20210924015744.h7egzvyxm5cifjzj@treble>
References: <1627456900-42743-1-git-send-email-feng.tang@intel.com>
 <20210922185137.ivdp4yoalv4qdbe2@treble>
 <20210923145720.GA28463@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210923145720.GA28463@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 10:57:20PM +0800, Feng Tang wrote:
> For binary size, I just tested 5.14 kernel with a default desktop
> config from Ubuntu (I didn't use the normal rhel-8.3 config used
> by 0Day, which is more for server):
> 
> v5.14
> ------------------------
> text		data		bss	    dec		hex	filename
> 16010221	14971391	6098944	37080556	235cdec	vmlinux
> 
> v5.14 + 64B-function-align
> --------------------------
> text		data		bss	    dec		hex	filename
> 18107373	14971391	6098944	39177708	255cdec	vmlinux
> 
> v5.14 + data-align(THREAD_SIZE 16KB)
> --------------------------
> text		data		bss	    dec		hex	filename
> 16010221	57001791	6008832	79020844	4b5c32c	vmlinux

That data size increase is indeed excessive.  However I wonder if some
other approach (other than SUBALIGN) could be taken.  For example, a 4k
alignment for each compilation unit's .data section.  That might require
some linker magic at the built-in.o linking level.

Anyway, I suspect the data alignment issues are less common than
function alignment.  It might be fine to leave the data alignment as a
debug feature for now, as this current patch does.

> > On a similar vein I think we should re-explore permanently enabling
> > cacheline-sized function alignment i.e. making something like
> > CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B the default.  Ingo did some
> > research on that a while back:
> > 
> >    https://lkml.kernel.org/r/20150519213820.GA31688@gmail.com
> 
> Thanks for sharing this, from which I learned a lot, and I hope I
> knew this thread when we first check strange regressions in 2019 :)
> 
> > At the time, the main reported drawback of -falign-functions=64 was that
> > even small functions got aligned.  But now I think that can be mitigated
> > with some new options like -flimit-function-alignment and/or
> > -falign-functions=64,X (for some carefully-chosen value of X).
> 
> Will study more about these options. 
> 
> If they have much less size increase and no regression in performance,
> then maybe it could be turned on by default.

Agreed!  I think/hope it would be a net positive change.

I've also been burned by such issues -- like a random one-line code
change causing a measurable performance regression due to changed
i-cache behavior in unrelated code.  It doesn't only affect 0-day tests,
it also affects real users.

-- 
Josh

