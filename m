Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4F237F86B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhEMNKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 09:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhEMNKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 09:10:04 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D88C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 06:08:54 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id v191so21663989pfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 06:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gXNGtSr5Jfwp0sWTm9YEqRolUceYdaH5fX4XDPsA5Wo=;
        b=IEah8HvzvcEfL+hYEKAPPzkpt1lA/Enb+VxQKD8zSURITes1ef/i/y8nUuSsZ+q/yO
         M4L2uj2v3/0H9O7xwyk8SE6DJ9Q+Qi2hKTB35/m+ctU8KGPKUOupZKcivs1MwV8LA498
         iokoEyVwXMoeT5Wj6r1akF8KQ6Vq19jqw7X7fWfzmE6ZLUXExk4rZx50apD5CKNxk1AC
         ZxQisNERvhjLrItOeOeXqtp4bY36SgZcSiR7GPVbL7pef3dtGukxCDRkXqfGknQUeGyI
         +tdV5iY0yPEfjvWOeJ7agFBQ8N1yP0IWRTVdeShE7ePZ60JYMXfR1Q9gGmD5DWrvMy6a
         IYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gXNGtSr5Jfwp0sWTm9YEqRolUceYdaH5fX4XDPsA5Wo=;
        b=iiIj6aK5uQgZDa0R6AeqTFQn+TjFjWew146bbIPDRp65pYjtGNgZwMaywbuNyYCh4N
         VVsV8E1+m/l9hqJ3WpCT1ZUp4naPhN9QeKiMYC71sJS8C3AdnFmTVd7klKngZwFTPP/j
         OiKZfqweOxUrTlTCKZxdB5gRsSIKZ5mn0QsF/fF8hriR9FmrLbH7jgN6LyrO+tRfW0YC
         MBwJUzukieequ0E4COnE0CJoekVpIJoGH7jXAm4HL0W8rld+A6l8Zy173JbauDpiBnkB
         oXRUSLDh5GzOpFLPy68ywBBa40yl+APNlq8aRgjxFx32gAoqHczKyuQNIYyvM7+wT657
         yazg==
X-Gm-Message-State: AOAM533+WpbZnOgAlyR/ij6koo7HkfbfgFfYNBotvJvBPb4wVyNSn2JH
        NzU2MnMmNNHOnbRk8UBcGsI=
X-Google-Smtp-Source: ABdhPJyGxU2t9N4d1gexGsfQJoEiMS20c+Z6tN85lIBMVtzxpNBn92piE0I/17OqF1NO1aWquPU5Dg==
X-Received: by 2002:a05:6a00:b46:b029:2d3:3504:88d9 with SMTP id p6-20020a056a000b46b02902d3350488d9mr839174pfo.39.1620911333958;
        Thu, 13 May 2021 06:08:53 -0700 (PDT)
Received: from hyeyoo ([121.135.181.35])
        by smtp.gmail.com with ESMTPSA id w14sm2164690pff.94.2021.05.13.06.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 06:08:53 -0700 (PDT)
Date:   Thu, 13 May 2021 22:08:48 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm, slub: change run-time assertion in
 kmalloc_index() to compile-time
Message-ID: <20210513130848.GA778609@hyeyoo>
References: <20210511173448.GA54466@hyeyoo>
 <20210512195227.245000695c9014242e9a00e5@linux-foundation.org>
 <20210513031220.GA133011@hyeyoo>
 <20210512204024.401ff3de38649d7d0f5a45e8@linux-foundation.org>
 <20210513062809.GA319973@hyeyoo>
 <a36ab9a1-f07a-42ca-bb11-5bd0c70660bb@suse.cz>
 <YJ0ACtMpasnoZdUp@elver.google.com>
 <20210513120339.GA772931@hyeyoo>
 <CANpmjNP9AQ2PH9wtZbZ3bT=0YAqnaPpxAN0LgrjBO_PhzG5tjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP9AQ2PH9wtZbZ3bT=0YAqnaPpxAN0LgrjBO_PhzG5tjQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 02:29:13PM +0200, Marco Elver wrote:
> This doesn't solve the problem. We want the compiler to complain
> whenever kmalloc_index() is used with non-constant in normal code. But
> it should be possible to use it in allocator tests regardless of size.
> Either that or export kmalloc_slab(), but I think that's worse. I'll
> send my patch with an updated comment.


to explain in more detail,

in include/linux/slab.h:

  static __always_inline void *kmalloc(size_t size, gfp_t flags)                                                                                                                                           
  {                                                                               
        if (__builtin_constant_p(size)) {                                         
  #ifndef CONFIG_SLOB                                                             
              unsigned int index;                                                 
  #endif                                                                          
              if (size > KMALLOC_MAX_CACHE_SIZE)                                  
                    return kmalloc_large(size, flags);                            
  #ifndef CONFIG_SLOB                                                             
              index = kmalloc_index(size);  


it checks if size is bigger than KMALLOC_MAX_CACHE_SIZE.
so kmalloc_index works safely because the size was already checked.

and definition of KMALLOC_MAX_CACHE_SIZE is

in include/linux/slab.h:
  #ifdef CONFIG_SLAB                                                              
  #define KMALLOC_SHIFT_HIGH    ((MAX_ORDER + PAGE_SHIFT - 1) <= 25 ? \           
                          (MAX_ORDER + PAGE_SHIFT - 1) : 25)                      
  #define KMALLOC_SHIFT_MAX     KMALLOC_SHIFT_HIGH                                
  #ifndef KMALLOC_SHIFT_LOW                                                       
  #define KMALLOC_SHIFT_LOW     5                                                 
  #endif                                                                          
  #endif                                                                          
                                                                                  
  #ifdef CONFIG_SLUB                                                              
  #define KMALLOC_SHIFT_HIGH    (PAGE_SHIFT + 1)                                  
  #define KMALLOC_SHIFT_MAX     (MAX_ORDER + PAGE_SHIFT - 1)                      
  #ifndef KMALLOC_SHIFT_LOW                                                       
  #define KMALLOC_SHIFT_LOW     3                                                 
  #endif                                                                          
  #endif                                                                          
                                                                                  
  #ifdef CONFIG_SLOB                                                              
  #define KMALLOC_SHIFT_HIGH    PAGE_SHIFT                                        
  #define KMALLOC_SHIFT_MAX     (MAX_ORDER + PAGE_SHIFT - 1)                      
  #ifndef KMALLOC_SHIFT_LOW                                                       
  #define KMALLOC_SHIFT_LOW     3                                                 
  #endif                                                                          
  #endif

so if kmalloc_index is called from another place other than kmalloc,
it's not safe to assume that the supported size is 32MB.

Thanks, Hyeonggon
