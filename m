Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E043E8D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 11:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbhHKJgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 05:36:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21807 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236320AbhHKJgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 05:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628674537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cf3MjxvLtXnOmLgMvYwULBr4gwnHPx12ZtDKQt4PbM4=;
        b=g4EZrBhXuSNG/Ec8DymxXXQAN1ws17mDiNDe1f2c2nT4H+ag9rxeagWD7xDV7cN9OicfuZ
        h0Eh80njBcszwkaiZHsI7GtFMvbPsFtoSrz18kBB51Vr8KBDXCkP7UdotVcflZ2XQwMtCT
        W8R22UAr/tr5+BLZNGLBke/BI5wgpJA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-nn72cHfpNc25lSnS6zCEHA-1; Wed, 11 Aug 2021 05:35:35 -0400
X-MC-Unique: nn72cHfpNc25lSnS6zCEHA-1
Received: by mail-wm1-f69.google.com with SMTP id l19-20020a05600c4f13b029025b036c91c6so658485wmq.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 02:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cf3MjxvLtXnOmLgMvYwULBr4gwnHPx12ZtDKQt4PbM4=;
        b=DswGRVLPZ8LeQkI0ZfgXO4LlmQ+xbrDGyB0pZ+TO9FlRqtV2Vu2rkrSRuAs1cWr6v6
         c7n8bc6qe6xnIM+86FLs5RnlpOo+uhJaWCdjagRhuDJNcgs6RY+0YEOguVqb39ruelm1
         ltavEStIZkFCkv+Dyi+sfOpqYuwtqq1NTftH7Xi0QFP47tT2yuKLJ/JMqA3y1PSnOMtA
         Qte0GzmMwMUiehCPVqqfDKM6HTqfCgBxr00FGbMVpyzb/4IvsNFptsE4qh7JvVZIJLe7
         f1JYtIgXT0W4fa5KhqQM5fJEF3Y6Ru9XKAEnyOejRvEaI6gad52epw1fBIxEz0DXy+Z4
         jDKg==
X-Gm-Message-State: AOAM533Kp7XC+ZHur0aZTDLYF7ukY+RRY/4N2DOSO+QhB7HGpUzQ185c
        0l28WHb6Pd//ZDlFWn3aB+1JX/YQ5z9y9Hmmv6h+t2cfSKCNetNtlSiHqK6v9QXDYkfVuZSXCgZ
        WT4G5E5jjZ7m/B0J5Fd8xL4nKrkEf896ArE0pq9WaNuD23yp/JH0AKxDD351mFPE80jzgzY6K
X-Received: by 2002:a5d:690e:: with SMTP id t14mr35388677wru.258.1628674534756;
        Wed, 11 Aug 2021 02:35:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzd+c8UQlHqZLR3QOaR8iJgVDzkYujRtaauiswaVPVPS1mM0ajqqHun8pmNv7S0En0cMK0QrQ==
X-Received: by 2002:a5d:690e:: with SMTP id t14mr35388656wru.258.1628674534565;
        Wed, 11 Aug 2021 02:35:34 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64a0.dip0.t-ipconnect.de. [91.12.100.160])
        by smtp.gmail.com with ESMTPSA id o28sm22489467wms.14.2021.08.11.02.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 02:35:34 -0700 (PDT)
Subject: Re: [PATCH] memblock: Check memory add/cap ordering
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <aabc5bad008d49f07d542815c6c8d28ec90bb09e.1628672091.git.geert+renesas@glider.be>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <1c4cb6e9-2ca9-9738-9706-28ff94f8fdcc@redhat.com>
Date:   Wed, 11 Aug 2021 11:35:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <aabc5bad008d49f07d542815c6c8d28ec90bb09e.1628672091.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.21 10:55, Geert Uytterhoeven wrote:
> For memblock_cap_memory_range() to work properly, it should be called
> after memory is detected and added to memblock with memblock_add() or
> memblock_add_node().  If memblock_cap_memory_range() would be called
> before memory is registered, we may silently corrupt memory later
> because the crash kernel will see all memory as available.
> 
> Print a warning and bail out if ordering is not satisfied.
> 
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   mm/memblock.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 57a9849a5d820c34..e2ca8ddc8ebebf4e 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1685,6 +1685,11 @@ void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t size)
>   	if (!size)
>   		return;
>   
> +	if (memblock.memory.cnt <= 1) {
> +		pr_warn("%s: No memory registered yet\n", __func__);
> +		return;
> +	}
> +
>   	ret = memblock_isolate_range(&memblock.memory, base, size,
>   						&start_rgn, &end_rgn);
>   	if (ret)
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

