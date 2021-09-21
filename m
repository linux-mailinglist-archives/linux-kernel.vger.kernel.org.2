Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248AA412B40
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343766AbhIUCML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238572AbhIUB5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:57:46 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4ED4C0C751B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 18:03:57 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id e16so6610216qte.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 18:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ab6mrt8eLtfOXiNX18cD3uCLQ/P714WEFlH+2+wPhIY=;
        b=Cz6e4Ov2NR46OgTiD02xOzJny2s8FtvNztAj7MTEVPUTzKuBT86oZobXxMoH7f3dVc
         r0iDefjPydG+87axOBpvG6SQKdtBB1T+ZTvHVSNIrxarTOZBc8bR09+cIBAT7QpAF+Jb
         rYHlHqDyA4wof8VJWmT2HarLffzrTEccTE6pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ab6mrt8eLtfOXiNX18cD3uCLQ/P714WEFlH+2+wPhIY=;
        b=1mNhCYS0j62syiOePdq8qUn+4nSsuhGvyNAvsRV1+WMIFe0sD9LxvZ1x/vbvSRChhb
         JrKSgV02G9rqYT9UzlXvjHlZjCY2XsLldHreAkQUo5cOwj5svyFqu3JA97qunQFw5Ruz
         F0EH2x/F5gwfKMHL8lvcU/1FMe22RajXnueqAawQrsgjJ053dbx/USB5LGYibdYv1Ulq
         aLrqauW1CSDAsItTgB4U/+9n8VTuKTBB+JfaDiR5AQux3u7owizaTp+KiE0Wd00MLksS
         ol4X1f+J8y6iQ2VVWQRuXsNYC7ZRlWr0zWfdqfblql5RJYZSSfV6yDopLpaCLCy3OQxn
         Sjmw==
X-Gm-Message-State: AOAM531nwulKeVcnM2oVf5fqqHfQ2iMHWtOEjOO48mbGEgFCjmIIPlgc
        MrulhyVuXDIbbE8p86m+UiGMMg==
X-Google-Smtp-Source: ABdhPJznqotNDJseSjG5AmzAcOXCsElsWPgAg+BboCnYHPCGVcjkGJm3c0Od2522/vO3K6/1Ag++zA==
X-Received: by 2002:ac8:720a:: with SMTP id a10mr2671662qtp.76.1632186235509;
        Mon, 20 Sep 2021 18:03:55 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id g13sm12751259qkk.110.2021.09.20.18.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 18:03:55 -0700 (PDT)
Date:   Mon, 20 Sep 2021 21:03:53 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>, warthog9@kernel.org
Cc:     Minchan Kim <minchan@kernel.org>, zhengjun.xing@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Laura Abbott <labbott@kernel.org>,
        Oliver Sang <oliver.sang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        John Dias <joaodias@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>
Subject: Re: [PATCH v3] mm: fs: invalidate bh_lrus for only cold path
Message-ID: <20210921010353.shmojvzdtbijva57@meerkat.local>
References: <20210907212347.1977686-1-minchan@kernel.org>
 <CAHk-=wh2_yEuAC5=9VWefK+0JD9pAKf8qL-vpSmS7MtLA8SZEA@mail.gmail.com>
 <YUkeOB3GfK6KO8KG@google.com>
 <CAHk-=wgr+xHSgita2Q-HD2CPx5dfgY2jhnLwjk7Gtuv+bOxipA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgr+xHSgita2Q-HD2CPx5dfgY2jhnLwjk7Gtuv+bOxipA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 05:23:38PM -0700, Linus Torvalds wrote:
> Hmm. That message-id isn't found anywhere.
> 
> Maybe it was sent just to you personally?
> 
> [ Goes off and looks ]
> 
> Nope, I can see it in my mails too, and yeah, I see
> 
>   To: Minchan Kim <minchan@kernel.org>, kernel test robot
> <oliver.sang@intel.com>
>   Cc: Linus Torvalds <torvalds@linux-foundation.org>, Chris
> Goldsworthy <cgoldswo@codeaurora.org>, Laura Abbott
> <labbott@kernel.org>, David Hildenbrand <david@redhat.com>, John Dias
> <joaodias@google.com>, Matthew Wilcox <willy@infradead.org>, Michal
> Hocko <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
> Vlastimil Babka <vbabka@suse.cz>, Andrew Morton
> <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
> lkp@lists.01.org, lkp@intel.com
>   References: <20210520083144.GD14190@xsang-OptiPlex-9020>
> <YKasEeXCr9R5yzCr@google.com>
>   From: "Xing, Zhengjun" <zhengjun.xing@intel.com>
>   Message-ID: <89e2b66b-c706-c020-bff5-b815dcd5c461@intel.com>
> 
> but lore has no idea about it:
> 
>   https://lore.kernel.org/all/89e2b66b-c706-c020-bff5-b815dcd5c461@intel.com/
> 
> just says "Message-ID <89e2b66b-c706-c020-bff5-b815dcd5c461@intel.com>
> not found".
> 
> Strange.
> 
> Something presumably caused the list to drop that email.

I think vger is backed up. I've flagged this with John, hopefully he'll be
able to figure out what's keeping things from hitting the archives.

-K
