Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586723482CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 21:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbhCXUWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 16:22:44 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:22453 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237807AbhCXUWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 16:22:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id EC54F401A9;
        Wed, 24 Mar 2021 21:22:21 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=mUke6Mhz;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Uwy-0R5DIGEx; Wed, 24 Mar 2021 21:22:21 +0100 (CET)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 4B8D8401B9;
        Wed, 24 Mar 2021 21:22:18 +0100 (CET)
Received: from [10.249.254.166] (unknown [192.198.151.44])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 0695836062E;
        Wed, 24 Mar 2021 21:22:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1616617338; bh=mjVvc9eC6YajJlFKKvLl6cV8/6/08eBr/yysRCc8+Ew=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=mUke6Mhz/EjBhy6BxSLI+hGZTe4KitrU8n1Pxt95MkZiPi5Xaj0ccLhSugRHrlkid
         c5l5Met3bKk5lcIOYNIsJ8e6VhhsCuXzyomxA7AgZvKPQ+HCRzrg7wutbtNWqVL7jI
         7SeKGdvhdhVdi7t/HTqMy1m6XG491Oz5w46LWXqQ=
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
To:     Dave Hansen <dave.hansen@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20210321184529.59006-1-thomas_os@shipmail.org>
 <20210321184529.59006-2-thomas_os@shipmail.org>
 <ec99146c7abc35d16b245816aba3e9d14862e624.camel@intel.com>
 <c2239da2-c514-2c88-c671-918909cdba6b@shipmail.org>
 <YFsNRIUYrwVQanVF@phenom.ffwll.local>
 <a1fa7fa2-914b-366d-9902-e5b784e8428c@shipmail.org>
 <75423f64-adef-a2c4-8e7d-2cb814127b18@intel.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <e5199438-9a0d-2801-f9f6-ceb13d7a9c61@shipmail.org>
Date:   Wed, 24 Mar 2021 21:22:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <75423f64-adef-a2c4-8e7d-2cb814127b18@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/24/21 5:34 PM, Dave Hansen wrote:
> On 3/24/21 3:05 AM, Thomas Hellström (Intel) wrote:
>> Yes, I agree. Seems like the special (SW1) is available also for huge
>> page table entries on x86 AFAICT, although just not implemented.
>> Otherwise the SW bits appear completely used up.
> Although the _PAGE_BIT_SOFTW* bits are used up, there's plenty of room
> in the hardware PTEs.  Bits 52->58 are software-available, and we're
> only using 58 at the moment.
>
> We also have not been careful at *all* about how _PAGE_BIT_SOFTW* are
> used.  It's quite possible we can encode another use even in the
> existing bits.
>
> Personally, I'd just try:
>
> #define _PAGE_BIT_SOFTW5        57      /* available for programmer */
>
OK, I'll follow your advise here. FWIW I grepped for SW1 and it seems 
used in a selftest, but only for PTEs AFAICT.

Oh, and we don't care about 32-bit much anymore?

/Thomas


