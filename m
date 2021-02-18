Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F0631E89D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 11:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhBRKIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 05:08:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47578 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230403AbhBRI4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613638518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XKvhMYbPeIfjBqzilW6MTKDEALceHhOMd9Ttih7NUzc=;
        b=MLxzsSEVj2slcN2G0gOS9NGNTTTtDX/I3+UxLbpfWQaaQDqlilvG9xdWB6eGg0HIc/1e73
        uKPpIGc+Tcvnpq3GZSlsaTvIRO1FrAYlIIYwH79smBxvMIitbyLnCIuXFVT2p7UNTX72O2
        EqkQ9GvduS5wen0IKDUAjbhDI1mF2pQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-Q0uAD2YWMX25mfx7NX_YEw-1; Thu, 18 Feb 2021 03:55:15 -0500
X-MC-Unique: Q0uAD2YWMX25mfx7NX_YEw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A5146EE20;
        Thu, 18 Feb 2021 08:55:13 +0000 (UTC)
Received: from [10.36.114.59] (ovpn-114-59.ams2.redhat.com [10.36.114.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ADBD96E407;
        Thu, 18 Feb 2021 08:55:08 +0000 (UTC)
Subject: Re: [PATCH] mm, kasan: don't poison boot memory
To:     Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        George Kennedy <george.kennedy@oracle.com>,
        Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <487751e1ccec8fcd32e25a06ce000617e96d7ae1.1613595269.git.andreyknvl@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <e58cbb53-5f5b-42ae-54a0-e3e1b76ad271@redhat.com>
Date:   Thu, 18 Feb 2021 09:55:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <487751e1ccec8fcd32e25a06ce000617e96d7ae1.1613595269.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.02.21 21:56, Andrey Konovalov wrote:
> During boot, all non-reserved memblock memory is exposed to the buddy
> allocator. Poisoning all that memory with KASAN lengthens boot time,
> especially on systems with large amount of RAM. This patch makes
> page_alloc to not call kasan_free_pages() on all new memory.
> 
> __free_pages_core() is used when exposing fresh memory during system
> boot and when onlining memory during hotplug. This patch adds a new
> FPI_SKIP_KASAN_POISON flag and passes it to __free_pages_ok() through
> free_pages_prepare() from __free_pages_core().
> 
> This has little impact on KASAN memory tracking.
> 
> Assuming that there are no references to newly exposed pages before they
> are ever allocated, there won't be any intended (but buggy) accesses to
> that memory that KASAN would normally detect.
> 
> However, with this patch, KASAN stops detecting wild and large
> out-of-bounds accesses that happen to land on a fresh memory page that
> was never allocated. This is taken as an acceptable trade-off.
> 
> All memory allocated normally when the boot is over keeps getting
> poisoned as usual.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Change-Id: Iae6b1e4bb8216955ffc14af255a7eaaa6f35324d

Not sure this is the right thing to do, see

https://lkml.kernel.org/r/bcf8925d-0949-3fe1-baa8-cc536c529860@oracle.com

Reversing the order in which memory gets allocated + used during boot 
(in a patch by me) might have revealed an invalid memory access during boot.

I suspect that that issue would no longer get detected with your patch, 
as the invalid memory access would simply not get detected. Now, I 
cannot prove that :)

-- 
Thanks,

David / dhildenb

