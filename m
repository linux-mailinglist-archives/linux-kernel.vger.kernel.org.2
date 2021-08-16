Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E233EDDBA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhHPTPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35938 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229699AbhHPTPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629141306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0fYCxlBvMGA/LBXj8tHruKymgQRzsd2D5alI8z9FqnE=;
        b=W03TUqmErJaoGmxbngFDMYhQxaSrz4GSYayJ5D0QdkvMzNyE6k6T/0ZhflWorBrreF/b+w
        PClKBq3CDZ+AXkTF9ylCuxLvWqx0aSsuhEl2w4E/cpxYU8nLwel7ah+lNe3leP2eMX4bAd
        MknZdVP7D+8mtrc4M0PmCL9lj2GQKl4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-7k5JgZvrMHuzthFY8RnuCA-1; Mon, 16 Aug 2021 15:15:05 -0400
X-MC-Unique: 7k5JgZvrMHuzthFY8RnuCA-1
Received: by mail-wm1-f72.google.com with SMTP id v2-20020a7bcb420000b02902e6b108fcf1so74037wmj.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0fYCxlBvMGA/LBXj8tHruKymgQRzsd2D5alI8z9FqnE=;
        b=jLb+hj9+ssH6cSjXec9jsohxu/APkjB7snoqXVeazdOOPGfXcYWpk2de18Zt2NAqVi
         YBWdqMbTgRQIjrE4+NLq6/FH426aW4BOQ5nGh73pj0KjH3uh0RA3WG+6h+5pt7zUIws5
         QC+3juehp1dfBE9gaXX4+nmHQyIELXyulQfE8/JhlRJcLT9Gf7aHcTDXVH4xoYJjJV82
         F0bcJGrX4XpQn8zZQtcKvJe8KZm3Xquqb6GWwGPUNCbC/SpFgpKcJj8Y+2YD5DJNWK2f
         crQ+kq6lVDeZrcQR3Brd2MefzLwF+yjoRUH+QXIIKvRVzXCy0OP5FbTrQpWWFowu7auZ
         hh2A==
X-Gm-Message-State: AOAM532reOOhXxEpsHzHEC4UN9oChJqWlJPpusXi+ejsjWguk1FRycJt
        ZCMgVjtvXGiCDsDxavuFnOJ59I2G8oC4EKu00YUFDXXS1XdIaFTGBzaIRxffRBe4c4J5J7pwG7O
        4N0/oPYhQb68cUG2V7AQUGrLz03XMm2ZX4ZPhLxRn0NEYPLTppXtT0jgqb48aLVfosHH0+AlM
X-Received: by 2002:a5d:4bd1:: with SMTP id l17mr19029wrt.5.1629141304597;
        Mon, 16 Aug 2021 12:15:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGMAV4ypYcEuNTTFWxKeTz0UQWx3vLgwHnm1667BgV+Huo+EPminRnsv0YDIDvBsvfww0XYw==
X-Received: by 2002:a5d:4bd1:: with SMTP id l17mr19006wrt.5.1629141304380;
        Mon, 16 Aug 2021 12:15:04 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c67f1.dip0.t-ipconnect.de. [91.12.103.241])
        by smtp.gmail.com with ESMTPSA id w14sm87376wrt.23.2021.08.16.12.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 12:15:03 -0700 (PDT)
To:     Yang Shi <shy828301@gmail.com>, naoya.horiguchi@nec.com,
        osalvador@suse.de, tdmackey@twitter.com, akpm@linux-foundation.org,
        corbet@lwn.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210816180909.3603-1-shy828301@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/2] mm: hwpoison: don't drop slab caches for offlining
 non-LRU page
Message-ID: <08a5ad43-7922-8cf8-31ed-4f6e0c346516@redhat.com>
Date:   Mon, 16 Aug 2021 21:15:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816180909.3603-1-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.21 20:09, Yang Shi wrote:
> In the current implementation of soft offline, if non-LRU page is met,
> all the slab caches will be dropped to free the page then offline.  But
> if the page is not slab page all the effort is wasted in vain.  Even
> though it is a slab page, it is not guaranteed the page could be freed
> at all.

... but there is a chance it could be and the current behavior is 
actually helpful in some setups.

[...]

> The lockup made the machine is quite unusable.  And it also made the
> most workingset gone, the reclaimabled slab caches were reduced from 12G
> to 300MB, the page caches were decreased from 17G to 4G.
> 
> But the most disappointing thing is all the effort doesn't make the page
> offline, it just returns:
> 
> soft_offline: 0x1469f2: unknown non LRU page type 5ffff0000000000 ()
> 

In your example, yes. I had a look at the introducing commit: 
facb6011f399 ("HWPOISON: Add soft page offline support")

"
     When the page is not free or LRU we try to free pages
     from slab and other caches. The slab freeing is currently
     quite dumb and does not try to focus on the specific slab
     cache which might own the page. This could be potentially
     improved later.
"

I wonder, if instead of removing it altogether, we could actually 
improve it as envisioned.

To be precise, for alloc_contig_range() it would also make sense to be 
able to shrink only in a specific physical memory range; this here seems 
to be a similar thing. (actually, alloc_contig_range(), actual memory 
offlining and hw poisoning/soft-offlining have a lot in common)

Unfortunately, the last time I took a brief look at teaching shrinkers 
to be range-aware, it turned out to be a lot of work ... so maybe this 
is really a long term goal to be mitigated in the meantime by disabling 
it, if it turns out to be more of a problem than actually help.

-- 
Thanks,

David / dhildenb

