Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD60E359239
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 04:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhDICv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 22:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhDICvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 22:51:55 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E32C061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 19:51:43 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id j1so1973730qvp.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 19:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=Ti/qpIJK0JqvHL8TU/tnfoeQ9Y9IJU2p+9Y0hgWyYLA=;
        b=dbL+4SuFGgzny/mPnRzaZ4dtQnvbr2GIofq9+J0p7ghVS5THzn0NrGyLRIsCM7ufDJ
         ntYXe6wRo1Qo7BO5TUGo3Swq5JspriqnLFEbKz4EPWmhmvrnLS7Hytszw8i7A2Wo+YFZ
         t43Iw1Qkun5eJ+ACmxXy3CoEA1Vr5ZjFXmMmFJGEM6BXfQWh3Uj23AOvh2iBmNItNO6s
         npsCM/CANpewDB/Ck5yama6lTO8stoQpz4bsbc3gVOoOJ6X8ToRVbsQO6HHt4ewimNDY
         NfRZpUtbPViUzQKO8bfhJDXM46PorufDiOlolfFB806LIh4XzXsDaw3/jRXedTS8hCrM
         uUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=Ti/qpIJK0JqvHL8TU/tnfoeQ9Y9IJU2p+9Y0hgWyYLA=;
        b=GlrEDYLtOFdKCE7PjtxQh2UfC578XLdmusX1GbtFpertlSG7aw6LKdAnFAcv0rh8+Y
         g9g+DAq+k2EuUhc3wd7JUmJJJj+WcotIcJUfKgCCLy8C75ot4Kqq9/Y5GgQJz2DGuxJR
         ih/3Z17Yj8I14+fJm7OVWW1/KVQhLg/20FWSlwHTxtRskje4ckS66zfA5IqHeMajQnOu
         B2S2DW2BLftFi0QpCI8R0OqHR9M1SJ20yu1VX7ODEIJScyoMpVtixc0jLEZhuh5wE3Uq
         CPZ+IhgZJcqWp0PfNeVZZjmw336OeYi5rQKJEmQNjxQ1QyWXXx06E5iOjN+GO2Jf8lj+
         INqA==
X-Gm-Message-State: AOAM531VI//6YQi6F9F8C21XlL75f12SVUEXUzQuXpGdjWn8/EyEoZJL
        ngneLttWj9oRDO0YA5OCfwQ=
X-Google-Smtp-Source: ABdhPJzTi39fAOMh7hkNEfyra0UzEUiu3Dt6zJYz5i979zxCQHEcKh6pILhSu5DdXRy7mGBRLE9K0w==
X-Received: by 2002:a0c:e84e:: with SMTP id l14mr12178774qvo.39.1617936702818;
        Thu, 08 Apr 2021 19:51:42 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com ([2804:14c:482:7b04::1000])
        by smtp.gmail.com with ESMTPSA id 26sm214093qtd.73.2021.04.08.19.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 19:51:42 -0700 (PDT)
Message-ID: <e5c924479839815c025de29d650d82419b18c0dc.camel@gmail.com>
Subject: Re: [PATCH 2/3] powerpc/mm/hash: Avoid multiple HPT resize-ups on
 memory hotplug
From:   Leonardo Bras <leobras.c@gmail.com>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sandipan Das <sandipan@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Mike Rapoport <rppt@kernel.org>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Apr 2021 23:51:36 -0300
In-Reply-To: <YFhNd42RvobCV8tF@yekko.fritz.box>
References: <20210312072940.598696-1-leobras.c@gmail.com>
         <20210312072940.598696-3-leobras.c@gmail.com>
         <YFhNd42RvobCV8tF@yekko.fritz.box>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David, thanks for the feedback!

On Mon, 2021-03-22 at 18:55 +1100, David Gibson wrote:
> > +void hash_memory_batch_expand_prepare(unsigned long newsize)
> > +{
> > +	/*
> > +	 * Resizing-up HPT should never fail, but there are some cases system starts with higher
> > +	 * SHIFT than required, and we go through the funny case of resizing HPT down while
> > +	 * adding memory
> > +	 */
> > +
> > +	while (resize_hpt_for_hotplug(newsize, false) == -ENOSPC) {
> > +		newsize *= 2;
> > +		pr_warn("Hash collision while resizing HPT\n");
> 
> This unbounded increase in newsize makes me nervous - we should be
> bounded by the current size of the HPT at least.  In practice we
> should be fine, since the resize should always succeed by the time we
> reach our current HPT size, but that's far from obvious from this
> point in the code.

Sure, I will add bounds in v2.

> 
> And... you're doubling newsize which is a value which might not be a
> power of 2.  I'm wondering if there's an edge case where this could
> actually cause us to skip the current size and erroneously resize to
> one bigger than we have currently.

I also though that at the start, but it seems quite reliable.
Before using this value, htab_shift_for_mem_size() will always round it
to next power of 2. 
Ex.
Any value between 0b0101 and 0b1000 will be rounded to 0b1000 for shift
calculation. If we multiply it by 2 (same as << 1), we have that
anything between 0b01010 and 0b10000 will be rounded to 0b10000. 

This works just fine as long as we are multiplying. 
Division may have the behavior you expect, as 0b0101 >> 1 would become
0b010 and skip a shift.
	
> > +void memory_batch_expand_prepare(unsigned long newsize)
> 
> This wrapper doesn't seem useful.

Yeah, it does little, but I can't just jump into hash_* functions
directly from hotplug-memory.c, without even knowing if it's using hash
pagetables. (in case the suggestion would be test for disable_radix
inside hash_memory_batch*)

> 
> > +{
> > +	if (!radix_enabled())
> > +		hash_memory_batch_expand_prepare(newsize);
> > +}
> >  #endif /* CONFIG_MEMORY_HOTPLUG */
> >  
> > 
> > +	memory_batch_expand_prepare(memblock_phys_mem_size() +
> > +				     drmem_info->n_lmbs * drmem_lmb_size());
> 
> This doesn't look right.  memory_add_by_index() is adding a *single*
> LMB, I think using drmem_info->n_lmbs here means you're counting this
> as adding again as much memory as you already have hotplugged.

Yeah, my mistake. This makes sense.
I will change it to something like 
memblock_phys_mem_size() + drmem_lmb_size()

> > 
> > +	memory_batch_expand_prepare(memblock_phys_mem_size() + lmbs_to_add * drmem_lmb_size());
> > +
> >  	for_each_drmem_lmb_in_range(lmb, start_lmb, end_lmb) {
> >  		if (lmb->flags & DRCONF_MEM_ASSIGNED)
> >  			continue;
> 
> I don't see memory_batch_expand_prepare() suppressing any existing HPT
> resizes.  Won't this just resize to the right size for the full add,
> then resize several times again as we perform the add?  Or.. I guess
> that will be suppressed by patch 1/3. 

Correct.

>  That's seems kinda fragile, though.

What do you mean by fragile here?
What would you suggest doing different?

Best regards,
Leonardo Bras

