Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6F53C6DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 11:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbhGMJyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 05:54:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234857AbhGMJyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 05:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626169909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbVpCJ8GLa0hxilOdeafb29laMr4Nxg08S4wR66Adcc=;
        b=c+eewRcHtVVKGKC5SwnXRKXGKSMZpYu2N7YYwpr+PCH/NRn2a78oZ6MIBgrTG0uJH0hI3P
        dNYvPeUO7noB9qGPjYACqi3NdXdAMmV8QBfv/tvDm6uFlM5Ca3KScuHcWsC7jPCzrN4CK+
        MzMcSfI/5uHu+wZNCNV+x7Mafh0i87A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-7KXmF0CgMk2yxBCDO9j3iA-1; Tue, 13 Jul 2021 05:51:48 -0400
X-MC-Unique: 7KXmF0CgMk2yxBCDO9j3iA-1
Received: by mail-wm1-f71.google.com with SMTP id m31-20020a05600c3b1fb02902082e9b2132so288426wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 02:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tbVpCJ8GLa0hxilOdeafb29laMr4Nxg08S4wR66Adcc=;
        b=k1A4eEkA4aHBhnGrcMpM907l2byyizM8V33um5bMPHeksZDaq6mHchryPnWgN6A/3M
         OfubVHHyjYg1dwxlrceG71AL9Aej7CTt4R8T6h6D/nVhAVU9TTpa5PNuX+e+7p+cBfKK
         KUOC7tukVFOl+GF9/LfKNrnf7pf7a1CagnfypVidNDmMvFV7uHI1mgg0Z/nB825aOgLJ
         tnL10Kztj642RI455IDByjgHRvbbRdp4EXDQYd+Jd6TudbvB6MrnlHYTihoUki0kXYht
         8izCMIazLLSchQGuX4x/LE7w+XGZ7ljkz3Uy7rZYgozjZIkE2oaTqXFyWHJ1glyCvSZG
         zz0A==
X-Gm-Message-State: AOAM531BXkV5saejQ6tsBYnuXivk4mgwY9BFyx8K9t+GGEFh92jHlTwp
        tjwTQ3P33J3+s5iPW4BAmCKYMN2Mmb+sJb3AqLcf57KWVYo2omk9OUOTKUR1VCTOPykOz9HsLNw
        nwVZ8++s4ixiD1PXqrnkDCyLG
X-Received: by 2002:a5d:46cc:: with SMTP id g12mr4415718wrs.136.1626169907572;
        Tue, 13 Jul 2021 02:51:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/GqNgtzZRWmYLDz80dEOp59PHsbGvCWr4Au8zvbhBgLzCZbb2+X12ymf+JjOj9uQxKghRiw==
X-Received: by 2002:a5d:46cc:: with SMTP id g12mr4415706wrs.136.1626169907427;
        Tue, 13 Jul 2021 02:51:47 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id n7sm1756180wmq.37.2021.07.13.02.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 02:51:47 -0700 (PDT)
Subject: Re: [PATCH 1/2] mm: remove pfn_valid_within() and
 CONFIG_HOLES_IN_ZONE
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210713080035.7464-1-rppt@kernel.org>
 <20210713080035.7464-2-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7300dfe1-0c6a-ae2e-2c48-c885248ec263@redhat.com>
Date:   Tue, 13 Jul 2021 11:51:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713080035.7464-2-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.07.21 10:00, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> After recent changes in freeing of the unused parts of the memory map and
> rework of pfn_valid() in arm and arm64 there are no architectures that can
> have holes in the memory map within a pageblock and so nothing can enable
> CONFIG_HOLES_IN_ZONE which guards non trivial implementation of
> pfn_valid_within().
> 
> With that, pfn_valid_within() is always hardwired to 1 and can be
> completely removed.
> 
> Remove calls to pfn_valid_within() and CONFIG_HOLES_IN_ZONE.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

There is currently the discussion to increase MAX_ORDER, for example, to 
cover 1GiB instead of 4MiB on x86-64. This would mean that we could 
suddenly, again, have holes insides MAX_ORDER - 1 pages.

So I assume if we ever go down that path, we'll need something like this 
again.

For now, this looks like the right thing to do

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

