Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF90F3D1EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 09:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhGVGcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 02:32:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58495 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229715AbhGVGcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 02:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626937969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lie9E7QLfh8t44ZxpePc74B/WhWJVlmlTUrVnVd6Siw=;
        b=IZ/oldIsJN9Dzxg146WbLpmWzM3G1eCV3BLkL2v3QzCH3YLfzr93QZjTlsYrMI7ncnbUFd
        Dhf1J3IbcGBsZch7AgMA6Ekk2wLJZtCL9lDQSD8ecDRbnz7HGvsLmDNFQeTkq1UpofDsI7
        nx8RZj3nuRnULeQsytQJvfKgEuDxlu0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-kuK0mceKNpSpbI-6aYvbxw-1; Thu, 22 Jul 2021 03:12:47 -0400
X-MC-Unique: kuK0mceKNpSpbI-6aYvbxw-1
Received: by mail-wm1-f72.google.com with SMTP id n11-20020a05600c3b8bb029024c165e7f08so161124wms.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 00:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lie9E7QLfh8t44ZxpePc74B/WhWJVlmlTUrVnVd6Siw=;
        b=hM0QiAmms27KmTFzZ2/ELf7RgVdU/trUlghnGgkeLNg8uD0CePO4B1IEhrAvPBfRe5
         8111FAuDhL8uhtDdxhIWiYJiTcXJGCse9RAfkb5a+a6PearB1jLmeI2wnBisrnQTt5YD
         FjvQTNepO52vz8fXhzZnbpTSej4RaETUTVpR0O4/LvvTZL2q99J0R4Fnqy6l7nlY76F4
         gGFnvKS9aQaigGkBFesiGnf3ykl7mGj7XEU7KBxM25tPodjtublgj9ZpmJ+cw9HYpTpP
         pmZaTLji0UrST6qXi+2atTHzcITn1Bk0m7mW27sjAu296GIF52SswnYB4ey6DXHVO+9Z
         Mspg==
X-Gm-Message-State: AOAM531C/xXG09AMDIBipApacA46d0UeYNRDHE8Os9u7oaMOmKyT7rdG
        3C0+qmogzSfPSoIBCW3g+L29mS98cAiZ6c0o2dqPp3IvYgjaxXmgK7A08XrnAADPM1YlWQ/nJ/9
        zAHhrZ3VnRs8pA90ytZhkI+ct
X-Received: by 2002:adf:a404:: with SMTP id d4mr47067011wra.156.1626937966678;
        Thu, 22 Jul 2021 00:12:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJws72t6GoXzqkqdYYOZQ/zPmaGiDeut0YyCtsqL2CB4Q31i/+0VkOCKcz5IUS6rDtPJVLwoVQ==
X-Received: by 2002:adf:a404:: with SMTP id d4mr47066995wra.156.1626937966533;
        Thu, 22 Jul 2021 00:12:46 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6970.dip0.t-ipconnect.de. [91.12.105.112])
        by smtp.gmail.com with ESMTPSA id v15sm1930785wmj.39.2021.07.22.00.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 00:12:46 -0700 (PDT)
To:     Evan Green <evgreen@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-api@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Pavel Machek <pavel@ucw.cz>, Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210721143946.v3.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3] mm: Enable suspend-only swap spaces
Message-ID: <dd405f78-ac37-18d4-23f1-7d43507edee6@redhat.com>
Date:   Thu, 22 Jul 2021 09:12:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210721143946.v3.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.07.21 23:40, Evan Green wrote:
> Currently it's not possible to enable hibernation without also enabling
> generic swap for a given swap area. These two use cases are not the
> same. For example there may be users who want to enable hibernation,
> but whose drives don't have the write endurance for generic swap
> activities. Swap and hibernate also have different security/integrity
> requirements, prompting folks to possibly set up something like block-level
> integrity for swap and image-level integrity for hibernate. Keeping swap
> and hibernate separate in these cases becomes not just a matter of
> preference, but correctness.
> 
> Add a new SWAP_FLAG_NOSWAP that adds a swap region but refuses to allow
> generic swapping to it. This region can still be wired up for use in
> suspend-to-disk activities, but will never have regular pages swapped to
> it. This flag will be passed in by utilities like swapon(8), usage would
> probably look something like: swapon -o noswap /dev/sda2.

Just a minor comment, I'd call it rather SWAP_FLAG_HIBERNATE_ONLY and 
SWAP_FLAG_HIBERNATE_ONLY -- that calls the child by its name.

I think some other flags might not apply with that new flag set, right? 
For example, does SWAP_FLAG_DISCARD_ONCE or SWP_AREA_DISCARD still have 
any meaning with the new flag being set?

We should most probably disallow enabling any flag that doesn't make any 
sense in combination.

Apart from that, I'd love to see a comment in here why the workaround 
suggested by Michal isn't feasible -- essentially a summary of what we 
discussed.

I had a quick glimpse and nothing jumed at me, no mm/swapfile.c expert, 
though :)



-- 
Thanks,

David / dhildenb

