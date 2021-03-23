Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B634F34639A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbhCWPv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:51:59 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:57930 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbhCWPvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:51:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 6385740788;
        Tue, 23 Mar 2021 16:51:36 +0100 (CET)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="EleZm2I2";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AQDp60f0fYOG; Tue, 23 Mar 2021 16:51:35 +0100 (CET)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 3C6D83F377;
        Tue, 23 Mar 2021 16:51:33 +0100 (CET)
Received: from [192.168.0.209] (unknown [192.198.151.43])
        by mail1.shipmail.org (Postfix) with ESMTPSA id E831D36062E;
        Tue, 23 Mar 2021 16:51:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1616514693; bh=PpnHon7n76/I1Ml56ry5YIl7V1XFxUoZiFQo7XIsOo0=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=EleZm2I24aMAYaz/MhnjN5URzc/kqVuAlD11PHvbPJkB6NfaxhcapX1jFTojbTeCH
         YcXbLcUWfQuEAg4fueeGtqiloALYj+O3rApzyHT/tKPQULCenaCZAUqGdJ4SzWq6D2
         6ZulON8q3PKV981iNkLaa2ieqssk+3jaon34zKUw=
Subject: Re: [RFC PATCH 2/2] mm,drm/ttm: Use VM_PFNMAP for TTM vmas
To:     Jason Gunthorpe <jgg@nvidia.com>, dri-devel@lists.freedesktop.org,
        Christian Koenig <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210321184529.59006-1-thomas_os@shipmail.org>
 <20210321184529.59006-3-thomas_os@shipmail.org>
 <YFnVTIGKBFnlsGxF@phenom.ffwll.local> <20210323140445.GF2356281@nvidia.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <4a47b044-3660-48e6-647d-4a2217cfa287@shipmail.org>
Date:   Tue, 23 Mar 2021 16:51:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323140445.GF2356281@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/23/21 3:04 PM, Jason Gunthorpe wrote:
> On Tue, Mar 23, 2021 at 12:47:24PM +0100, Daniel Vetter wrote:
>
>>> +static inline bool is_cow_mapping(vm_flags_t flags)
>> Bit a bikeshed, but I wonder whether the public interface shouldn't be
>> vma_is_cow_mapping. Or whether this shouldn't be rejected somewhere else,
>> since at least in drivers/gpu we have tons of cases that don't check for
>> this and get it all kinds of wrong I think.
>>
>> remap_pfn_range handles this for many cases, but by far not for all.
>>
>> Anyway patch itself lgtm:
>>
>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> I would like it if io_remap_pfn_range() did not allow shared mappings
> at all.

You mean private mappings?

>
> IIRC it doesn't work anyway, the kernel can't reliably copy from IO
> pages eg the "_copy_from_user_inatomic()" under cow_user_page() will
> not work on s390 that requires all IO memory be accessed with special
> instructions.
>
> Unfortunately I have no idea what the long ago special case of
> allowing COW'd IO mappings is. :\

Me neither, but at some point it must have been important enough to 
introduce VM_MIXEDMAP...

/Thomas


> Jason
