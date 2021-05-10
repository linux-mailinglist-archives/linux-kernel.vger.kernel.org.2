Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BD03790FB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhEJOij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhEJOgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:36:17 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC20C061260
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:59:03 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t21so9185075plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eWWny1RMQecsKvOMWuYPoM/t5n+oHPFJqr+Tnw3Kljo=;
        b=pKoti58TLOtwwm477QlzZuDcSOzsz9RESlJS0Ih1fuCy748GoBB/Yr8h5da5p97ZHk
         hIgTZ6FuTknIBqQpEqkLwW/rRLeXBllG1UtYN3DaKhLIf82ESKSQAjjSIgvsN5whYo+y
         zdpRcQ9Dw8atnEkKCrcyNysjyEk8hwjdeoVBjY/B56ZRyCmRalYeM+Zi91egeFRmU0kW
         314uJlkPy+GFBFOOYyPY+Ed4suBJcZPFmutwzySXOLiEbclkpAwkkJiPKJCoKSUAkSOP
         MNz04xbp0T9Y3wJt44IAmmb0qKsnD0MOFvRbLAhqmzPX8QUL9TMOv3E9safQIn9YpBzw
         rg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eWWny1RMQecsKvOMWuYPoM/t5n+oHPFJqr+Tnw3Kljo=;
        b=kPrR3JTzKsj4Ms0ceIKyNiXfdB47k/6lOolVel2LIJjmWOfruFYmiJ7okLwCyhCjXs
         CUBe5oPDLP2nB1k8aNdOvsAUA6O7o5fA0BXdsvl1XeKyzI/pKEFE6dAdmQNs/gevTKxK
         kL1KIygsfTt4FHWsCg5ZfeG6AkB7wvw6JEELFOqPi4R7rNEbHOdb8YO2Gx9n6BcTTZAM
         LdKdj2IrHJbjR3J3483EBM/aFC0K0v7efUmYqHGovp0UaA/y/haMNAatPA1lXJ/qHNjN
         0xN6cqm5BlpqrrWad6QBcnz9ubNPwobpHktc/4SuQnGEvVGI19clYMLkGiQtC+jpKVZB
         3fgw==
X-Gm-Message-State: AOAM533CfQ+wD2zpn9f8+IXPP10zyZr2KCGGkIhJvdWdvYiRFnWlz4cC
        M4pMK9Zu4Yk3GkE3AhPtKAg=
X-Google-Smtp-Source: ABdhPJxIEN3rnf84NgkWK2mGvNNf/mu1xRPA8bIoz/kUzgR1Mh33iuXQLto4SIzzDtTPi0V3rkdtqQ==
X-Received: by 2002:a17:902:c106:b029:ee:9d6f:8861 with SMTP id 6-20020a170902c106b02900ee9d6f8861mr24444856pli.85.1620655143234;
        Mon, 10 May 2021 06:59:03 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id m14sm11795732pff.17.2021.05.10.06.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 06:59:03 -0700 (PDT)
Date:   Mon, 10 May 2021 22:58:57 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kmalloc_index: remove case when size is more than
 32MB
Message-ID: <20210510135857.GA3594@hyeyoo>
References: <20210508221328.7338-1-42.hyeyoo@gmail.com>
 <YJccjBMBiwLqFrB8@casper.infradead.org>
 <CAB=+i9QyxOu_1QDfX5QA=pOxxnRURPnwd2Y0EbhoO1u0e=irBA@mail.gmail.com>
 <c305ec02-a7d6-dd0c-bfee-e5b571d9ca9a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c305ec02-a7d6-dd0c-bfee-e5b571d9ca9a@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 12:09:55PM +0200, Vlastimil Babka wrote:
> On 5/9/21 7:33 AM, Hyeonggon Yoo wrote:
> > On Sun, May 09, 2021 at 12:19:40AM +0100, Matthew Wilcox wrote:
> >> On Sun, May 09, 2021 at 07:13:28AM +0900, Hyeonggon Yoo wrote:
> >> > the return value of kmalloc_index is used as index of kmalloc_caches,
> >>
> >> it doesn't matter.  every few weeks somebody posts a patch to "optimise"
> >> kmalloc_index, failing to appreciate that it's only ever run at compile
> >> time because it's all under __builtin_constant_p().
> > 
> > Oh thanks, I didn't know about __builtin_constant_p.
> > 
> > But I was not optimizing kmalloc_index. isn't it confusing that
> > kmalloc_caches alllows maximum size of 32MB, and kmalloc_index allows
> > maximum size of 64MB?
> > 
> > and even if the code I removed is never reached because 64MB is always
> > bigger than KMALLOC_MAX_CACHE_SIZE, it will cause an error if reached.
> 
> KMALLOC_MAX_CACHE_SIZE depends on KMALLOC_SHIFT_HIGH
> size of kmalloc_caches array depends on KMALLOC_SHIFT_HIGH
> 
> So I don't an easy way how it could become reachable while causing the index to
> overflow - if someone increased KMALLOC_SHIFT_HIGH from 25 to 26, all should be
> fine, AFAICS.
> 
> The problem would be if someone increased it to 27, then we might suddenly get a
> BUG() in kmalloc_index(). We should probably replace that BUG() with
> BUILD_BUG_ON(1) to catch that at compile time. Hopefully no supported compiler
> will break because it's not able to do the proper compile-time evaluation - but
> if it does, at least we would know.
> 
> So I would accept the patch if it also changed BUG() to e.g. BUILD_BUG_ON_MSG(1,
> "unexpected size in kmalloc_index()");
> and expanded the function's comment that this is always compile-time evaluated
> and thus no attempts at "optimizing" the code should be made.
> 

Thank you so much reviewing and replying to my patch.
plecase check if I understood well.

Okay, I'll do that work. then the following patch will:
	- remove case when size is more than 32MB
	- change "BUG to BUILD_BUG_ON to let compiler know when the size is not supported"
	- add comment that there's no need to optimize it

is it what you mean. right?

and I have a question. in the lin 751 of mm/slab_common.c,
thre's struct kmalloc_info_struct kmalloc_info. and it initializes kmalloc info
up to 64MB, which is currently not supported. should I change it too? in a separate patch?
