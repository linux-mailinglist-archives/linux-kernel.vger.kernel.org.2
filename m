Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001753DDCAF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbhHBPsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:48:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38416 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234148AbhHBPsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627919273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=di+y0xMvdbCrkaN5KumVgKe0pl3QX55ReR309IY2E68=;
        b=NvDcvjHqWNf+KLwAIQTdXqC1w2xluqzsSJ6lboQEX9FIGt8pTiFBQAsuoAFsijV1sd3smo
        F8SUp2ohMFT2S0jt2tfRuwv6qp/ZPhZqy986xbNUYsMa1eyM5CK8BGG6Nnfo+nfPGWVIsA
        XZD9Z1kl9adUQNBc10iSNe3PJgB0sjw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-sjbr0MtOPUuoiTx10O4Gjg-1; Mon, 02 Aug 2021 11:47:49 -0400
X-MC-Unique: sjbr0MtOPUuoiTx10O4Gjg-1
Received: by mail-wr1-f72.google.com with SMTP id d13-20020adfc3cd0000b02901531b0b7c89so6621467wrg.23
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 08:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=di+y0xMvdbCrkaN5KumVgKe0pl3QX55ReR309IY2E68=;
        b=SD11UnBPfVYvyot0KD92+wpRm5ZakbnflvGoZOwlUzcf0uJ6eynMV9CNT9UuuQ+J9o
         LiWRGQcfIuDvcgf+75VlQwYgw9T7D0HDRNNyZfjUcQEJuRevEt4TkoOLcm4IprXgEScC
         t02bUt2167pXpcGjjNjW624L1bAP1Xe9yz+g7IFK/gSeaYN2BBK80APR9yD8EywaPb3z
         PKIAZEUwvCeDJi8gWx1p0lENg8GcmmbQRySfEw8GWLWujJE/Q7mbktSCLNlkULO7ZlO/
         r17M99Jeg5IN0ut60EiwYAyJJPZa3iQDiWPvvVkVbAYXa1MDXyKuij1CZB+WeIfPcohF
         ELow==
X-Gm-Message-State: AOAM533d0NWseepyKfY/DkHJCdNX/akt2mu3OI2cTDu2aXQXl1UjAK2u
        Aucz6QRZivoVzLwqh5vQjBiYljHqXBRWr6HRKha4I+Jc7WO2dznjzTxYND/iXRAZSu6HAq6UIcb
        Xj6WLsVzi4TIytEkrQBvvayK1
X-Received: by 2002:adf:ffd1:: with SMTP id x17mr18205656wrs.391.1627919268617;
        Mon, 02 Aug 2021 08:47:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEmbb2zH0a3fy8LIe8wfQA4/Y23WkCq1MgwVEgZQua5UBPTWh4ebj7+H7vh1LKNBn5dVAnLA==
X-Received: by 2002:adf:ffd1:: with SMTP id x17mr18205644wrs.391.1627919268477;
        Mon, 02 Aug 2021 08:47:48 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c60af.dip0.t-ipconnect.de. [91.12.96.175])
        by smtp.gmail.com with ESMTPSA id t15sm8872923wrw.48.2021.08.02.08.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 08:47:48 -0700 (PDT)
Subject: Re: [PATCH] device-dax: use fallback nid when numa_node is invalid
To:     Justin He <Justin.He@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
References: <20210728082226.22161-1-justin.he@arm.com>
 <20210728082226.22161-2-justin.he@arm.com>
 <fc31c6ab-d147-10c0-7678-d820bc8ec96e@redhat.com>
 <AM6PR08MB437663A6F8ABE7FCBC22B4E0F7EB9@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <f005a360-6669-1da6-5707-00b114831db2@redhat.com>
 <AM6PR08MB43766A114DA6AE971697CA1CF7EB9@AM6PR08MB4376.eurprd08.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <9fec6bd8-1dbe-1a34-3cc0-fab7645f84b4@redhat.com>
Date:   Mon, 2 Aug 2021 17:47:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <AM6PR08MB43766A114DA6AE971697CA1CF7EB9@AM6PR08MB4376.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.07.21 16:44, Justin He wrote:
> Hi David
> 
>> -----Original Message-----
>> From: David Hildenbrand <david@redhat.com>
>> Sent: Thursday, July 29, 2021 3:59 PM
>> To: Justin He <Justin.He@arm.com>; Dan Williams <dan.j.williams@intel.com>;
>> Vishal Verma <vishal.l.verma@intel.com>; Dave Jiang <dave.jiang@intel.com>
>> Cc: nvdimm@lists.linux.dev; linux-kernel@vger.kernel.org; nd <nd@arm.com>
>> Subject: Re: [PATCH] device-dax: use fallback nid when numa_node is
>> invalid
>>
>> Hi Justin,
>>
>>>>>
>>>>
>>>> Note that this patch conflicts with:
>>>>
>>>> https://lkml.kernel.org/r/20210723125210.29987-7-david@redhat.com
>>>>
>>>> But nothing fundamental. Determining a single NID is similar to how I'm
>>>> handling it for ACPI:
>>>>
>>>> https://lkml.kernel.org/r/20210723125210.29987-6-david@redhat.com
>>>>
>>>
>>> Okay, got it. Thanks for the reminder.
>>> Seems my patch is not useful after your patch.
>>>
>>
>> I think your patch still makes sense. With
>>
>> https://lore.kernel.org/linux-acpi/20210723125210.29987-7-
>> david@redhat.com/
>>
>> We'd have to detect the node id in the first loop instead.
> 
> Ok, I got your point. I will do that in v2.
> 
> Btw, sorry for commenting there about your patch 06 since I didn't
> subscribe lkml via this mailbox.

Sure, you really should subscribe :)

> > +	for (i = 0; i < dev_dax->nr_range; i++) {
> +		struct range range;
> +
> +		rc = dax_kmem_range(dev_dax, i, &range);
> +		if (rc) {
> +			dev_info(dev, "mapping%d: %#llx-%#llx too small after alignment\n",
> +					i, range.start, range.end);
> +			continue;
> +		}
> +		total_len += range_len(&range);
> +	}
> You add an additional loop to get the total_len.
> I wonder is it independent on 2nd loop?
> If yes, why not merge the 2 loops into one?
> Sorry if this question is too simple, I don't know too much
> about the background of your patch.

We need total_len to register the memory group. We need the memory group 
to add memory. Therefore, we need a second loop to calculate total_len 
upfront.


-- 
Thanks,

David / dhildenb

