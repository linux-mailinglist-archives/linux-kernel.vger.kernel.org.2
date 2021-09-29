Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800E141C301
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 12:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245186AbhI2Kwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 06:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbhI2Kwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 06:52:42 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBF5C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 03:51:02 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id me5-20020a17090b17c500b0019af76b7bb4so3908618pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 03:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N2AhW7/yXhLS+p9DJTDAvEqVCt9e17qTEDDeFVYs/oY=;
        b=RyMsCYE/GPdmLMehhNEYi0Qph7BznA9IY+9JGPVQBGKKQZhfGujCDFjfXN0aNOTvjc
         WJZz2pTFcc5KoXTUkmys4FvxN81R8Tt/6lsy9HBPRSMKNl+XALjNFsMEG86+3jY9fvJy
         RrrFaPS2yC+cZfy/8SRHNxy7toTL/1ksLlaQIROq5ksLLdqKrKxvIuO4lr9C6t2SrME6
         O6Z74rGP5J55ZVT8jYQCganS6c0ujxxXItqnsNu4mHsZPnalkCvBGyG3uaFx3ofeYnXL
         B2FBSHxKgnpJ3uDGXt8QD1SqDIbVMs8zkJ0AL6c4KTByYF+VilK5bNPCSvA5kfJBH9T+
         49xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N2AhW7/yXhLS+p9DJTDAvEqVCt9e17qTEDDeFVYs/oY=;
        b=7aUqqD4n1uGwU9wi9adhtaiB+6XjLBE47kVFQbKy8Myl0QrllFa39GFxuPxoEPIwt4
         vJ9S2zI30eZIDJO9XXX+8EyScWgzxuB6Pq9PGPSFLtR2iLML3yAEXqW9ZFfaHf6t0TTh
         iD1bHC+b8xF0UFVwFAQQ4PIbCMd80FLs7JA2LNAGCGJ5xeXy8EcQDhkL0sDAmRP2YIuG
         3nirq0jOuOn7vU9rkLjs5WrBP9Jrv5snxI9zblz7WG+IgSW4oWJrmf3hogEuZ/3fcv09
         9Z2Sul1TcPh239W3WoXEeKG8aiPgKdZLs6WYJBsiCDZSOLoWMF7FO1L1hL2xVwf17Rpn
         qzWQ==
X-Gm-Message-State: AOAM530Bl27vYUTJ7jlImpoZNnV9EWE4tJn02z/l0INKJgIa18srzwe8
        2fa4vFB8RCiQrN2YvLKrZJQ=
X-Google-Smtp-Source: ABdhPJwAd/pndiC/AwN96gErn0OavyL6ztFJAOWT7JYWQaqQGmulRl3Biw0hqAU3wilVaxl3JThO+Q==
X-Received: by 2002:a17:90a:1912:: with SMTP id 18mr5900015pjg.24.1632912661740;
        Wed, 29 Sep 2021 03:51:01 -0700 (PDT)
Received: from linux.asia-northeast3-a.c.our-ratio-313919.internal (252.229.64.34.bc.googleusercontent.com. [34.64.229.252])
        by smtp.gmail.com with ESMTPSA id t24sm2308860pgn.78.2021.09.29.03.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 03:51:01 -0700 (PDT)
Date:   Wed, 29 Sep 2021 10:50:56 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] is SLAB considered legacy and deprecated?
Message-ID: <20210929105056.GA2575@linux.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20210927090347.GA2533@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <8aa15f4b-71de-5283-5ebc-d8d1a323473d@suse.cz>
 <20210928111231.GA2596@linux.asia-northeast3-a.c.our-ratio-313919.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928111231.GA2596@linux.asia-northeast3-a.c.our-ratio-313919.internal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 11:12:36AM +0000, Hyeonggon Yoo wrote:
> SLAB uses much memory than slab, 

not slab, slub.

> when there are *lots* of NUMA nodes.
> 	because kmem_cache_node exist per node and it keeps alien cache
> 	(used for caching freeing object from remote node),
> 	so it keeps MAX_NUMANODES ^ 2 of array_cache per slab.

not "per slab". it is per cache (kmem_cache).

it was my mistake. but that is still too much for
systems with high number of numa nodes.

batching freeing object from remote node is needed,
but slab uses too much memory for that.

for each node, it allocates alien cache for every other nodes.
so it's using MAX_NUMNODES ^ 2 alien_cache.

> 	that is why I said SLAB uses much memory than SLUB.

