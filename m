Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4416C40064C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 22:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbhICUEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 16:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23486 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235902AbhICUEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 16:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630699385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VKgG5Q4GJoZylhkC+igd3ORO7G/PVfFNNgAWNVRKHjA=;
        b=Y+YZZt+yERSvzX8F4rfpsD2kDbMvBm1tevBsq7TdU+M+hsPJsIz5hHwkH03Mf2CTOdCQu/
        yI9g3FpLkBlPzQPC6NCvvAjsFwLMMGWHxcXnN3xn8z4PDnlDOb3fgT1QtEi1irOiQCdTaG
        cWy6L/vUEH1sd1k7GCsXH3XKNhqtHDE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-Z04qiz2xO4OZF6GCWMPM3A-1; Fri, 03 Sep 2021 16:03:04 -0400
X-MC-Unique: Z04qiz2xO4OZF6GCWMPM3A-1
Received: by mail-wr1-f72.google.com with SMTP id i16-20020adfded0000000b001572ebd528eso59598wrn.19
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 13:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VKgG5Q4GJoZylhkC+igd3ORO7G/PVfFNNgAWNVRKHjA=;
        b=sNxOsGziyNsoBR0kjebUmzktySHS7DLF9415ps05eBFBQu7uowJtpV5GkOFHqekftT
         p3XUdGGnVT4bdzaLP+Oad1NZHNS9vPJyLBw4s9ZAbkFY5xFswE3ZEMuvcsFM3/zvAXl1
         dnAVFvPVlTxMLfW+Ad3lICTl1PVtxJ1BJVeFn0vn2J9mB+wkP9d1xcosOrQlkrAhmjqc
         AYqM7N59j7HoQdglp3aooUQzbGLXs+Kt+6/YQ1asU6eWoGcQBc7siiWdiqXOFhrIkpBr
         jEtee5+LQ/i2mtoViXWLSa8jm0wGTkVF7hxvuzTCuFyonjgmXXYY8qN+pAxdhwsrsGR+
         AQ7A==
X-Gm-Message-State: AOAM530/JadCPOL+5ag3dp78JJeS6BlZbDQytMMwm+vfPQWCp9Qig/du
        RHt7PrwM61BwV17S0pq+QqsAEuKyDTLx1ECACTjsZOcj8/TEyc6gbc5NqFc3VAE9WdkWTaBtXeU
        Ja8fP7HpvaZPNoo61N7F7p/S7
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr384494wmk.5.1630699382950;
        Fri, 03 Sep 2021 13:03:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQhSfAMAF02/q6C2QxnKU2WGgOJyKv6ePPQ4NAfk0+wU4lJfiNPUufyOzUU+d+fOt0TKO1cw==
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr384477wmk.5.1630699382743;
        Fri, 03 Sep 2021 13:03:02 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23e05.dip0.t-ipconnect.de. [79.242.62.5])
        by smtp.gmail.com with ESMTPSA id b1sm188902wrh.85.2021.09.03.13.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 13:03:00 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] mm/shmem: Unconditionally set pte dirty in
 mfill_atomic_install_pte
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>
References: <20210902201721.52796-1-peterx@redhat.com>
 <20210902201721.52796-2-peterx@redhat.com>
 <2f1bfe82-9bb7-957c-2b32-2ccf8a48e70a@redhat.com> <YTJ+4PAzKf9Cqydk@t490s>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <05d64fe1-77f6-aa2a-6b79-e08f6b997ed9@redhat.com>
Date:   Fri, 3 Sep 2021 22:02:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YTJ+4PAzKf9Cqydk@t490s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.09.21 22:00, Peter Xu wrote:
> On Fri, Sep 03, 2021 at 09:42:34AM +0200, David Hildenbrand wrote:
>> On 02.09.21 22:17, Peter Xu wrote:
>>> It was conditionally done previously, as there's one shmem special case that we
>>> use SetPageDirty() instead.  However that's not necessary and it should be
>>> easier and cleaner to do it unconditionally in mfill_atomic_install_pte().
>>>
>>> The most recent discussion about this is here, where Hugh explained the history
>>> of SetPageDirty() and why it's possible that it's not required at all:
>>>
>>> https://lore.kernel.org/lkml/alpine.LSU.2.11.2104121657050.1097@eggly.anvils/
>>>
>>> Currently mfill_atomic_install_pte() has three callers:
>>>
>>>           1. shmem_mfill_atomic_pte
>>>           2. mcopy_atomic_pte
>>>           3. mcontinue_atomic_pte
>>>
>>> After the change: case (1) should have its SetPageDirty replaced by the dirty
>>> bit on pte (so we unify them together, finally), case (2) should have no
>>> functional change at all as it has page_in_cache==false, case (3) may add a
>>> dirty bit to the pte.  However since case (3) is UFFDIO_CONTINUE for shmem,
>>> it's merely 100% sure the page is dirty after all, so should not make a real
>>> difference either.
>>
>> Would it be worth adding VM_BUG_ON() to make sure that "100%" is really the
>> case?
> 
> I won't be able to make it 100% sure (and that's where I put it "merely").  The
> example discussed between Axel and me in the other thread could be an outlier
> (when two processes, uffd target, and uffd minor resolver, map the region as
> RO), it's just that neither do I think that's a great matter, nor do I think it
> would be worth a BUG_ON(), not to mention we use BUG_ON so carefully.

Agreed then, if we really expect there are corner cases and that the 
corner cases are fine!

(VM_BUG_ON() could have helped to catch these while testing)

-- 
Thanks,

David / dhildenb

