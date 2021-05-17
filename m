Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B58386D73
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 01:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344342AbhEQXCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 19:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238778AbhEQXCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 19:02:02 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76512C061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 16:00:45 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v13so3994342ple.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 16:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J5UPtJBA2/uZss4lqlO0e1yXDcg7qUB+Zl/PUuJbbYE=;
        b=IWyM9sjVdu++omxyx1AMtdPQs4a0ozm7svxwu99rUMs1VRGo4TonL0IHdGzZb3uW5E
         xcXAAoCzpkvavTrGVB2nYvnsrfhEpqCrRXKN/hHngWLIfpgwnhEuoLK113dG/+BIyDuh
         Sj6y3fZ+nJNL/E6Q+hRNLJsBNkgTa4IqDF58R8kALne80FnSnzqfRr6HB5bVXC0tkqeQ
         3kxCS7V/DJGPsrLZs4VpsAFy5CYCCtEcff8VQy/Mh/EjPJFrJ/hrYQgn8pgHqyZSwFBV
         zs9wSfEPs0gcw3SoFy5hNxoxojXZMLp32MFdnQMLB+8jHTDwfh5nlsImKnHT0O5aqk1g
         Eo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J5UPtJBA2/uZss4lqlO0e1yXDcg7qUB+Zl/PUuJbbYE=;
        b=TzJ8NQ1+vrI8TafTqvodFpbq3qfoWKLs1mb/Miq3FchEPtTj761FgJ8uf7diL/ANuK
         7W4RmI/yfdx+wfcyGgsT+qoyq5ruZuiTUjMoxyMb3vDRSZFIMyJCgA8mrx0APnI2nBKc
         HzYH4xbqQ3zvogGd7dsrdvK7S74Dd36hc1mAlNrsgRz2Ok+BhFSkJ/0qeShFn1AXF1jz
         +2u7E0IR82aU51Ij0k/8QBwDaYGjcj/zqb9QIJRnXfv68agqvuCEHeBuERbXIRyeEOYL
         Rs/hTZUtMeSHo784M7ie9uQG3WaP3HMtCgpvfs6cFsHZeEAHLG6NdeIS9wZJs/Pk3ANu
         IMDA==
X-Gm-Message-State: AOAM532jxy5Usli0JUQwE1FIU/hnJxIgjyIGHrbk34cAYg7vtvhatGEp
        IfQ/GgYtkLpXLZ0yhL2qzI0Z6MGlmRkaKw==
X-Google-Smtp-Source: ABdhPJzHx/GzyV+cs+RXbfCjINrLXRVbUF9R3U+E1uvDqWvR1mQ7fgDj9nswene7Drh2+s6SOT/zVA==
X-Received: by 2002:a17:90a:aa96:: with SMTP id l22mr1517678pjq.173.1621292444994;
        Mon, 17 May 2021 16:00:44 -0700 (PDT)
Received: from hermes.local (76-14-218-44.or.wavecable.com. [76.14.218.44])
        by smtp.gmail.com with ESMTPSA id r5sm374912pjd.2.2021.05.17.16.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 16:00:44 -0700 (PDT)
Date:   Mon, 17 May 2021 16:00:36 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Dave Taht <dave.taht@gmail.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        bloat <bloat@lists.bufferbloat.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [Bloat] virtio_net: BQL?
Message-ID: <20210517160036.4093d3f2@hermes.local>
In-Reply-To: <CAA93jw7Vr_pFMsPCrPadqaLGu0BdC-wtCmW2iyHFkHERkaiyWQ@mail.gmail.com>
References: <56270996-33a6-d71b-d935-452dad121df7@linux.alibaba.com>
        <CAA93jw6LUAnWZj0b5FvefpDKUyd6cajCNLoJ6OKrwbu-V_ffrA@mail.gmail.com>
        <CA+FuTSf0Af2RXEG=rCthNNEb5mwKTG37gpEBBZU16qKkvmF=qw@mail.gmail.com>
        <CAA93jw7Vr_pFMsPCrPadqaLGu0BdC-wtCmW2iyHFkHERkaiyWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021 14:48:46 -0700
Dave Taht <dave.taht@gmail.com> wrote:

> On Mon, May 17, 2021 at 1:23 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Mon, May 17, 2021 at 2:44 PM Dave Taht <dave.taht@gmail.com> wrote:  
> > >
> > > Not really related to this patch, but is there some reason why virtio
> > > has no support for BQL?  
> >
> > There have been a few attempts to add it over the years.
> >
> > Most recently, https://lore.kernel.org/lkml/20181205225323.12555-2-mst@redhat.com/
> >
> > That thread has a long discussion. I think the key open issue remains
> >
> > "The tricky part is the mode switching between napi and no napi."  
> 
> Oy, vey.
> 
> I didn't pay any attention to that discussion, sadly enough.
> 
> It's been about that long (2018) since I paid any attention to
> bufferbloat in the cloud and my cloudy provider (linode) switched to
> using virtio when I wasn't looking. For over a year now, I'd been
> getting reports saying that comcast's pie rollout wasn't working as
> well as expected, that evenroute's implementation of sch_cake and sqm
> on inbound wasn't working right, nor pf_sense's and numerous other
> issues at Internet scale.
> 
> Last week I ran a string of benchmarks against starlink's new services
> and was really aghast at what I found there, too. but the problem
> seemed deeper than in just the dishy...
> 
> Without BQL, there's no backpressure for fq_codel to do its thing.
> None. My measurement servers aren't FQ-codeling
> no matter how much load I put on them. Since that qdisc is the default
> now in most linux distributions, I imagine that the bulk of the cloud
> is now behaving as erratically as linux was in 2011 with enormous
> swings in throughput and latency from GSO/TSO hitting overlarge rx/tx
> rings, [1], breaking various rate estimators in codel, pie and the tcp
> stack itself.
> 
> See:
> 
> http://fremont.starlink.taht.net/~d/virtio_nobql/rrul_-_evenroute_v3_server_fq_codel.png
> 
> See the swings in latency there? that's symptomatic of tx/rx rings
> filling and emptying.
> 
> it wasn't until I switched my measurement server temporarily over to
> sch_fq that I got a rrul result that was close to the results we used
> to get from the virtualized e1000e drivers we were using in 2014.
> 
> http://fremont.starlink.taht.net/~d/virtio_nobql/rrul_-_evenroute_v3_server_fq.png
> 
> While I have long supported the use of sch_fq for tcp-heavy workloads,
> it still behaves better with bql in place, and fq_codel is better for
> generic workloads... but needs bql based backpressure to kick in.
> 
> [1] I really hope I'm overreacting but, um, er, could someone(s) spin
> up a new patch that does bql in some way even half right for this
> driver and help test it? I haven't built a kernel in a while.
> 

The Azure network driver (netvsc) also does not have BQL. Several years ago
I tried adding it but it benchmarked worse and there is the added complexity
of handling the accelerated networking VF path.

