Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181FB387A0C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349668AbhERNfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:35:07 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:44881 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349539AbhERNfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:35:05 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id CB1CF138E;
        Tue, 18 May 2021 09:33:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 18 May 2021 09:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=dFf5WOkSavXSozEUmyF23vNvgNn
        I6ayFO8rZHK3NyVs=; b=RV3erbT/q2HlYvg96af6Pc+ZWZHVPSWzsYwurq/55x5
        MbhMXSXSIogWrnTzsXrF5x+bLqTGuRtumiCBdbCeSwEBrAi3BDnqRb7aYF7QThX9
        8BM8kKWlsnTpMyXtAU2CI0sBFUrj8FcmAF+voGmeGhoXw1syEfJTRR6zb3gFhgyL
        hPW2CyFGO/pfMjSRge6RNeyBsP2YaaohNYgvbtHi1JjoMxJSDZ3C5dBuT3zByOs1
        kZdEyo6KkHgWtigIEOqDm9oHtkw6FhJhBt3KM3XtQsgeCQEYtBtsUbWCsTXhWwm7
        GsVaSEQhae65jXjjt3MhP3TlYx28AFSmpp+bnP7ApEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=dFf5WO
        kSavXSozEUmyF23vNvgNnI6ayFO8rZHK3NyVs=; b=ctwXa1+J4M16sZaGvwzOWb
        Jdwzfq/mfeVkZc+dyXEaU1368jeg+2N37tCAQGiGz3BIyeIYSux7awhC4bYaQi2s
        ahGnRjP4Jqgp2sXDvblT2kIpGy/lXTUvDWgcwD1FaO7BWWh170ci+OE+0teKLob6
        CjkaCrmv6o0t72dt7QazB9I5r5OpD7d1ST+uK+CG7XfQ7NjA/VCQtX8oO848ei3+
        RPAaRuBT5EdYfN0sTMhPf6h9r1AIKkv7Eth0II/f6bI0ND67X7xPgI2nZq9mdkpS
        ApS/zACX0kjLa3krkZ8/8Mv+pcjg954dadIm8l1E4/XaM/djszAf5SKW/ySLQChw
        ==
X-ME-Sender: <xms:OMKjYKwdez2d8iLH1nmI5NI-cqWMrrpReTa6FFOC6SURN7bOwuPoog>
    <xme:OMKjYGRGmpS4uWwcHHFlbwB6j_xk37KPO1jdNu_tIx-Hj6hvvGoSac13AKxYLYx21
    oW9fjEZvN36-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeijedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:OMKjYMUofnTzTqROixQHvzG_q7A9-qKQ3Bsw-5ErtLDASQaSZzFg_w>
    <xmx:OMKjYAjG16KtFj2mVodzqvy0PfwZKIrH8XnBv_0yDovezl3pCZlmZQ>
    <xmx:OMKjYMBFbu1QPebz-bn8ImBDVrdu-gNg5p5fkBDk7ywfw5IXr7IqBg>
    <xmx:OcKjYPXTiV3iOR08vEaFABw7aoYUn-VLX3At_H40wp8a3F7B0pybTrmfmM0>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 18 May 2021 09:33:43 -0400 (EDT)
Date:   Tue, 18 May 2021 15:33:41 +0200
From:   Greg KH <greg@kroah.com>
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        glittao@gmail.com, vinmenon@codeaurora.org
Subject: Re: [PATCH v5] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
Message-ID: <YKPCNT+yiBfkvnbP@kroah.com>
References: <1620296523-21922-1-git-send-email-faiyazm@codeaurora.org>
 <YJUpBWcFp+wlq9xT@kroah.com>
 <6d91e7cb-514f-8816-76b1-a70f6891a47a@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d91e7cb-514f-8816-76b1-a70f6891a47a@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 06:24:48PM +0530, Faiyaz Mohammed wrote:
> 
> 
> On 5/7/2021 5:18 PM, Greg KH wrote:
> > On Thu, May 06, 2021 at 03:52:03PM +0530, Faiyaz Mohammed wrote:
> >> alloc_calls and free_calls implementation in sysfs have two issues,
> >> one is PAGE_SIZE limitiation of sysfs and other is it does not adhere
> >> to "one value per file" rule.
> >>
> >> To overcome this issues, move the alloc_calls and free_calls implemeation
> >> to debugfs.
> >>
> >> Rename the alloc_calls/free_calls to alloc_traces/free_traces,
> >> to be inline with what it does.
> >>
> >> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
> >> ---
> >>  include/linux/slub_def.h |  10 ++
> >>  mm/slab_common.c         |   9 ++
> >>  mm/slub.c                | 362 ++++++++++++++++++++++++++++++++++++-----------
> >>  3 files changed, 299 insertions(+), 82 deletions(-)
> >>
> >> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> >> index dcde82a..f8c268d 100644
> >> --- a/include/linux/slub_def.h
> >> +++ b/include/linux/slub_def.h
> >> @@ -110,6 +110,9 @@ struct kmem_cache {
> >>  #ifdef CONFIG_SYSFS
> >>  	struct kobject kobj;	/* For sysfs */
> >>  #endif
> >> +#ifdef CONFIG_SLUB_DEBUG
> >> +	struct dentry *slab_cache_dentry;
> >> +#endif
> >>  #ifdef CONFIG_SLAB_FREELIST_HARDENED
> >>  	unsigned long random;
> >>  #endif
> >> @@ -159,6 +162,13 @@ static inline void sysfs_slab_release(struct kmem_cache *s)
> >>  }
> >>  #endif
> >>  
> >> +#ifdef CONFIG_DEBUG_FS
> >> +void debugfs_slab_release(struct kmem_cache *);
> >> +#else
> >> +static inline void debugfs_slab_release(struct kmem_cache *s)
> >> +{
> >> +}
> >> +#endif
> >>  void object_err(struct kmem_cache *s, struct page *page,
> >>  		u8 *object, char *reason);
> >>  
> >> diff --git a/mm/slab_common.c b/mm/slab_common.c
> >> index f8833d3..f3afe6b 100644
> >> --- a/mm/slab_common.c
> >> +++ b/mm/slab_common.c
> >> @@ -445,6 +445,9 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
> >>  #else
> >>  		slab_kmem_cache_release(s);
> >>  #endif
> >> +#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB)
> >> +		debugfs_slab_release(s);
> >> +#endif
> > 
> > If you write your .h files correctly, no need for #ifdef in a .c file.
> > 
> > Please fix up.
> > 
> fixed in new patch and used the single #ifded because
> debugfs_slab_release declaration is there in slub_def.h and slab_common
> is used for both slab and slub.
> Like SLAB_SUPPORTS_SYSFS, SLAB_SUPPORT_DEBUGFS will be not defined if
> slab config is used.

No, you should have have any #ifdef at all, as I point out in that
review.

thanks,

greg k-h
