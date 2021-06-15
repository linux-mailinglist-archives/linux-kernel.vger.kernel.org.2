Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C158C3A78D5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 10:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhFOIOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 04:14:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23291 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230479AbhFOIOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623744732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zkFswLa16HS+1rAmPsXuA9PEyCn4dKv5EonI+IJkKKQ=;
        b=IdKV8ZQNNY7/5bFwoAIH2ydzM2tx/+3YKeBobQ0HproAKrVKzEndVhbtj/jV+idfPRE3/v
        w95C9WSk8lZirtFo8rfGjFK2YmO99aL2YZt3EqD8CkVU9XcXRDeEqXaaSUR1EPDADkBCGl
        n1xGZjU7R5EUdo3JSqkoFYA92vdXS1w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-ZvbCNC8OMIuspFK5xL0M-g-1; Tue, 15 Jun 2021 04:12:08 -0400
X-MC-Unique: ZvbCNC8OMIuspFK5xL0M-g-1
Received: by mail-wr1-f71.google.com with SMTP id h10-20020a5d688a0000b0290119c2ce2499so8167259wru.19
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 01:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zkFswLa16HS+1rAmPsXuA9PEyCn4dKv5EonI+IJkKKQ=;
        b=SiSyKwANhGxgTALbd0ENF1vJergYwjnlBfs8yEixLbFUoKWGYGGKF4MQPpQIOGBlxQ
         tTM7zLpam5esuTBjENpOYdwE/6eYppEC5/97U/+08N1iBGG60ZiBlJQFOOTyJ6uPx8Bp
         nlU5qJOYksGHLTZ6UVs/PIa0N4ozVHHxB95/zfKpemeKJWIuitpihsrzlMvpDFShHKwN
         cuf4Fl1Ug/DC9gqGkRcK8bMINX6GYfj4V3hjuOzjxCN/I6EpOUqRS71xUO0/g0x+8/3A
         1OOuWTsVLz8geIw5JQJo/gQqxAD+RqM+jv61R1OGCGgY6B2Hh45tfkP+GMVfE2oG//yb
         IJVA==
X-Gm-Message-State: AOAM532Vy858+Q+DGafN08lVyXnvjiPGrqTL96purMjL3YmwbA7EG4Cu
        4xygS5FD7c3usTYf2zgvoGciQlXXXLQEzi3O9Q+5GYUTv5GAxfF+J9IdAI0CGgWdYpifP3+JeEC
        j1kwb6z3TBkOFtRM3e14GYFyu
X-Received: by 2002:adf:a191:: with SMTP id u17mr23646147wru.150.1623744727433;
        Tue, 15 Jun 2021 01:12:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9ewGkGMrN8irtKlU0AgoLfsPXPeWdncDLrNCXaTB9Ps384HUoujSkTJh97Njpm8/B2PrHWQ==
X-Received: by 2002:adf:a191:: with SMTP id u17mr23646138wru.150.1623744727299;
        Tue, 15 Jun 2021 01:12:07 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6136.dip0.t-ipconnect.de. [91.12.97.54])
        by smtp.gmail.com with ESMTPSA id n1sm15089943wms.18.2021.06.15.01.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 01:12:07 -0700 (PDT)
To:     Rustam Kovhaev <rkovhaev@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dvyukov@google.com, gregkh@linuxfoundation.org
References: <YMe8ktUsdtwFKHuF@nuc10>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: kmemleak memory scanning
Message-ID: <f60e2a4f-2eb8-1097-60b5-eee998478068@redhat.com>
Date:   Tue, 15 Jun 2021 10:12:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YMe8ktUsdtwFKHuF@nuc10>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.06.21 22:31, Rustam Kovhaev wrote:
> hello Catalin, Andrew!
> 
> while troubleshooting a false positive syzbot kmemleak report i have
> noticed an interesting behavior in kmemleak and i wonder whether it is
> behavior by design and should be documented, or maybe something to
> improve.

Hi,

See below regarding documentation.

> apologies if some of the questions do not make sense, i am still going
> through kmemleak code..
> 
> a) kmemleak scans struct page (kmemleak.c:1462), but it does not scan
> the actual contents (page_address(page)) of the page.
> if we allocate an object with kmalloc(), then allocate page with
> alloc_page(), and if we put kmalloc pointer somewhere inside that page,
> kmemleak will report kmalloc pointer as a false positive.
> should we improve kmemleak and make it scan page contents?
> or will this bring too many false negatives?

I looked into this a while ago to see which parts of the kernel end up 
reading random physical page content and was happy to see that kmemleak 
does *not* scan random physical memory :)

We have to be very careful when reading random physical page content, 
especially in virt environments this is really undesired, or when 
dealing with memory holes, memory with problematic semantics like gart 
memory ...

The doc (Documentation/dev-tools/kmemleak.rst) states "Page allocations 
and ioremap are not tracked.", which includes the alloc_page() example 
you gave I think.

-- 
Thanks,

David / dhildenb

