Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD5A3B93F6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 17:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhGAPct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 11:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32613 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233064AbhGAPcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 11:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625153417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SKgmc78iHmsFP5+Ry+OkoxQCgaV5z3jDGGPpateTs4g=;
        b=C822jfP8zsE3qgL8oCJh2WfqLjrqttMbstADVhduUhz7TLSOAi7GCv6FIU2QRbekFT00HM
        kPfhi/26qOqG12oJUlEFibHbZimw2+8ubvpHe8/4XB9gHzhT1XIK1MHnqyecRlkTtPt2bK
        ZZjDzvEkIjxDXg8a4WZJcId3vB7WPuQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-upN89EKQO6yAN1Nb7aibaA-1; Thu, 01 Jul 2021 11:30:16 -0400
X-MC-Unique: upN89EKQO6yAN1Nb7aibaA-1
Received: by mail-wm1-f69.google.com with SMTP id v25-20020a1cf7190000b0290197a4be97b7so2186472wmh.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 08:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SKgmc78iHmsFP5+Ry+OkoxQCgaV5z3jDGGPpateTs4g=;
        b=f7Gvzxr+vlreHp3OAulUo4OueRwNUhkvpWylY+mz7wsQGZVvNMafRYZoV5522aI/t0
         tybwWSIRMDQMJhCiPKC4XSTJkI0SOMRmDOmr2TiHaZTMaAMd/V+XXQfHYtUhdBs02i82
         mGfDFomiY1GAhiO4w/ePXN+Ju2nPwJD3fdPM4KQQiz55wEVu6xkyTbci441xz8Yngzg9
         xg7rz+soKN88StTTCZ6U6tpB/XmtC7u9YvpD9NeWTeFBKZKGN05pjWLBLaihQ6L2Mb2l
         9xciLm1fOdei7NaBye3EG7YU2i/P2v2XA8AgfrsDiOL0s+LEMfKxdXOGjTat3A0fj1zf
         7glw==
X-Gm-Message-State: AOAM530fG7xeCbz9tUDhIu6EC02y0BDptVq8Xm78AtECdEa/TrlrZ1o4
        TaJhZwwhgywmrkwTG+OWtaFcWQDEb/Gnvs0x/JqtH4b49A75nzYeNU1yzJ0k7vkfBzsR+208uze
        NSAoSIFx6DHeCzlw62j5+QA1t
X-Received: by 2002:adf:fd46:: with SMTP id h6mr268612wrs.420.1625153415392;
        Thu, 01 Jul 2021 08:30:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwNFp6uW8LdObOxnBc5oIIj2quQhTEJKlugqsY1opjyH1JwL0gjMVczaGGpy5QTA90C17c3A==
X-Received: by 2002:adf:fd46:: with SMTP id h6mr268599wrs.420.1625153415268;
        Thu, 01 Jul 2021 08:30:15 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23bca.dip0.t-ipconnect.de. [79.242.59.202])
        by smtp.gmail.com with ESMTPSA id n8sm254959wrt.95.2021.07.01.08.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 08:30:14 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] memory-hotplug.rst: complete admin-guide overhaul
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20210609075752.4596-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <4624932e-2022-a60d-f58f-e11b70014efa@redhat.com>
Date:   Thu, 1 Jul 2021 17:30:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210609075752.4596-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.06.21 09:57, David Hildenbrand wrote:
> This is v3 of the memory hot(un)plug admin-guide overhaul.
> 
> v2 -> v3:
> - Added ACKs and RBs (thanks!)
> - s/aarch64/arm64/
> - Refine error handling when onlining/offlining
> - s/memory hotplug/memory offlining/ in the vmemmap optimization section
>    for huge pages
> 
> v1 -> v2:
> - Added "memory-hotplug.rst: remove locking details from admin-guide"
> - Incorporated all feedback from Mike and Michal (thanks!)
> - Compressed some lines to make full use of 80 chars.
> - Added details regarding 64bit/supported archs to the introduction.
> - Added KASAN to the list of sizing considerations.
> 
> David Hildenbrand (2):
>    memory-hotplug.rst: remove locking details from admin-guide
>    memory-hotplug.rst: complete admin-guide overhaul
> 
>   .../admin-guide/mm/memory-hotplug.rst         | 800 ++++++++++--------
>   1 file changed, 455 insertions(+), 345 deletions(-)
> 

Andrew,

are you planning on picking+sending this for this cycle, or do you 
prefer to let this doc update rest for a little bit longer?

I can spot that mmotm still contains v1.

Thanks!

-- 
Thanks,

David / dhildenb

