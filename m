Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1071F3E9F35
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 09:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbhHLHIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 03:08:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36440 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234577AbhHLHIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 03:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628752066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QgOG1KaHZGrp2vIMn7queyr7qSVpNW7VY1VTdadCTbg=;
        b=LdvzkUTiq5XQqUvuZn4KJ9VBAERgr2x+yGG3MAwVYzTFDLy1b9khYJWyS+Wdzz7w6oPhdI
        UIr1RW1nFPl4KGg+6ELjxfR4BdfiSWuDh7ALiGYWhYA6XntT67PyvsBJ8M34puqVEEDYpz
        GyJ2x0T3QWuxWCdGL54hklk8sY7dzU0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-0TcqXWiJPde3e_iCy1TedA-1; Thu, 12 Aug 2021 03:07:44 -0400
X-MC-Unique: 0TcqXWiJPde3e_iCy1TedA-1
Received: by mail-wm1-f69.google.com with SMTP id l19-20020a05600c4f13b029025b036c91c6so1541152wmq.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 00:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QgOG1KaHZGrp2vIMn7queyr7qSVpNW7VY1VTdadCTbg=;
        b=lzmarT/UCHKa23F/NFzcFYqWaf8wVYOiIZ1fRQJvHIsPeZ1ULPr2x+FW8RExy4rm5M
         RtmkwQtNC8z8Eus+sPp3CAksvd3CR87/uz8Wd7t5M5OSO5OC56xzuxqUuRpQCfx9J7oI
         Ya2NutRtVk5B76jqqTZbrEbsiyRxwLaqCsmN3q6SC2BRL3qqPADrFZGQEnrH2eAgHMb4
         7J54y1NA+lRizd03VgELW/dVsy1s82AR1Vq0R+YCSxpnFBZC1vEQWSsZR5cqUrfwiwq6
         l4JFdhbK6B/Lt/PRdDqp8wPqgh3T4KwBYitYHkMCnBaD/JxxxT1MLXT3b1sulGoZQpnq
         NOlA==
X-Gm-Message-State: AOAM5332wyWqj9NmlrboxnAyoD+5KZEAiLGmeKoteHCspzWplzaMWmj0
        UydHtsZb+DrjFiRDbcJIP3G1QS70MaaSn9bisdpTkIN7tGhskwzLjb3A+J0DMI3wAfOg1HwebS7
        tzAn+fuU3ECurEiw21MDKdxdb
X-Received: by 2002:a05:600c:a08:: with SMTP id z8mr2323933wmp.52.1628752063499;
        Thu, 12 Aug 2021 00:07:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/dQjmzRpVnjhu2nYG+mODfNo/0E2cQXbxEhmzGgBMgSVGnSaxBpdZxfEwooDN34fMK4D4Zw==
X-Received: by 2002:a05:600c:a08:: with SMTP id z8mr2323911wmp.52.1628752063241;
        Thu, 12 Aug 2021 00:07:43 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23d8b.dip0.t-ipconnect.de. [79.242.61.139])
        by smtp.gmail.com with ESMTPSA id i10sm8311155wmq.21.2021.08.12.00.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 00:07:42 -0700 (PDT)
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20210811203612.138506-1-david@redhat.com>
 <20210811203612.138506-4-david@redhat.com>
 <CAHp75VdQ_FkvBH4rw63mzm-4MymCWD2Ke_7Rf8T3Zmef3FeQVQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 3/3] kernel/resource: cleanup and optimize
 iomem_is_exclusive()
Message-ID: <37179df3-13d7-9b98-4cd8-13bb7f735129@redhat.com>
Date:   Thu, 12 Aug 2021 09:07:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdQ_FkvBH4rw63mzm-4MymCWD2Ke_7Rf8T3Zmef3FeQVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.21 22:47, Andy Shevchenko wrote:
> 
> 
> On Wednesday, August 11, 2021, David Hildenbrand <david@redhat.com 
> <mailto:david@redhat.com>> wrote:
> 
>     Let's clean it up a bit, removing the unnecessary usage of r_next() by
>     next_resource(), and use next_range_resource() in case we are not
>     interested in a certain subtree.
> 
>     Signed-off-by: David Hildenbrand <david@redhat.com
>     <mailto:david@redhat.com>>
>     ---
>       kernel/resource.c | 19 +++++++++++--------
>       1 file changed, 11 insertions(+), 8 deletions(-)
> 
>     diff --git a/kernel/resource.c b/kernel/resource.c
>     index 2938cf520ca3..ea853a075a83 100644
>     --- a/kernel/resource.c
>     +++ b/kernel/resource.c
>     @@ -1754,9 +1754,8 @@ static int strict_iomem_checks;
>        */
>       bool iomem_is_exclusive(u64 addr)
>       {
>     -       struct resource *p = &iomem_resource;
>     +       struct resource *p;
>              bool err = false;
>     -       loff_t l;
>              int size = PAGE_SIZE;
> 
>              if (!strict_iomem_checks)
>     @@ -1765,27 +1764,31 @@ bool iomem_is_exclusive(u64 addr)
>              addr = addr & PAGE_MASK;
> 
>              read_lock(&resource_lock);
>     -       for (p = p->child; p ; p = r_next(NULL, p, &l)) {
>     +       for (p = iomem_resource.child; p ;) {
> 

Hi Andy,

> 
> I consider the ordinal part of p initialization is slightly better and 
> done outside of read lock.
> 
> Something like
> p= &iomem_res...;
> read lock
> for (p = p->child; ...) {

Why should we care about doing that outside of the lock? That smells 
like a micro-optimization the compiler will most probably overwrite 
either way as the address of iomem_resource is just constant?

Also, for me it's much more readable and compact if we perform a single 
initialization instead of two separate ones in this case.

We're using the pattern I use in, find_next_iomem_res() and 
__region_intersects(), while we use the old pattern in 
iomem_map_sanity_check(), where we also use the same unnecessary 
r_next() call.

I might just cleanup iomem_map_sanity_check() in a similar way.

-- 
Thanks,

David / dhildenb

