Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE473E087F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 21:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239137AbhHDTJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 15:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57372 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234217AbhHDTJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 15:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628104140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MmgRMjocut7OSXdP14e4QYlZF0FOf7QmoFVYgj2gIC8=;
        b=DvahVTgvQN5K1PNnmljLjuqzPOt1Nva3nhROVdK5i5dXgNiyymkK0m8fYIr4vFFFyUnpWu
        GlOurKHvOyNZdOjBJs3LeXAp9qTzulefcpqUcxnsbz17s8S7C50BPUybpzjH3TpePBQxCH
        R0OHTARXcgdwmhgK+Nu918Gkkjg6t+Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-3CrAW3jGOf6Jgi2H5iOhHQ-1; Wed, 04 Aug 2021 15:08:59 -0400
X-MC-Unique: 3CrAW3jGOf6Jgi2H5iOhHQ-1
Received: by mail-wr1-f70.google.com with SMTP id c1-20020a5d4cc10000b02901547bb2ef31so1155419wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 12:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MmgRMjocut7OSXdP14e4QYlZF0FOf7QmoFVYgj2gIC8=;
        b=uC75vI9Zdl2fsj/nt9h5vV6LYEzdg3nUSl+PTdTx77cyAsAQw2t+A271i+9GMYDsrk
         /MFjDDc24froZDuvNfFGEzd5C40lGmldJx7+FnKCUUsQBNPuYI0a01dY6S119+s5uXGu
         H8C4GcbDTyQesNNR76YysXTkSTlaPQOPOXcCDk7Ed44vTaXWO5HncgHjWBYOaKlHfKaV
         cQyF1UmmzTiSXEEp3M2VQHpud5qV+TL6CgF7CSOhsENX24PYzElC+cNC/vCG+f4W9kmQ
         tIBApF84gnJxcVoGfUTqfRZLxriti2aHy9y5MQFT9jLiwrN8ir/jLBQ03jg01D+a0DNL
         w6Jw==
X-Gm-Message-State: AOAM530xoCZR+4P2PIueclnOegg3FsiAIRSCUcGLlutHS+IZDCOnCnb+
        VNgA8/U/gfGJp6hKKqnKnGtdkum82eAZILzKW+cHqhUvyJ3MJzQRZwq1wm4OMhweZEI0ZZiBXpr
        zKUUKBEGbNNA7Li3p4sJU1ym0rwtjx7kmgaa9pv+VIPmzlooNY9fkSy96Ky8/xQyjY8U7AtFm
X-Received: by 2002:adf:cd02:: with SMTP id w2mr918142wrm.68.1628104138488;
        Wed, 04 Aug 2021 12:08:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxr/wims9ZS/vrYwBXt5mU6isketLRTl4fzFijcJJ44MVzhRnRbQd+CgvmhYA6BR7DTxPpKxw==
X-Received: by 2002:adf:cd02:: with SMTP id w2mr918126wrm.68.1628104138317;
        Wed, 04 Aug 2021 12:08:58 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c65d3.dip0.t-ipconnect.de. [91.12.101.211])
        by smtp.gmail.com with ESMTPSA id y66sm3176625wmy.39.2021.08.04.12.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 12:08:57 -0700 (PDT)
Subject: Re: [PATCH] mm/madvise: add MADV_WILLNEED to process_madvise()
To:     zhangkui <zhangkui@oppo.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210804082010.12482-1-zhangkui@oppo.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <480fd747-d8d7-0830-0b97-bf2069dbef07@redhat.com>
Date:   Wed, 4 Aug 2021 21:08:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210804082010.12482-1-zhangkui@oppo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.21 10:20, zhangkui wrote:
> There is a usecase in Android that an app process's memory is swapped out
> by process_madvise() with MADV_PAGEOUT, such as the memory is swapped to
> zram or a backing device. When the process is scheduled to running, like
> switch to foreground, multiple page faults may cause the app dropped
> frames.
> To reduce the problem, SMS can read-ahead memory of the process immediately
> when the app switches to forground.
> Calling process_madvise() with MADV_WILLNEED can meet this need.
> 
> Signed-off-by: zhangkui <zhangkui@oppo.com>
> ---
>   mm/madvise.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 6d3d348b17f4..b9681fb3fbb5 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1046,6 +1046,7 @@ process_madvise_behavior_valid(int behavior)
>          switch (behavior) {
>          case MADV_COLD:
>          case MADV_PAGEOUT:
> +       case MADV_WILLNEED:
>                  return true;
>          default:
>                  return false;

I guess this should be fine. In contrast to other (e.g., destructive) 
madvise calls, an application could merely notice the difference that 
for example, in the pagemap something is suddenly no longer swapped, 
even thought the page wasn't touched by the process. But that can also 
happen e.g., during swapoff.

So I think this is fine, but let's hear if there are concerns.

-- 
Thanks,

David / dhildenb

