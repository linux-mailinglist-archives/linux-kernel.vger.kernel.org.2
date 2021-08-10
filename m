Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B873E7C74
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243354AbhHJPhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:37:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33853 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243270AbhHJPhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628609839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kBYBVLFUuqcbHN0Vn7qdk9GROPKy6ZMoXPiOiWvTwPA=;
        b=hxmH2uxpJSafv0dk4im773s+8JyKaKr0uA70BtUwaWai1CL6ggNDvap90sWZc5vcbX4DzR
        o1ixlymA+6YJxgMTXDQjAswyaoJ6uMDIVzEiuMDFp15785f37eQZWUpkinZi9eagf4tOfa
        bPNbkWN/NSHFgvtle+dm4JZ8XFMbQeI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-Fzjvfi-mN46pZkNk3_0guA-1; Tue, 10 Aug 2021 11:37:18 -0400
X-MC-Unique: Fzjvfi-mN46pZkNk3_0guA-1
Received: by mail-qv1-f71.google.com with SMTP id t9-20020a0562140c69b029033e8884d712so16006070qvj.18
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 08:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kBYBVLFUuqcbHN0Vn7qdk9GROPKy6ZMoXPiOiWvTwPA=;
        b=S7HDHpTUkLPHbRC/DYbfcpPGNp3cWHS2JfqX5XfUX37wTtz+m0bNmQH/qGO1OEsHvo
         T01kT2ycBg9yhrsNgN4hcgo5JY6zzA7dFk9RRdMgFlK+Er80lnxxLSerho0c7VWauA+P
         1eUk9uV00kwSLujn41sJppBGSZL833wBH2pDajqmLrYM/8ROfqH5EGhPqYavwQSBCA/s
         +cDd0I3AIQlEdJ0SUssvGnCi+6xRkvOJL6K4wyZGL9VdFXXjyttQb/vkZNDd/3kuvVU9
         cyONepHzi0e2khCfo2B53B/sRmd/ubwqfp/Nm4TGwCQp1W1AeULKtQKlWq/gQcHLZz79
         3FAQ==
X-Gm-Message-State: AOAM531baDc/an2GbvA6kmn1rZJ3ocqtfU2Ki8koH3YxYxijoT4TvOHx
        h3vpma+zoh2cMyqF7ilUEKR8RsCpatYlP3Guff5UWaly7zCqz4WQQVyXkbHLsBYhBOeM3kGNbXi
        y20fflkq6sfd33zakj/vuoVyu
X-Received: by 2002:a05:6214:f0c:: with SMTP id gw12mr18537904qvb.33.1628609837640;
        Tue, 10 Aug 2021 08:37:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOm0EFOKMF7EgqNWVhF6h0Ag5o+ey7u/ZRHLmnbXOgs9I+L3hLZXhW5JKjn8aYN/3AGF2qmw==
X-Received: by 2002:a05:6214:f0c:: with SMTP id gw12mr18537893qvb.33.1628609837376;
        Tue, 10 Aug 2021 08:37:17 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id f17sm2970346qkm.107.2021.08.10.08.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 08:37:16 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3] vm_swappiness=0 should still try to avoid swapping
 anon memory
To:     Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     hannes@cmpxchg.org, aquini@redhat.com, shakeelb@google.com,
        llong@redhat.com, mhocko@suse.com, hakavlad@inbox.lv
References: <20210809223740.59009-1-npache@redhat.com>
Message-ID: <88f76721-3786-625f-b867-216f7904e116@redhat.com>
Date:   Tue, 10 Aug 2021 11:37:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809223740.59009-1-npache@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/21 6:37 PM, Nico Pache wrote:
> Since commit 170b04b7ae49 ("mm/workingset: prepare the workingset detection
> infrastructure for anon LRU") and commit b91ac374346b ("mm: vmscan: enforce
> inactive:active ratio at the reclaim root") swappiness can start prematurely
> swapping anon memory. This is due to the assumption that refaulting anon should
> always allow the shrinker to target anon memory. Add a check for swappiness
> being >0 before indiscriminately targeting Anon. Before these commits
> when a user had swappiness=0 anon memory would rarely get swapped; this
> behavior has remained constant sense RHEL5. This commit keeps that behavior
Typo: "sense" -> "since"
> intact and prevents the new workingset refaulting from challenging the anon
> memory when swappiness=0.
>
> Anon can still be swapped to prevent OOM. This does not completely disable
> swapping, but rather tames the refaulting aspect of the code that allows for
> the deactivating of anon memory.
>
> We have two customer workloads that discovered this issue:
> 1) A VM claiming 95% of the hosts memory followed by file reads (never dirty)
>     which begins to challenge the anon. Refaulting the anon working set will then
>     cause the indiscriminant swapping of the anon.
>
> 2) A VM running a in-memory DB is being populated from file reads.
>     Swappiness is set to 0 or 1 to defer write I/O as much as possible. Once
>     the customer experienced low memory, swapping anon starts, with
>     little-to-no PageCache being swapped.

Pagecache are not swapped. It is discarded under memory pressure and 
written back if dirty.

Other than that, the patch looks good to me.

Cheers,
Longman

