Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60502393723
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbhE0U0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:26:38 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:41630 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbhE0U0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:26:32 -0400
Received: by mail-io1-f42.google.com with SMTP id n10so1846923ion.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c5avyG+JG+HCBZSkDHForBT/c7WMYaoLNLCgHmVeHfQ=;
        b=OToOPIeA8FBu36dTLjBiJ9hAN1E3NoNlSRMRK24TRcdEf8yvye/xedQ/1kmvNcj9bq
         qVt/MunXuJEOwaHzz56D/ZtewgHHazVhz0Bt9RHs+GudbmRVvsJUa8JvP4SQ5hoIYv88
         54/3KpvIKwG96wac9Y4I2BLDCE3zhOMDVfgOLgj0bmy0AycWOZhPRiJvslKu31t6GmO+
         XxvhwxDOR8y9xxI+2jkuUa0n8SvAg78QYTOadFnXFv/tfNufDts30AvVgpeMgRG4ZvS4
         bpH24bPD/5nme0klhQ6EBWwwfpxnyld8BoKGOSKGoFihb3gJtDyFaVS45+sLU1hF5cFw
         6E4Q==
X-Gm-Message-State: AOAM531mbV9/QRQOpEdx8LXKaOrmiakJgYZYHLsQk8ZUXeD9eeN6Wj2W
        yvYMLU4qkDU7Un4u/eI8x2yoF+5Rxls=
X-Google-Smtp-Source: ABdhPJxuqBvZJLjl7cqOx+pzzc28YudKBtnl2uT3U+QHzhvlP9kfRDVM+jRRpZQEE83MxpnWGvyWcQ==
X-Received: by 2002:a02:908a:: with SMTP id x10mr5067710jaf.30.1622147097974;
        Thu, 27 May 2021 13:24:57 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id o18sm1690240ilq.9.2021.05.27.13.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:24:57 -0700 (PDT)
Date:   Thu, 27 May 2021 20:24:56 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     tj@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu: initialize best_upa variable
Message-ID: <YLAAGCeCyVKGxO+V@google.com>
References: <20210515180817.1751084-1-trix@redhat.com>
 <YKHPV4QAXmaWb6jJ@google.com>
 <dd1dabe0-73a5-8a39-ba58-bb58a1453d90@redhat.com>
 <YKKAGbOyRSX5jmxY@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKKAGbOyRSX5jmxY@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, May 17, 2021 at 02:39:21PM +0000, Dennis Zhou wrote:
> On Mon, May 17, 2021 at 06:17:47AM -0700, Tom Rix wrote:
> > 
> > On 5/16/21 7:05 PM, Dennis Zhou wrote:
> > > Hello,
> > > 
> > > On Sat, May 15, 2021 at 11:08:17AM -0700, trix@redhat.com wrote:
> > > > From: Tom Rix <trix@redhat.com>
> > > > 
> > > > Static analysis reports this problem
> > > > percpu.c:2945:6: warning: Assigned value is garbage or undefined
> > > >          upa = best_upa;
> > > >              ^ ~~~~~~~~
> > > > best_upa may not be set, so initialize it.
> > > > 
> > > > Signed-off-by: Tom Rix <trix@redhat.com>
> > > > ---
> > > >   mm/percpu.c | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/mm/percpu.c b/mm/percpu.c
> > > > index a257c3efdf18b..6578b706fae81 100644
> > > > --- a/mm/percpu.c
> > > > +++ b/mm/percpu.c
> > > > @@ -2916,6 +2916,7 @@ static struct pcpu_alloc_info * __init __flatten pcpu_build_alloc_info(
> > > >   	 * Related to atom_size, which could be much larger than the unit_size.
> > > >   	 */
> > > >   	last_allocs = INT_MAX;
> > > > +	best_upa = max_upa;
> > > >   	for (upa = max_upa; upa; upa--) {
> > > >   		int allocs = 0, wasted = 0;
> > > > -- 
> > > > 2.26.3
> > > > 
> > > I think the proper fix would be:
> > > 
> > > best_upa = 0;
> > 
> > I was looking for initializing with something that would work.
> > 
> 
> I think I prefer setting it to 0 because it forces the loop to have
> succeeded vs being able to bypass it if the for loop logic was changed.
> 
> > > for (...) { }
> > > BUG_ON(!best_upa);
> > WARN_ON instead?
> 
> This is initialization code. So if upa == 0, it really is a problem.
> Having 0 units per allocation is bogus.
> 
> > > upa = best_upa;
> > > 
> > > If you're fine with this I'll make the changes and apply it to
> > > for-5.13-fixes.
> > > 
> > > Can you also tell me what static analysis tool produced this? I'm just a
> > > little curious because this code hasn't changed in several years so I'd
> > > have expected some static analyzer to have caught this by now.
> > 
> > Clang 10
> > 
> > Tom
> > 
> 
> Thanks,
> Dennis

Following up here. Are you find with me making the changes and
attributing it to you? Otherwise I can just spin another patch real
quick.

At this point I've already sent my PR for-5.13-fixes. So I'll queue some
fix for-5.14.
 
Thanks,
Dennis
