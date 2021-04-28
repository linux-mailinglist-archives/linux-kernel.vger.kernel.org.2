Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE2F36D9C5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 16:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240251AbhD1Opa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 10:45:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54453 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240219AbhD1OpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 10:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619621080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VjWuwXa1YtMUwTvGVSDOIM7cAaoA6yJc6vXG9qhAW3A=;
        b=Q6UE8FSCnJh2jf1+vXbRxxWgzpALUP3VOgssfQ5ZBIBhNwykF6fKBbWIxmMlvWdTMnLjjn
        sUNVKsmvwTqscLeZf/B+ojS9YOrpeHyirl36VXz+LfAuXvAsyo2afcTOmVzuw4sMKG0pBc
        617C49fUFoLO0izTsepbLTqAGYd9QxQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-uYulJ5gWNDKWRXKDqRW8oA-1; Wed, 28 Apr 2021 10:44:38 -0400
X-MC-Unique: uYulJ5gWNDKWRXKDqRW8oA-1
Received: by mail-wr1-f72.google.com with SMTP id 91-20020adf94640000b029010b019075afso5620443wrq.17
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 07:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VjWuwXa1YtMUwTvGVSDOIM7cAaoA6yJc6vXG9qhAW3A=;
        b=QemrijU5MLYum/0qKmhrFTHgtUA1m+DEZR15+HsRj9SKL2e4Q3pm2UtPGRRh1KRu7v
         ChQgsVkPrHb4LY6oyI97BP+CIVP8T4F+YhW4ZEE/y0z/whZNCfizKJ5Er1o+xi/o85ew
         5FlrIAZXIqtlxX9J0smlyXHLEovUtmgoPTJ/24t8ZSq1wY+hW13W+a97suGxsoff1JbY
         citDByH1eZrMp+BntZ+dID6/GhH+93ZbE6pPyhYkiBCbXJ7QLAW7xr8WFLZTcKuVzio3
         Qsji2g8H/pJGNneI9xP0Gxvcz58B6tQcnsHdeCz8jkkzlRt561kQmSe22T/2EJLXgXAT
         vzjw==
X-Gm-Message-State: AOAM531IFS+u505SVm3tfB3QcFftqTdwlY3BLWwECaBo9Dx7UU04wBH7
        ffOWelAzTf4XquAYJJQaD/Xh3uB2p+O6V4Q7YJnU/CxT0uZH1LRZ9HDc6qyKmniL4yqygvvYQT1
        MQatbBDwmH5uApxVRAFeLEYY3
X-Received: by 2002:a7b:c312:: with SMTP id k18mr32218057wmj.89.1619621077288;
        Wed, 28 Apr 2021 07:44:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/eTvBZIFZBQvqlxG36XxLa2MkImGigzmxHvgls8vpEbFngdpMJma6FbJTuPACeuAEUlKkHg==
X-Received: by 2002:a7b:c312:: with SMTP id k18mr32218040wmj.89.1619621077038;
        Wed, 28 Apr 2021 07:44:37 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f38:2400:62f4:c5fa:ba13:ac32? (p200300d82f38240062f4c5faba13ac32.dip0.t-ipconnect.de. [2003:d8:2f38:2400:62f4:c5fa:ba13:ac32])
        by smtp.gmail.com with ESMTPSA id g11sm192970wri.59.2021.04.28.07.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 07:44:36 -0700 (PDT)
Subject: Re: Is there a different memory allocation path other than the buddy
 allocator?
To:     Shivank Garg <shivankgarg98@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        sergey.senozhatsky@gmail.com, pmladek@suse.com
References: <CAOVCmzEAMz4NGF3gi4O_tNUQfm2+-8AkGiOn0gPN+p3GHctkKA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <88d5164f-0261-469c-5549-4d97a7936775@redhat.com>
Date:   Wed, 28 Apr 2021 16:44:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAOVCmzEAMz4NGF3gi4O_tNUQfm2+-8AkGiOn0gPN+p3GHctkKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.04.21 09:37, Shivank Garg wrote:
> Hi Everyone!
> 
> I'm understanding memory allocation in Linux and doing some changes in
> buddy allocator (__alloc_pages_nodemask) for my experiments. I create
> a new flag in `struct page->flags` (by adding a new flag in `enum
> pageflags` in `page-flags.h`. I set this bit permanently in
> __alloc_pages_nodemask (to not to be cleared once set and survive all
> further allocation and freeing). But I'm not able to see expected
> behavior.
> 
> I'm guessing this is because Linux is also using some different path
> to allocate memory (probably during boot). Is my hypothesis correct?
> 
> Is there any different memory allocation path other than buddy
> allocator? Where can I find it?

memblock is the early memory allocator during boot, before the buddy is 
up and running. The range allocator (e.g., alloc_contig_range()) is some 
kind of mechanism that builds up on top of the buddy. Other allcoators 
(hugetlb, slab, ...) might cache some pages, but effectively get 
"physical memory" either via memblock or the buddy.

CMA is another special-purpose allocator which reserves physical memory 
areas via memblock and then uses the range allocator to actually 
allocate memory inside these reserved regions at runtime.

-- 
Thanks,

David / dhildenb

