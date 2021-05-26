Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25BE3922B7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 00:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhEZWak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 18:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24295 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234201AbhEZWai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 18:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622068146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KJRZ7Xr9eE1StDnH/ATVl1uLoI8ZB4qRKeY2WD/qOD0=;
        b=RYS3otLmKgkK9XXdcQQynoE1AomxeYvgoT7dz5ecDcd1J9yb2f9o/wfXzKvUpL3XWA5UBI
        oHeZZk+WbFtfGvMYZ+46CUTjz+IAoTn9nLBOWsPuNpPh2fbDQhtqQ9FuowCHEcuXRz6UpJ
        ouNnhdfxi9tF3zn/PSMcn0+PDl51fv0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-DkzzrCcMPP-U0D74zZ4Epw-1; Wed, 26 May 2021 18:29:04 -0400
X-MC-Unique: DkzzrCcMPP-U0D74zZ4Epw-1
Received: by mail-qv1-f72.google.com with SMTP id n3-20020a0cee630000b029020e62abfcbdso2380981qvs.16
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 15:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KJRZ7Xr9eE1StDnH/ATVl1uLoI8ZB4qRKeY2WD/qOD0=;
        b=nGqVgoS/3RoPrQaIlKb13Rg+SIJFR3jGRSxdXBXLGxP3sUQX3QzJrAVBhoSsMMTu15
         3f1w9wgeYxOUdxkbQKy4rkx/jksRv3bintRg6trrTe1sQkl6F/kRRoR0YcQ/ndMD3NBw
         UZl2wGGgyECwYln7XPP/wrUgQq69w5hx1dS8Cygtjr4QsHM/C5OSnFYLIGCEOeu+rRsA
         Bil373cSQ6zybPQVedP9oSaBZbgLuMtXVuVxPni7UexKYp41Gl6A+jLjpVQN0sn0rrkz
         jMR7cQJgBcGFx3dCR2DcYKP3635MXnkDotk8oh/cEyOEHsyzKzK141JJGzKybUlcrs8T
         +PBg==
X-Gm-Message-State: AOAM530rutmpmesDmcWdm9uK86guKL7rQg9pvU6RtB2vbZzRqQl0rh79
        RW/UaQJwOhJZQlRf++p5HvPxii442FWuYBp91HMp2haCdUhvguB5FhMqm7kqD/Jiivyy9qKTxW3
        YijUshz+Nyv6I11SortsfjkAF
X-Received: by 2002:a37:e11:: with SMTP id 17mr364051qko.499.1622068144278;
        Wed, 26 May 2021 15:29:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzYClyKpygSkxiLgjGmd4Z0WDwgsAIxTAfrAxM/4Ef8VZM6cO98o6XMM6GieLiHaSuGLwpCg==
X-Received: by 2002:a37:e11:: with SMTP id 17mr364043qko.499.1622068144117;
        Wed, 26 May 2021 15:29:04 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id v17sm203783qta.77.2021.05.26.15.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 15:29:03 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH-next] mm/memcontrol.c: Fix potential uninitialized
 variable warning
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
References: <20210526193602.8742-1-longman@redhat.com>
 <20210526134321.42bbd4a9dcbcf53e855c5b1b@linux-foundation.org>
Message-ID: <9fb60ba4-258d-2bb5-57af-c174df9b1a31@redhat.com>
Date:   Wed, 26 May 2021 18:29:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210526134321.42bbd4a9dcbcf53e855c5b1b@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/21 4:43 PM, Andrew Morton wrote:
> On Wed, 26 May 2021 15:36:02 -0400 Waiman Long <longman@redhat.com> wrote:
>
>> If the -Wno-maybe-uninitialized gcc option is not specified, compilation
>> of memcontrol.c may generate the following warnings:
>>
>> mm/memcontrol.c: In function ‘refill_obj_stock’:
>> ./arch/x86/include/asm/irqflags.h:127:17: warning: ‘flags’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>>    return !(flags & X86_EFLAGS_IF);
>>            ~~~~~~~^~~~~~~~~~~~~~~~
>> mm/memcontrol.c:3216:16: note: ‘flags’ was declared here
>>    unsigned long flags;
>>                  ^~~~~
>> In file included from mm/memcontrol.c:29:
>> mm/memcontrol.c: In function ‘uncharge_page’:
>> ./include/linux/memcontrol.h:797:2: warning: ‘objcg’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>>    percpu_ref_put(&objcg->refcnt);
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Fix that by properly initializing *pflags in get_obj_stock() and
>> introducing a use_objcg bool variable in uncharge_page() to avoid
>> potentially accessing the struct page data twice.
>>
> Thanks.  I'll queue this as a fix against your "mm/memcg: optimize user
> context object stock access".
>
Thanks for that.

Cheers,
Longman

