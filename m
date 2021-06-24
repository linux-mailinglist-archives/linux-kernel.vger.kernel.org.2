Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B8A3B321F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 17:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhFXPDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 11:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhFXPDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 11:03:04 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D80C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 08:00:45 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id k10so10724298lfv.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VEtW/m2G4JMnkRazKy7NH/xx9Lmp9+147gFKq1PM9Yg=;
        b=WAWI8So/qhhVeppsIvdijPvUzdKdS80W6KrQW/YiWqHSSLQfZqqWsi1EBJnzuaRtvQ
         uwilI74b1Rj2CMfhicSt0oPI4F1Xekqj4XfrQLsepNL76BJ8xBCOBMSkY3Y1x6Gqw2sj
         7lvnVcUcP93CrANK0OjxaCB9Zt34DH2PHf5vKOMNRYu5V5fvB00/TP3EnPOIhIxca6Zl
         P+N/bo1Uu48b6MI43s1/NQYwIej3Cl/5IKT4nCsxBXfmhsKkx3WsExXRF4YkWlBeBjCu
         K43gwfpaWSvIznaF14eSVUglFjETBkIwB6IrOSXTcfm8yUGeHyxDJ3fgOm99lLecLaBD
         MiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VEtW/m2G4JMnkRazKy7NH/xx9Lmp9+147gFKq1PM9Yg=;
        b=taBZ6iOh+6/QGtoxM9zaPfFVSgfPOcM79TBiecXi4wkdQMrwqP2p2PnnMt5b3sNefn
         suuV7LM7AV2Esshep6hWmSDjB84Ky2XDnfR7SF2bpAwpJMziGN7LUbsrIrTx4+vWOOXu
         kh4yjJKOQ8NnH6ar8kjHJtHIVwstgxARGVhM0QhaIbpZwo/hSTm4bHOOQLPvIobaT2rU
         YiJ37SCBi7mt3cWwljU2diZ7nQeTcbSWAuLulDajjeJ3GhTRN/rUkgodDE5589FEQM/p
         WyYDWbAObt6eut5E8eej9RIzP07AXSZzxfKnNCNKgZ0SZ9Hc0d3DnNRR0ZfTfSO2Tupj
         FBxQ==
X-Gm-Message-State: AOAM532RAR8s8Da6pU2JpMp3w1LbjBN94qQmRCmlVpD9xHok5NOZIvDC
        lpTyQwMpDIlLi6OpNRDZs0iDz3W7Ezj1j0GMVKQ0Sg==
X-Google-Smtp-Source: ABdhPJycOg00GNdG4YJ4aGl9RCigJVkD9ALTczBVbkVgHKy7VLUFW33L9S9Uoh8460AKd9LLPMgakQpyXeA4ZPVT9aA=
X-Received: by 2002:ac2:545a:: with SMTP id d26mr4103361lfn.83.1624546843227;
 Thu, 24 Jun 2021 08:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210615174435.4174364-1-shakeelb@google.com> <20210615174435.4174364-2-shakeelb@google.com>
 <YNSQNu4ZW7mEX6LW@blackbook>
In-Reply-To: <YNSQNu4ZW7mEX6LW@blackbook>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 24 Jun 2021 08:00:31 -0700
Message-ID: <CALvZod4zaJZ1VjSQNvV7oUDZ58VYWvEUBa5WsGU4SYWnT70vbw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] memcg: periodically flush the memcg stats
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 7:01 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote=
:
>
> Hello Shakeel.
>
> On Tue, Jun 15, 2021 at 10:44:35AM -0700, Shakeel Butt <shakeelb@google.c=
om> wrote:
> > At the moment memcg stats are read in four contexts:
> >
> > 1. memcg stat user interfaces
> > 2. dirty throttling
> > 3. page fault
> > 4. memory reclaim
>
> Sorry for being dense or ignorant -- what do you refer to with the point
> no. 3 (memcg stats reader during page fault)?
>

Yes, specifically workingset_refault() which reads lruvec stats
directly through lruvec_page_state and indirectly through
lru_note_cost_page.
