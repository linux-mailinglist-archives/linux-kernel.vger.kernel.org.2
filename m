Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7E43C5BC8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 14:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhGLLzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 07:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230207AbhGLLzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626090770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lc6I5ALb2S+ldsnn5ztxjFIQulHh2QSr/HwIqVfY5UQ=;
        b=LHuzU1yg9tQgGaxqCp8ggDXgkh64sr+G5/uc8+gzQl2MKhX3DkA/BHSOwmqj9Vyry4vAyR
        WN9FRrXiy9D2tbS9haXGNRFPMlm0ELG0a7WWljufD9UqjsrpX6Ih0oEwQSfQxLZcqAqZM9
        HRKx6Wb8EWmrRFzDCvH47qXxSnbXN7Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-RYRitGwaOKWXQm-HRxpJKQ-1; Mon, 12 Jul 2021 07:52:49 -0400
X-MC-Unique: RYRitGwaOKWXQm-HRxpJKQ-1
Received: by mail-wm1-f70.google.com with SMTP id m6-20020a05600c4f46b0290205f5e73b37so6254084wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 04:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lc6I5ALb2S+ldsnn5ztxjFIQulHh2QSr/HwIqVfY5UQ=;
        b=qF5vuWus/WRTidJ8skIW/yYFjxWRuFlaJX1FMx47ZSDhfDqND94BFod/WB7onkwFLJ
         NWQ6KRG7N7GXMkJSU9m6YKEfegRaxLTO3pGHCKb7AlSsIe1vixvBBcGf5V34aSYyhSx7
         x0NOU6hxbTAuYPW3MY0MZ4icLxYiFHrd6tnTozK05+0YUGKfHMScp20mYBkvLR6hgg5f
         p2XO79/ryJxX4Zo5mwsdewyqn341+jV/9Qoq4F+XrNFjcYWxDWoY8AYAyu5EyK/iRXFq
         WyNn/m5VjX/oqWa7Pq5gn6cFiVosq2A2XdnpXDE1oQEcjK8DPJFzfr9f35BJoW/E8tja
         2jrw==
X-Gm-Message-State: AOAM531BDUcJPcVGS/81Z/ghJnDdP6fKFaRuYT/lWSoGdawTXQr+ZgSk
        B0wJ2BbJPxCO10WDU1g4PWPQNB121jaH4SLj1ZHXZkjlzCNt/FeVbj+stEtUMuY0hRnTbvef3cI
        MTBKZrkXyD8x5apNGEZR4IJrZ2kaca2I6NOusXFhbl9ygu0wrzUKUmzhFhQTcQ4z+ujh4ksT5wI
        0=
X-Received: by 2002:a5d:5103:: with SMTP id s3mr36472896wrt.180.1626090768503;
        Mon, 12 Jul 2021 04:52:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyO4tVxsN8i5WrsovbxbVuMx4/RhGLUZtJO+O+tRrePWUsT1qE1LvbczI8hffbS1jfgKECbhg==
X-Received: by 2002:a5d:5103:: with SMTP id s3mr36472869wrt.180.1626090768269;
        Mon, 12 Jul 2021 04:52:48 -0700 (PDT)
Received: from [192.168.42.238] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id y66sm12728260wmy.39.2021.07.12.04.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 04:52:47 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com, Netdev <netdev@vger.kernel.org>,
        Alexander Duyck <alexanderduyck@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Guillaume Nault <gnault@redhat.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Matteo Croce <mcroce@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1 v2] skbuff: Fix a potential race while recycling
 page_pool packets
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20210709062943.101532-1-ilias.apalodimas@linaro.org>
 <CAKgT0UdQmrzZufHpvRBtWgbFdTCVmKH4Vx6GzwtmC9FuM8K+hg@mail.gmail.com>
Message-ID: <1e0596d2-d6dc-b4f8-b908-0fedc9060124@redhat.com>
Date:   Mon, 12 Jul 2021 13:52:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UdQmrzZufHpvRBtWgbFdTCVmKH4Vx6GzwtmC9FuM8K+hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/07/2021 16.34, Alexander Duyck wrote:
> On Thu, Jul 8, 2021 at 11:30 PM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> As Alexander points out, when we are trying to recycle a cloned/expanded
>> SKB we might trigger a race.  The recycling code relies on the
>> pp_recycle bit to trigger,  which we carry over to cloned SKBs.
>> If that cloned SKB gets expanded or if we get references to the frags,
>> call skbb_release_data() and overwrite skb->head, we are creating separate
>> instances accessing the same page frags.  Since the skb_release_data()
>> will first try to recycle the frags,  there's a potential race between
>> the original and cloned SKB, since both will have the pp_recycle bit set.
>>
>> Fix this by explicitly those SKBs not recyclable.
>> The atomic_sub_return effectively limits us to a single release case,
>> and when we are calling skb_release_data we are also releasing the
>> option to perform the recycling, or releasing the pages from the page pool.
>>
>> Fixes: 6a5bcd84e886 ("page_pool: Allow drivers to hint on SKB recycling")
>> Reported-by: Alexander Duyck <alexanderduyck@fb.com>
>> Suggested-by: Alexander Duyck <alexanderduyck@fb.com>
>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> ---
>> Changes since v1:
>> - Set the recycle bit to 0 during skb_release_data instead of the
>>    individual fucntions triggering the issue, in order to catch all
>>    cases
>>   net/core/skbuff.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index 12aabcda6db2..f91f09a824be 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -663,7 +663,7 @@ static void skb_release_data(struct sk_buff *skb)
>>          if (skb->cloned &&
>>              atomic_sub_return(skb->nohdr ? (1 << SKB_DATAREF_SHIFT) + 1 : 1,
>>                                &shinfo->dataref))
>> -               return;
>> +               goto exit;
>>
>>          skb_zcopy_clear(skb, true);
>>
>> @@ -674,6 +674,8 @@ static void skb_release_data(struct sk_buff *skb)
>>                  kfree_skb_list(shinfo->frag_list);
>>
>>          skb_free_head(skb);
>> +exit:
>> +       skb->pp_recycle = 0;
>>   }
>>
>>   /*
>> --
>> 2.32.0.rc0
>>
> 
> This is probably the cleanest approach with the least amount of
> change, but one thing I am concerned with in this approach is that we
> end up having to dirty a cacheline that I am not sure is otherwise
> touched during skb cleanup. I am not sure if that will be an issue or
> not. If it is then an alternative or follow-on patch could move the
> pp_recycle flag into the skb_shared_info flags itself and then make
> certain that we clear it around the same time we are setting
> shinfo->dataref to 1.
> 

The skb->cloned and skb->pp_recycle (bitfields) are on the same 
cache-line (incl. nohdr, destructor, active_extensions).  Thus, we know 
this must be in CPUs cache, regardless of this change.  I do acknowledge 
that it might be in cache coherency "Shared" state, and writing 
skb->pp_recycle=0 the CPU *might* have to change the cache coherency 
state, but I don't expect this to be a performance problem.

> Otherwise this looks good to me.
> 
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
  Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

I've gone over the code-path, with Ilias on IRC and I've convinced 
myself that this fix is correct, thus ACK.

