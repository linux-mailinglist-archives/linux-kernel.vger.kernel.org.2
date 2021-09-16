Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A1540D2E3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 07:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbhIPFdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 01:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbhIPFdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 01:33:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04C7C061764
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 22:32:23 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id j16so4879852pfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 22:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=lpQeXpJnDPLq9EM++SgX1hsrS2o8DK7oqXbcQuiENms=;
        b=dVuOTjqdxMs7om2GBMnJW1JtJirdyLapvbyYqIaA0hSto0TKuv32C2H+M4lfHE+N8L
         EpBTiaPuVp9FrkviqdynL7lFW3P+hOtb6OcSR3elIgIC+9pUYEOO85zqTjLdQpuwd0wL
         7bFne5kV0t7j1Onoz4HSFMwgwH9Am996EtkPCWhpu722UNu4Mav/xAvZiJLeF5+JwI5q
         Tzi9Vp+sG1UrVpl7CWqeklL8wKzdz74IOvO+olUpsm3x1WZGzUVLih3l7dz4CY55pzua
         9NyFTgN9D6cIs7W/VUwYJNrp2QAQx6bgj6GewaLr97VyAHQSOzOgX454JDvmDcpMZhJF
         04Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=lpQeXpJnDPLq9EM++SgX1hsrS2o8DK7oqXbcQuiENms=;
        b=TZVhbaeAt+Peol4vTzsbh0L+xZaI9mYgo44rb1gG6pLlm25V+sSwACtI1b4R9YpHOh
         AiuS52rsKT+xfMFdYX9AAwTsncGCIbrfZo4BRV8XUt11pZzS6Cf96J5fjtH80wu/AOe1
         1yrsxCl9/44AxlJijIio75ZnpBRmspzPopvbVVV6bKEAW7qUUQiWHjW9fo0/lzjHm3UG
         arFqlhRi62zr0WfKRSjir7jIUHRlO/BFLgTijj5ua/kNaYdAvmAbBSVo5wUSi76x4BZ4
         y+3TqjWJd/foeKbzax7/To8AbTl94gVmK1JTAt/Ph918PQ4CzDdggvhWcHhGol0EzR3Z
         ABQQ==
X-Gm-Message-State: AOAM532lYwn+NYcpj2gLnbDfB8rp+tW/Ej88MsLSo7KKUd9dGyAog37N
        2DKdJ6Aco/nWaCljnwgEnCY/yw==
X-Google-Smtp-Source: ABdhPJwtKQswoEXBPAUSCEEpeqsvci1Aec5NdxszOeNoWmCa3dPa5iejw520VsTlXmc5sLmJj84WHw==
X-Received: by 2002:a63:f501:: with SMTP id w1mr3284849pgh.57.1631770343134;
        Wed, 15 Sep 2021 22:32:23 -0700 (PDT)
Received: from [10.254.159.231] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id c15sm689474pfn.105.2021.09.15.22.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 22:32:22 -0700 (PDT)
Subject: Re: [PATCH v2 0/9] Free user PTE page table pages
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
 <5b9348fc-95fe-5be2-e9df-7c906e0c9b81@redhat.com>
 <41ceeec1-52c4-4e99-201c-e1e05b2afbbc@bytedance.com>
 <20210915145933.GH3544071@ziepe.ca>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
Message-ID: <d33a4349-a228-f98a-ab14-e221bf80dd4a@bytedance.com>
Date:   Thu, 16 Sep 2021 13:32:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210915145933.GH3544071@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/21 10:59 PM, Jason Gunthorpe wrote:
> On Wed, Sep 15, 2021 at 10:52:40PM +0800, Qi Zheng wrote:
>> I am going to split this patch series as follows:
>>
>> 1. Introduce the new dummy APIs, which is an empty implementation.
>>     But I will explain its semantics.
>> 2. Merge #6, #7 and #8, and call these dummy APIs in any necessary
>>     location, and split some special cases into single patches, such as
>>     pagefault and gup, etc. So that we can explain in more detail the
>>     concurrency in these cases. For example, we don't need to hold any
>>     pte_refcount in the fast path in gup on the x86_64 platform. Because
>>     the PTE page can't be freed after the local CPU interrupt is closed
>>     in the fast path in gup.
>> 3. Introduce CONFIG_FREE_USER_PTE and implement these empty dummy APIs.
>> 4. Add a description document.
>>
>> And I try to add a function that combines pte_offset_map() and
>> pte_try_get(). Maybe the func name is pte_try_map() recommended by
>> Jason, or keep the pte_offset_map() unchanged?
> 
> It is part of the transformation, add a
> pte_try_map()/pte_undo_try_map() and replace all the pte_offset_map()
> callsites that can use the new API with it. The idea was that try_map
> would incorporate the pmd_trans_unstable/etc mess so searching for
> trans_unstable is a good place to start finding candidates. Some are
> simple, some are tricky.

Yes, I will search pte_offset_map()/pmd_trans_unstable/etc, and then 
analyze the specific situation.

> 
> When you get to step 3 you just change pte_try_map() and the callsites
> don't need changing.
> 
> Jason
> 

Thanks,
Qi


