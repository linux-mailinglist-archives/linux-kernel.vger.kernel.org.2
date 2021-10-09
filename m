Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41FB42749C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 02:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243969AbhJIAVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 20:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243892AbhJIAVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 20:21:04 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B77C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 17:19:08 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 133so4612813pgb.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 17:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=LB1tqTg7JIBTDwc1gmSEz4/wFsLPlTgEcqybliaCAkE=;
        b=cAFOFT5mTdnpWSMjey4+W+i0C9GYdGa3LD4bS8TYCC/opQjIXSln/+4NVLaQnGkRtB
         8Is88Flk0Tw1a62MWvn9VmtfiptDX1oppV6g4c1OraUO9Vex3hwyLCf8zrFB23Ddf62y
         tdskULK0/UKLWgGlOjKTU9vzTatQCXJ3BTXs9F+vRJKBF6ecZIpk6pGot8RKbF8UJsAa
         955dc+9MT8YN00YxNxZeVWHcoJ+hX2oNY8Sm8gt21nf8gnvfkaqqq0eBethEcuLOttyL
         vr8joAXYoKpZcoBYgetybmFkCbvxmQ7X9gWPvkD/qD4+AG+R4TYmfoAzBYCjHnBA4opQ
         VlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=LB1tqTg7JIBTDwc1gmSEz4/wFsLPlTgEcqybliaCAkE=;
        b=yWQkFxzULxfaesg4VGArc3CgGjl4Ipj3zGpdeN42vnEnG3R+vnoNY/yNHVySYl5zmi
         6WsBqMijO9popH+6n2S6HriBHp5fewsRfb9c9UkPDhQ8MFeoFZTjsClFgBqoovGRv5De
         RD4v8jQD8lkOW2uGusaJ/MWG2eSWRZMvYUOzWFidvmkebpe5F5fRgKIl4Inxlojm9JFq
         wIddjynub3FhLi4CEWfXQgTZIOSXSAyPhMwYVCsibuvPmj/1Mi/0pdkC44Fc5gVzFGCf
         n+q0McYTqyYWTtQyeKfjtZhFq+pDbVSNa+TThEiluwa3UoS3ZzaJ7SI1FY5VAVP4uISG
         V46g==
X-Gm-Message-State: AOAM53284C1VtLRYIHVWFBTw+Y6yppJp3Y4Em7PINM7uQbe3rYRauT4c
        GlNYx9VM4A7dekZJ9gb28WU=
X-Google-Smtp-Source: ABdhPJx5xE1U5RxvrbhFLR1CWLp141FmZ6zNLPMmjL63kvh9hL7vmOn+zNp7EpJ7l+WuVj7nczbVJg==
X-Received: by 2002:a63:6943:: with SMTP id e64mr7124543pgc.480.1633738748135;
        Fri, 08 Oct 2021 17:19:08 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (24.151.64.34.bc.googleusercontent.com. [34.64.151.24])
        by smtp.gmail.com with ESMTPSA id u12sm11739324pjr.2.2021.10.08.17.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 17:19:07 -0700 (PDT)
Date:   Sat, 9 Oct 2021 00:19:03 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC] Some questions and an idea on SLUB/SLAB
Message-ID: <20211009001903.GA3285@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Questions:

 - Is there a reason that SLUB does not implement cache coloring?
   it will help utilizing hardware cache. Especially in block layer,
   they are literally *squeezing* its performance now.
 
 - In SLAB, do we really need to flush queues every few seconds? 
   (per cpu queue and shared queue). Flushing alien caches makes
   sense, but flushing queues seems reducing it's fastpath.
   But yeah, we need to reclaim memory. can we just defer this?

Idea:

  - I don't like SLAB's per-node cache coloring, because L1 cache
    isn't shared between cpus. For now, cpus in same node are sharing
    its colour_next - but we can do better.

    what about splitting some per-cpu variables into kmem_cache_cpu
    like SLUB? I think cpu_cache, colour (and colour_next),
    alloc{hit,miss}, and free{hit,miss} can be per-cpu variables.
