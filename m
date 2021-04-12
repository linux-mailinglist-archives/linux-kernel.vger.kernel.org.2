Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BF235C273
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbhDLJoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38540 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240459AbhDLJTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618219160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TKAiLP3d+p3qCAebqqPZXHK9shFNXxv2cv7bg8EEuys=;
        b=TtWD0zG7BonvUdrIgU0UUTJON+YsbOh/W0dhTehdL8G4ZNk1wmDBJs0qESzeUCihRY06DO
        jN/7vRuh06PGfPx1DWFJS19XX8jReNWfo/83Vs3j5BlZkfshOR9S45U9a+x2/QOYRBPjOk
        WOE6937hZuvphvU7QLVV6NCI6ruoRxg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-dq5GauqGP5iwvGbnKjRS5Q-1; Mon, 12 Apr 2021 05:19:18 -0400
X-MC-Unique: dq5GauqGP5iwvGbnKjRS5Q-1
Received: by mail-wr1-f70.google.com with SMTP id a6so5756531wro.15
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TKAiLP3d+p3qCAebqqPZXHK9shFNXxv2cv7bg8EEuys=;
        b=LdcDdUgzViiYsccFjKMtLoEGfDE6t35q2pH3Kpnf+WXhWOocrUhi4kq2z0erAzAIZ/
         oUs1MnU3h3O71//Hxv7rMseVx+Tv4muyHw7Rlq+ms9gvvUx1SyIAYJdI3XbJ5ktIT8ve
         3sVbKFVF5Txa94MfBUlOJjryuJihOx7aQekF6EMGkmVw5pSPhuoRGcuoCPWQMXr6GHt3
         FD4ZLMRGclJ5HVH7ADGEkdzxVDMiDySiudZowabk87J1TD/kAFfO7kKEXhfuFkxJ0Jtf
         Z8stifRrhrDhrj50IL/u8fUQWFQR2S6T9E2g5Hac6+qGsBcDAmjpNZLLj1xwplXPifFd
         vn9A==
X-Gm-Message-State: AOAM533ol58tPAtoFhoAdWXIvoeUjYRVDvnPPUqrrIYXrGgRnHgT9UG4
        vtICOfKKBKdSu3xhLSGozL8rxt4htI57gKf95KNi5nyGY6yC9cdGctE0Hdo1h2A+7caHfotO9cn
        I28QIeapKavwmg+a1IK9seg0k
X-Received: by 2002:adf:f504:: with SMTP id q4mr14593079wro.304.1618219157816;
        Mon, 12 Apr 2021 02:19:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkc92meKZVnFz3CUz8Q/mlmcd1iRAJgSFlsHnsjowjeNvC4W+VqN+qkhxRypPj+eRHVnDSAA==
X-Received: by 2002:adf:f504:: with SMTP id q4mr14593064wro.304.1618219157618;
        Mon, 12 Apr 2021 02:19:17 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c66cb.dip0.t-ipconnect.de. [91.12.102.203])
        by smtp.gmail.com with ESMTPSA id 24sm13732412wmg.19.2021.04.12.02.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 02:19:15 -0700 (PDT)
Subject: Re: [PATCH 03/10] mm/migrate: update node demotion order during on
 hotplug events
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, shy828301@gmail.com,
        weixugc@google.com, rientjes@google.com, ying.huang@intel.com,
        dan.j.williams@intel.com
References: <20210401183216.443C4443@viggo.jf.intel.com>
 <20210401183221.977831DE@viggo.jf.intel.com>
 <YG7Sc3i54IV6KyPn@localhost.localdomain> <20210409101400.GA32159@linux>
 <fb51273c-12e5-f47f-064b-86f5b30b1072@redhat.com>
 <20210412071936.GA27818@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <d72377e1-770f-555a-3559-14215039510f@redhat.com>
Date:   Mon, 12 Apr 2021 11:19:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210412071936.GA27818@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.21 09:19, Oscar Salvador wrote:
> On Fri, Apr 09, 2021 at 08:59:21PM +0200, David Hildenbrand wrote:
>   
>> The only way to add more System RAM is via add_memory() and friends like
>> add_memory_driver_managed(). These all require CONFIG_MEMORY_HOTPLUG.
> 
> Yeah, my point was more towards whether PMEM can come in a way that it does
> not have to be hotplugged, but come functional by default (as RAM).
> But after having read all papers out there, I do not think that it is possible.
> 

You mean e.g., configuring in the BIOS/firmware how an NVDIMM will get 
exposed to the OS (pmem vs. RAM). I once heard something about that, not 
sure if it's real. But from Linux' perspective, it would simply be 
System RAM and it would get treated like that.

-- 
Thanks,

David / dhildenb

