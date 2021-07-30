Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70DE3DB5BC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 11:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238138AbhG3JRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 05:17:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25377 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230513AbhG3JRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627636645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/zY1bTaUTwe02HOCyGjtvAnuXlFEWzzopPrkJZBvT6Y=;
        b=RmVj6FnP1sV6VTF7McBdNooZlXos8FhCFwP2qoQO/FseXp8WIgvV7BOIFDRo6zgPho72tO
        OcMPGO5MoAz9n1Sz0LLTHZYs7t0m+myTszqYHgnwPxKuzAR0QnburEwvz4yd+GCsFjCaOl
        HvjtbvYt1zL58Eq0vaDHR69TDsFp/E4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-xA6QOlYDN6GtPNa_68fSiw-1; Fri, 30 Jul 2021 05:17:24 -0400
X-MC-Unique: xA6QOlYDN6GtPNa_68fSiw-1
Received: by mail-wr1-f69.google.com with SMTP id c5-20020adfed850000b02901537ecbecc6so2999288wro.19
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/zY1bTaUTwe02HOCyGjtvAnuXlFEWzzopPrkJZBvT6Y=;
        b=EIYs0dmoVYmPn3LnT9Csf2j22w8FSipvuc24078QhVo9MDwlSpKdoTYqbIgSNJe4h3
         Pzph13CsZg992gh5hfMt3FjOOJ9Nii9xPSgS1kekhVqi/EsdjLXOY5GRafpGPOefUWwr
         lieWk+KpOi2giWA7VMDPT2ZRO3IcZSH/d+AnNUPbANVy/69mgUOlLHsMQom0BxUxZtAv
         bZAu/FZmBNsP1wicUR5cBOJkJloPpmIa4RftW1pkb+6sIhoR2KAdnU2lGtVP+V+Sxonp
         bygyKS7rDAYhcuRh3eNaMA0Rh2kt78fTuI7dFr4UDKcu8wYipVUWuVcz+xUlMAgAQMBR
         BeSA==
X-Gm-Message-State: AOAM531HXUMji2gLD6nTtwJOVgPIGquadOb6z5uIq3y0cmwTwvjrpdu+
        O9CtwiYI13UtD80dY2MGHpXyguznm1AEAMmMb4aLr8O3Rrh5LbJmVK3jao62DYT+3JTZNzelfQy
        rt2agwny5ULTjb8g0Sb0+kGpR
X-Received: by 2002:a5d:6589:: with SMTP id q9mr1987680wru.284.1627636643015;
        Fri, 30 Jul 2021 02:17:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzou7Qy/seWzmdS2TuqljP6WE6ccibthm/JdTwXmg1TjCHD8m30HO110jianPApwogbYCEUAA==
X-Received: by 2002:a5d:6589:: with SMTP id q9mr1987658wru.284.1627636642863;
        Fri, 30 Jul 2021 02:17:22 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id e3sm1063745wrw.51.2021.07.30.02.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 02:17:22 -0700 (PDT)
Subject: Re: [PATCH] mm: delete unused get_kernel_page()
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric B Munson <emunson@mgebm.net>,
        Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>,
        Mike Christie <michaelc@cs.wisc.edu>,
        Neil Brown <neilb@suse.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
        Trond Myklebust <Trond.Myklebust@netapp.com>,
        Xiaotian Feng <dfeng@redhat.com>,
        Mark Salter <msalter@redhat.com>
References: <20210729221847.1165665-1-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <3551cde6-b48f-8cfc-7b64-b3341e717716@redhat.com>
Date:   Fri, 30 Jul 2021 11:17:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210729221847.1165665-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.07.21 00:18, John Hubbard wrote:
> get_kernel_page() was added in 2012 by [1]. It was used for a while for
> NFS, but then in 2014, a refactoring [2] removed all callers, and it has
> apparently not been used since.
> 
> Remove get_kernel_page() because it has no callers.
> 
> [1] commit 18022c5d8627 ("mm: add get_kernel_page[s] for pinning of
>      kernel addresses for I/O")
> [2] commit 91f79c43d1b5 ("new helper: iov_iter_get_pages_alloc()")
> 
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Eric B Munson <emunson@mgebm.net>
> Cc: Eric Paris <eparis@redhat.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: Mike Christie <michaelc@cs.wisc.edu>
> Cc: Neil Brown <neilb@suse.de>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> Cc: Trond Myklebust <Trond.Myklebust@netapp.com>
> Cc: Xiaotian Feng <dfeng@redhat.com>
> Cc: Mark Salter <msalter@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> Hi,
> 
> Just a minor decluttering: I ran across this while looking for something
> else entirely, and then noticed that it's been orphaned for quite a long
> time. It seems like only the plural form of this function is needed
> these days, and probably in the coming days as well.
> 
> thanks,
> John Hubbard
> NVIDIA

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

