Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F7C361A56
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 09:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhDPHJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 03:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238538AbhDPHJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 03:09:22 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B807C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 00:08:56 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m3so30985210edv.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 00:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zLSMvZYRAJCsk2Rs4S2rsxdlqP0N63/bvG4UtBJlhds=;
        b=BlfiJ62lVmCMYByn7WvrksbbVI6TDARHp3g2O1W3ZtQwmxayq62Kf5FE0ajOQhHB26
         htlN704WKAY3fwWT25ySYXp46TeheqfnPYqTn7LL1Xm8/rvCPRrTHFX5lf0nkKQKh8P+
         15pSu5V0cHZrpjn83WWFePMOoOwlVnVlNoYNKRbxW5XEqi4ifSYHOIfL0H2hapsMAUNx
         CaBM7Jv9Pdmy8X1L123AXZniNoRhXalwQGdR3SDfq9od/K6Etk3U5GE99+JxY5Igv8+X
         pojj+Ob30ktvFVtClekEkCGrvmyeohvQUScQlV+EgfQQGqhkCz8+8DWzN43Ler/Ye98W
         IfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zLSMvZYRAJCsk2Rs4S2rsxdlqP0N63/bvG4UtBJlhds=;
        b=hEzYeRAVBS+CfpVehpPlDdz7MFvPNs1RA5RrRmSedwTuJIv1mCEUEjfv7LFbSvQrmv
         yYglJvPnhEHItTPyUMTI4JkTR9IDJws/eBrhgDJ91MowLByxCdgQYnyVm5ycpILgrJqF
         7X9rjii8YiAt06JhGlcIdO0taoEAUpGDVV+x6WBVO4rbgwrfI8CqXMPf4CKojOPG9DcF
         Ktbe7RCqS8UNP9y3FWIj0lw7vKiFoS0X2IxLg6ZMIva7mwrIjQXLpjLJ9a2vJysQeXJf
         APrg3UD4jU5mELKPJzM4bp4Q02xDFfRW3ny4VATvzbKsNUi7Qhigrm8YqjDOkmuEbVz7
         zSGg==
X-Gm-Message-State: AOAM531bOAwVYwrwNcQRyAeqM40XfR9Gf/7dBwU1zUqnxt0JeDQ34/nd
        DcFzzFkrOtQd/3W7PPJa774DmAEyvIU=
X-Google-Smtp-Source: ABdhPJydJ7xvzJS0k7fG4gTWodX4tiWHFMzTnM+NC5HYG9Xb+seCqYMDtLNm+BvO9A97hGceLRSCXQ==
X-Received: by 2002:a05:6402:4405:: with SMTP id y5mr8598888eda.32.1618556935191;
        Fri, 16 Apr 2021 00:08:55 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:c122:98c9:2964:3d64? ([2a02:908:1252:fb60:c122:98c9:2964:3d64])
        by smtp.gmail.com with ESMTPSA id k9sm3405159eje.102.2021.04.16.00.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 00:08:54 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/ttm: optimize the pool shrinker a bit v2
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, vbabka@suse.cz, daniel@ffwll.ch,
        ray.huang@amd.com
References: <20210415115624.2904-1-christian.koenig@amd.com>
 <20210415115624.2904-2-christian.koenig@amd.com>
 <20210415133310.1ee9df70a9eb887be937c3a3@linux-foundation.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <57572373-d68c-80de-7f9e-c04239d1b050@gmail.com>
Date:   Fri, 16 Apr 2021 09:08:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210415133310.1ee9df70a9eb887be937c3a3@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 15.04.21 um 22:33 schrieb Andrew Morton:
> On Thu, 15 Apr 2021 13:56:24 +0200 "Christian König" <ckoenig.leichtzumerken@gmail.com> wrote:
>
>> @@ -530,6 +525,11 @@ void ttm_pool_fini(struct ttm_pool *pool)
>>   			for (j = 0; j < MAX_ORDER; ++j)
>>   				ttm_pool_type_fini(&pool->caching[i].orders[j]);
>>   	}
>> +
>> +	/* We removed the pool types from the LRU, but we need to also make sure
>> +	 * that no shrinker is concurrently freeing pages from the pool.
>> +	 */
>> +	sync_shrinkers();
> It isn't immediately clear to me how this works.  ttm_pool_fini() has
> already freed all the pages hasn't it?  So why would it care if some
> shrinkers are still playing with the pages?

Yes ttm_pool_fini() has freed up all pages which had been in the pool 
when the function was called.

But the problem is it is possible that a parallel running shrinker has 
taken a page from the pool and is in the process of freeing it up.

When I return here the pool structure and especially the device 
structure are freed while the parallel running shrinker is still using them.

I could go for a design where we have one shrinker per device instead, 
but that would put a bit to much pressure on the pool in my opinion.

> Or is it the case that ttm_pool_fini() is assuming that there will be
> some further action against these pages, which requires that shrinkers
> no longer be accessing the pages and which further assumes that future
> shrinker invocations will not be able to look up these pages?
>
> IOW, a bit more explanation about the dynamics here would help!

Sorry, I'm not a native speaker of English and sometimes still have a 
hard time explaining things.

Regards,
Christian.
