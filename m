Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE7A367DD8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbhDVJht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:37:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58281 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230285AbhDVJhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619084230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92nwvpG04WD4NVWeRes937L3vx8UtkIYushEuYfIPR4=;
        b=bWYYSkJ5rhI6VGAspAYW4wDSHpYqWWEgI7y/HMLpZBnd7pfm7fdd9k5/Z6RcaOnEFUxyvZ
        OtIioybWaaqnqLuvYGdHPH1WMJGlM6qb5/g7csvpaVBslZEOc+krmNECO4b8NT+EhQx9EA
        m/1WjTfz1YTh6FnVjCNOgoM688opZVQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-a5k2EX_EOEGPivKGL1AyGw-1; Thu, 22 Apr 2021 05:37:08 -0400
X-MC-Unique: a5k2EX_EOEGPivKGL1AyGw-1
Received: by mail-wr1-f71.google.com with SMTP id 93-20020adf80e60000b0290106fab45006so9032626wrl.20
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 02:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=92nwvpG04WD4NVWeRes937L3vx8UtkIYushEuYfIPR4=;
        b=JVp9AMcdJ9TGDt56vTTIbfAosLMhrj2MMEYMqyOey9rKFFzpnFhl9pieUs4NtmyV0C
         GCzv2BYT6Nkj7eVg5But4rQ0OxQmxO/Lhsncn/zFUfhxCAL5BbIKgiZPV736LkHA2W0I
         hHWOEGcrTzVSUB0NvEsqLMEVvuO1iUek9GzNi+hEb/bwcPhtaMSXkn5V2yv5oCmWTEli
         mWGwEzwGaB/JxW1FuIY2jatPeOSQiBEpbboCgyUbRI6H/XSS9NKtY+yHntiU38qY7TV2
         3IuFLD9IMrWzX8jHPpTmzOLWBhrGz57DEWhBM1hMKOWnHcsjWHsMBf6ScOCuHdbaXh0p
         rXww==
X-Gm-Message-State: AOAM530EUeSL5ckFFNi/PuxhY/ykaWDGQWLKI2w6P7KaQ0ogRDtxTBKC
        drnyTN7XW4WHpKCQAgHgWWG5cAC5aObNkdxvU6QqdzqOAxwBEUge4sq6rW+mep/DBip/zxZEF5H
        jiKsX+wcuFiXXGJms2NbdljAN
X-Received: by 2002:adf:a1db:: with SMTP id v27mr3000385wrv.181.1619084227658;
        Thu, 22 Apr 2021 02:37:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6+utQiD61Y5IOvGNjyr/njut4uxGj5SoOGPkTc18xAOAUfRtrcCKozUOITQtMMUbmwvIlQw==
X-Received: by 2002:adf:a1db:: with SMTP id v27mr3000369wrv.181.1619084227488;
        Thu, 22 Apr 2021 02:37:07 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23eb0.dip0.t-ipconnect.de. [79.242.62.176])
        by smtp.gmail.com with ESMTPSA id c1sm2569703wrx.89.2021.04.22.02.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 02:37:07 -0700 (PDT)
To:     "lipeifeng@oppo.com" <lipeifeng@oppo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        peifengl55 <peifengl55@gmail.com>,
        schwidefsky <schwidefsky@de.ibm.com>,
        "heiko.carstens" <heiko.carstens@de.ibm.com>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        zhangshiming <zhangshiming@oppo.com>,
        guoweichao <guoweichao@oppo.com>,
        zhouhuacai <zhouhuacai@oppo.com>
References: <20210414023803.937-1-lipeifeng@oppo.com>
 <a7bb16c0-31b2-6aa5-2186-8c957955649e@suse.cz>
 <2021041910374593320011@oppo.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC] mm: support multi_freearea to the reduction of external
 fragmentation
Message-ID: <0585db50-e8d5-e6d8-9d41-fc398f292d91@redhat.com>
Date:   Thu, 22 Apr 2021 11:37:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2021041910374593320011@oppo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.21 04:37, lipeifeng@oppo.com wrote:
> Hi Vlastimil Babka:
> Thank you very much indeed for your advice.
> 
> 
> Hi Vlastimil Babka, schwidefsky,heiko.carstens:
> 
> It is a temporary patch to consult experts:
> Is it possible to merge the optimization idea and the implementation
> method to the baseline?

Well, we cannot really say that :)

History taught that merging large and invasive buddy changes is a 
tedious task, can take a long time, and can fail even after a lot of 
discussions and patch series.

Further, usually there has to be a very compelling reason to merge 
large, invasive buddy changes (read: not only optimize very specific 
scenarios); otherwise there will just push back because the invasive 
changes might introduce additional problems or degrade other special 
cases or even the general case.

Last but not least, there have to be more benchmarks and test cases that 
proof that other workload won't be degraded to a degree that people 
care; as one example, this includes runtime overhead when 
allocating/freeing pages.

What usually works best is improving the code in small steps, doing 
minor adjustments but moving into the desired direction.

-- 
Thanks,

David / dhildenb

