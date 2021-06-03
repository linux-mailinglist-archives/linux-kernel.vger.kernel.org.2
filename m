Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34A239A1D0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhFCNJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:09:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30005 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229958AbhFCNJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622725685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=phWDTBiOPyAG0wKIKRe1O/Soj0OfowGQS7YwZbib9wQ=;
        b=WjH997Bkg1ZIxn3sKC3enASz2wgWX8DQWQCilvljviOroX4/0kEpdb1wZMvSWcZnyrtMEp
        09Etx9ScBrSSLLEhQr0wmxuMM7QYddvSW84EHFw5csc5rpBAK9PKfyPyUKx8ToXduWIL9p
        3yiiEIgXXJL6REKDBxw7STD8Fp4vDH0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-c17O9-bJNiCNd9YyIouPFA-1; Thu, 03 Jun 2021 09:08:04 -0400
X-MC-Unique: c17O9-bJNiCNd9YyIouPFA-1
Received: by mail-qk1-f197.google.com with SMTP id s4-20020a3790040000b02902fa7aa987e8so4267828qkd.14
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 06:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=phWDTBiOPyAG0wKIKRe1O/Soj0OfowGQS7YwZbib9wQ=;
        b=HEsiDN0EKFQj/UWak6a4lkyUn5FvdG1L0tp+xviGEQvg5ht94A+SmX7gfeXYZ3ur5I
         P7OFNM2PV9zNbjje5+PBOSzBcTuAU3/g1cNOSFL48ZZ1amidMkl39SOx273AUUm8r+F5
         e0cQGukvWmh+9sErV+dXo3y+wUo3VZUcqUzojCe9CH4SIbwCcFWB8Szq898ewhSbAeXb
         qaKs9U5m0rCunmgPjQ8YuhwiVIGZbIMLeOAgCJ0zZDljcI4sE1uWZ2aQmTz6tu6cCEuc
         EVXk72qNtEpZRvBx/dMeWv4+WGfu0CFnuIobe0WDXlVEgLQgpRD7DYWstGtKwJlp3V3W
         xSjA==
X-Gm-Message-State: AOAM530SL5ouru1MQJF80TrZ1SN504vS/PDzY43N7tL304qXFMTOx2fB
        QUEFTb3VyAWl9VRdOiSnSNZiioPSekPg57SnM86UVzUNWS1VN9+2InXsxxzHJI/JfExP4z52JsD
        hX6BJbuciAgsdRo+Rq7QW+npN
X-Received: by 2002:ac8:5fc1:: with SMTP id k1mr28653282qta.275.1622725683452;
        Thu, 03 Jun 2021 06:08:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZjxAZ016NuyN/W44nOTWDXC5wz52b3xuVvNZCq0Lcw66NuNZkMabgGskv6A7NYazam2qOOw==
X-Received: by 2002:ac8:5fc1:: with SMTP id k1mr28653262qta.275.1622725683203;
        Thu, 03 Jun 2021 06:08:03 -0700 (PDT)
Received: from [192.168.0.106] ([24.225.235.43])
        by smtp.gmail.com with ESMTPSA id z186sm1889159qkb.116.2021.06.03.06.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 06:08:02 -0700 (PDT)
Subject: Re: The value of FB_MTU eats two pages
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     ying.xue@windriver.com, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        tipc-discussion@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
References: <CADxym3baupJJ7Q9otxtoQ-DH5e-J2isg-LZj2CsOqRPo70AL4A@mail.gmail.com>
 <e91baaba-e00a-4b16-0787-e9460dacfbb9@redhat.com>
 <CADxym3ZdyqJ7b_PqdcjbNhKWP7_nsPRQ9Q0TtFC6Qzr75ekK+g@mail.gmail.com>
From:   Jon Maloy <jmaloy@redhat.com>
Message-ID: <85310a8b-35ab-376d-ca87-7487b97232c8@redhat.com>
Date:   Thu, 3 Jun 2021 09:08:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CADxym3ZdyqJ7b_PqdcjbNhKWP7_nsPRQ9Q0TtFC6Qzr75ekK+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/21 10:26 PM, Menglong Dong wrote:
> Hello Maloy,
>
> On Thu, Jun 3, 2021 at 3:50 AM Jon Maloy <jmaloy@redhat.com> wrote:
>
> [...]
>> Hi Dong,
>> The value is based on empiric knowledge.
>> When I determined it I made a small loop in a kernel driver where I
>> allocated skbs (using tipc_buf_acquire) with an increasing size
>> (incremented with 1 each iteration), and then printed out the
>> corresponding truesize.
>>
>> That gave the value we are using now.
>>
>> Now, when re-running the test I get a different value, so something has
>> obviously changed since then.
>>
>> [ 1622.158586] skb(513) =>> truesize 2304, prev skb(512) => prev
>> truesize 1280
>> [ 1622.162074] skb(1537) =>> truesize 4352, prev skb(1536) => prev
>> truesize 2304
>> [ 1622.165984] skb(3585) =>> truesize 8448, prev skb(3584) => prev
>> truesize 4352
>>
>> As you can see, the optimal value now, for an x86_64 machine compiled
>> with gcc, is 3584 bytes, not 3744.
> I'm not sure if this is a perfect way to determine the value of FB_MTU.
> If 'struct skb_shared_info' changes, this value seems should change,
> too.
>
> How about we make it this:
>
> #define FB_MTU (PAGE_SIZE - \
>           SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) - \
>           SKB_DATA_ALIGN(BUF_HEADROOM + BUF_TAILROOM + 3 + \
>                   MAX_H_SIZ))
>
> The value 'BUF_HEADROOM + BUF_TAILROOM + 3' come from 'tipc_buf_acquire()':
>
> #ifdef CONFIG_TIPC_CRYPTO
>      unsigned int buf_size = (BUF_HEADROOM + size + BUF_TAILROOM + 3) & ~3u;
> #else
>      unsigned int buf_size = (BUF_HEADROOM + size + 3) & ~3u;
> #endif
>
> Is it a good idea?
Yes, I think that makes sense. I was always aware of the "fragility" of 
my approach, -this one looks more future safe.

///jon

>
> Thanks
> Menglong Dong
>

