Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28ED3436F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 04:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhCVDAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 23:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhCVC7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 22:59:39 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA20C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 19:59:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id j25so9978241pfe.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 19:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8PSyfDnBNxdEv0JuzVsHXHjHmPcZoANyRQWH8adKcPU=;
        b=KeQ2EZhFTYagfAjvaNMYRY2V8nza7K0AVpdfi9X2lo8Gs3x7mT7i06esVkHvO3ZvU4
         lebgmxwhNqqUNxEOyZB+LLlOzZGqdINNcOrS5xMouPK7ioJkYNfJMcWj2C4Xk3ThbZRm
         8GKB6ZEdQA4FaSOrfEWq1IzQ59N0bVKT/RlsuZShrfAINBb3nFG+k3SvJ8H1DkZwRXii
         6rmpMRrm4lgT3oOiXCaydKA3ksPUrGXt6qz3Gmu1VOTrPhM6SwqZY7F40NJZ8bUjmyN3
         aQ8wjtQ42ctdLsXzmpPtVnhYx+ohKZvxauXtiqKdhk8igcIeeFQ17gBe7K77JoALBN1X
         lsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8PSyfDnBNxdEv0JuzVsHXHjHmPcZoANyRQWH8adKcPU=;
        b=CCOMKdWDpmoyviIk/X7yj3VBG4Z3neM0R/xK+NPpcF7RGqHWEjBKpHc69Wb/tOeL2/
         kwXpppf8CnP7GfhkjnRWlmbdCdp+0oAT+6wwQLmJsOkYOM1dVswnmDUyNBUPpchFcXRp
         7A2hBYWx8VHtXRQbSl0aM3PTBudpHqAl1B6YZ/IyEiKKOh057ucTbOlXdcClHbD4qd+R
         V1BYQs36PnHMY8LaLirFiUy9eoYlJFClWLFpENxUm0k09+WRH5bdKDT5Vr0iQqoaurot
         25XiMxIIhrfJu3pSyDq6uQBerHX25zH1KEBoYs6yzMxXAR4Rttxa19VFfkB72UOZQOWP
         NpEw==
X-Gm-Message-State: AOAM53053H7jpAJ46NYHU99WeBwrta0sJ5TVnrGLPnkzkzrM5j0GKpys
        oO6sfV+erQ9Kj3Aghj96g2cEpPJZ236ifdr4
X-Google-Smtp-Source: ABdhPJzP+wfmDE3n90GIkMs5FVkBLmsqxwWI8xoZ7BBqinIpDh/WojCEAWo5OUMjof16ChcmAc4HzQ==
X-Received: by 2002:aa7:86d9:0:b029:1ff:275c:b67a with SMTP id h25-20020aa786d90000b02901ff275cb67amr19223972pfo.69.1616381979110;
        Sun, 21 Mar 2021 19:59:39 -0700 (PDT)
Received: from localhost (121-45-173-48.tpgi.com.au. [121.45.173.48])
        by smtp.gmail.com with ESMTPSA id mp19sm14599055pjb.2.2021.03.21.19.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 19:59:38 -0700 (PDT)
Date:   Mon, 22 Mar 2021 13:59:34 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Daniel Axtens <dja@axtens.net>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH v11 6/6] powerpc: Book3S 64-bit outline-only KASAN support
Message-ID: <20210322025934.GG77072@balbir-desktop>
References: <20210319144058.772525-1-dja@axtens.net>
 <20210319144058.772525-7-dja@axtens.net>
 <20210320060259.GF77072@balbir-desktop>
 <87o8fcatxv.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8fcatxv.fsf@dja-thinkpad.axtens.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 11:55:08AM +1100, Daniel Axtens wrote:
> Hi Balbir,
> 
> > Could you highlight the changes from
> > https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20170729140901.5887-1-bsingharora@gmail.com/?
> >
> > Feel free to use my signed-off-by if you need to and add/update copyright
> > headers if appropriate.
> 
> There's not really anything in common any more:
> 
>  - ppc32 KASAN landed, so there was already a kasan.h for powerpc, the
>    explicit memcpy changes, the support for non-instrumented files,
>    prom_check.sh, etc. all already landed.
> 
>  - I locate the shadow region differently and don't resize any virtual
>    memory areas.
> 
>  - The ARCH_DEFINES_KASAN_ZERO_PTE handling changed upstream and our
>    handling for that is now handled more by patch 3.
> 
>  - The outline hook is now an inline function rather than a #define.
> 
>  - The init function has been totally rewritten as it's gone from
>    supporting real mode to not supporting real mode and back.
> 
>  - The list of non-instrumented files has grown a lot.
> 
>  - There's new stuff: stack walking is now safe, KASAN vmalloc support
>    means modules are better supported now, ptdump works, and there's
>    documentation.
> 
> It's been a while now, but I don't think when I started this process 2
> years ago that I directly reused much of your code. So I'm not sure that
> a signed-off-by makes sense here? Would a different tag (Originally-by?)
> make more sense?
>

Sure
 
> >> + * The shadow ends before the highest accessible address
> >> + * because we don't need a shadow for the shadow. Instead:
> >> + * c00e000000000000 << 3 + a80e 0000 0000 0000 000 = c00fc00000000000
> >
> > The comment has one extra 0 in a80e.., I did the math and had to use
> > the data from the defines :)
> 
> 3 extra 0s, even! Fixed.
> 
> >> +void __init kasan_init(void)
> >> +{
> >> +	/*
> >> +	 * We want to do the following things:
> >> +	 *  1) Map real memory into the shadow for all physical memblocks
> >> +	 *     This takes us from c000... to c008...
> >> +	 *  2) Leave a hole over the shadow of vmalloc space. KASAN_VMALLOC
> >> +	 *     will manage this for us.
> >> +	 *     This takes us from c008... to c00a...
> >> +	 *  3) Map the 'early shadow'/zero page over iomap and vmemmap space.
> >> +	 *     This takes us up to where we start at c00e...
> >> +	 */
> >> +
> >
> > assuming we have
> > #define VMEMMAP_END R_VMEMMAP_END
> > and ditto for hash we probably need
> >
> > 	BUILD_BUG_ON(VMEMMAP_END + KASAN_SHADOW_OFFSET != KASAN_SHADOW_END);
> 
> Sorry, I'm not sure what this is supposed to be testing? In what
> situation would this trigger?
>

I am bit concerned that we have hard coded (IIR) 0xa80e... in the
config, any changes to VMEMMAP_END, KASAN_SHADOW_OFFSET/END
should be guarded.

Balbir Singh.
