Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55574359308
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhDIDbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbhDIDb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:31:28 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F43BC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 20:31:11 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id h7so3239306qtx.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 20:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=6UuQfMQF3OUZ83yBXGwyDB/n7MYxlPyfj5Q62eMYOas=;
        b=n0r36yzy05cjaLySQ0nj0iZxl6wD3E4lQ6XjHXdBIqrfwkHyxefdW5OcIoLS2tZ0YI
         LuyoNJdit33LPL5CN0O8ValmYVvyaO8c1H+Pa32tCe2s8yw9vN7yKw9fTj6NWR0XXldQ
         V5tKvHEeVR2d9dLU2jf46yC3lTz7U8cNQodrDZ9+2IL3eouiIzbagu1a+kD4XLmG/fmB
         DqZaLi9IfpC9FkwNMHXzDryhD/kETBKmfmFHIDhpcxd2c7fQv0HhQxpeoAOZ0W3Pjals
         WS1UMVcOaWeFwSQjoWOQd6jesuDkXUHFz+exC2VxfQg+NpLMLeAuhdeXWeH7grZAbrdL
         yDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=6UuQfMQF3OUZ83yBXGwyDB/n7MYxlPyfj5Q62eMYOas=;
        b=bXd4nc766l9potb8l0UV/2RkGt/0Cbu3XmCYE95tYB96O9hiu7TavpRClAOIPaoPN7
         R4RO58/SMU60r9+negJt4gFdI6K2ATIxqREPhOJV4p11CbafedA4rqr00pAvHdR2LK/r
         2DbAj96aKKbTWQyjr2cU/CC+GJo0vgTNHTpNhLlWLu9/Vxki6KTXKe8Zpo82QkBprKnA
         UyyU4v6VD4uJ+K1DGKFMHHSQ1OHeTBqyIcFb7NQ8oB+bczWZA7VjQr02Lmg3nBQLuCzv
         0LGe60HHbGSxwcCtV8xJF4MfmIS06zbwj7ZvOcWyWdf8Uqj2USXS0/ofS+QiCI5sUGcm
         XyYw==
X-Gm-Message-State: AOAM5329zq9+pF1tlSYNyFwzLUcoBHqSzvhcT+SGV3ezcKy4vQaz7CnB
        +VEIRwsK5l7Gl9LoX2j8eoo=
X-Google-Smtp-Source: ABdhPJxDnbslzKC7wrVB97E/nbUaKtOowt3QwqLALE//+XDB8gZptK7ggVkaiwxtYZrZlzhpsciICw==
X-Received: by 2002:ac8:6f2e:: with SMTP id i14mr10652056qtv.277.1617939070848;
        Thu, 08 Apr 2021 20:31:10 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com ([2804:14c:482:7b04::1000])
        by smtp.gmail.com with ESMTPSA id g11sm953629qkk.5.2021.04.08.20.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 20:31:10 -0700 (PDT)
Message-ID: <418f044aab385389681529b0b6057e75825b0e5f.camel@gmail.com>
Subject: Re: [PATCH 3/3] powerpc/mm/hash: Avoid multiple HPT resize-downs on
 memory hotunplug
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
Date:   Fri, 09 Apr 2021 00:31:03 -0300
In-Reply-To: <YFksMw8Hw/mC48yb@yekko.fritz.box>
References: <20210312072940.598696-1-leobras.c@gmail.com>
         <20210312072940.598696-4-leobras.c@gmail.com>
         <YFksMw8Hw/mC48yb@yekko.fritz.box>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David, thanks for commenting.

On Tue, 2021-03-23 at 10:45 +1100, David Gibson wrote:
> > @@ -805,6 +808,10 @@ static int resize_hpt_for_hotplug(unsigned long new_mem_size, bool shrinking)
> >  	if (shrinking) {
> > 
> > +		/* When batch removing entries, only resizes HPT at the end. */
> > +		if (atomic_read_acquire(&hpt_resize_disable))
> > +			return 0;
> > +
> 
> I'm not quite convinced by this locking.  Couldn't hpt_resize_disable
> be set after this point, but while you're still inside
> resize_hpt_for_hotplug()?  Probably better to use an explicit mutex
> (and mutex_trylock()) to make the critical sections clearer.

Sure, I can do that for v2.

> Except... do we even need the fancy mechanics to suppress the resizes
> in one place to do them elswhere.  Couldn't we just replace the
> existing resize calls with the batched ones?

How do you think of having batched resizes-down in HPT? 
Other than the current approach, I could only think of a way that would
touch a lot of generic code, and/or duplicate some functions, as
dlpar_add_lmb() does a lot of other stuff.

> > +void hash_memory_batch_shrink_end(void)
> > +{
> > +	unsigned long newsize;
> > +
> > +	/* Re-enables HPT resize-down after hot-unplug */
> > +	atomic_set_release(&hpt_resize_disable, 0);
> > +
> > +	newsize = memblock_phys_mem_size();
> > +	/* Resize to smallest SHIFT possible */
> > +	while (resize_hpt_for_hotplug(newsize, true) == -ENOSPC) {
> > +		newsize *= 2;
> 
> As noted earlier, doing this without an explicit cap on the new hpt
> size (of the existing size) this makes me nervous. 
> 

I can add a stop in v2.

>  Less so, but doing
> the calculations on memory size, rather than explictly on HPT size /
> HPT order also seems kinda clunky.

Agree, but at this point, it would seem kind of a waste to find the
shift from newsize, then calculate (1 << shift) for each retry of
resize_hpt_for_hotplug() only to point that we are retrying the order
value.

But sure, if you think it looks better, I can change that. 

> > +void memory_batch_shrink_begin(void)
> > +{
> > +	if (!radix_enabled())
> > +		hash_memory_batch_shrink_begin();
> > +}
> > +
> > +void memory_batch_shrink_end(void)
> > +{
> > +	if (!radix_enabled())
> > +		hash_memory_batch_shrink_end();
> > +}
> 
> Again, these wrappers don't seem particularly useful to me.

Options would be add 'if (!radix_enabled())' to hotplug-memory.c
functions or to hash* functions, which look kind of wrong.

> > +	memory_batch_shrink_end();
> 
> remove_by_index only removes a single LMB, so there's no real point to
> batching here.

Sure, will be fixed for v2.

> > @@ -700,6 +712,7 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add)
> >  	if (lmbs_added != lmbs_to_add) {
> >  		pr_err("Memory hot-add failed, removing any added LMBs\n");
> > 
> > +		memory_batch_shrink_begin();
> 
> 
> The effect of these on the memory grow path is far from clear.
> 

On hotplug, HPT is resized-up before adding LMBs.
On hotunplug, HPT is resized-down after removing LMBs.
And each one has it's own mechanism to batch HPT resizes...

I can't understand exactly how using it on hotplug fail path can be any
different than using it on hotunplug.
> 

Can you please help me understanding this?

Best regards,
Leonardo Bras

