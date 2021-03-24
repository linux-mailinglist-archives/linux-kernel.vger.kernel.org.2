Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F073479AF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbhCXNdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbhCXNcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:32:46 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595C0C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:32:46 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id n138so31987636lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MhDJbQFqmlzG4Q5PZ+EddHi8ImHiOeeMcvBa+QRSFmY=;
        b=OrvEY/UiOyO0t+M4n2uRkPQ2oZKBf3fQne2aSZagEC8NQraoyfxf93JfPvSuS69Wul
         RfKCoSNd2AAR6olqgHvz8OiEjcWZpPGJpEEfUh8LOyhXAt+WBQZWanrOBgMMasAjV380
         MTKG/czF7hFYGxklWZnyxvGhhvlaffaTihu3V71sTXSHHFK3NEHe6OQJLn9+WWCeOtmS
         DaJeOMrS+BrVj/LFk9tIj1iMxDUKemMYIpCrtmilXE/ytDGRuKMoutE31nDiseA7G1A9
         v7rYyi3tLM3Aue7FVvqjtMt0EJavpTSSOykFQJl58o2+vvgDwRQCsrlWyYWsfMVejU0f
         HhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MhDJbQFqmlzG4Q5PZ+EddHi8ImHiOeeMcvBa+QRSFmY=;
        b=drTY5ulNljgvyncT6DpG2gLSyGzUwMPQONHByTN3KfEMS1Vdg1xWiAH1lDsFCQZ4rN
         /p0ouVglUWnPQXeGsBuPIr0qNW6tFnIoOJcdQTg+UZFGyp8cyit6w3qTojdlRy3e1BaR
         cJxvCYfQQ4poAAkVh7GxP1bZlDZBhCTiKs3QK3Hjsj4VJTApiWye1+C0Md3zPA8hdrHx
         IRdDCDeZTeZ40I9/IN1DPQ/MtCX9QU2C0O4sRCI6Qk7fs9NrxOKMYzcVlzM0njFz0jc+
         5cPMvtWh4g5BcDr2l5AEl+BgI5TKCsPa8YZid8xfVkOJZFcGoY9xqJ0NFFzUZU3K0pJp
         DgtA==
X-Gm-Message-State: AOAM531dHjqsuRiC3M5zTez9YZhrVY231nN0JDlcNNNx2ukSvFNQub68
        En7TiJnBdqdxx7V8XF+3N9k=
X-Google-Smtp-Source: ABdhPJzp97PyjZ+uffvTaZygqpXWG7E/wrHLU7Kc0CxlVat/qjq8pxnjF37G+6/6h2L99Q6MRTshPg==
X-Received: by 2002:a19:6611:: with SMTP id a17mr2036724lfc.244.1616592764824;
        Wed, 24 Mar 2021 06:32:44 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id w26sm312546ljm.38.2021.03.24.06.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 06:32:44 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 24 Mar 2021 14:32:42 +0100
To:     Vijayanand Jitta <vjitta@codeaurora.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org
Subject: Re: [PATCH] mm: vmalloc: Prevent use after free in _vm_unmap_aliases
Message-ID: <20210324133242.GA1906@pc638.lan>
References: <1616062105-23263-1-git-send-email-vjitta@codeaurora.org>
 <20210318165907.GA10448@pc638.lan>
 <803dc8ec-d1a2-ed26-ddab-a5258e60d318@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <803dc8ec-d1a2-ed26-ddab-a5258e60d318@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On 3/18/2021 10:29 PM, Uladzislau Rezki wrote:
> > On Thu, Mar 18, 2021 at 03:38:25PM +0530, vjitta@codeaurora.org wrote:
> >> From: Vijayanand Jitta <vjitta@codeaurora.org>
> >>
> >> A potential use after free can occur in _vm_unmap_aliases
> >> where an already freed vmap_area could be accessed, Consider
> >> the following scenario:
> >>
> >> Process 1						Process 2
> >>
> >> __vm_unmap_aliases					__vm_unmap_aliases
> >> 	purge_fragmented_blocks_allcpus				rcu_read_lock()
> >> 		rcu_read_lock()
> >> 			list_del_rcu(&vb->free_list)
> >> 									list_for_each_entry_rcu(vb .. )
> >> 	__purge_vmap_area_lazy
> >> 		kmem_cache_free(va)
> >> 										va_start = vb->va->va_start
> > Or maybe we should switch to kfree_rcu() instead of kmem_cache_free()?
> > 
> > --
> > Vlad Rezki
> > 
> 
> Thanks for suggestion.
> 
> I see free_vmap_area_lock (spinlock) is taken in __purge_vmap_area_lazy
> while it loops through list and calls kmem_cache_free on va's. So, looks
> like we can't replace it with kfree_rcu as it might cause scheduling
> within atomic context.
> 
A double argument of the kfree_rcu() is a safe way to be used from atomic
contexts, it does not use any sleeping primitives, so it can be replaced.

From the other hand i see that per-cpu KVA allocator is only one user of
the RCU and your change fixes it. Feel free to use:

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thanks.

--
Vlad Rezki
