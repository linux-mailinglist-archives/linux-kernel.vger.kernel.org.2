Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8519F3B3132
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhFXO0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhFXO0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:26:03 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A543AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:23:43 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id k10so10519172lfv.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KgFifCAkeZcDK+UcSraC2hixAdAzl9d3VxbSNqIWiCY=;
        b=pk1jq5HrE0hdxkVCtm3caTZvLlezJVNHc2CgejRXq2mDFm/+mHYNAN7Y6YSPf5kjop
         Wte61AOxEheZFhDgHXwG0XCArGbIcxLhPGxjrUfro9g/hkDYsfwpKBE2TewRkEJREVSA
         xaEAxi/lpbmgJ8Nn5lIaOuoks/sUhMKJqErMAm6ilif6+s+9d0Qc1OIzjHfk9cUrRX3W
         wnRmQxPsZUxKaFPSvY59GSsFFopCPLEtUpRFUWjUtDJEGw/1uDYaLQRD3CMqIbyBAJkw
         KU4Qpbo1BULIyb80B/mi42tK9/pYG7DscBykAr7NGJ84hVloxRk5DD3Xq5NEZmxiXQjs
         9kSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KgFifCAkeZcDK+UcSraC2hixAdAzl9d3VxbSNqIWiCY=;
        b=Ta3Gul9R3I/GI5bs7oY8H4UySd56FYUhyU8zqh7wr5l3aNVealSDGR9O9lNryzdfm/
         67WNoLquxjsZvNmUlpKnEvqfVleZZnqrVkhngNq7Ygn1lwlfqwJB0omzcB5m7O8gW8wR
         kATRUEGfVLPavWURgvkNCJ7F3FiyG2CDl7z7ZouCwFLnagBd239lbW6WsxS8XEW4OQee
         THYNFVNi2hInn1msPyCUbXS3klKz0VSdR4gTZsNdBq93tG1o/XUJvaNIqGP9UCLdW+sz
         3sVapVhmf4+jMLVwUQOYDF6kqcqAwhUJUMu9/O8Tbo4s+kHlzwv3txvVQsWzfELt28dO
         yeGQ==
X-Gm-Message-State: AOAM533nk2FBiZ9Y3aWV2c5kUd0/iiL7PY5HkVprEm4xEhmgsGCLwjwj
        lJso55lv5lW8JK1o8vpVHxVkcjjZpQ3DPg==
X-Google-Smtp-Source: ABdhPJyxuJO/aRxvP8GQQ8lLXbIUf5wM4BFtSNyc0DSL+K+6/l2nkfSwVmcyF4OkNZvRSYgBGEkN+g==
X-Received: by 2002:a05:6512:1327:: with SMTP id x39mr4252957lfu.37.1624544622039;
        Thu, 24 Jun 2021 07:23:42 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id m5sm304240ljo.88.2021.06.24.07.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 07:23:41 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 24 Jun 2021 16:23:39 +0200
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>
Cc:     Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmalloc: add cond_resched() in __vunmap()
Message-ID: <20210624142339.GA2267@pc638.lan>
References: <20210622225030.478384-1-aquini@redhat.com>
 <YNR4ZkwF+Bh11XMC@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNR4ZkwF+Bh11XMC@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 02:21:21PM +0200, Michal Hocko wrote:
> On Tue 22-06-21 18:50:30, Rafael Aquini wrote:
> > On non-preemptible kernel builds the watchdog can complain
> > about soft lockups when vfree() is called against large
> > vmalloc areas:
> > 
> > [  210.851798] kvmalloc-test: vmalloc(2199023255552) succeeded
> > [  238.654842] watchdog: BUG: soft lockup - CPU#181 stuck for 26s! [rmmod:5203]
> > [  238.662716] Modules linked in: kvmalloc_test(OE-) ...
> > [  238.772671] CPU: 181 PID: 5203 Comm: rmmod Tainted: G S         OE     5.13.0-rc7+ #1
> > [  238.781413] Hardware name: Intel Corporation PURLEY/PURLEY, BIOS PLYXCRB1.86B.0553.D01.1809190614 09/19/2018
> > [  238.792383] RIP: 0010:free_unref_page+0x52/0x60
> > [  238.797447] Code: 48 c1 fd 06 48 89 ee e8 9c d0 ff ff 84 c0 74 19 9c 41 5c fa 48 89 ee 48 89 df e8 b9 ea ff ff 41 f7 c4 00 02 00 00 74 01 fb 5b <5d> 41 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 f0 29 77
> > [  238.818406] RSP: 0018:ffffb4d87868fe98 EFLAGS: 00000206
> > [  238.824236] RAX: 0000000000000000 RBX: 000000001da0c945 RCX: ffffb4d87868fe40
> > [  238.832200] RDX: ffffd79d3beed108 RSI: ffffd7998501dc08 RDI: ffff9c6fbffd7010
> > [  238.840166] RBP: 000000000d518cbd R08: ffffd7998501dc08 R09: 0000000000000001
> > [  238.848131] R10: 0000000000000000 R11: ffffd79d3beee088 R12: 0000000000000202
> > [  238.856095] R13: ffff9e5be3eceec0 R14: 0000000000000000 R15: 0000000000000000
> > [  238.864059] FS:  00007fe082c2d740(0000) GS:ffff9f4c69b40000(0000) knlGS:0000000000000000
> > [  238.873089] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  238.879503] CR2: 000055a000611128 CR3: 000000f6094f6006 CR4: 00000000007706e0
> > [  238.887467] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [  238.895433] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [  238.903397] PKRU: 55555554
> > [  238.906417] Call Trace:
> > [  238.909149]  __vunmap+0x17c/0x220
> > [  238.912851]  __x64_sys_delete_module+0x13a/0x250
> > [  238.918008]  ? syscall_trace_enter.isra.20+0x13c/0x1b0
> > [  238.923746]  do_syscall_64+0x39/0x80
> > [  238.927740]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > 
> > Like in other range zapping routines that iterate over
> > a large list, lets just add cond_resched() within __vunmap()'s
> > page-releasing loop in order to avoid the watchdog splats.
> 
> cond_resched makes a lot of sense. We do not want vmalloc to be visible
> the userspace (e.g. by stalling it) so all time consuming operations
> should yield regularly whenever possible. I would expect that any
> susbsystem which needs huge vmalloc areas would have it for the whole
> boot life time so such large vfrees should be really rare.
> 
There is at least one more place with potentially similar issue. I see that
the bulk allocator disables irqs during obtaining pages and filling an array.

So i suspect if we request a huge size to allocate over vmalloc same soft
lockup should occur. For example 10G alloactions simultaneously on different
CPUs.

I will try to reproduce it on !CONFIG_PREEMPT kernel and post feedback here.

--
Vlad Rezki
