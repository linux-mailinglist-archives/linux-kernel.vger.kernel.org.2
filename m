Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5825348114
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbhCXS7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbhCXS70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:59:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C46CC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 11:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=S5c08tH94DbYnQq7ubCip4+4vB1dGbmIUGgd0vL4esY=; b=oqZZIo5N0eBy6O8OrtRF/DBDva
        Dumskv2fuiudyaQYnfIUyXCfX3m6uEo7wgpTan3zTZG5PO8boMSelZzFH9ZY7Ai7Nc7rQ/Yh+KJiL
        8EseYgIWFqIMKKzmtjI0BKV21t5t+cudxABVee1F0hZ6RPPxum8MhOZiD8pP35Svz7BWeaLlhoGqP
        f/1qJ8MS2RtDwjDl/7Qbex8WQawEwDwAXPtxhoZ0ze7yqIFVsEBC/VNOuwViKs3WlJL75mWD6NfIY
        cb7jkAwpwBBArKJW4gpvh9C0joyVTKTZp+yBwu5VNcgvqDpEQ9mJQP92lyCJVp8V1QRZQBbGH9xjf
        d1vGh48Q==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lP8iv-0005bz-W7; Wed, 24 Mar 2021 18:59:22 +0000
Subject: Re: [PATCH] ARM: xen/mm.c: A mundane typo fix
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     linux@armlinux.org.uk, xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com
References: <20210324133036.17665-1-unixbhaskar@gmail.com>
 <alpine.DEB.2.21.2103241154320.439@sstabellini-ThinkPad-T480s>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5e1b573a-6dc7-7f28-28ae-c509e6782fbf@infradead.org>
Date:   Wed, 24 Mar 2021 11:59:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2103241154320.439@sstabellini-ThinkPad-T480s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/21 11:55 AM, Stefano Stabellini wrote:
> On Wed, 24 Mar 2021, Bhaskar Chowdhury wrote:
>> s/acrros/across/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> 
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> 
> 

Hi,
It seems to me like some of those "page" should be "pages".

>> ---
>>  arch/arm/xen/mm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
>> index 467fa225c3d0..be7c942c74bf 100644
>> --- a/arch/arm/xen/mm.c
>> +++ b/arch/arm/xen/mm.c
>> @@ -105,7 +105,7 @@ bool xen_arch_need_swiotlb(struct device *dev,
>>  	 *	- The Linux page refers to foreign memory
>>  	 *	- The device doesn't support coherent DMA request
>>  	 *
>> -	 * The Linux page may be spanned acrros multiple Xen page, although>> +	 * The Linux page may be spanned across multiple Xen page, although

	                                                     pages,

>>  	 * it's not possible to have a mix of local and foreign Xen page.

	                                                            pages.

>>  	 * Furthermore, range_straddles_page_boundary is already checking
>>  	 * if buffer is physically contiguous in the host RAM.
>> --


-- 
~Randy

