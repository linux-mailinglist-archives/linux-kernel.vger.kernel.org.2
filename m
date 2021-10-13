Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBAA42CA7B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 21:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbhJMUAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 16:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJMUAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 16:00:03 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B14C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:57:59 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id y11so3697178qtn.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k+BonliAPowDteyZoYp6dggycLLuWAlBJRnflFJEQYs=;
        b=OteN24zYQGdCBWBUvva9p/uxqvsPD4xBMRDCgqmLJXmAOareEtIZMtv/SuOkrKPre3
         Jjjyl82NyDVM6Lv8sT1AWLw+dBK9tt3wBEYRtadefApyb/83xnozOxK0OkGcu6l0Ei9U
         +mx5MOlU2ec3h0i4iuJ8HAWcUwbZpN0cNjjzZpB7PdKpbppD4ykRmGgdB4sRye5qWFaf
         LRqQgmCD0GXDqZeGDh2yPUSERpkIad8PW0scOhZTYYIccVFY3BS1kI2ZJY88wpds4FMr
         O+EA6f8vb7PI0AIiuC/3dDXc4mG/oQfNwSieDEBb+vAX7ydcz823A0kTT1paNJabp256
         +5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k+BonliAPowDteyZoYp6dggycLLuWAlBJRnflFJEQYs=;
        b=PDtp5k1QF/NSB1s9Dm10MEpwZ1och9utnKRPD+fPRiJ5/arq+vw45kUAuT8mcGCPxf
         S+q1qmsM0hUQAe6V7T/Km7pzv1u/F6RQpjSDJCPmYD6YriUXqbV7XhD/f4vxFdv/F+DS
         bu6c6TRBRBIl9cXlX6KLg0aS4NQQi+3nNINIzP7/53xAOFFjIgcpHBXGl9r0E5LSapHP
         VpT4GMF3e//RVbI1enJTF4+VI/A6nQKcttWshP87PLQABrQ+Dhv92FU9+/T7pU5Tr3QI
         MpgLqS9tquMM2DjZrZm9DtaxozWvkmVZdmxvVu9iD1Iq8ebqwMRGhLPzil3hfCcncfU4
         1+Qg==
X-Gm-Message-State: AOAM5321hJCjH+453iLAWEPCTZfBBsMnFToJV7/F7eHS88A87HFv4G3z
        zVV0AcDlho5r1khDCdJXqH15RA==
X-Google-Smtp-Source: ABdhPJzYZGdj4hq/G8MSGkPG+Shb6zvY/ZX8F3yPhiaWCwiQ8cGru71Ht/OXceJbj7EgwZ5c4p4eHw==
X-Received: by 2002:ac8:6112:: with SMTP id a18mr1519579qtm.401.1634155078959;
        Wed, 13 Oct 2021 12:57:58 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id h2sm294792qkf.106.2021.10.13.12.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 12:57:58 -0700 (PDT)
Date:   Wed, 13 Oct 2021 15:57:57 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/11] PageSlab: eliminate unnecessary compound_head()
 calls
Message-ID: <YWc6Re+XvZBkLlwC@cmpxchg.org>
References: <20211012180148.1669685-1-hannes@cmpxchg.org>
 <YWXgrhRDIxcoBhA1@casper.infradead.org>
 <YWXwXINogE0Qb0Ip@cmpxchg.org>
 <YWZQNj+axlIQrD5C@casper.infradead.org>
 <YWbj6+myCposUKk1@cmpxchg.org>
 <YWcdoktn30ofnsPO@casper.infradead.org>
 <YWc0a7zlWAdUSCdT@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWc0a7zlWAdUSCdT@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 03:33:00PM -0400, Johannes Weiner wrote:
> On Wed, Oct 13, 2021 at 06:55:46PM +0100, Matthew Wilcox wrote:
> > On Wed, Oct 13, 2021 at 09:49:31AM -0400, Johannes Weiner wrote:
> > > On Wed, Oct 13, 2021 at 04:19:18AM +0100, Matthew Wilcox wrote:
> > > > For today, testing PageSlab on the tail page helps the test proceed
> > > > in parallel with the action.  Looking at slub's kfree() for an example:
> > > > 
> > > >         page = virt_to_head_page(x);
> > > >         if (unlikely(!PageSlab(page))) {
> > > >                 free_nonslab_page(page, object);
> > > >                 return;
> > > >         }
> > > >         slab_free(page->slab_cache, page, object, NULL, 1, _RET_IP_);
> > > > 
> > > > Your proposal is certainly an improvement (since gcc doesn't know
> > > > that compound_head(compound_head(x)) == compound_head(x)), but I
> > > > think checking on the tail page is even better:
> > > > 
> > > > 	page = virt_to_page(x);
> > > > 	if (unlikely(!PageSlab(page))) {
> > > > 		free_nonslab_page(compound_head(page), object);
> > > > 		return;
> > > > 	}
> > > > 	slab = page_slab(page);
> > > > 	slab_free(slab->slab_cache, slab, object, NULL, 1, _RET_IP_);
> > > > 
> > > > The compound_head() parts can proceed in parallel with the check of
> > > > PageSlab().
> > > >
> > > > As far as the cost of setting PageSlab, those cachelines are already
> > > > dirty because we set compound_head on each of those pages already
> > > > (or in the case of freeing, we're about to clear compound_head on
> > > > each of those pages).
> > > 
> > > ... but this is not. I think the performance gains from this would
> > > have to be significant to justify complicating page flags further.
> > 
> > My argument isn't really "this is more efficient", because I think
> > the performance gains are pretty minimal.  More that I would like to
> > be able to write code in the style which we'll want to use when we're
> > using dynamically allocated memory descriptors.  It's all just code,
> > and we can change it at any time, but better to change it to something
> > that continues to work well in the future.
> > 
> > I don't think we end up with "virt_to_head_page()" in a dynamically
> > allocated memory descriptor world.  The head page contains no different
> > information from the tail pages, and indeed the tail pages don't know
> > that they're tail pages, or where the head page is.  Or maybe they're
> > all tail pages.
> 
> I agree with that, but future-provisioning is a tradeoff.
> 
> It'll be trivial to replace virt_to_head_page() with virt_to_page()
> and remove compound_head() calls when whatever is left of struct page
> will unconditionally point to a memory descriptor. And that can be
> part of the changes that make it so.

I.e. remove all the *to_head() stuff when head/tail pages actually
cease to be a thing, not earlier.

Essentially, I think it's the right direction to pursue, but I'm not
sure yet that it's exactly where we will end up.

> > I could see a world where we had a virt_to_memdesc() which returned
> > a generic memory descriptor that could be cast to a struct slab if
> > the flags within that memdesc said it was a slab.  But I think it works
> > out better to tag the memory descriptor pointer with a discriminator
> > that defines what the pointer is.  Plus it saves a page flag.
> > 
> > Maybe that's the best way to approach it -- how would you want to write
> > this part of kfree() when memory descriptors are dynamically allocated?

Yeah, or as Kent put it "how would you like the code to look like with
infinite refactoring?"

But that also implies we can do it in incremental, self-contained
steps that each leave the code base in a better place than before.

Which avoids building up dependencies on future code and unimplemented
ideas that are vague, likely look different in everybody's head, or
may not pan out at all.
