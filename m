Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA704289D4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 11:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbhJKJmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 05:42:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235500AbhJKJmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 05:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633945216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nvm/qex5O1o/iUk7v0jlAEBgI/qIYmJudO2T4n06fHw=;
        b=Yy87L9GOelgf+y0eddyNRdZsH8PejzraP3JlBCOs51W/0gMvT3TEmnbuvEnjPMBGwHkBzL
        Sex0Kp8s0p+EtWv/g7ExT5pyDh3fX7UNmAzwFDB+01+Apj9rxwKw6x3NO7C5Df8GTlXqlM
        +/y0y2GR5QZcZIqBlG5qK5zmqqyYSE0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-QlUU8msMOReSeflVvIpM6w-1; Mon, 11 Oct 2021 05:40:15 -0400
X-MC-Unique: QlUU8msMOReSeflVvIpM6w-1
Received: by mail-wr1-f70.google.com with SMTP id j19-20020adfb313000000b00160a9de13b3so12831988wrd.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 02:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Nvm/qex5O1o/iUk7v0jlAEBgI/qIYmJudO2T4n06fHw=;
        b=qlHvKAKGBxPk/HlLUhCORATlKkEJqMPAzXBLeo5D+tq/slneXra/kZPJ9RLsWVBhod
         Oh0VIUvcswBZjkxxyc3VhN/QbwCgUI4k6aamSV27FYl1UDN4uYLGNCFkR7fwZrdKN5mr
         89uVGFeQdYuYT5K2kbhud88K1gzf3f3zE4WV9nIV9H6Bgnkc/7zG3TpRwtR1f5Mqvs6x
         2MK5albJ5PaRFSoCQuCNnHYna3ohNV8BZh1k05YFL9JEM0sZC0MEYEShQhqIMnXB4UrO
         CPQgEPVCDgXrJnUJ3/32nTTf1Ir65TjKJv77C2s/dbD01BBHQeyKEiRHopLey5B3GfuV
         /bcg==
X-Gm-Message-State: AOAM533ftPDH1W2FL5/5/vYw/3xUnIihp/cGJ1jGjTuqUYMnAz0yNhhW
        D0L9zcRHMNFcPIz0LocyrH2zP8OWmQj6Cy+Xdr+8lMNWRA63wtmUFB/Yl934fqWc/2VOywXshsz
        b+C/Bq3GTIN/N0anblWzigU3V
X-Received: by 2002:a1c:4c17:: with SMTP id z23mr20209652wmf.61.1633945213835;
        Mon, 11 Oct 2021 02:40:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbwaJB797an2sMAZ7pQoYzSQIrEcgcM7naLW3zaJiRPSrzLO96YOx+/YJBwMe6cq4fgXMd2g==
X-Received: by 2002:a1c:4c17:: with SMTP id z23mr20209632wmf.61.1633945213663;
        Mon, 11 Oct 2021 02:40:13 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64ba.dip0.t-ipconnect.de. [91.12.100.186])
        by smtp.gmail.com with ESMTPSA id v23sm7087848wmj.4.2021.10.11.02.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 02:40:13 -0700 (PDT)
Subject: Re: [PATCH] mm: Free per cpu pages async to shorten program exit time
To:     Michal Hocko <mhocko@suse.com>
Cc:     ultrachin@163.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, brookxu.cn@gmail.com,
        chen xiaoguang <xiaoggchen@tencent.com>,
        zeng jingxiang <linuszeng@tencent.com>,
        lu yihui <yihuilu@tencent.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20211008063933.331989-1-ultrachin@163.com>
 <d71e6021-777b-3ca9-b08f-64fe7ff51e08@redhat.com>
 <YWQDqtnA5FXk7xan@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <278a6cda-3095-5e27-e136-2765f73bc67d@redhat.com>
Date:   Mon, 11 Oct 2021 11:40:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YWQDqtnA5FXk7xan@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.21 11:28, Michal Hocko wrote:
> On Fri 08-10-21 10:17:50, David Hildenbrand wrote:
>> On 08.10.21 08:39, ultrachin@163.com wrote:
>>> From: chen xiaoguang <xiaoggchen@tencent.com>
>>>
>>> The exit time is long when program allocated big memory and
>>> the most time consuming part is free memory which takes 99.9%
>>> of the total exit time. By using async free we can save 25% of
>>> exit time.
>>>
>>> Signed-off-by: chen xiaoguang <xiaoggchen@tencent.com>
>>> Signed-off-by: zeng jingxiang <linuszeng@tencent.com>
>>> Signed-off-by: lu yihui <yihuilu@tencent.com>
>>
>> I recently discussed with Claudio if it would be possible to tear down the
>> process MM deferred, because for some use cases (secure/encrypted
>> virtualization, very large mmaps) tearing down the page tables is already
>> the much more expensive operation.
>>
>> There is mmdrop_async(), and I wondered if one could reuse that concept when
>> tearing down a process -- I didn't look into feasibility, however, so it's
>> just some very rough idea.
> 
> This is not a new problem. Large process tear down can take ages. The
> primary road block has been accounting. This lot of work has to be
> accounted to the proper domain (e.g. cpu cgroup). 

In general, yes. For some setups where admins don't care about that 
accounting (e.g., enabled via some magic toggle for large VMs), I guess 
this accounting isn't the major roadblock, correct?

-- 
Thanks,

David / dhildenb

