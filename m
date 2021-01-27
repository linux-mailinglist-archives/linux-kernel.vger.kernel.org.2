Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B133F3063F1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344413AbhA0TTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344300AbhA0TTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:19:38 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3B7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:18:58 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id u15so1600345plf.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=93SynukuYeg709JYhF7Ulm4tPXAZSEgL9ZbUq1MNWPg=;
        b=Vm7WFn/mtMq/xKPXg5onQUf7G4Oa5uUMg+ij1z8ZUcokyXxV1LMLwv774qzV0sn6Z8
         kKbOT6WWrhauaidzoGf32VpY03ukC+c+TsF4XIxEPF1TgWUnuhkWo2klpg3zddkhRyfL
         JAVHf+w6M1riQYLbHFjKnltu0JQhizSjmWMBcEUPTpx0FLHdtFBuPypb8VJkAh/VO6cW
         Jk62QN3836T11wyY9hSAuM/wgtuL6dHP4il8arp9HLRcgACnvmBi5PFJhXZ2sLAtDnZ8
         4LHGDdTIvMu9iFwxmTPBEXxohuS/ZnVvedQe8WG85BlHqu4c3BYwJps1AstkidzteKfQ
         2dtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=93SynukuYeg709JYhF7Ulm4tPXAZSEgL9ZbUq1MNWPg=;
        b=k2fqZcO8WnlVitCD5LQ//q5l9aMwWeBpb7ZieijMbL78/WWXZU2YU6Fuo3pL7hfnhm
         FMVTQpTP/UTi0BziNs35SBIwtHxCmThZTeSB2MWEOTFnkI3d258tgj5bDkihG8WYyq5o
         hx/Oacg5RAN+57azLbqFps/wxNut7R9xD5a32Podro7VhqGcMJ5ie7GD0u8nnKn3grwt
         KFUIxR51dz2CEetKAJkUrf+bhiWf98Q1104CifkUBWvYm7BgTCxqSDhQwPv+Ay9U2IVF
         gaB9ZqJ9GU5+6Y79UyY+XwlHkl+F9FBUEj2d/MpA8Eq6JniBCnzqiS+F/PDHMJx3OL4z
         eR1Q==
X-Gm-Message-State: AOAM531f42CLMlbpM/aSZLIFeGeiYmYEmKBe3W80geJ+oq1f/UAiRAUL
        DoJr4kPn/rsuln46DQL1nxdYBw==
X-Google-Smtp-Source: ABdhPJzPCEs7Fm91XUyHkwCy3jcz2AQo5nEL837xRx2JVkBm7bijnRR1T3NFn/eiTCXHdezOqZpRPQ==
X-Received: by 2002:a17:90a:7e82:: with SMTP id j2mr7148214pjl.217.1611775137707;
        Wed, 27 Jan 2021 11:18:57 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id p64sm3075517pfb.201.2021.01.27.11.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 11:18:56 -0800 (PST)
Date:   Wed, 27 Jan 2021 11:18:56 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH] mm, slub: remove slub_memcg_sysfs boot param and
 CONFIG_SLUB_MEMCG_SYSFS_ON
In-Reply-To: <20210127124745.7928-1-vbabka@suse.cz>
Message-ID: <69d1e35a-7324-5e7e-6a7-cb3246c865b6@google.com>
References: <20210127124745.7928-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021, Vlastimil Babka wrote:

> The boot param and config determine the value of memcg_sysfs_enabled, which is
> unused since commit 10befea91b61 ("mm: memcg/slab: use a single set of
> kmem_caches for all allocations") as there are no per-memcg kmem caches
> anymore.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: David Rientjes <rientjes@google.com>
