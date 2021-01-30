Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0799430932E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhA3JUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhA3JUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 04:20:15 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75BAC061353
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 00:49:01 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id w18so7738022pfu.9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 00:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=VPPQK3MYARFNPka0GW0BKWI8SGFdjK1DBHoMEVMkIm4=;
        b=Qsey4FGl9nvu2x/jd6bpXS3rKOqLJXy9LdnmzyuLg7dsH4D+8c2CNWzJRbJonj43xp
         HfrIZGFojh2ynt8QDw5pcamIGbuHWVLVFCXjvRUVqXXFpkJEwwbUHsd21nEcWbwsw/oi
         piwkVpbCOb2pg/enEafEo+HVTV96UfBecfC2l1lKJxeVBAclkpg4AvMpoxEYXSOQI0gk
         2wj2nS5ulquxkpqA/zaj1BRfxG5s6jPQ1hWy3Sy9+BhJRSojJx7w+x1FuA2jiVzhAPHb
         mMutHNQbcJQSi7klFYeKolkGTR0SkOU3plbrRYnCfBIkdVE0PjifvhPBetl/uIa0IQww
         j59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=VPPQK3MYARFNPka0GW0BKWI8SGFdjK1DBHoMEVMkIm4=;
        b=RtHDcMiEldVv6DJIMViBE2eQGWHq9iMqq0caIfdUJnjJ0ZfG+f8Si8f+W+h0JdKKzg
         vZ/O1npYjORXSzgt6J0fjljTd5k/BruTbmVwzzuBlBHxDCqRePenN0YD1a+9cKbWO69b
         gmOU2OlDVbzifnVLzedFjL0969LnVSIp918liHHvGsP6iVu9LtXlQxih/3n0DUE8hjKH
         6xnQkieozAI/uWgTvE0tCm+isqREgocTYzjQq/9MtFkWbKCDn3jBeT6y5QLO1RRA3gSK
         uXNkoLz5RaWzisgk9PbT9IL/Yu9qwetMfZtjwu1NbyeyWMy4hk3o7fSh3KqdJRZOt2bl
         EnDQ==
X-Gm-Message-State: AOAM533oZFJlaSxKFQF2/HmwDt1KViiHXwqrjSTENpuTiVvFZC/KwSSF
        1sWYiNSlRfjKKQw8ZKNjpysIhg==
X-Google-Smtp-Source: ABdhPJzpYIOdqiFPbQlzZUqRBC8ZCwu6SwcWVnHq3VTBCRyWFiNZQGTzv7ubm6hfTHvk8Mxu1WMgBA==
X-Received: by 2002:a63:e54f:: with SMTP id z15mr8201841pgj.247.1611996541042;
        Sat, 30 Jan 2021 00:49:01 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id p7sm10888408pfn.52.2021.01.30.00.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 00:49:00 -0800 (PST)
Date:   Sat, 30 Jan 2021 00:48:59 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     David Hildenbrand <david@redhat.com>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_alloc: count CMA pages per zone and print
 them in /proc/zoneinfo
In-Reply-To: <20210129113451.22085-1-david@redhat.com>
Message-ID: <cadaa7ed-27e9-587d-5cc3-6d3f5c3b2e69@google.com>
References: <20210127101813.6370-3-david@redhat.com> <20210129113451.22085-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jan 2021, David Hildenbrand wrote:

> Let's count the number of CMA pages per zone and print them in
> /proc/zoneinfo.
> 
> Having access to the total number of CMA pages per zone is helpful for
> debugging purposes to know where exactly the CMA pages ended up, and to
> figure out how many pages of a zone might behave differently, even after
> some of these pages might already have been allocated.
> 
> As one example, CMA pages part of a kernel zone cannot be used for
> ordinary kernel allocations but instead behave more like ZONE_MOVABLE.
> 
> For now, we are only able to get the global nr+free cma pages from
> /proc/meminfo and the free cma pages per zone from /proc/zoneinfo.
> 
> Example after this patch when booting a 6 GiB QEMU VM with
> "hugetlb_cma=2G":
>   # cat /proc/zoneinfo | grep cma
>           cma      0
>         nr_free_cma  0
>           cma      0
>         nr_free_cma  0
>           cma      524288
>         nr_free_cma  493016
>           cma      0
>           cma      0
>   # cat /proc/meminfo | grep Cma
>   CmaTotal:        2097152 kB
>   CmaFree:         1972064 kB
> 
> Note: We print even without CONFIG_CMA, just like "nr_free_cma"; this way,
>       one can be sure when spotting "cma 0", that there are definetly no
>       CMA pages located in a zone.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: linux-api@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: David Rientjes <rientjes@google.com>
