Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7BB33B9369
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 16:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhGAOgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 10:36:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23905 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232853AbhGAOgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 10:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625150057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yADBe2xQ5npAVwH25VEszdyBUUjNr26/F5DNdlSzd4M=;
        b=BxG31DYtohdHpnPE89MF4SXS51X3qtS/jHMG4li2eBR72v3VZixddL7V6un3cHefidhBOI
        HAew6kLwHWv7wjIk0ZJ2Exul1b3drhh+e6wtOwaJ44dbYFwe5B7lb2cdHpWv1MjaS0Qrrc
        hA9KXqVMYZR8wV9Yt2BvpYOFqp4lBeg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-ZFEpY-2cNIOci8EV9OWSXg-1; Thu, 01 Jul 2021 10:34:15 -0400
X-MC-Unique: ZFEpY-2cNIOci8EV9OWSXg-1
Received: by mail-wm1-f69.google.com with SMTP id o19-20020a05600c5113b02901ecf901808fso1295042wms.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 07:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yADBe2xQ5npAVwH25VEszdyBUUjNr26/F5DNdlSzd4M=;
        b=CS+EOb6d3AouEwLaO5zKTWjMPK8CwYaipN2GCvIzJPjWcz6cxQiCSm62TafJPD81Dv
         o+L8HAJQSnkl/OBYlnxM7gsvJe4JLSub/WtROeY+83nD4e+Asl1PwIip1uMmts4JoYyS
         DZkIoqPdXUvw9tk9ONC6ndBr/T3a4Xwitz6zcxTJWB2C/5+mm4VitaNTrig5lm/6raM2
         RnLSguvZGJ0hY1rfp+RMpbfL7Doh2T6IajOFnHXdOxMnMmU+5KoMVT+6PxQjnf4I08s+
         PFAuEoFs2YMLfuJ2Uisdld9EzPTZvPk+6wC2owe0C5z1Go0ORqBiAddeDJROyuWzU5dU
         8OxQ==
X-Gm-Message-State: AOAM533dUEXHSbSWwx3I83Lxkn+OoiNepIPmERG5RaEOmCDpJao+uUyZ
        590761+YkB9245OrJ+aWiOz6IQzNCscKwOxncQHIWHTytslVomUmnXh0cmKhOGccJVejKWPkOBb
        0emYL161/5h3GE1Ivrc/EEJisq/E6nKkcm8Juqp/MhANpLUoxpxA695sSdX4mVy8aaf9qZ9pJ
X-Received: by 2002:adf:fd46:: with SMTP id h6mr46553388wrs.420.1625150054841;
        Thu, 01 Jul 2021 07:34:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3Daqh9yV63XtzPnnYaCsFApyMtVEo5FKdQVnwFDjlzCdWc0J6/pD8SAj5j2CDzLi/Tvo8xA==
X-Received: by 2002:adf:fd46:: with SMTP id h6mr46553357wrs.420.1625150054600;
        Thu, 01 Jul 2021 07:34:14 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23bca.dip0.t-ipconnect.de. [79.242.59.202])
        by smtp.gmail.com with ESMTPSA id p16sm98915wrs.52.2021.07.01.07.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 07:34:14 -0700 (PDT)
To:     ohoono.kwon@samsung.com,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>
Cc:     "bhe@redhat.com" <bhe@redhat.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "ohkwon1043@gmail.com" <ohkwon1043@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20210701135543epcms1p84a043bf49757bafada0a773372611d69@epcms1p8>
 <20210701135543epcms1p84a043bf49757bafada0a773372611d69@epcms1p8>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: sparse: pass section_nr to section_mark_present
Message-ID: <c5f8e6ae-9d2c-24a6-c21a-6c6c83912b35@redhat.com>
Date:   Thu, 1 Jul 2021 16:34:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701135543epcms1p84a043bf49757bafada0a773372611d69@epcms1p8>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.07.21 15:55, 권오훈 wrote:
> With CONFIG_SPARSEMEM_EXTREME enabled, __section_nr() which converts
> mem_section to section_nr could be costly since it iterates all
> sections to check if the given mem_section is in its range.

It actually iterates all section roots.

> 
> On the other hand, __nr_to_section which converts section_nr to
> mem_section can be done in O(1).
> 
> Let's pass section_nr instead of mem_section ptr to section_mark_present
> in order to reduce needless iterations.

I'd expect this to be mostly noise, especially as we iterate section 
roots and for most (smallish) machines we might just work on the lowest 
section roots only.

Can you actually observe an improvement regarding boot times?

Anyhow, looks straight forward to me, although we might just reintroduce 
similar patterns again easily if it's really just noise (see 
find_memory_block() as used by). And it might allow for a nice cleanup 
(see below).

Reviewed-by: David Hildenbrand <david@redhat.com>


Can you send 1) a patch to convert find_memory_block() as well and 2) a 
patch to rip out __section_nr() completely?

> 
> Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
> ---
>   mm/sparse.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 55c18aff3e42..4a2700e9a65f 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -186,13 +186,14 @@ void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
>    * those loops early.
>    */
>   unsigned long __highest_present_section_nr;
> -static void section_mark_present(struct mem_section *ms)
> +static void section_mark_present(unsigned long section_nr)
>   {
> -	unsigned long section_nr = __section_nr(ms);
> +	struct mem_section *ms;
>   
>   	if (section_nr > __highest_present_section_nr)
>   		__highest_present_section_nr = section_nr;
>   
> +	ms = __nr_to_section(section_nr);
>   	ms->section_mem_map |= SECTION_MARKED_PRESENT;
>   }
>   
> @@ -279,7 +280,7 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
>   		if (!ms->section_mem_map) {
>   			ms->section_mem_map = sparse_encode_early_nid(nid) |
>   							SECTION_IS_ONLINE;
> -			section_mark_present(ms);
> +			section_mark_present(section);
>   		}
>   	}
>   }
> @@ -933,7 +934,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>   
>   	ms = __nr_to_section(section_nr);
>   	set_section_nid(section_nr, nid);
> -	section_mark_present(ms);
> +	section_mark_present(section_nr);
>   
>   	/* Align memmap to section boundary in the subsection case */
>   	if (section_nr_to_pfn(section_nr) != start_pfn)
> 


-- 
Thanks,

David / dhildenb

