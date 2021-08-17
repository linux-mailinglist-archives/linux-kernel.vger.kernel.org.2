Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3082D3EE5FF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 06:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbhHQFAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 01:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhHQFAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 01:00:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C949360E78;
        Tue, 17 Aug 2021 04:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629176379;
        bh=6dOr1zXUwHMhzllgenVUuv80XsCXUb3BWOhAaYNX7Hw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=upxHrYZG+A6r4Zq5U1nHXvROzqE18aqhztaN/c3MNQB3D+uU40dcQDIeDm1UjJ2eG
         lzjh4SZBEcAJbqkt0Ngr54qXEeReCw1C6Er+9xI2uXQi2xD0dB+IFOE+KFehwUD5NT
         YlTB0Ad0+tYBLjK4zp0lMww1M1AGq0sdrppegIyfWK08dNxGbYWo66As0aqA6/q2Gu
         w900Ri9yyzqRE6egBZv2oIc2cdgSLtZTKV3UpdQ8OMzWjvtvgFwvNH7kI3h6O9IskA
         JJ6/AUa6HEPUn/EQ7XUTklfmkEN2sQaowMv6cLKPcqyLPqpXRiVCyV8w3WHXw+ZRej
         JnFT4gRncTQIA==
Date:   Tue, 17 Aug 2021 07:59:31 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Peter Collingbourne <pcc@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmflags.h: add missing __GFP_ZEROTAGS and
 __GFP_SKIP_KASAN_POISON names
Message-ID: <YRtCM/ZC+nWHQmey@kernel.org>
References: <20210816133502.590-1-rppt@kernel.org>
 <20210816170510.9d6afcd53c767397aba758ef@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816170510.9d6afcd53c767397aba758ef@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 05:05:10PM -0700, Andrew Morton wrote:
> On Mon, 16 Aug 2021 16:35:02 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Add missing names of __GFP_ZEROTAGS and __GFP_SKIP_KASAN_POISON flags to
> > __def_gfpflag_names.
> > 
> > Fixes: 013bb59dbb7c ("arm64: mte: handle tags zeroing at page allocation time")
> > Fixes: c275c5c6d50a ("kasan: disable freed user page poisoning with HW tags")
> 
> "fixes" in what way?  ie, what problems were caused by the above commits?
> 
> > --- a/include/trace/events/mmflags.h
> > +++ b/include/trace/events/mmflags.h
> > @@ -48,7 +48,9 @@
> >  	{(unsigned long)__GFP_WRITE,		"__GFP_WRITE"},		\
> >  	{(unsigned long)__GFP_RECLAIM,		"__GFP_RECLAIM"},	\
> >  	{(unsigned long)__GFP_DIRECT_RECLAIM,	"__GFP_DIRECT_RECLAIM"},\
> > -	{(unsigned long)__GFP_KSWAPD_RECLAIM,	"__GFP_KSWAPD_RECLAIM"}\
> > +	{(unsigned long)__GFP_KSWAPD_RECLAIM,	"__GFP_KSWAPD_RECLAIM"},\
> > +	{(unsigned long)__GFP_ZEROTAGS,		"__GFP_ZEROTAGS"},	\
> > +	{(unsigned long)__GFP_SKIP_KASAN_POISON,"__GFP_SKIP_KASAN_POISON"}\
> >  
> >  #define show_gfp_flags(flags)						\
> >  	(flags) ? __print_flags(flags, "|",				\
> 
> I'm guessing that the tracing output was messed up in some fashion?

I didn't check tracing actually, but printk("%pGg") outputs these two flags
as hexadecimal number, rather that string, e.g:

	GFP_KERNEL|0x1800000 

-- 
Sincerely yours,
Mike.
