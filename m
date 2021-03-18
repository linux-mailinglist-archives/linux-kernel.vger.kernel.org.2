Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF8F340ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhCRQ7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 12:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhCRQ7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 12:59:13 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C02C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 09:59:13 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id u20so8338204lja.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YMrggABsnZJ+ZXH9liZmlQCij8GSsr394Gpx+UK66oA=;
        b=Jeut3itmky30azxyzWFWMjRvFxF+exGrDtA9srFYbGOwBYPtZAgkwCYNvPclFzpEWV
         6uprkOejOZQMLRwiJqFqxHqudVreaMMESCdqidv4FUM4fJBNJPf/sdwudvWZul8q99Wj
         tlaa6jM7zZUJqLdE+jsaJ+by6GggNpaKVbwIIX60pA8Ww0BsANcJQ/igVik2FOqqYSkc
         /E8t+g5fzeFyj51OirThPVImdERuU8nhIFdwFjg4BQQupLF9vcrtB+y9lsbRAKPqpKZ4
         xinL8ONnXH07fwWzLbmgBopI/gwjtOz2Akn7VB8CR7t257PjfQNK6mjKa1mvj5FNR+kv
         dTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YMrggABsnZJ+ZXH9liZmlQCij8GSsr394Gpx+UK66oA=;
        b=cUfJvOveGydGd2MXVgbmZc5KDLxwa7xbBXryI3nb5HbyRE0tkI0qzVLj00pQIrkIWB
         itgft8t3wm7b5/jL/PvE/BnpPqCc/X+KXmG4ER+llf2aAC1k3vaJxI6c85KA4c4jWf0V
         SmcJsvJpX3Hy0LoPkjYFT+vwYCPOxpyOW+pE+kYWWBGMRDD9Wb4PTPzc3iUDGDDHi8zC
         wILpDdaA9m9VNColrOl21gsg0SMKUGQuGwI+DDe88QCfSTPd6ecK76ycCXrvY8s9v/xV
         srUW2XKVTAU5Kn1Esq+6o7P3Jh3cS7kG/MaT/BDZDBAcQ61K5/DvjRKyu+A7b73bbiEx
         A4Fw==
X-Gm-Message-State: AOAM5301jC+mw3yt5rYbOB/qGIW9pVOfoiFvCvMTjw+rOdnAEZzosrqm
        yyiO9qLJlXJUiKXOMzWNERMPFMdpXbc=
X-Google-Smtp-Source: ABdhPJxI9vhvprPuimBHRjKQuE2wRnNH3gIGfmc85DlGSsaBDpd37m0Poo1nSvgbpfib/Hq+qefIgA==
X-Received: by 2002:a2e:9a98:: with SMTP id p24mr6001300lji.265.1616086750123;
        Thu, 18 Mar 2021 09:59:10 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id d8sm286841lfa.49.2021.03.18.09.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 09:59:09 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 18 Mar 2021 17:59:07 +0100
To:     vjitta@codeaurora.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
Subject: Re: [PATCH] mm: vmalloc: Prevent use after free in _vm_unmap_aliases
Message-ID: <20210318165907.GA10448@pc638.lan>
References: <1616062105-23263-1-git-send-email-vjitta@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616062105-23263-1-git-send-email-vjitta@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 03:38:25PM +0530, vjitta@codeaurora.org wrote:
> From: Vijayanand Jitta <vjitta@codeaurora.org>
> 
> A potential use after free can occur in _vm_unmap_aliases
> where an already freed vmap_area could be accessed, Consider
> the following scenario:
> 
> Process 1						Process 2
> 
> __vm_unmap_aliases					__vm_unmap_aliases
> 	purge_fragmented_blocks_allcpus				rcu_read_lock()
> 		rcu_read_lock()
> 			list_del_rcu(&vb->free_list)
> 									list_for_each_entry_rcu(vb .. )
> 	__purge_vmap_area_lazy
> 		kmem_cache_free(va)
> 										va_start = vb->va->va_start
Or maybe we should switch to kfree_rcu() instead of kmem_cache_free()?

--
Vlad Rezki
