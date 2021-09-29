Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4171541C9D5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 18:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345555AbhI2QMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 12:12:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27700 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345817AbhI2QMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 12:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632931830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WLMPpqPP550w7vqpI230ig8SxHeIacnrqJ+kTAlwAqE=;
        b=MfFiJPemGofziC2FHlapRKWxMrWPFhj4kV5jptfMJiaLpzfEMGX9Cir70Ant+TSE85ZrnZ
        bGD9qh+9RYtZJOVPyChftXxLXNmrbTV8AiDlKWRgVRCLLv1bMTml2JMOFM4AUlJLpD6LA1
        Hb+QFEf36/Neq6pYqni0vQHZBO80Pj0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-UPTQ24zPNei4B83wZx6W-w-1; Wed, 29 Sep 2021 12:10:27 -0400
X-MC-Unique: UPTQ24zPNei4B83wZx6W-w-1
Received: by mail-wr1-f71.google.com with SMTP id j15-20020a5d564f000000b00160698bf7e9so784839wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 09:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WLMPpqPP550w7vqpI230ig8SxHeIacnrqJ+kTAlwAqE=;
        b=qdz/Nw/L/HC9/vl2jcczQ3Uq0a+o7LubA55ftQy+G6TauC7mAKT4KJdxRGZjG73AJR
         5K+sd4Nzo5wdlcYznHiCXg/TlAP4GlymwpgXdmtFwiy2QduF2OkweZxjU972S8Pz7wVO
         XgN7XidaYi2sLD2H4QvspcxuWbZvMpdA6hew67dL+A8akMc5IWHkYafjQRmi1CI0O8xM
         AczwFkBdY1ELMR0gx1VAq627i1h+FSW5NyGf+vzT30q4moARnECVuHuMLSkeZproyHjw
         w+bcjneYGsoMGpPAzQT/ZpBmQF64E06xBYJtuNKpK3OEFlNGhWgqG4GBrgl+RmeoFlj1
         ADgA==
X-Gm-Message-State: AOAM530hnVjKP8cpPF87B5yQGzPS7nGCAiq0Xsqungsn1VqhnEewsaF+
        arrhPXOtG3YkDa53xubmqbLOsaayVU2xnZIieuvqeGkV9+91XcC/vjRph3D5GZhoOPtq4MRd0mU
        U1NZNYL+QNYZATDFTUh+0jlho
X-Received: by 2002:a5d:574c:: with SMTP id q12mr825461wrw.382.1632931825993;
        Wed, 29 Sep 2021 09:10:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZr1rHe13QhZNhdJKCME+MB4f6Kn7CxUGBW2vbFebu1x3OAb0Yf9fBK2OT6yZe0GK3vgIx4g==
X-Received: by 2002:a5d:574c:: with SMTP id q12mr825426wrw.382.1632931825811;
        Wed, 29 Sep 2021 09:10:25 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23c3b.dip0.t-ipconnect.de. [79.242.60.59])
        by smtp.gmail.com with ESMTPSA id g2sm349444wrb.20.2021.09.29.09.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 09:10:25 -0700 (PDT)
Subject: Re: [PATCH v1] mm/vmalloc: fix exact allocations with an alignment >
 1
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ping Fang <pifang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <20210908132727.16165-1-david@redhat.com>
 <CA+KHdyWadbqZ=xVBv6uZwxpZSEndAAk_inK+0962VcntY+mnSA@mail.gmail.com>
 <CA+KHdyUTQLwN0YASOX8XJoWCD_x1QwRmz81BGShCzb_8jZ93XQ@mail.gmail.com>
 <ea75df96-f381-6949-5627-1382a370dc71@redhat.com>
 <20210916193403.GA1940@pc638.lan>
 <221e38c1-4b8a-8608-455a-6bde544adaf0@redhat.com>
 <20210921221337.GA60191@pc638.lan>
 <7f62d710-ca85-7d33-332a-25ff88b5452f@redhat.com>
 <20210922104141.GA27011@pc638.lan>
 <e378e60a-319b-e9aa-7e30-3e280c4431da@redhat.com>
 <CA+KHdyWZ9T2GEuUENXD_OYHX1JxKfZuW5YzmDtqXUYSgkQd8fQ@mail.gmail.com>
 <953ea84a-aabb-f64b-b417-ba60928430e0@redhat.com>
 <CA+KHdyWFjtoVqGd=7-yp33G-5WcZCtf80BaAk+3jx2bW5FCfWA@mail.gmail.com>
 <689b7c24-623d-c01e-6c0f-ad430f1fa3ae@redhat.com>
 <CA+KHdyVC1KCP2r2st_TmfmXaPZ49ym0gyN31CwLZfE=ipLGjmA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <f4884091-8448-bebc-61f1-4af3226ca00d@redhat.com>
Date:   Wed, 29 Sep 2021 18:10:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CA+KHdyVC1KCP2r2st_TmfmXaPZ49ym0gyN31CwLZfE=ipLGjmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.21 18:08, Uladzislau Rezki wrote:
>>> Could you please to be more specific? I mean how is it connected with huge
>>> pages mappings? Huge-pages are which have order > 0. Or you mean that
>>> a special alignments are needed for mapping huge pages?
>>
>> Let me try to clarify:
>>
>>
>> KASAN does an exact allocation when onlining a memory block,
>> __vmalloc_node_range() will try placing huge pages first, increasing the
>> alignment to e.g., "1 << PMD_SHIFT".
>>
>> If we increase the search length in find_vmap_lowest_match(), that
>> search will fail if the exact allocation is surrounded by other
>> allocations. In that case, we won't place a huge page although we could
>> -- because find_vmap_lowest_match() would be imprecise for alignments >
>> PAGE_SIZE.
>>
>>
>> Memory blocks we online/offline on x86 are at least 128MB. The KASAN
>> "overhead" we have to allocate is 1/8 of that -- 16 MB, so essentially 8
>> huge pages.
>>
>> __vmalloc_node_range() will increase the alignment to 2MB to try placing
>> huge pages first. find_vmap_lowest_match() will search within the given
>> exact 16MB are a 18MB area (size + align), which won't work. So
>> __vmalloc_node_range() will fallback to the original PAGE_SIZE alignment
>> and shift=PAGE_SHIFT.
>>
>> __vmalloc_area_node() will set the set_vm_area_page_order effectively to
>> 0 --  small pages.
>>
>> Does that make sense or am I missing something?
>>
> Thank you for clarification. OK, we come back anyway to the "problem" with fixed
> range and an exact allocation plus a special alignment > PAGE_SIZE. Thus the
> KASAN will not make use of huge pages mappings and go with regular instead
> as a fallback path. But we would like to utilize huge-mappings for KASAN.
> 
> I will send the patch you tested and add your "tested-by" tag. Does it
> sound good?

Feel free to add

Tested-by: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!

-- 
Thanks,

David / dhildenb

