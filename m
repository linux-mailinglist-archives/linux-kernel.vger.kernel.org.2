Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3067D416F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 11:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245249AbhIXJi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 05:38:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36496 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245054AbhIXJiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 05:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632476210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ySa8i5QKxO2R8AtKn1wzOUGI7jeTVD2yq0IrP5uOcwo=;
        b=GMEqXhDaz2ncPZR8Hi8/0Vc60+OA1J6MnJWGky2IGJOqFGcOzEmkKfq7FVPnENg9IA0007
        1l2RHk1FWSZL6qbYQxK5r/rt8+vROILmosXSj31KDdNx2O2Mm76F3977QSdG/tL56qQvMA
        JH9SFvXR0QfYG6Hw6dODIuk2/QUZ3Bs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-yuguzHENPz-mpbsRWLVjxQ-1; Fri, 24 Sep 2021 05:36:49 -0400
X-MC-Unique: yuguzHENPz-mpbsRWLVjxQ-1
Received: by mail-wr1-f71.google.com with SMTP id a17-20020adfed11000000b00160525e875aso30857wro.23
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 02:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ySa8i5QKxO2R8AtKn1wzOUGI7jeTVD2yq0IrP5uOcwo=;
        b=yFJf2t/K7ZD7DK5yb00AnBHLx0vdAeO6/oZ2EZlXvO0kDU16VdP+5H+mHZrrk/og1n
         kz6TQu0vp7Kjq0UfLLnacqY1MhlqcYKEYk1syWr+bK5TFcxF8Pw1sGd+SUMX8CSJOzxJ
         a6SFA+DeABrDnUO7SBrXp+eJF6mPXgmjQhwOt7bn1SADnwlb6PT7rTdiKwGu4AsrPGkC
         EtkKXDg0Kk0srlACFGJWqur2pwgmW5s15mriHgw5pskG506i1gdeQNI/PlZLkL7Zf1TO
         iBkfObi0FcoTfbIb8YiWdAxhuJPJIMx59NEbc+AI1O63X6R50Hng0MJgHr+KnjNAL5ZL
         8aIQ==
X-Gm-Message-State: AOAM531DK49qiKH02ZIV/0g+R9EjR9X7ZexF5YoWnQi2fjgHV+ThFLxX
        ooICcAwyt/7GabI3GRfzzyAz70Ud4/1LyyHBP392duNrn+c8rRpCMBZGzWmbs8ptisxsiao8Ad1
        FkKoSbfpy/qIP4+dty1vBualQ
X-Received: by 2002:adf:fe49:: with SMTP id m9mr1679256wrs.295.1632476208368;
        Fri, 24 Sep 2021 02:36:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiDgGkC+y2exmKyjLmDjth7Ee3YImPUpNjeQRQF8Jooc7hxtHt0XQieNQWjef0RhAxQF9iXA==
X-Received: by 2002:adf:fe49:: with SMTP id m9mr1679236wrs.295.1632476208206;
        Fri, 24 Sep 2021 02:36:48 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c61fc.dip0.t-ipconnect.de. [91.12.97.252])
        by smtp.gmail.com with ESMTPSA id m4sm12020908wml.28.2021.09.24.02.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 02:36:47 -0700 (PDT)
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>,
        Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210923175347.10727-1-mike.kravetz@oracle.com>
 <20210923175347.10727-3-mike.kravetz@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/4] hugetlb: add HPageCma flag and code to free
 non-gigantic pages in CMA
Message-ID: <7ab7690d-aa21-0fd9-75f1-f3a23b892853@redhat.com>
Date:   Fri, 24 Sep 2021 11:36:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210923175347.10727-3-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.09.21 19:53, Mike Kravetz wrote:
> When huge page demotion is fully implemented, gigantic pages can be
> demoted to a smaller huge page size.  For example, on x86 a 1G page
> can be demoted to 512 2M pages.  However, gigantic pages can potentially
> be allocated from CMA.  If a gigantic page which was allocated from CMA
> is demoted, the corresponding demoted pages needs to be returned to CMA.
> 
> In order to track hugetlb pages that need to be returned to CMA, add the
> hugetlb specific flag HPageCma.  Flag is set when a huge page is
> allocated from CMA and transferred to any demoted pages.  Non-gigantic
> huge page freeing code checks for the flag and takes appropriate action.

Do we really need that flag or couldn't we simply always try 
cma_release() and fallback to out ordinary freeing-path?

IIRC, cma knows exactly if something was allocated via a CMA are and can 
be free via it. No need for additional tracking usually.

-- 
Thanks,

David / dhildenb

