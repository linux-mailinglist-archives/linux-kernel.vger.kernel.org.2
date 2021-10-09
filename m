Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF26427545
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 02:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244051AbhJIAnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 20:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbhJIAm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 20:42:59 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7671C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 17:41:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ls18so8779089pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 17:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gbNbd7Wz3p2O73QmnnBxtoMhGaSnr/esB6d0N4BYdkI=;
        b=UdDACpcGI1OYHgzs7fn54lJkzb95zBJCcBzcGHNvaiBRASRQWD/q6MKpoOlieuDAdK
         VA9WjxdGPPpazXJ5w2HKmLOSjbaymw8QhO6irlr9R4gsvTVU/fe7HiEAMqSE2T7ADJMC
         zMZY6wOKabiw9VJcgpTGv5Zr6H21Kk/a6GLDIxTErukM6XU9wI/uZZkEl6U7V+UFK1J6
         Fsz82c/1p8NApmcnC6qonAyfKv9KD8RCE71s/pS9T9UJZbudo6pE5GcnsBOi6s0H+jit
         RUd/oCfW4XV+Qs6aEuFb1X//FHvWnu+LiA+dVQyvFS506KDB5NIrRbmJ2Tf5w4tKAKTn
         bXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gbNbd7Wz3p2O73QmnnBxtoMhGaSnr/esB6d0N4BYdkI=;
        b=yis8hcr3puCrntIXzaUE56A3Y+IlgNIpg2MT0ov6t0eiEkgj7UcIOabS0hDt9h38hV
         dWvxGc/R+BVZAj07m4h/8yP92X+zLKKEWg5jo4uXK4/C/ZkYzp7kOiEfw8mlRrkbjsjh
         yU/LNKOLf0g0bukU/xFtSmsaXukip4UpiS8T3b7xl67C81/+LWYPkdmM1VTXJpjf6U63
         6uLAKc5uWNFB3bMehKOY3H5j1wAJjHIgv0/HroqMucIhZP2wmbO6u2V0e+i6c55f8syo
         vbU0wpFXj3J8ix4W7tDWo/GuFTA2MAw1x60RIZ4VEmMt17ngkF30H31jHvFN10MaXff4
         H8XQ==
X-Gm-Message-State: AOAM532eH/ak/B7w8FGB7yr6q5cM41kx9y9QvClg0f7VKpD86fl/P1iL
        ohIPpFfFobD5xJBvUItmVEw=
X-Google-Smtp-Source: ABdhPJyYwe7zdrfsKr5vEd8p4BqsNBWp4hcUbTNFi5nOi3lN9tZWD/JsDhtna7BolMR7mhRN0f8aZw==
X-Received: by 2002:a17:902:b40a:b0:13d:cbcd:2e64 with SMTP id x10-20020a170902b40a00b0013dcbcd2e64mr12554348plr.18.1633740063356;
        Fri, 08 Oct 2021 17:41:03 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (24.151.64.34.bc.googleusercontent.com. [34.64.151.24])
        by smtp.gmail.com with ESMTPSA id lp9sm335253pjb.35.2021.10.08.17.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 17:41:03 -0700 (PDT)
Date:   Sat, 9 Oct 2021 00:40:58 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC] Some questions and an idea on SLUB/SLAB
Message-ID: <20211009004058.GA4992@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20211009001903.GA3285@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YWDjZ+KlkV2wKShh@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWDjZ+KlkV2wKShh@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2021 at 01:33:43AM +0100, Matthew Wilcox wrote:
> On Sat, Oct 09, 2021 at 12:19:03AM +0000, Hyeonggon Yoo wrote:
> >  - Is there a reason that SLUB does not implement cache coloring?
> >    it will help utilizing hardware cache. Especially in block layer,
> >    they are literally *squeezing* its performance now.
> 
> Have you tried turning off cache colouring in SLAB and seeing if
> performance changes?  My impression is that it's useful for caches
> with low associativity (direct mapped / 2-way / 4-way), but loses
> its effectiveness for caches with higher associativity.  For example,
> my laptop:
> 
>  L1 Data Cache: 48KB, 12-way associative, 64 byte line size
>  L1 Instruction Cache: 32KB, 8-way associative, 64 byte line size
>  L2 Unified Cache: 1280KB, 20-way associative, 64 byte line size
>  L3 Unified Cache: 12288KB, 12-way associative, 64 byte line size
> 
> I very much doubt that cache colouring is still useful for this machine.

Hello Matthew,
What benchmark did you use for test?

-
Hyeonggon
