Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0AE4427992
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 13:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbhJILr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 07:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbhJILr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 07:47:56 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AF8C061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 04:45:59 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e7so5795521pgk.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 04:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ujYwsHZBVmm5oLHlnTuLYoOEg7HetCPfsuEX8hVwybI=;
        b=RDHhwEsUU16yULlbcS1WddwhWb8KlvE/Gnly0OqJeOiz6JZxhi1/kQwgMyDgC6YPmS
         WHjzC3NAM2bCODu2MyUhaQkAX+HTqQDTZcJ+PFvwC/xn8kDpV2bcSSsIy3I1HM+jeIvl
         fxl9jn1JmqU7l68jO/NXVVW7G3m6laEQC3RORKgNdx7d8EesFqSgG++aOyRWX/W71K2z
         SatkSba+0D9b582J+3+1ArJ7Nwk/e7UinmbSzoaNjUrzFy3c99FaIeGJ/REHpW2frF74
         OerhiScWCz8htuxmJ+NwMsEcPPJOuAWpZx0ibbNrSA5mBe/4TcMULchyBO/ZNvnE0GkJ
         YOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ujYwsHZBVmm5oLHlnTuLYoOEg7HetCPfsuEX8hVwybI=;
        b=m6GR/0kqGwELZlovHBi+nO32vOmP+mJTHjilRe+RUfe5ePDZwL++xGlaoRhdhlAIk2
         6fLaWZzi+MSfOID7BXJ+y2UbUKAKMWpuQntgRG0MEKN8aYaLuMbLOaJt1Y6SAexk0nsl
         sqsJlVSdYsytaBTFLyQKt4b31/DaQWs9eewH7eej4fzJ1APGPPDLjydFBpmh9QHPrUjs
         +vcY0Sy3CW68lRaRGZhWOn/Ri4O9et8UNU+X8Br4CwvGasqO4ZgxEQZY8m8OShDdHtXc
         xsmSbfOIFaVFA30Vu5kHaDs/ZwMsCThrHlBg1UsGwbYjJjpgl69XGNJ77ncCq26twPyC
         gsfg==
X-Gm-Message-State: AOAM532uHydRmreKvh4OQLSYpgAEqPQ72k2EyG43ayM2E/PrtYNtG7/g
        0ii5JwH8FEcz+q5dpYDiWFc=
X-Google-Smtp-Source: ABdhPJzUpGIJHLSe5LXQT+edL8naF6aqdpL1qHGES3VyxqtRelb1duCUFoTsAfQGGe9ENtXWLB9Iiw==
X-Received: by 2002:a05:6a00:10cc:b0:44c:852:41d8 with SMTP id d12-20020a056a0010cc00b0044c085241d8mr15502380pfu.54.1633779959339;
        Sat, 09 Oct 2021 04:45:59 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (24.151.64.34.bc.googleusercontent.com. [34.64.151.24])
        by smtp.gmail.com with ESMTPSA id s2sm14562353pjs.56.2021.10.09.04.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 04:45:59 -0700 (PDT)
Date:   Sat, 9 Oct 2021 11:45:54 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Almost no difference
Message-ID: <20211009114554.GA8165@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
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

On my machine,
L1 Data Cache: 32KB, 8-way associative, 64 byte line size
L1 Instruction Cache: 32KB, 8-way associative, 64 byte line size
L2 Unified Cache: 1MB, 16-way associative, 64 byte line size
L3 Unified Cache: 33MB, 11-way associative, 64 byte line size


I run hackbench with per-node coloring, per-cpu coloring, and without
coloring.

hackbench -g 100 -l 200000
without coloring: 2196.787
with per-node coloring: 2193.607
with per-cpu coloring: 2198.076

it seems there is almost no difference.
How much difference did you seen low associativity processors?

Hmm... I'm gonna search if there's related paper.

