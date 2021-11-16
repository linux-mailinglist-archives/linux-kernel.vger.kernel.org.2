Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0190B453CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 00:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhKPXWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 18:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKPXWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 18:22:30 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EC3C061570;
        Tue, 16 Nov 2021 15:19:33 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id n85so816095pfd.10;
        Tue, 16 Nov 2021 15:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o10KqWnht6cmB5ddllrxH2n45i3Vp26vix6RdQhB//Q=;
        b=cvJ87lWGSV1MzgbkcDV37z/bzi6Nbu28fyF5ShxFHGQGJlOl2YGIFJnBKnCeTrGHa+
         SpUD/+lJsLMlBYl9jc/ReTO+pMSn9UPikiezuyp1v9V/21EtiCEHcEx4rMKXtb6gl5B3
         G8U9TP03x/7ikAhwg7LGbXC1HYDNkfkZa5wzKcP6K5Qyic3bnjvNfDM55mYQMQYmdet6
         koRp8IOjLAe5E4H0u+s6LWE896vPgVwZVD1vkM80EwP4AgzN8/5TvDY/GED9OgMjsnLG
         1KGsirwnmWPBWR0DRzgTXwT2b2oZcKQW/QTe2Gh2HTDgPJAB4ZSuy63hH81mFN660vxv
         rpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o10KqWnht6cmB5ddllrxH2n45i3Vp26vix6RdQhB//Q=;
        b=5pWfRjmLxpaVO7N9uFjUBcDHn+WZkhRKmRJsgX77GV0QsqG/OOOLbU/fW+b3jjI6Cx
         ilCT3qsupdWMI+gzfPPajSW+TMhVTJiWBtniS6yZqDrd2n4NrkPr+Lgm9NDNN69ZYU+f
         ljr/VUgU59i7Kw3OJv5KQoZfcaAAKHR+bhdgq/Q8NJBkFt/vt+7meND4Ik+kxNxTuaGX
         t0F0W3MGrwlEYDE7EB0R8RfPO1qmKHuLSxzd9Z0cK9EZ5ZtrRVz/l4E8mqQTMNGYUpgg
         EqhWPLjBK1VCkCbdp5fpv443jLfE3ktVG8nngEk9gXzOswBrv7AK0abCNBqmNt9KLv4A
         1Xlw==
X-Gm-Message-State: AOAM530aFv7MqxpjaCFUBCXfSvDVrY2u9wVA0ywXUXMymSO1hyJ+BE4x
        0V/3zIdW/irskEcoomqPsCs=
X-Google-Smtp-Source: ABdhPJwIy2PEM8dIrawMJ5qzJBEoPsIjpvEMwZo6vuyNqBtUk9t7FEtOS+nqv0ZiVVPWhCNifk/Tjg==
X-Received: by 2002:aa7:8611:0:b0:49f:a5b3:14b4 with SMTP id p17-20020aa78611000000b0049fa5b314b4mr44733165pfn.30.1637104772422;
        Tue, 16 Nov 2021 15:19:32 -0800 (PST)
Received: from nuc10 (d50-92-229-34.bchsia.telus.net. [50.92.229.34])
        by smtp.gmail.com with ESMTPSA id om8sm3449228pjb.12.2021.11.16.15.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 15:19:31 -0800 (PST)
Date:   Tue, 16 Nov 2021 15:19:29 -0800
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, corbet@lwn.net,
        djwong@kernel.org, david@fromorbit.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, dvyukov@google.com
Subject: Re: [PATCH v3] slob: add size header to all allocations
Message-ID: <YZQ8gUH9BjT4ukcI@nuc10>
References: <be7ee3a6-9b3c-b436-f042-82bd3c416acc@suse.cz>
 <20211029030534.3847165-1-rkovhaev@gmail.com>
 <037227db-c869-7d9c-65e8-8f5f8682171d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <037227db-c869-7d9c-65e8-8f5f8682171d@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 12:26:17PM +0100, Vlastimil Babka wrote:
> On 10/29/21 05:05, Rustam Kovhaev wrote:
> > Let's prepend both kmalloc() and kmem_cache_alloc() allocations with the
> > size header.
> > It simplifies the slab API and guarantees that both kmem_cache_alloc()
> > and kmalloc() memory could be freed by kfree().
> > 
> > meminfo right after the system boot, x86-64 on xfs, without the patch:
> > Slab:              35456 kB
> > 
> > the same, with the patch:
> > Slab:              36100 kB
> > 
> > Link: https://lore.kernel.org/lkml/20210929212347.1139666-1-rkovhaev@gmail.com
> > Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
> 
> Sorry for the late reply. I think we can further simplify this. We have:
> 
> static void *slob_alloc(size_t size, gfp_t gfp, int align,
> 			int node, int align_offset)
> 
> Previously there was one caller that passed size as unchanged, align_offset
> = 0, the other passed size + SLOB_HDR_SIZE, align_offset = SLOB_HDR_SIZE.
> Now both callers do the latter. We can drop the align_offset parameter and
> pass size unchanged. slob_alloc() can internally add SLOB_HDR_SIZE to size,
> and use SLOB_HDR_SIZE instead of align_offset.

Thank you, I'll send a v4.

