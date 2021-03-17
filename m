Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176C033FA72
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 22:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhCQV0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 17:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbhCQVZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 17:25:52 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C855C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 14:25:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id hq27so626516ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 14:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RWcOSSbP27/RBMgQWe11X/aJCQVEZ7g4yrghOGqiUdw=;
        b=G01FSC0WdaRw6SoJwmrtuo3o+0nBq50lAKF0vYw+O5GLViuiT9CjymaK2TMd68YDxc
         akyZ3CzMGnXOn1egPwiucNYPgXcWyMBPP0RZm2lhbN9Hwigt1GoT1lDEH/T5l54wuQa+
         /DOjjG2rFtESBup+N1zxrM5caaIQOPdHbhLA0B/5Y7DWzioZ/RHMYegEXM+gyBbP07v2
         6HeVccbZMsVEKWhodp1rOvHQmg+c8UAWd8elENbAAmIFd1fWh99BgA6x54OtFLYHvxpM
         tC8S09D4O8wrWRh2zUMRMIaOcgJPma3daJOYKaFjNnWEXiMD+XwWcpgeCIRNCrmJY937
         6m4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWcOSSbP27/RBMgQWe11X/aJCQVEZ7g4yrghOGqiUdw=;
        b=R2lrjtHDEtk4Ajs9NOXBanMjQPK6ZkE9oqsBu5/iCKZ/Ft7mkvm8O7GNSWxgkgrkA9
         THknRuCqsg5lEwC1bC1c9RqAV4rIxnBP4LIotSTAVgGQpZDvIKy/GGwGVANin0C7V7Qq
         xkzjCV1YRtsshk3Ew6bESc64JFxWEByCBlBzkUvRkZOPGhVGSsxhyhv+sMrlH1IPEwPz
         D8ozeg6hvXKyWjmftXv7OpHtAccxeXyxgArQ8DPz/4ltec71ZRISCLubNPKz7hrrgzQP
         Le29gURrpktfAIXhjOLG2jTOU9YGE0x7XCv7HoJfILtTPw8Faoj9+TrRNs1TS4ghKVj9
         rupA==
X-Gm-Message-State: AOAM5320MswD0LEZtug87iS5cMAlvTVWfCExB6W+Ym/DrXlE58SOKqTA
        rHWEJlQJ7eWYM+FEXyNonPCgnotAjfF/8x9JltCsSQ==
X-Google-Smtp-Source: ABdhPJyW21ya2MEzz1lGrPkE8yW6bR6Gw1paHRM622UMolppSnjoVAKlLNbZhpyPGThWRRkWRPec4nVVgJk8A2Z9sr0=
X-Received: by 2002:a17:906:25c4:: with SMTP id n4mr37937861ejb.359.1616016350818;
 Wed, 17 Mar 2021 14:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210303175235.3308220-1-bgeffon@google.com> <20210317191334.564944-1-bgeffon@google.com>
 <20210317204015.GM395976@xz-x1> <CADyq12z6vQ0qHs14aVOFgqfn9pvFak-vwEVmLTObMQ1exsOM+g@mail.gmail.com>
 <20210317211857.GN395976@xz-x1>
In-Reply-To: <20210317211857.GN395976@xz-x1>
From:   Brian Geffon <bgeffon@google.com>
Date:   Wed, 17 Mar 2021 17:25:14 -0400
Message-ID: <CADyq12xdH=WQCLU=Y9fZQKBca9OAb-Yco64WcLtZ1vp95fNEPA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: Allow non-VM_DONTEXPAND and VM_PFNMAP mappings
 with MREMAP_DONTUNMAP
To:     Peter Xu <peterx@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Dmitry Safonov <dima@arista.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You're 100% correct, I'll mail a new patch in a few

Brian


On Wed, Mar 17, 2021 at 5:19 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Mar 17, 2021 at 04:44:25PM -0400, Brian Geffon wrote:
> > Hi Peter,
>
> Hi, Brian,
>
> > Thank you as always for taking a look. This change relies on the
> > existing check in vma_to_resize on line 686:
> > https://elixir.bootlin.com/linux/v5.12-rc3/source/mm/mremap.c#L686
> > which returns -EFAULT when the vma is VM_DONTEXPAND or VM_PFNMAP.
>
> Do you mean line 676?
>
> https://elixir.bootlin.com/linux/v5.12-rc3/source/mm/mremap.c#L676
>
> I'm not sure whether it'll work for MREMAP_DONTUNMAP, since IIUC
> MREMAP_DONTUNMAP only works for the remap case with no size change, however in
> that case in vma_to_resize() we'll bail out even earlier than line 676 when
> checking against the size:
>
> https://elixir.bootlin.com/linux/v5.12-rc3/source/mm/mremap.c#L667
>
> So IIUC we'll still need the change as Hugh suggested previously.
>
> Thanks,
>
> --
> Peter Xu
>
