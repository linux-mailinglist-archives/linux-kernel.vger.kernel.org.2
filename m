Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781CA411365
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236591AbhITLPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:15:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229735AbhITLPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632136417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IZ8YEasz0PdN4ukrSk2HlDUkS7Znu8KVlo9VMULnn3Y=;
        b=ApwcfJ4wcDPzADhOxKPJkXecAjCDyn6D4byRPGHRiJlC0wE1NbUan1gWcmiUFAoMq6jytb
        ARMCYDl/jHaKxJE7DOzg/+MJBZ0fxfkwwG2KSaYJIlDUPy78zSwk+71agC+PUQa5CvTwLM
        IFI7JAA8tOi9z5I93G2lh5MMU4eJYYo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-jpxV4eT6OmefnW6UyxuAhw-1; Mon, 20 Sep 2021 07:13:35 -0400
X-MC-Unique: jpxV4eT6OmefnW6UyxuAhw-1
Received: by mail-wr1-f70.google.com with SMTP id i4-20020a5d5224000000b0015b14db14deso5768583wra.23
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 04:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IZ8YEasz0PdN4ukrSk2HlDUkS7Znu8KVlo9VMULnn3Y=;
        b=GYEHlYkqQjryfZll/grw2K5GcOUqvJowbwHRZnh8AtxLpLWMzH46QwQWNvwYEUmoaC
         e1TZKYb6QFmjtjNayKVUDF5CqYCEfOXLxrDJ+oayUOOIHVXh4tN/u4V+ABUMEckJSXx0
         eJQ5ZRSXMnXgBpkNfoCwwsXwurrVlHKrClGwjEsxaL4s8i5xW3qJW96li0alVlTqtEn4
         /m+BsQdDv4EK6KJ48CgGXCVidxPrm/77uwsIYNSHie8ZQfmJ/Qyj6j0sTU3OEkX8YOP1
         NgUa0n8MuN3xBWyDgCSEiWi9xANWgE0NeXsfP74kJqFdBNkW5WJacYZQ6lKKlWYWeTFU
         WHvA==
X-Gm-Message-State: AOAM533L92VYJWBd6O9cS1l6bHpO4biIT/xAFabh3EAhdLBokBxmcvXk
        bkcpH7VW2GfQqPFtuyv1JEivP9WNO8tH/NoeMDanwYHsP2Wfm0MaQtj+TIoNaRMOeHyC+s2/1NN
        /y+XPlo81bd+9KQ9V25TGeoER
X-Received: by 2002:a5d:4e90:: with SMTP id e16mr27545302wru.243.1632136414678;
        Mon, 20 Sep 2021 04:13:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVVC3QWCiYBVueV5VyBnjktyocWHYCd61aZMvqJvpVU+4t4lDWOAg5sex5oshyENhYJauZeQ==
X-Received: by 2002:a5d:4e90:: with SMTP id e16mr27545282wru.243.1632136414457;
        Mon, 20 Sep 2021 04:13:34 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23e48.dip0.t-ipconnect.de. [79.242.62.72])
        by smtp.gmail.com with ESMTPSA id n68sm19504842wmn.13.2021.09.20.04.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 04:13:33 -0700 (PDT)
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
To:     Christoph Hellwig <hch@lst.de>, Mike Rapoport <rppt@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Bee <knaerzche@gmail.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <d3a3c828-b777-faf8-e901-904995688437@gmail.com>
 <20210824173741.GC623@arm.com> <YSU6NVZ3j0XCurWC@kernel.org>
 <0908ce39-7e30-91fa-68ef-11620f9596ae@arm.com>
 <60a11eba-2910-3b5f-ef96-97d4556c1596@redhat.com>
 <20210825102044.GA3420@arm.com> <YUUHJ5EI+6Mop4Wu@kernel.org>
 <20210918051843.GA16104@lst.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <71b7d1b5-4a5f-9053-b22b-4d946cbf6d6e@redhat.com>
Date:   Mon, 20 Sep 2021 13:13:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210918051843.GA16104@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.09.21 07:18, Christoph Hellwig wrote:
> On Sat, Sep 18, 2021 at 12:22:47AM +0300, Mike Rapoport wrote:
>> I did some digging and it seems that the most "generic" way to check if a
>> page is in RAM is page_is_ram(). It's not 100% bullet proof as it'll give
>> false negatives for architectures that do not register "System RAM", but
>> those are not using dma_map_resource() anyway and, apparently, never would.
> 
> The downside of page_is_ram is that it looks really expensiv for
> something done at dma mapping time.
> 

There would be ways to speed it up, similar to

https://lkml.kernel.org/r/20210902160919.25683-2-david@redhat.com

but the end result is still walking a list. Question would be, how much 
that overhead matters in practice.

-- 
Thanks,

David / dhildenb

