Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3F53908A0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 20:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhEYSN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 14:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31359 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229819AbhEYSN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 14:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621966347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1WHkrjtXA494SlCEhN3Bx7hSUV7AdTJw4XPOhexNR20=;
        b=NZpQK03HNZkGegEdeH5P8r1ftu/JSE5wZG3ejlwCrw/BEQVljF7/CtSA1eTViJcgLCccdN
        Yn0Q+Jg7TtwPJnvv7mTZZbjf+jTxwBN/1avHmDkN8dehS4JIU3jaykakSFHpZQKL685XVG
        FIYJsqoXflBfCMjnI7MOQxZEVyngjSU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-Awb3jrR6O7u0aWCI59JC6Q-1; Tue, 25 May 2021 14:12:25 -0400
X-MC-Unique: Awb3jrR6O7u0aWCI59JC6Q-1
Received: by mail-wm1-f69.google.com with SMTP id z62-20020a1c65410000b0290179bd585ef9so3857573wmb.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 11:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1WHkrjtXA494SlCEhN3Bx7hSUV7AdTJw4XPOhexNR20=;
        b=kjxphca50aL35QBOfjIcqdbfs75S+e7O7IAaobhPH0eLFcgyoukZTqCLVHig7Ywioe
         U857/+kFiakxQDy5f3VkkEdylRcUr+OWnyUZ90FX1yB48h6f6HLw5e0ZYVTaxQY9YwXk
         vmIellVjMVtkAKkKC0U7sgFYeE/9NT/zutiesf9gDS85mj/wu4guIysiqH8jr+GZ+ZGk
         S0ZazrbrM/Qtj3eUXQtGGN0rZCL+QPou+DkIC7vHpyiRbDLDNNTJSuEq8xmZO7AyAEmp
         7sSS+ofZeXvvcNe49fe6fDv+ufrOahjNGxlUF47AtJ5F+fnPi9AQoi6xPnIHm35GjPZA
         dQ+g==
X-Gm-Message-State: AOAM531ckuQrBHhKqvVVG/as+prm7H9xg9GeUXdtzG7XI5z8F/bLmtLS
        4Jq/NTgKYxAxNUoIzVyNb1a/KAMLLx4tPI1Yra1PP3LJx2IP5NvemCCC5XjwPPqjzr8ZCYSbVh1
        0rX9ekeMhhHISE/IMAdkRu7LHV7QRs2cc20plo7bBnF5EW/lDn+3NerDSjKVAHbK4ZQuZbvbM
X-Received: by 2002:adf:f0ca:: with SMTP id x10mr29536281wro.40.1621966344173;
        Tue, 25 May 2021 11:12:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9ckYsGK9u1fIRGrc+rrkX67qXdkR20wX+K7gS2Y5J8OlQ2XUrwnKhFphQS75FbiRmSluSsQ==
X-Received: by 2002:adf:f0ca:: with SMTP id x10mr29536250wro.40.1621966343819;
        Tue, 25 May 2021 11:12:23 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f38:2400:62f4:c5fa:ba13:ac32? (p200300d82f38240062f4c5faba13ac32.dip0.t-ipconnect.de. [2003:d8:2f38:2400:62f4:c5fa:ba13:ac32])
        by smtp.gmail.com with ESMTPSA id f202sm14010365wmf.14.2021.05.25.11.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 11:12:23 -0700 (PDT)
Subject: Re: Arm64 crash while online/offline memory sections
To:     Oscar Salvador <osalvador@suse.de>,
        "Qian Cai (QUIC)" <quic_qiancai@quicinc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <DM5PR0201MB35576EF9B568FEE05FE58CF08E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
 <b34499c5-a330-1bfc-d564-8ebffb3236cd@redhat.com>
 <DM5PR0201MB35576CEF62C53EF393E3D9768E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
 <YK07NhNOnKNB02RY@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <8e0dc9de-6834-72aa-364c-50ce1c717437@redhat.com>
Date:   Tue, 25 May 2021 20:12:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YK07NhNOnKNB02RY@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.05.21 20:00, Oscar Salvador wrote:
> On Tue, May 25, 2021 at 05:57:34PM +0000, Qian Cai (QUIC) wrote:
>>> Do we know which patch in particular is problematic?
>>
>> Okay, the winner is "mm,memory_hotplug: Allocate memmap from the added memory range".
>>
>> https://lore.kernel.org/linux-mm/20210421102701.25051-5-osalvador@suse.de/
> 
> Ok, which means that is irrelevant to having it enabled, as the latter
> patch of that series actualy enables it for arm64.
> Can you work out where exactly the crash happens?
> 
> I will have a look into it tomorrow.
> 
> Thanks for reporting.
> 

I assume the following will work:

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index b31b3af5c490..6e661d106e96 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -218,14 +218,15 @@ static int memory_block_offline(struct memory_block *mem)
         struct zone *zone;
         int ret;
  
-       zone = page_zone(pfn_to_page(start_pfn));
-
         /*
          * Unaccount before offlining, such that unpopulated zone and kthreads
          * can properly be torn down in offline_pages().
          */
-       if (nr_vmemmap_pages)
+       if (nr_vmemmap_pages) {
+               /* Hotplugged memory has no holes. */
+               zone = page_zone(pfn_to_page(start_pfn));
                 adjust_present_page_count(zone, -nr_vmemmap_pages);
+       }
  
         ret = offline_pages(start_pfn + nr_vmemmap_pages,
                             nr_pages - nr_vmemmap_pages);


We must not touch pfn_to_page(start_pfn) if it might be a memory hole.
offline_pages() will make sure there are no holes, but that's too late.

-- 
Thanks,

David / dhildenb

