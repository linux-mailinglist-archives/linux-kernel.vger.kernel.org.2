Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F553BC7F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 10:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhGFIjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 04:39:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41380 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230497AbhGFIjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 04:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625560602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I+o/40+uDBX2iOKWdhlGm7tGKv0Mm2UPpPu5LYL1H+A=;
        b=b0YkBI2AP8ILtGaPLsNFplUztsAO0guq4RvcdLIEpJXfd8ZNY9XFsaxb8wutYqJ5/UzDvu
        jhi+R/MHWtDSnmXhIyoax5f/apzEro+RMuxI7hFy/zY4OOamiZH/EYKUpXXANkVADtaO7e
        vWmFaqn67dt+nrcMlShxvXJIB48GsG4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536--ZJP1Tw4OretNzykTsg3CA-1; Tue, 06 Jul 2021 04:36:38 -0400
X-MC-Unique: -ZJP1Tw4OretNzykTsg3CA-1
Received: by mail-wr1-f71.google.com with SMTP id y5-20020adfe6c50000b02901258bf1d760so6907975wrm.14
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 01:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=I+o/40+uDBX2iOKWdhlGm7tGKv0Mm2UPpPu5LYL1H+A=;
        b=Uev/82GFBR8LS8OxKhiZSqluE2Fggtk9kNjIjDmZtMD+8ScQenglZO+vXRX7+HyNTt
         U8DCn3SeMrRoB7fv5K9gH4SwbTS8ka6ElyKPnESmSMnK7nRctkCPGAoqx1/8/bxAZAoP
         LqRuKGwVeH3tz7SwzJhgt9hLA/d6a3jaQe8/cOuXv4y/tEko3yDfVUWnWhiaZgRI48a7
         HW+xAkzy3tGSYrkid4dlzKsthPSa2U+iQss/Hlq81uQuxxGKKxenAeS1tjW3yJM8XT0Z
         SNV6tXBUJIWbz00oTcMrdWHdnRAK8+/CBGJg1+mtdZ4QtQfiD7fUXWxoAGHwjOIb8ePT
         Mb7A==
X-Gm-Message-State: AOAM530TVSk+NCLbvStgGuAbdNeBsxI72E7S5PtRjZr9OIZD09td9aAT
        Z5+WoETe8myZJNAmsZiIWQLNtQGvleubfughvgjR9vKhI+IC3OnvfNYGXPCsy2DjdM53wH3EemS
        LtNznEgSTmQwMlXIVbpDMR5zv
X-Received: by 2002:a7b:c248:: with SMTP id b8mr3556963wmj.115.1625560597576;
        Tue, 06 Jul 2021 01:36:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9aVQ/6Du46/3/qnkFqf8wfnSzoxzzRTCxmqtbBtP+gQXruHwL9l4IP6UPUp734N0NoMVg+A==
X-Received: by 2002:a7b:c248:: with SMTP id b8mr3556948wmj.115.1625560597447;
        Tue, 06 Jul 2021 01:36:37 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id b8sm2161916wmb.20.2021.07.06.01.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 01:36:37 -0700 (PDT)
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Wang Wensheng <wangwensheng4@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rui.xiang@huawei.com" <rui.xiang@huawei.com>,
        =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= 
        <k-hagio-ab@nec.com>
References: <20210427083019.110184-1-wangwensheng4@huawei.com>
 <e838d8b5-84f1-5532-6f22-e4b729124e1c@redhat.com>
 <20210623230939.GA2963480@hori.linux.bs1.fc.nec.co.jp>
 <CAPcyv4h5a5AYscsyC40_5bc6j1kmjMFWJ_0MFAGEx1EPS9Tmrw@mail.gmail.com>
 <20210628070601.GB418318@u2004>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/sparse: set SECTION_NID_SHIFT to 6
Message-ID: <10142860-06b2-df68-c283-64560f31fb44@redhat.com>
Date:   Tue, 6 Jul 2021 10:36:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628070601.GB418318@u2004>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sounds nice to me, so here's a patch. Could you review this?
> 

Hi,

sorry for the late reply, I was on vacation. Please send it as a proper 
stand-alone patch next time, such that it

1. won't get silently ignored by reviewers/maintainers within a thread
2. Can easily get picked up/tested

Some minor comments below.

> Thanks,
> Naoya Horiguchi
> ---
>  From a146c9f12ae8985c8985a5861330f7528cd14fe8 Mon Sep 17 00:00:00 2001
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Date: Mon, 28 Jun 2021 15:50:37 +0900
> Subject: [PATCH] mm/sparse: set SECTION_NID_SHIFT to 6
> 
> Hagio-san reported that crash utility can see bit 4 in section_mem_map
> (SECTION_TAINT_ZONE_DEVICE) to be set, even if we do not use any
> ZONE_DEVICE ilke pmem or HMM.  This problem could break crash-related

s/ilke/like/

> toolsets and/or other memory analysis tools.
> 

I'd rephrase this to "Having SECTION_TAINT_ZONE_DEVICE set for wrong 
sections forces pfn_to_online_page() through the slow path, but doesn't 
actually break the kernel. However, it can break crash-related toolsets."

However, I am not sure why it actually breaks crash? crash would have to 
implement the same slow-path check and would have to double-check the 
sub-section present map. Then, it should just work like 
pfn_to_online_page() and not have a real issue. What am I missing?

> The root cause is that SECTION_NID_SHIFT is incorrectly set to 3,
> while we use lower 5 bits for SECTION_* flags.  So bit 3 and 4 can be
> overlapped by sub-field for early NID, and bit 4 is unexpectedly set
> on (for example) NUMA node id is 2 or 3.
> 
> To fix it, set SECTION_NID_SHIFT to 6 which is the minimum number of
> available bits of section flag field.
> 
> [1]: https://github.com/crash-utility/crash/commit/0b5435e10161345cf713ed447a155a611a1b408b

[1] is never referenced

> 
> Fixes: 1f90a3477df3 ("mm: teach pfn_to_online_page() about ZONE_DEVICE section collisions")
> Cc: stable@vger.kernel.org # v5.12+

^ I am not really convinced that this is a stable fix. It forces 
something through the slow path, but the kernel itself is not broken, no?

> Reported-by: Kazuhito Hagio <k-hagio-ab@nec.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>   include/linux/mmzone.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index fcb535560028..d6aa2a196aeb 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1357,6 +1357,7 @@ extern size_t mem_section_usage_size(void);
>    *      worst combination is powerpc with 256k pages,
>    *      which results in PFN_SECTION_SHIFT equal 6.
>    * To sum it up, at least 6 bits are available.
> + * SECTION_NID_SHIFT is set to 6 based on this fact.

I'd drop that comment or rephrase to ("once this changes, don't forget 
to adjust SECTION_NID_SHIFT")

>    */
>   #define SECTION_MARKED_PRESENT		(1UL<<0)
>   #define SECTION_HAS_MEM_MAP		(1UL<<1)
> @@ -1365,7 +1366,7 @@ extern size_t mem_section_usage_size(void);
>   #define SECTION_TAINT_ZONE_DEVICE	(1UL<<4)
>   #define SECTION_MAP_LAST_BIT		(1UL<<5)
>   #define SECTION_MAP_MASK		(~(SECTION_MAP_LAST_BIT-1))
> -#define SECTION_NID_SHIFT		3
> +#define SECTION_NID_SHIFT		6
>   
>   static inline struct page *__section_mem_map_addr(struct mem_section *section)
>   {
> 

Change itself looks correct to me.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

