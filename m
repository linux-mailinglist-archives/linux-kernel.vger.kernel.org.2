Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291AE343937
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 07:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCVGKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 02:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhCVGKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 02:10:02 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEDCC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 23:10:02 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id z9so13770672ilb.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 23:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Q+s1MiLMwx0bam3J6ExtRojLRZ6PSv31/x1AmahgfS8=;
        b=ISXPF8Sg8ajKIlAgfB6lB6CjajMUZdeB5dj5uFXcuUGHsznyrC3Ygf42nAnrgIqjzY
         6L/1vtu5i2BouZWc233qsj9xKmETcXm8mC7KP3vSDO0sN/ZVB5Us+Loow6qpSguCf0Ll
         PV6KNnoTryuLt3AeSGQy2X7BrMlSghE+vfYoxbZbelplZuyLh/CKlnxEWTITXRg1VivL
         J5rgmMEJXOtiKFyekXHh5NHIsuRxEAxgvfKFwCFoauJc6lvBd8m/clIl+BWcGoQox5du
         93gFZCm+lMRRhFPaynDcAcTZ+xX2JG9hun0+3MwDVeN2uOja5OAFrfwL3EFEk/2eWX+7
         XZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Q+s1MiLMwx0bam3J6ExtRojLRZ6PSv31/x1AmahgfS8=;
        b=QolMxTEPDw5grGzgr2oMySp4yIg6hfUXoKapSaro42zFLolfizN3THT8Ui13nxQ8H3
         aLGUWe2TnClS3sTmi+WCTIR/F31LtkObNKW8Ht/tLSZqjACIBcTicXawn8gsWtg1O9B1
         qW2fVmGvl6deBizxdLvtEGK3Vo2OtiLey+If9sQYx5ymDuOekRgqVlF9FGOrOKw3Nlm3
         smYJFouRAkoaZaOjclhzTzFhgMWw8dn/QpfjNYd3/yx9Y1htKJiUEaamEUiaqD1QARxo
         WFaLZMi56xAxtr4f1TyINR/56Hu2dTc/2qY6jMFd9BSQLt08iQW2YGUVBtIZedG28kgK
         fRhg==
X-Gm-Message-State: AOAM530Ek+IORKD4dGJuaEBWyYRRGtHbStVvjzd0P/N99zCtTCStaHEJ
        S7A/TIE2gChrvKtJONJ1weCCEg==
X-Google-Smtp-Source: ABdhPJzDexgLwHM4O3mCR+nFOjO61au1zX2EwG3zFu94761WO2LWa+vfsdNeyZz0QzQuKC+KG/T4Fg==
X-Received: by 2002:a05:6e02:188f:: with SMTP id o15mr3466697ilu.178.1616393401589;
        Sun, 21 Mar 2021 23:10:01 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:44ef:831f:a5ff:abb6])
        by smtp.gmail.com with ESMTPSA id e6sm6912822ioq.13.2021.03.21.23.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 23:10:00 -0700 (PDT)
Date:   Mon, 22 Mar 2021 00:09:56 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, page-reclaim@google.com
Subject: Re: [PATCH v1 14/14] mm: multigenerational lru: documentation
Message-ID: <YFg0tBswj0VhZLAA@google.com>
References: <20210313075747.3781593-1-yuzhao@google.com>
 <20210313075747.3781593-15-yuzhao@google.com>
 <cfef5a43-8be1-3890-e04b-eaac433f59c2@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfef5a43-8be1-3890-e04b-eaac433f59c2@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 05:31:20PM +0800, Alex Shi wrote:
> 
> 
> 在 2021/3/13 下午3:57, Yu Zhao 写道:
> > +Recipes
> > +-------
> > +:Android on ARMv8.1+: ``X=4``, ``N=0``
> > +
> > +:Android on pre-ARMv8.1 CPUs: Not recommended due to the lack of
> > + ``ARM64_HW_AFDBM``
> > +
> > +:Laptops running Chrome on x86_64: ``X=7``, ``N=2``
> > +
> > +:Working set estimation: Write ``+ memcg_id node_id gen [swappiness]``
> > + to ``/sys/kernel/debug/lru_gen`` to account referenced pages to
> > + generation ``max_gen`` and create the next generation ``max_gen+1``.
> > + ``gen`` must be equal to ``max_gen`` in order to avoid races. A swap
> > + file and a non-zero swappiness value are required to scan anon pages.
> > + If swapping is not desired, set ``vm.swappiness`` to ``0`` and
> > + overwrite it with a non-zero ``swappiness``.
> > +
> > +:Proactive reclaim: Write ``- memcg_id node_id gen [swappiness]
> > + [nr_to_reclaim]`` to ``/sys/kernel/debug/lru_gen`` to evict
> > + generations less than or equal to ``gen``. ``gen`` must be less than
> > + ``max_gen-1`` as ``max_gen`` and ``max_gen-1`` are active generations
> > + and therefore protected from the eviction. ``nr_to_reclaim`` can be
> > + used to limit the number of pages to be evicted. Multiple command
> > + lines are supported, so does concatenation with delimiters ``,`` and
> > + ``;``.
> > +
> 
> These are difficult options for users, especially for 'races' involving.
> Is it possible to simplify them for end users?

They look simple for a few lruvecs, but do become human-unfriendly on
servers that have thousands of lruvecs.

It's certainly possible simplify them, but we'd have to sacrifice
some flexibility. Any particular idea in mind?
