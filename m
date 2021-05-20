Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EC638A976
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbhETLCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:02:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60288 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237565AbhETKoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 06:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621507358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fzKc8otL995FMgE/dY3Fv/l/KMH2QqAEASjB2RUM+o8=;
        b=EanUJOvnbiu5cGJPRJ5+k1Hd6Xu7RHM69a5KX/7zJwP53F7x9rjrzkKtBuqSZ0tdch+jHq
        Q7IvsB77Kg4eIc0v1O/3jDsJ8yLZAb8stM6qsZnz5SEk6utWfKxVftwHyQZkLwDdfgPT+M
        QmpHvdITcLtiW9mDjlY4GabgFILFGlY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-VaSfBBsiN6KLkUrgcgnbmg-1; Thu, 20 May 2021 06:42:37 -0400
X-MC-Unique: VaSfBBsiN6KLkUrgcgnbmg-1
Received: by mail-wr1-f71.google.com with SMTP id a9-20020adfc4490000b0290112095ca785so3269702wrg.14
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 03:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fzKc8otL995FMgE/dY3Fv/l/KMH2QqAEASjB2RUM+o8=;
        b=sGS+GJJOCsTm0ifNzO9htQXabocqbjpiVbrWobLjvqih6/uIBIksRSaIjAUhuqOAng
         q9mkBCB7VBp6SLO/KgrtC/HIjyUeGTHYRXtvyHY0LtIRb5itvrSIfxTnxXQMJVvz0x55
         AK9dPRcSmK6WghlN2FM8JDX26kghVpE9+Ra+898Lj//aLdS42LBvJZV7YPIQrcAGKGNh
         EdHLW8jTMUu3MX3eng8aSFVaujektgBqDC42fzFF/8oVWVradgDgnqUFYsDvW3i7/M2L
         3qv0p2Bo4hXrNsWKDTFpuCBgMUxPDzpWAUpFrxaQVRKEpCTjF2ubdbUGFoCp9ONivnAI
         vQog==
X-Gm-Message-State: AOAM5334/U1Dus9OV8brDqHPMAK1xgauWIcYBepRutg7AGBpxWvW2Gem
        Jhbr7il9eOnW7f6sSFyAQsGtZoFFUbiemYMLYlp6+/8ruBM7yWScSM4hc/7TS6323+P4ol93d72
        heDHjaQUMJrt+fEqteiNRePLJgc/3ZjCPVyrdvrpus6FdWa52T5Lhw10miuI9Sv7J43UmWpE5
X-Received: by 2002:a1c:2985:: with SMTP id p127mr3011283wmp.165.1621507356226;
        Thu, 20 May 2021 03:42:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4soDFIHP99TZ0OevVyozD5GpuTFTtbX6eNOB1PPc1CU2RzPZsFsqTr73AZN5LSDi3G/zXOQ==
X-Received: by 2002:a1c:2985:: with SMTP id p127mr3011256wmp.165.1621507355912;
        Thu, 20 May 2021 03:42:35 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6315.dip0.t-ipconnect.de. [91.12.99.21])
        by smtp.gmail.com with ESMTPSA id d9sm2749745wrx.11.2021.05.20.03.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 03:42:35 -0700 (PDT)
Subject: Re: [PATCH 07/14] mm/memory_hotplug: Fix kerneldoc comment for
 __try_online_node
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210520084809.8576-1-mgorman@techsingularity.net>
 <20210520084809.8576-8-mgorman@techsingularity.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <d4434e56-5e42-2f53-7338-9103143bc656@redhat.com>
Date:   Thu, 20 May 2021 12:42:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210520084809.8576-8-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.05.21 10:48, Mel Gorman wrote:
> make W=1 generates the following warning for try_online_node
> 
> mm/memory_hotplug.c:1087: warning: expecting prototype for try_online_node(). Prototype was for __try_online_node() instead
> 
> Commit b9ff036082cd ("mm/memory_hotplug.c: make add_memory_resource use
> __try_online_node") renamed the function but did not update the associated
> kerneldoc. The function is static and somewhat specialised in nature
> so it's not clear it warrants being a kerneldoc by moving the comment
> to try_online_node. Hence, leave the comment of the internal helper in
> place but leave it out of kerneldoc and correct the function name in
> the comment.
> 
> Fixes: Commit b9ff036082cd ("mm/memory_hotplug.c: make add_memory_resource use __try_online_node")
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>   mm/memory_hotplug.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 70620d0dd923..e3266be1d020 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1072,8 +1072,8 @@ static void rollback_node_hotadd(int nid)
>   }
>   
>   
> -/**
> - * try_online_node - online a node if offlined
> +/*
> + * __try_online_node - online a node if offlined
>    * @nid: the node ID
>    * @set_node_online: Whether we want to online the node
>    * called by cpu_up() to online a node without onlined memory.
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

