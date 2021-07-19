Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA57C3CCE92
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 09:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhGSHhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 03:37:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36741 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233759AbhGSHhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 03:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626680064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0sfSO6C1l3WtCtuFbg0VI6VLBjRIkRSfgQNpDtonfxE=;
        b=PdsUK6CcnpDkzgT7rmSkVERCqDksMyVtTzhWFXH9O/OY2DVC1dRu5drARJOuZMM4CUZ206
        I1JqnMoc48CmU0NSDUpAVrMFxG4EgQdZ2l5ZLnbaDeLL3nstwkiWsR8U+dWlBHRoiDYi0j
        uJxWUx4Mg2mesO2oLFpCewMtRUIrzC8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-QGB3zAoxPNCtdMDAyHWvxw-1; Mon, 19 Jul 2021 03:34:23 -0400
X-MC-Unique: QGB3zAoxPNCtdMDAyHWvxw-1
Received: by mail-wm1-f71.google.com with SMTP id y6-20020a7bc1860000b0290227b53c7cefso5064663wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 00:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0sfSO6C1l3WtCtuFbg0VI6VLBjRIkRSfgQNpDtonfxE=;
        b=q2WF6rkap+/df3ysjo3RQilRcHavQhGGh3eeSJxFQnQrMFk9vaQ6sc5vDJvDi6pQ0k
         MwrjL/0L/MoAN2/LYN5OlD++OimfdNES/Xhu0WTbgsAc8e+R3pYa/vijH3l417oTN/Wj
         CD3dKvng5HT5k+1GIMdqWIB08PuZXDqpn2u1aYQs90WDjf967UfVGiIHdiSVtvny54ax
         MsRRiBgOXdzjP+Wz1IUa2kiiKF1icc3ngG0oFUIhwUvPAo2NYmQVx3QPzfzxrqxu+oCr
         cA1S0hp+77lZW2QZgEOgmnHq2wHSr++il4H71UUUpJUNiiopEU233tgeh0IQiiT1Mq1U
         u3yw==
X-Gm-Message-State: AOAM5336PZfE9LceauwQuCdONqhrdsR02oID/fRImb1aoQKB7kRNLsI7
        vUguXlUjTHa2LJ9kco2d8M7r7F7Btlayh6Mv0hZIjJkRpSQjM1N4Yk8fWSjPASiLJmMr7as3MsQ
        52zzKY2m2UXXvtHmNWCl973NY
X-Received: by 2002:a05:600c:3595:: with SMTP id p21mr17863833wmq.105.1626680062007;
        Mon, 19 Jul 2021 00:34:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz07efcFEv5EX0OoyTVlUJhLNO1Fd9o7f8O9ViBtmkhlottvR3Rzu2ykVMUwwmu3TH+CIaAhw==
X-Received: by 2002:a05:600c:3595:: with SMTP id p21mr17863820wmq.105.1626680061792;
        Mon, 19 Jul 2021 00:34:21 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id y3sm19433446wrh.16.2021.07.19.00.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 00:34:21 -0700 (PDT)
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
References: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 0/7] Free user PTE page table pages
Message-ID: <5ce5fb25-df1d-b807-8807-595b8a7bfc63@redhat.com>
Date:   Mon, 19 Jul 2021 09:34:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.07.21 06:30, Qi Zheng wrote:
> Hi,
> 
> This patch series aims to free user PTE page table pages when all PTE entries
> are empty.
> 
> The beginning of this story is that some malloc libraries(e.g. jemalloc or
> tcmalloc) usually allocate the amount of VAs by mmap() and do not unmap those VAs.
> They will use madvise(MADV_DONTNEED) to free physical memory if they want.
> But the page tables do not be freed by madvise(), so it can produce many
> page tables when the process touches an enormous virtual address space.

... did you see that I am actually looking into this?

https://lkml.kernel.org/r/bae8b967-c206-819d-774c-f57b94c4b362@redhat.com

and have already spent a significant time on it as part of my research, 
which is *really* unfortunate and makes me quite frustrated at the 
beginning of the week alreadty ...

Ripping out page tables is quite difficult, as we have to stop all page 
table walkers from touching it, including the fast_gup, rmap and page 
faults. This usually involves taking the mmap lock in write. My approach 
does page table reclaim asynchronously from another thread and do not 
rely on reference counts.

-- 
Thanks,

David / dhildenb

