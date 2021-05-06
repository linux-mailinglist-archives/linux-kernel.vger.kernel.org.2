Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7629375A26
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 20:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhEFSZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 14:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhEFSZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 14:25:30 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7C0C061761
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 11:24:31 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id v6so8290617ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 11:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jEv5tsbty+v8OeQ9wP03mPApi7oS9HlG3cJxYfgNoiA=;
        b=cwWL6QfDfsK88627ETLN1flWqt9CgqYpMKMsnTfLYNl1q4lygFb0rZq1Lz0VwVsmrT
         AA9L6aOYWLWc8zfj+wGu+fTRyHCLoBzinxwLZ+RovMH7d0BzrMTIS/1t+Z5Na/ZsVpBS
         tPXeVSy7MvRWsvD3T64Pg72keOq3vST+61MvG326ReMWUIXXORBy8AI/uBrqCi0PujKV
         TrLfh6Xr7Tybx8Sza9TaTAeui8kUskm8BNtjkWdjkBwW1l53PKDohLZKu6PoGynPeHxs
         DzifD5lCoEgDClyS4w0wbpYYhUuq4kjnledeOK+gUfjx/j7/OLGYWNY51QaQj9vIvbYe
         lVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jEv5tsbty+v8OeQ9wP03mPApi7oS9HlG3cJxYfgNoiA=;
        b=fHvme3n264OJxKSZJaAIIvq+DzZfkfW82NbV2DpZL7AFzavaKQ8lh3b1y5Oxnt+5jU
         uMSUyTWKFgydlb+tumAnFRErPuaXFtwnQS/3NDXP2qOY7wPeoW4vNwk1YIJUZvl70BqQ
         UnYZoZjiSIZLGXrR+X4QZ8mJYxblPEUpVaWco+PDx0T0wWOuRxgqjtiu8w+62iYNgJLW
         von8Zc0DKtEJJguzVfS5nsIc5Ip3yZZU8ZcZcJJdiHhS2F5jhJck4NW4+SNfbLUlP+D0
         JAfiJzv8jQg0JgIj84cItL2tvm1SDmtonH23PxG03OHfTSRApFb/qF9pdVwZZOS1NCus
         cEcQ==
X-Gm-Message-State: AOAM532sCxwTX9fjwnOpLraxpNiZKFFEZnTAVIJqT4YCiEM0DBCIuDGR
        LNFh1iV1AMUO2Copsva6ZPf4d1SBckRRQPcEqdITJw==
X-Google-Smtp-Source: ABdhPJzy4hau3Y+ImQptMqxd6yvrIolm3ihuACWllTQt3Q7HCocEB90y1lMX8Lc4gL3EwqVc0U2JKjjqKX4V2//PC5c=
X-Received: by 2002:a2e:b5cd:: with SMTP id g13mr4757099ljn.0.1620325469530;
 Thu, 06 May 2021 11:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210505003032.489164-1-rick.p.edgecombe@intel.com> <20210505003032.489164-6-rick.p.edgecombe@intel.com>
In-Reply-To: <20210505003032.489164-6-rick.p.edgecombe@intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 6 May 2021 11:24:18 -0700
Message-ID: <CALvZod7ieLEObX0y-7X+_zMwaVN5o0P-ZwZVLqCAK5ytQrNs9w@mail.gmail.com>
Subject: Re: [PATCH RFC 5/9] x86, mm: Use cache of page tables
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linux MM <linux-mm@kvack.org>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 5:36 PM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
[...]
> +#ifdef CONFIG_PKS_PG_TABLES
> +struct page *alloc_table(gfp_t gfp)
> +{
> +       struct page *table;
> +
> +       if (!pks_page_en)
> +               return alloc_page(gfp);
> +
> +       table = get_grouped_page(numa_node_id(), &gpc_pks);
> +       if (!table)
> +               return NULL;
> +
> +       if (gfp & __GFP_ZERO)
> +               memset(page_address(table), 0, PAGE_SIZE);
> +
> +       if (memcg_kmem_enabled() &&
> +           gfp & __GFP_ACCOUNT &&
> +           !__memcg_kmem_charge_page(table, gfp, 0)) {
> +               free_table(table);
> +               table = NULL;
> +       }
> +
> +       VM_BUG_ON_PAGE(*(unsigned long *)&table->ptl, table);

table can be NULL due to charge failure.
