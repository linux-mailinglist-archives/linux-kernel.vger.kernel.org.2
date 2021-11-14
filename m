Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CC044FC2A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 23:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhKNWWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 17:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhKNWWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 17:22:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EEBC061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 14:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=/YI2I8AStZ9sTO+q28vUUfwszyhcKKFFKLCMRT0PkXU=; b=HVEJGk+dPQWWZgwlIgZ+vLLfQj
        sXnSd4HXEr/q8qLUgazRO9psL4fADN4ESlHl0pTBNqaldzGjYj9wEZ2YN7IAW01se+eJOvTPYx5oP
        5QpmPnvOMM97sFNrXOurGTxSs43lLcS8Ue+nXnNWR9WUBE31rgYXF6PgoKwGNYtz7fEUK3015ws+e
        38/crwqs8eIwtwF5qspp2BD5bWEWZM8TYhFxfUf7bua9M4800h3bGdUR7psjJyybKWvL3/a+YBsvt
        cvi6MFliDMBuSiD6DmItmfOC477bKFRD3yWSf8Y16LIQz6Xcly3W4Qhhrc/KnAVK5fBXDacdCr7th
        tMXP7P9w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmNq9-00E8GD-2T; Sun, 14 Nov 2021 22:19:09 +0000
Subject: Re: SH: error: implicit declaration of function
 'init_cache_node_node'
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <b5bdea22-ed2f-3187-6efe-0c72330270a4@infradead.org>
 <CAK8P3a1FcP8R1stLEj4468kk_zF28rCQz7mZZhVk31r-jYpYcg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2f29a441-5105-5f62-9e06-d1c97b08801a@infradead.org>
Date:   Sun, 14 Nov 2021 14:19:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1FcP8R1stLEj4468kk_zF28rCQz7mZZhVk31r-jYpYcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/21 2:04 PM, Arnd Bergmann wrote:
> On Sun, Nov 14, 2021 at 2:17 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> on arch/sh/,
>> CONFIG_SMP is not defined,
>> CONFIG_NUMA=y,
>> CONFIG_MEMORY_HOTPLUG is not defined:
>>
>> ../mm/slab.c: In function 'slab_memory_callback':
>> ../mm/slab.c:1143:23: error: implicit declaration of function 'init_cache_node_node'; did you mean 'drain_cache_node_node'? [-Werror=implicit-function-declaration]
>>    1143 |                 ret = init_cache_node_node(nid);
>>
>>
>> commit 76af6a054da4
>> Author: Dave Hansen <dave.hansen@linux.intel.com>
>> Date:   Mon Oct 18 15:15:32 2021 -0700
>>
>>       mm/migrate: add CPU hotplug to demotion #ifdef
>>
>>
>> How should we handle this config?
> 
> I think we can safely assume that NUMA without SMP is not a useful
> configuration on SH and add a dependency in Kconfig for it.
> 
> I assume this came from some randconfig build rather than a config
> that someone was intentionally using? My guess would be that testing
> sh randconfig kernels is not overly productive as you likely need
> countless patches before there is a chance of it working most of
> the time. I haven't tried this myself, but I spend a lot of time fixing
> randconfig failures on arm and x86, and I whenever I try any other
> architecture, there is simply too much work needed upfront.

I understand why you guess that it's from a randconfig, but it's not.
It's from migor_defconfig.

-- 
~Randy
