Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD643BA3CA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 19:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhGBR7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 13:59:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20516 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229499AbhGBR7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 13:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625248637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VyOX1XyKGar6HVpF2pvAGlRx3oFJwVrE2GV/F03AcqM=;
        b=JYRwuV9XYAPOheoEuP9bfoZqovcuWNLSj/WFIPsAMF57I2MMD4JPgX8NqO7mgHKSY/eX8V
        H6c7nh8L5poWGsnQHjIK7E6yJ2VlgiO+XNJcL7Mg1p7lqOE874uVyL5K7BgXSTfj1RME6i
        ZMtWaFy3A+g+2pu8Rrg+aLtHSHswlT8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-hjO7LAfdMBiVgPMpIHga2g-1; Fri, 02 Jul 2021 13:57:16 -0400
X-MC-Unique: hjO7LAfdMBiVgPMpIHga2g-1
Received: by mail-wr1-f72.google.com with SMTP id c15-20020a056000184fb0290124a352153cso4121277wri.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 10:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VyOX1XyKGar6HVpF2pvAGlRx3oFJwVrE2GV/F03AcqM=;
        b=CQVxYKUPVbacJ5LHiO0pRIELRC3Ri7JNEQqHIX/Y0oh8Bu7a/TKUwS7JNWPsJJ+zpD
         TPs/AvUZXvsnhpbLNmDMyTp8DJ1SuC1jsAV0JwccHCXAbZnX4eZrhCKnnK/KtD6ziZ46
         /idWzQDnE1magVhl26nz5oReUqzXrP2BHvmoQVqqS94Xvfdg4Zhck9AKZvcdHabYbKTA
         JpemcsoVAjzWhOYzDpXVKSWbssXltGtMWseofhZojMyUKcWjqgcrg0Pi1thbYZYOeyyJ
         Pp+qGt1howHDkJsQqb+tLsSQp+XooxBlph8L764psLPuyRipLXJr+qJD7Y/fd2ZnM7y0
         AZng==
X-Gm-Message-State: AOAM531gf7Xb5WZs+gs0YL656cxHQALJNib+j9wUhvbSQrIF/C77R3F5
        gFU3f91GBXKZV/i0a+Vuz8AQkZOk4JBVncc+Ixh711HEbTO5SfzGpYO2rExgcjhU8crl8wKJz52
        iU8DyneIlOh+hvgp5GOaIlInlMEzFJUnYC+4iPeXcmSMOj1GeDWOZX+9769Hqkn5wO0vkK526
X-Received: by 2002:a05:6000:1889:: with SMTP id a9mr940506wri.141.1625248635131;
        Fri, 02 Jul 2021 10:57:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxS7TybUgpLaYy3CrmfiQ5mLI6fYGEEC1YvL1sgjNReZ72CrYZobJZEvr+Ipp6hPyBsq+eZNQ==
X-Received: by 2002:a05:6000:1889:: with SMTP id a9mr940482wri.141.1625248634907;
        Fri, 02 Jul 2021 10:57:14 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23afb.dip0.t-ipconnect.de. [79.242.58.251])
        by smtp.gmail.com with ESMTPSA id n20sm3552874wmk.12.2021.07.02.10.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 10:57:14 -0700 (PDT)
Subject: Re: [PATCH 3/3] mm: sparse: remove __section_nr() function
To:     Michal Hocko <mhocko@suse.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>
Cc:     akpm@linux-foundation.org, bhe@redhat.com, rppt@linux.ibm.com,
        ohkwon1043@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210702094132.6276-1-ohoono.kwon@samsung.com>
 <CGME20210702094457epcas1p4e181c7b0a18338403a7ffb57f44807fe@epcas1p4.samsung.com>
 <20210702094132.6276-4-ohoono.kwon@samsung.com>
 <YN8EHfBu358OMugA@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <747f311e-0239-0f4a-2561-11e2a34d8ce1@redhat.com>
Date:   Fri, 2 Jul 2021 19:57:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YN8EHfBu358OMugA@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.07.21 14:18, Michal Hocko wrote:
> On Fri 02-07-21 18:41:32, Ohhoon Kwon wrote:
>> __section_nr() was used to convert struct mem_section * to section_nr.
>>
>> With CONFIG_SPARSEMEM_EXTREME enabled, however, __section_nr() can be
>> costly since it iterates all section roots to check if the given
>> mem_section is in its range.
>>
>> On the other hand, __nr_to_section() which converts section_nr to
>> mem_section can be done in O(1).
>>
>> The only users of __section_nr() was section_mark_present() and
>> find_memory_block().
>>
>> Since I changed both functions to use section_nr directly in the
>> preceeding patches, let's remove __section_nr() which has no users.
>>
>> Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
> 
> I would go with a much shorter changelog. The function is not used
> anymore so it can be simply dropped.
> Acked-by: Michal Hocko <mhocko@suse.com>

Agreed, also avoid the use of "I" in patches.

Use something like

"As the last users of __section_nr() are gone, let's remove now unused 
__section_nr()."

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

