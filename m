Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4ED2434A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhJTLsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhJTLsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:48:10 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BEAC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:45:55 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id r17so2676550qtx.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vhvaoZ+wHJBa6Q68stwGndjLH++jNxGQGS33m44y204=;
        b=p+6RSM8zu41A9edVgEJFVALuyQXSLPZ+K/uBBm6aM+W1ROFU6TK4BRDvF3ET4KsV6G
         vUQiqVOCau1zQ3FBz1OfhdWaTinQXIwS7uy8um0HGCiwE17BS6sCucrCkC/ZRVqLfMQs
         99+z+AnQWTr8TmvhLiQoe5wRWm1ucBCnKT7SPpPpXRqDC1MlhpnHBYJ1JwIvhdqSHjMi
         R2r/wwU4C0Ycb3hO0rfvfspQxld29VphdheFp65xwLrui9qlm027QQ0+DfyIr7zDA2M4
         lrAqiUlBaJrJhW29ksxwYVmtPeHjJTY4GaGAPbWJZKN+DTXAZV73597dlhbRXDJp2aHG
         xpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vhvaoZ+wHJBa6Q68stwGndjLH++jNxGQGS33m44y204=;
        b=xQNPNbsb0bQAF9nGBFppPnq2iT/zIywNT3ZFPMErClvDfQNNClieWpzSOIOmAKRHnc
         8L9aDI5pTXdAhhl/yFSCJ6QbRjaEn5QOgTRrOojq7j8lit8zTd61NJR8vaHsy4oIYI0m
         mS6Wv+uwUPtSePQV82RN23GfJXdbKq6v/G3XhpebgwtIRnlT8X8ETdYNTWcsmER283LB
         LPLDrqNmMYSNyGObDZumVdsBF5v0BirCNK50tr488krjVvaCjZ2F4dWSIbNz0q/4TDGE
         OLiPFuRZ82raJwCt5+3bTj8DYdLM8jW70gHy4c794IKZZU4eAPTL86hXGmBrxssvWPO2
         8eaA==
X-Gm-Message-State: AOAM5307FNCGWbDvASt/5NiJYmjlc7E8373DIdp6HY0Bh+9iOX2YiOar
        gmmF2p98hx3D9Konl5DLi6BajwEMd5Q6r+u+vMY=
X-Google-Smtp-Source: ABdhPJwqeggaHeS4vdFzq8VqOVZD42AfkTVUHwtPn98HL6j4rhcJBTezcWbpnFTEuKzTDiC5b6E717eDsjqPhOo6kJA=
X-Received: by 2002:a05:622a:1998:: with SMTP id u24mr6305457qtc.156.1634730355177;
 Wed, 20 Oct 2021 04:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <1634278529-16983-1-git-send-email-huangzhaoyang@gmail.com>
 <YW0u67o8wl3CGikP@dhcp22.suse.cz> <CAGWkznEO9SyNFEBqL8=JxewVTvaUhwFLPow69mi=R1MJ=XCpow@mail.gmail.com>
 <YW1rcv4bN1WWhzLD@dhcp22.suse.cz> <CAGWkznG65_FGx9jU7rjj5biEdyHZ=kcPwmXj6cGxxVmPy2rdKQ@mail.gmail.com>
 <YW6LSVK+NTiZ05+X@dhcp22.suse.cz> <CAGWkznHSPAu572BjoE510Sm+G9vGetKg-v2TkjwtcmZGo8MPVw@mail.gmail.com>
 <YW7G7znfHxd52b/T@dhcp22.suse.cz> <CAGWkznGb05Uykxz=9K+8uB6axS7LCo_7hMXAn7DFJXvAmkFy5Q@mail.gmail.com>
 <YW/Zf/s/CtRFlJ87@dhcp22.suse.cz>
In-Reply-To: <YW/Zf/s/CtRFlJ87@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 20 Oct 2021 19:45:33 +0800
Message-ID: <CAGWkznHF8Q8VEiKmDHNXW7Lf2=37=YXC+oP0COxe7WhY4bPWiQ@mail.gmail.com>
Subject: Re: [PATCH] mm: skip current when memcg reclaim
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 4:55 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 20-10-21 15:33:39, Zhaoyang Huang wrote:
> [...]
> > Do you mean that direct reclaim should succeed for the first round
> > reclaim within which memcg get protected by memory.low and would NOT
> > retry by setting memcg_low_reclaim to true?
>
> Yes, this is the semantic of low limit protection in the upstream
> kernel. Have a look at do_try_to_free_pages and how it sets
> memcg_low_reclaim only if there were no pages reclaimed.
>
> > It is not true in android
> > like system, where reclaim always failed and introduce lmk and even
> > OOM.
>
> I am not familiar with android specific changes to the upstream reclaim
> logic. You should be investigating why the reclaim couldn't make a
> forward progress (aka reclaim pages) from non-protected memcgs. There
> are tracepoints you can use (generally vmscan prefix).
Ok, I am aware of why you get confused now. I think you are analysing
cgroup's behaviour according to a pre-defined workload and memory
pattern, which should work according to the design, such as processes
within root should provide memory before protected memcg get
reclaimed. You can refer [1] as the hierarchy, where effective
userspace workloads locate in protect groups and have rest of
processes be non-grouped. In fact, non-grouped ones can not provide
enough memory as they are kernel threads and the processes with few
pages on LRU(control logic inside). The practical scenario is groupA
launched a high-order kmalloc and introduce reclaiming(kswapd and
direct reclaim). As I said, non-grouped ones can not provide enough
contiguous memory blocks which let direct reclaim quickly fail for the
first round reclaiming. What I am trying to do is that let kswapd try
more for the target. It is also fair if groupA,B,C are trapping in
slow path concurrently.

[1]
root
|                                                       |
|              |
non-grouped processes             groupA    groupB  groupC
>
> --
> Michal Hocko
> SUSE Labs
