Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC3E421141
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 16:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhJDOY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 10:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbhJDOY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 10:24:28 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B17EC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 07:22:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id h1so3937216pfv.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G9ezp7evjOZKJ358P904p9qdWMlp+LXB67WAKDUGAvU=;
        b=fDVZp6zUdjdIrAJ4sxqkNxQwpOBzbMrmRJKzHx1YIV96EQzpOKrz4oAL73lx4ohBOK
         HSZCs/pdurVBOY01RbN2jVygRzzFwLNF89CI8gL0Aa+uC7NgFKuEK3fkLGvj6a4khyjd
         s8LBkUGKzgjAYEfCQcf46xF6tHb3mXvsp9PZiq0ZmVy9VEX8oNcjh9+ac2KAfUhMI4Bt
         ZqxCnKHzGfUovEoCQLy3Jq2irgWApPKgDK0wfGOapR8HVkilgwS6VSgOg7rgU9xQC0SX
         prmsfH/GjvWsQNFzWOUFq3QprF+LHoKVTIpDuQAM83wV2TecN1hel3LJRXdQqA+QlKUD
         mnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G9ezp7evjOZKJ358P904p9qdWMlp+LXB67WAKDUGAvU=;
        b=J4HKR9610PvHQw33IVc7B4gsSjeqbco0AXKyPHwwY26bKzTIDObqZBgjSj9+thcrbj
         V0pkJOmAWSUq2MldwCKdOjqu8+UbZbFtsGGfslAP/+syg7UaX5n+5TvueBYOt4wV6f4K
         W2QQNJq+iHRx6o49M4GV0iv+AAn6/QwzC+VztfgT4WYV/ShkEFj+vmRxxMQE0B34JUvR
         3gkFjNacmiPvjFpVYgwNOjheYWZAYpw2uSUcJu3UbZw13ms+zsHIYwFYfPLYPk2Ol0zU
         zWTv4P6w9FPOrDc1tjwM8sGdj0HGwvSNNJ2qKT+6vXeo3/wKGXaKZ5yRqA+dN0H4WKoI
         +WSg==
X-Gm-Message-State: AOAM533+iJJBh2/pboyDwI5AEs1q+Yn9WuqoN4ssbHK64MZvGW0ksPN6
        HPxi5GsLNZWEnisHYyFYNdg=
X-Google-Smtp-Source: ABdhPJw9/BU5KlBxePHCFWCqv0cjbOlwA+ftV9Te5GxWWnnwL0HxwFZ/mjos0oxboc7aDxNViUNIbg==
X-Received: by 2002:a62:8c93:0:b0:44c:faf:43cd with SMTP id m141-20020a628c93000000b0044c0faf43cdmr20165717pfd.5.1633357359042;
        Mon, 04 Oct 2021 07:22:39 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (252.229.64.34.bc.googleusercontent.com. [34.64.229.252])
        by smtp.gmail.com with ESMTPSA id 8sm13859473pfi.194.2021.10.04.07.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:22:38 -0700 (PDT)
Date:   Mon, 4 Oct 2021 14:22:34 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] is SLAB considered legacy and deprecated?
Message-ID: <20211004142234.GA3065@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20210927090347.GA2533@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <8aa15f4b-71de-5283-5ebc-d8d1a323473d@suse.cz>
 <20210928111231.GA2596@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <b3c5bd9a-5fbc-8388-a4ab-6c20864dc7c6@suse.cz>
 <20211003055928.GA7643@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <8224ddae-88f5-63ab-c375-473462c50efe@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8224ddae-88f5-63ab-c375-473462c50efe@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 01:34:17PM +0200, Vlastimil Babka wrote:
> On 10/3/21 07:59, Hyeonggon Yoo wrote:
> > Hello Vlastimil! I'm happy to discuss with you.
> > I hope this discussion to make us think about slab allocator.
> 
> Yeah, it's useful, thanks for asking!
> 

Me too, Thanks for answering.

> > On Fri, Oct 01, 2021 at 04:07:56PM +0200, Vlastimil Babka wrote:
> >>>> In some contexts it's still being preferred, AFAIK.
> >>>
> >>> In what context is SLAB or SLUB is preferred?
> >>
> >> I don't know the full answer. With our distro we have used SLAB, and
> >> switched to SLUB after verifying that there are no major regressions.
> >> Better debugging features were perhaps the major reason.
> >>
> > 
> >>> And what is the core reason that SLUB is used by default?
> >>
> >> The usual reason in MM, nobody objected :)
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a0acd82080768
> >>
> > 
> > What was the decision based on ? performance measurements or anything
> 
> I haven't been around back then, so don't know. Also tried to find this
> particular patch (and possible replies) in the linux-mm lore archive,
> and didn't succeed. Might have been event sent off-list by mistake.
> 

I can't find it in the list too.
Maybe it was not sent to list.

> >>>>> So there is a fundamental question coming into my mind:
> >>>>>     'is SLAB considered legacy and deprecated?'
> >>>>
> >>>> To some extend, but not yet in a sense where we would have a deadline to get
> >>>> rid of it.
> >>>>
> >>> What makes you to say 'To some extent'?
> >>> That's what I'm curious about :)
> > 
> >> "To some extent" because SLUB is default and if some new stuff was added
> >> that only worked with SLUB and not SLAB, there wouldn't be major
> >> objections expected.
> > 
> > You said new features are added to only SLUB and there are no
> > objections expected, But what makes you to do so?
> > 
> > You are not saying why. what you are saying is just only result.
> > What is the mind behind maintaining SLUB and neglecting SLAB?
> 
> David explained it well. I'll add it's a question of motivation, people
> generally add features to the subsystem they prefer, and most prefer
> SLUB these days, and in that case we don't require the same feature to
> be added to SLAB (or even SLOB) as well.  But if someone wants to, we
> also don't stop them - but to some extent. If someone suddenly came up
> with "SLUB has this nice debugging and SLAB not, so I will reimplement
> it there" we would be questioning hard if the code churn is really needed.
>

I got your point.
no need to take unnecessary maintenance cost.

Thanks,
Hyeonggon
