Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7313D06B1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 04:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhGUBmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 21:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhGUBlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 21:41:21 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5941C061762
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 19:21:58 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id j73so527995pge.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 19:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Xa2qBzVhj+Lwzg0PLQSc5h1ujLhU4dxvWdbFcvIDTfw=;
        b=SXnOcZ0M8e/9dJtVF+RdQ0y/kMDW3abcs+qkGIoPCTEsFozKmSK82jf2+02L57zLYC
         jYmgqsfAtoGhhgdRxMjIWYm52f2rP12uQ0HsOTR47XMczrlEmI/trqf2epwZ7HNM/pa+
         QrE9oTA0xM6/KaoH212t8N0P/HgCCPh57r0MAI+h5lgVUMHCrcT3h2z6/3vbtSrUV52q
         Jgtl5vTIWagvcfTskpINygfcsuFhHi16QeSKcD+9VQ+K+rYZDH/OJyDNZ6qOAhwqLY04
         8Cl5EpaWOs6HPygLiAD2zjQNZT3LEKvLV97l1d9D9YhFKP3uP5pT73FV/TykavGBSdcQ
         SLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Xa2qBzVhj+Lwzg0PLQSc5h1ujLhU4dxvWdbFcvIDTfw=;
        b=n7n5YfeOjo9J9zCoLOforMv9QQbrcYLciTZJBivZE9tWGQFrN6YS+pbqyQnY4M4Gwq
         uqf0b3LcrFrZI74F8vRXTadHIf4My1YZ5kSjbdNWEtLK+rkxkxIBreHtM3RON+2XBR6p
         8oXHoQWZ0gya5qlUSfmiCQJHt/4NPK/xYfc1Gd9MBuvS84W6fyN0oWpcoff/OTkBeD1N
         OmUZoFacdC307WjoX3lHeqApX66W79YhXrQbhDjLTFxBE8LfeF8XjfgDdJ9h47s+Qczp
         yNxGnn0y6BAshr005y8IqPTOzJGMMj/g7bUaQ5rixKEcZFwgbhmU+pMsZEDk6MJujEeG
         KQzg==
X-Gm-Message-State: AOAM530jggbZsGwuosgjdTsbObnGLN6vw/oadKy/MI89vFtNgUQ1Km6r
        N/r8Ny3Zogidi/L+0tTADtwcyA==
X-Google-Smtp-Source: ABdhPJwS6Lzpa5Vs2Z8wzgBskUrWY6TXhY1ph6ulpI4RrbxgxkYEI8hVxvqHQoiYdxs5NDFF5jtyzA==
X-Received: by 2002:a63:5442:: with SMTP id e2mr34013774pgm.365.1626834118464;
        Tue, 20 Jul 2021 19:21:58 -0700 (PDT)
Received: from [10.76.41.210] ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id n14sm26773984pfq.177.2021.07.20.19.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 19:21:58 -0700 (PDT)
Subject: Re: [PATCH 1/7] mm: fix the deadlock in finish_fault()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, tglx@linutronix.de,
        hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
References: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
 <20210718043034.76431-2-zhengqi.arch@bytedance.com>
 <20210718212814.suvziikndiyezi6m@box.shutemov.name>
 <9e97cedc-9fd7-4290-9f44-04b96acea15d@bytedance.com>
 <20210720161421.f4874db77e0b13192d0ab895@linux-foundation.org>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
Message-ID: <b4dc16f4-faf0-7af6-7853-5f54fef77b02@bytedance.com>
Date:   Wed, 21 Jul 2021 10:21:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210720161421.f4874db77e0b13192d0ab895@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/21 7:14 AM, Andrew Morton wrote:
> On Mon, 19 Jul 2021 17:53:12 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>>
>>
>> On 7/19/21 5:28 AM, Kirill A. Shutemov wrote:
>>> On Sun, Jul 18, 2021 at 12:30:27PM +0800, Qi Zheng wrote:
>>>> The commit 63f3655f9501(mm, memcg: fix reclaim deadlock with writeback)
>>>> fix a deadlock bug by pre-allocating the pte page table outside of the
>>>> page lock, the commit f9ce0be71d1f(mm: Cleanup faultaround and
>>>> finish_fault() codepaths) rework the relevant code but ignore this race,
>>>> fix it.
>>>>
>>>> Fixes: f9ce0be71d1f(mm: Cleanup faultaround and finish_fault() codepaths)
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>
>>> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>
>>> and add stable@, please.
>>>
>>
>> OK, I will add these in the patch v2, thanks.
> 
> Please send this as a separate standalone patch, not as a part of the
> main series.
> 
> Also, please include in the changelog a description of the user-visible
> impact of the bug which is being fixed.
> 

OK, I will do this.

Thanks,
Qi
