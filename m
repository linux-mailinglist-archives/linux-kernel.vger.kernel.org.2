Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DD63A5D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 09:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhFNHXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 03:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23782 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232454AbhFNHXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 03:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623655300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ipsvS6A+HlAzDhWVC1tQRKuJP6hbewkOM+0HTeXP3I=;
        b=W3xDbMQZQn2F8Iks7x1sI2J1Dmyz4LFOZM00/IlRhN7m75R1ASxK+kWlctPkWuN65+TFcZ
        l4dIo8n9mskK/tL9ZQSMX8VOG/LfotAIgJqc2NG1aKG2pHW3c+pzLtPhmBIJiAzy49/XdB
        ZERIxA1tUdKtuEKAUi+FoUX8JZDvSN4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-h-gOCg95O_K8yAbEioqdPw-1; Mon, 14 Jun 2021 03:21:38 -0400
X-MC-Unique: h-gOCg95O_K8yAbEioqdPw-1
Received: by mail-wr1-f69.google.com with SMTP id g14-20020a5d698e0000b0290117735bd4d3so6578195wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 00:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3ipsvS6A+HlAzDhWVC1tQRKuJP6hbewkOM+0HTeXP3I=;
        b=MV/eGvlyF4q+qz5ASLcY3MpizIL9UamQrnANqW8RlfWO5hNvtMongtSXffdcSQaJUB
         VllUpms28kqW8Jn27I/3BuJZHz6eGntVqFgjqU2tRv8kEZLB39zi9fgGuK6dbtJb8Zhb
         IxTJTQ5rKIGa2QJQSrc+FbwMUiWLFfo0yKzwXy177AWnXt0rSRB4KExj4kT79m5xCttj
         Dmt66Sk1NeCgZPpOA7GzDLH4F89QK/iS4SddDvmqxtAvjRy1K2YOxQmWc16J+QTIomtN
         9YikQuYqwAH9YOrZlVYHvlupY5R6ulKVwZ5fy3OA5el/sNIxIezbUclFQrFS6AKX7Knl
         qvgw==
X-Gm-Message-State: AOAM530JFMcH835imUFKFE+KTmFVpnPzPQWZUXYLmvTMB00m7R8HydyO
        BV2dwWkwxxBvjeDd76bVMqsIa6S6jW2LE8WMh9bmbXXUEn01ocLEh76Gb2xe88FTnpwGejIaK6P
        Hy9gvhB/m04UP/+doXym1WWlC
X-Received: by 2002:a7b:c417:: with SMTP id k23mr30456986wmi.71.1623655297242;
        Mon, 14 Jun 2021 00:21:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZygjtzbVwMFmk9Lw/cG1jtTA4mlUghRbuPrFBqZz2O9z35PVkC1q/cwfLCvXMamx+pM01Aw==
X-Received: by 2002:a7b:c417:: with SMTP id k23mr30456975wmi.71.1623655297104;
        Mon, 14 Jun 2021 00:21:37 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c66ca.dip0.t-ipconnect.de. [91.12.102.202])
        by smtp.gmail.com with ESMTPSA id w13sm16698909wrc.31.2021.06.14.00.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 00:21:36 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] memory-hotplug.rst: complete admin-guide overhaul
To:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
 <87y2bd9wse.fsf@meer.lwn.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <d517106f-64ba-5d3a-59f5-c87d5e032bdc@redhat.com>
Date:   Mon, 14 Jun 2021 09:21:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87y2bd9wse.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.06.21 01:20, Jonathan Corbet wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> This is v3 of the memory hot(un)plug admin-guide overhaul.
>>
>> v2 -> v3:
>> - Added ACKs and RBs (thanks!)
>> - s/aarch64/arm64/
>> - Refine error handling when onlining/offlining
>> - s/memory hotplug/memory offlining/ in the vmemmap optimization section
>>    for huge pages
> 
> So this set doesn't apply to docs-next, even when I correct for the fact
> that you didn't make the patch from the top-level kernel directory.

Hi Jon,

oh, looks like I messed up v3 by git-format-patching from the wrong 
directory ...

> What tree is this against?
> 

Essentially against Andrew's mmotm, which already contains v1. Note 
mmotm was chosen due to a conflict in:

https://lkml.kernel.org/r/20210510030027.56044-1-songmuchun@bytedance.com

I'd suggest we take this via Andrew's tree, unless you have other 
preference on how to handle the conflict. Thanks!

> Thanks,
> 
> jon
> 


-- 
Thanks,

David / dhildenb

