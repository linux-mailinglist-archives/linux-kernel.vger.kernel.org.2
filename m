Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FFA38328F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 16:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241992AbhEQOt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 10:49:27 -0400
Received: from mail-il1-f178.google.com ([209.85.166.178]:34759 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239534AbhEQOkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 10:40:40 -0400
Received: by mail-il1-f178.google.com with SMTP id c16so6311491ilo.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 07:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jH0fCm6/ssgqTQFTtYAxRzZAnMgRul40cu4aOLtnS2s=;
        b=UKZLohwHmqWAw1tZjA+KYAX6m9EBndA62UT92/8NM5MD0isXR2WVpmTIgezqxrNtar
         tiTVZGiRP+8rF681iakwJ5jq10DeFMVSKhcvpXqeQNeKQ8lGJH4DVvzVvPuvHF28vn1h
         aDgj8JWe8IHJZ1reAFAnNbub6VDiB9AbCRZBe6VlE37Bi/Q+XVSyuORX9ba2vNtuuq0r
         EVgdu1qn6dl5z/ld0FJF38O43p3cWECIRHGaAnpz6FAjlW2+Skb1MKQCANiXdnlYySfU
         8s0i6S3JEuZsTBT2tq8FWutUPvASWOvLm+SygMplE4vX7WAdPXokR3qZuXxwH2PMOkZH
         P8dg==
X-Gm-Message-State: AOAM5308kL5nZg1lchbomuYhRShYktVaqlCLi6gR2U1jNlzNKqPViPMw
        E3xaeuAu+84yE2VQziZberU=
X-Google-Smtp-Source: ABdhPJycdz0JtI1u2VVpJ/hbQoX+Bdowg/jnuMQPSv/KFHO5P0NxYLYnt+QC2OC5JOsMPJu3bdR/ZQ==
X-Received: by 2002:a05:6e02:1a0c:: with SMTP id s12mr6006ild.201.1621262363435;
        Mon, 17 May 2021 07:39:23 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id u18sm1112124ilj.20.2021.05.17.07.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 07:39:22 -0700 (PDT)
Date:   Mon, 17 May 2021 14:39:21 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     tj@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu: initialize best_upa variable
Message-ID: <YKKAGbOyRSX5jmxY@google.com>
References: <20210515180817.1751084-1-trix@redhat.com>
 <YKHPV4QAXmaWb6jJ@google.com>
 <dd1dabe0-73a5-8a39-ba58-bb58a1453d90@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd1dabe0-73a5-8a39-ba58-bb58a1453d90@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 06:17:47AM -0700, Tom Rix wrote:
> 
> On 5/16/21 7:05 PM, Dennis Zhou wrote:
> > Hello,
> > 
> > On Sat, May 15, 2021 at 11:08:17AM -0700, trix@redhat.com wrote:
> > > From: Tom Rix <trix@redhat.com>
> > > 
> > > Static analysis reports this problem
> > > percpu.c:2945:6: warning: Assigned value is garbage or undefined
> > >          upa = best_upa;
> > >              ^ ~~~~~~~~
> > > best_upa may not be set, so initialize it.
> > > 
> > > Signed-off-by: Tom Rix <trix@redhat.com>
> > > ---
> > >   mm/percpu.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/mm/percpu.c b/mm/percpu.c
> > > index a257c3efdf18b..6578b706fae81 100644
> > > --- a/mm/percpu.c
> > > +++ b/mm/percpu.c
> > > @@ -2916,6 +2916,7 @@ static struct pcpu_alloc_info * __init __flatten pcpu_build_alloc_info(
> > >   	 * Related to atom_size, which could be much larger than the unit_size.
> > >   	 */
> > >   	last_allocs = INT_MAX;
> > > +	best_upa = max_upa;
> > >   	for (upa = max_upa; upa; upa--) {
> > >   		int allocs = 0, wasted = 0;
> > > -- 
> > > 2.26.3
> > > 
> > I think the proper fix would be:
> > 
> > best_upa = 0;
> 
> I was looking for initializing with something that would work.
> 

I think I prefer setting it to 0 because it forces the loop to have
succeeded vs being able to bypass it if the for loop logic was changed.

> > for (...) { }
> > BUG_ON(!best_upa);
> WARN_ON instead?

This is initialization code. So if upa == 0, it really is a problem.
Having 0 units per allocation is bogus.

> > upa = best_upa;
> > 
> > If you're fine with this I'll make the changes and apply it to
> > for-5.13-fixes.
> > 
> > Can you also tell me what static analysis tool produced this? I'm just a
> > little curious because this code hasn't changed in several years so I'd
> > have expected some static analyzer to have caught this by now.
> 
> Clang 10
> 
> Tom
> 

Thanks,
Dennis
