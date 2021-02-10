Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986CA316D07
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhBJRm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhBJRmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:42:10 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3361FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:41:30 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id o21so1676729pgn.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dGLuSqUXXuVXsA+05i4UxiT8airi5DH3dr+tpBhyP/c=;
        b=Kxu7mzpgBKECFR5krBksL+lnN9+0uI9rIhAvTImUhhRVyqZskVAW9gg56z+9MSmHAu
         44MkLA6Z0+aqFH9qFdSWaEBUzFp3zsYARIYTFzinMoJQd+inujWP0YYGgAjZtzHL6zLT
         1/YhVmuECobMmdppuvOZet3MLl98mguySNgYElotTGp3yCH2wnE873Uv/+zo9h6XP8sw
         JxbT3KubkCYrOFtyQNxtJl7qym3OZZuflUyGOEtJEOzv82ljCAO+lzIdas+BGAC0dJ4m
         KD8ADFEuP3eFBgbdc0cb0HIUyAD1iFhXNWFZIxOQwUXBbYcqnc//zNWL3r7Qo9WuQ44m
         8d6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=dGLuSqUXXuVXsA+05i4UxiT8airi5DH3dr+tpBhyP/c=;
        b=iCfTGChxq5hPrjMg10VR3+NWtkNmijnBFZ/8C/uilNLTcjH9QvCByF79+ctaoPwOCg
         jMzXQz1salLOmj9DfcVQh8ALC1SjZ6mVZqN7Wpn1JAPZuaGQZg8bOKPyeUvCaL1SpmUa
         Su0hzCvnbs0LShma5dsqtypQN47bcrXikvS11yGQ5R/jYLMj8ni27E7Vd/Rh2psrRUuV
         2G/fU4v/BdUKluQ7uguFj/3hQu/mM6CR0B7bsGq5OTlSvuuGVZJJTtsYGWxoS/1CQ4Z1
         giN18UYPfdxIXcIUN4Ril6Yz7C5uJTf9IeGsIYePJjccJsQqJx7CR/VmUpkLyreqryMf
         7SBA==
X-Gm-Message-State: AOAM531SHEwvahlnGvexexfT3cUpanE72olTjha9JiVoPHioM0959s2w
        PrrAClGD9P8c2ekSp07UY/M=
X-Google-Smtp-Source: ABdhPJys0MPxO6Uhzsj8fyry2OKslhC+Q6/Z0IY4kvRiOyIgzgMg3RGAVxcgirIZ1Ykky+5iG848OQ==
X-Received: by 2002:a63:1d25:: with SMTP id d37mr4057589pgd.205.1612978889691;
        Wed, 10 Feb 2021 09:41:29 -0800 (PST)
Received: from google.com ([2620:15c:211:201:e5b0:be96:1dfb:a1f6])
        by smtp.gmail.com with ESMTPSA id z10sm3140140pff.179.2021.02.10.09.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 09:41:28 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 10 Feb 2021 09:41:26 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] dma-buf: system_heap: do not warn for costly allocation
Message-ID: <YCQaxiaiJ8Ps8IkB@google.com>
References: <20210210162632.3903128-1-minchan@kernel.org>
 <CAJuCfpER=nbfY93CPf3Lz+bJcvAN8Vuqy6ZWZg12HnRGvznm+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpER=nbfY93CPf3Lz+bJcvAN8Vuqy6ZWZg12HnRGvznm+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 09:24:52AM -0800, Suren Baghdasaryan wrote:
> The code looks fine to me. Description needs a bit polishing :)
> 
> On Wed, Feb 10, 2021 at 8:26 AM Minchan Kim <minchan@kernel.org> wrote:
> >
> > Linux VM is not hard to support PAGE_ALLOC_COSTLY_ODER allocation
> > so normally expects driver passes __GFP_NOWARN in that case
> > if they has fallback options.
> >
> > system_heap in dmabuf is the case so do not flood into demsg
> > with the warning for recording more precious information logs.
> > (below is ION warning example I got but dmabuf system heap is
> > nothing different).
> 
> Suggestion:
> Dmabuf system_heap allocation logic starts with the highest necessary
> allocation order before falling back to lower orders. The requested
> order can be higher than PAGE_ALLOC_COSTLY_ODER and failures to
> allocate will flood dmesg with warnings. Such high-order allocations
> are not unexpected and are handled by the system_heap's allocation
> fallback mechanism.
> Prevent these warnings when allocating higher than
> PAGE_ALLOC_COSTLY_ODER pages using __GFP_NOWARN flag.
> 
> Below is ION warning example I got but dmabuf system heap is nothing different:

I will take it.
Thanks, Suren!

