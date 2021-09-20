Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97ED1411F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 19:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348775AbhITRkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 13:40:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25791 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352075AbhITRhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 13:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632159372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=joEmUTI4ZZjQtcXVOCrz/b3U1ugGJV5MEzLo31LXFyM=;
        b=i8TIiM/jE1lK36soC22bYhDiPafqZ4uFV1q81ITefXT+LtWEFPSkDomZa3sD9ZjrVkukEy
        WK0d2B4FwRejE49yYkcqinj0VobxMUt2ddTfghpNwtRrtx0r+PiNkfZWgK36YEsCzcnGdX
        CNI70ZFEiMTkEZK9nzFC7peXMRQi1Zg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-_wwAutFROwuWyK0abXkA9g-1; Mon, 20 Sep 2021 13:36:11 -0400
X-MC-Unique: _wwAutFROwuWyK0abXkA9g-1
Received: by mail-wr1-f71.google.com with SMTP id r15-20020adfce8f000000b0015df1098ccbso6721870wrn.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 10:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=joEmUTI4ZZjQtcXVOCrz/b3U1ugGJV5MEzLo31LXFyM=;
        b=mYmOFsP2ZVnhixcwdr8cBzQB13eMG7C2a6+xFhuM96WVXDIGz9CyFW3VmsZhoePa6K
         kiR3M/OYCXc8ePa2RYvvzoSYAQApyNTwMM5kUIUCO5NtzlwIP0tmcmN/7FEtc+w0sELv
         qBVMOQ/LCug/JjGO/LVZzMcDBgocBHBZK0XK+GmEVcajd+YV8Mbo+CfVeQpHz+2Kro/2
         xeYq/bcReCEneJCDGB/plNxMQMqli0n8rnJWTp5dgarEJ3PeCN6VwERDFeeN3O+yKX28
         47BaAjI7YEnzLEf9uiwItFlP91BRbgsutpQvk4EBt12fDspC8rLKYP3BrMKhMOzGWlOa
         54ag==
X-Gm-Message-State: AOAM530ZSpE41+1Dw/vzUhmuXDM7QfqwsVWvwMcWrVtO6wu3b1UoBZVl
        gBf15eqP0gtnbmWg2JIovFBHD5k57eVb9BGNAcTeCem0Gv6ZpSX4fAOMaETp5V3vMYEa3bi91ta
        +l3JlQKA62YHyxqGjqONct9c/
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr29694381wrs.271.1632159370305;
        Mon, 20 Sep 2021 10:36:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxd+Ecc/ldnyJDRLp7Hdo6uHjNnF8F4pT5VdfoRiLEQAWtep8SAoFkzsot/bUJ/fdK5Sue1gw==
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr29694338wrs.271.1632159369854;
        Mon, 20 Sep 2021 10:36:09 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23e48.dip0.t-ipconnect.de. [79.242.62.72])
        by smtp.gmail.com with ESMTPSA id w1sm171783wmc.19.2021.09.20.10.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 10:36:09 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] Documentation: update pagemap with shmem
 exceptions
To:     Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>,
        akpm@linux-foundation.org, corbet@lwn.net, peterx@redhat.com,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     ivan.teterevkov@nutanix.com, florian.schmidt@nutanix.com,
        carl.waldspurger@nutanix.com, jonathan.davies@nutanix.com
References: <20210920164931.175411-1-tiberiu.georgescu@nutanix.com>
 <20210920164931.175411-2-tiberiu.georgescu@nutanix.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <a89b861e-e5ff-32cf-c511-5b17ef60c2dd@redhat.com>
Date:   Mon, 20 Sep 2021 19:36:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210920164931.175411-2-tiberiu.georgescu@nutanix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.09.21 18:49, Tiberiu A Georgescu wrote:
> Mentioning the current missing information in the pagemap and alternatives
> on how to retrieve it, in case someone stumbles upon unexpected behaviour.
> 
> Signed-off-by: Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
> Reviewed-by: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
> Reviewed-by: Florian Schmidt <florian.schmidt@nutanix.com>
> Reviewed-by: Carl Waldspurger <carl.waldspurger@nutanix.com>
> Reviewed-by: Jonathan Davies <jonathan.davies@nutanix.com>
> ---
>   Documentation/admin-guide/mm/pagemap.rst | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
> index fb578fbbb76c..ea3f88f3c18d 100644
> --- a/Documentation/admin-guide/mm/pagemap.rst
> +++ b/Documentation/admin-guide/mm/pagemap.rst
> @@ -196,6 +196,28 @@ you can go through every map in the process, find the PFNs, look those up
>   in kpagecount, and tally up the number of pages that are only referenced
>   once.
>   
> +Exceptions for Shared Memory
> +============================
> +
> +Page table entries for shared pages are cleared when the pages are zapped or
> +swapped out. This makes swapped out pages indistinguishable from never-allocated
> +ones.
> +
> +In kernel space, the swap location can still be retrieved from the page cache.
> +However, values stored only on the normal PTE get lost irretrievably when the
> +page is swapped out (i.e. SOFT_DIRTY).
> +
> +In user space, whether the page is swapped or none can be deduced with the
> +lseek system call. For a single page, the algorithm is:
> +
> +0. If the pagemap entry of the page has bit 63 (page present) set, the page
> +   is present.
> +1. Otherwise, get an fd to the file where the page is backed. For anonymous
> +   shared pages, the file can be found in ``/proc/pid/map_files/``.
> +2. Call lseek with LSEEK_DATA flag and seek to the virtual address of the page
> +   you wish to inspect. If it overshoots the PAGE_SIZE, the page is NONE.
> +3. Otherwise, the page is in swap.
> +
>   Other notes
>   ===========
>   
> 

Thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

