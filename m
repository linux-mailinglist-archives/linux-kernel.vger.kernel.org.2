Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7882D38A979
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbhETLCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:02:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237911AbhETKoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 06:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621507365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nr9+DlfBg48tYmT45uZZLEvFJ1KtfJY23S6lwgRrWao=;
        b=ZJFeqmVoTWfSiQU83jw6yXx3Cbuz0AU//2gdBioFHEN0e7OfkF21ECXI6yeXumYPcryDHs
        bpMyxpOKE83XDdDSwM1Vk5k527Tvr72xhnUiCNQztGlfEqf2t5DfbDEG4uwkvZV2wert/i
        LSliUqdTropH8z6pIiChj/yzYXOa62A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-0EvZk562PaWVhbO5C4JHgA-1; Thu, 20 May 2021 06:42:43 -0400
X-MC-Unique: 0EvZk562PaWVhbO5C4JHgA-1
Received: by mail-wm1-f72.google.com with SMTP id y129-20020a1c32870000b029016920cc7087so2087466wmy.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 03:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Nr9+DlfBg48tYmT45uZZLEvFJ1KtfJY23S6lwgRrWao=;
        b=iLoVav0vH8DTTapnvi+wSMCrJ5n3Azp6JKQAIuPD7nIxx/wC5dSXLmzAeFlJBDoFbC
         iVy3LFKWbaOH7fIZc+fRn0WsUtPAyMKiU9G8y1rb+ZIlvjYCcvZYDDeWRjzjFsAYV5RU
         uqsMFA/I9F/MguAUNjkgiBdn6m/kkcMziqyI+VfyGyWqAqt+xAFx/A4EV8LGxZOP2cnc
         y6Ry52wgF+VxwCM7v5H4FUuGt8Hj6UqggTsL4HJv9YEIXI0xi1fBUe3Ni77uMjZJ9Bpw
         Lnh+8w155fwJH94a7x3iXV4DNPVO2DUQkNGF9G9jE23SFi38F4+9NPU4DGU/KJTvDuY8
         YW+g==
X-Gm-Message-State: AOAM5300ISRhkJmWuQF8mx9J97eI3VfkftjUaNRzya4Fi97gHtTMRS3G
        TjSI0eAX60hKFmRPsQdWg6FSH+n9G5lqX7WUNJMMC8BNGY9KeM7aWw/5meKF1tJvC4Yh9uz5oGy
        kVkeHnnutyaozC9z7ABMtOg1eFgq11WemsJOJ4iOOvc0tDDIzyMXDEsoJ476A68+ZkuBzXphp
X-Received: by 2002:adf:e4c8:: with SMTP id v8mr3589450wrm.345.1621507362475;
        Thu, 20 May 2021 03:42:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFqUkFevK/7EEQMp2LynkF0uJ/mORJiN1O6rHeSUplUHDQXCsm2NGQAZS/cMUvEBdsDMpkLw==
X-Received: by 2002:adf:e4c8:: with SMTP id v8mr3589420wrm.345.1621507362177;
        Thu, 20 May 2021 03:42:42 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6315.dip0.t-ipconnect.de. [91.12.99.21])
        by smtp.gmail.com with ESMTPSA id x2sm2256899wmj.3.2021.05.20.03.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 03:42:41 -0700 (PDT)
Subject: Re: [PATCH 08/14] mm/memory_hotplug: Fix kerneldoc comment for
 __remove_memory
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210520084809.8576-1-mgorman@techsingularity.net>
 <20210520084809.8576-9-mgorman@techsingularity.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <96f1cf9c-3516-30d5-201a-9212cdd79ac2@redhat.com>
Date:   Thu, 20 May 2021 12:42:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210520084809.8576-9-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.05.21 10:48, Mel Gorman wrote:
> make W=1 generates the following warning for __remove_memory
> 
>    mm/memory_hotplug.c:2044: warning: expecting prototype for remove_memory(). Prototype was for __remove_memory() instead
> 
> Commit eca499ab3749 ("mm/hotplug: make remove_memory() interface usable")
> introduced the kerneldoc comment and function but the kerneldoc name and
> function name did not match.
> 
> Fixes: eca499ab3749 ("mm/hotplug: make remove_memory() interface usable")
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>   mm/memory_hotplug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index e3266be1d020..4ea1b19e8c7a 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -2031,7 +2031,7 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
>   }
>   
>   /**
> - * remove_memory
> + * __remove_memory - Remove memory if every memory block is offline
>    * @nid: the node ID
>    * @start: physical address of the region to remove
>    * @size: size of the region to remove
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

