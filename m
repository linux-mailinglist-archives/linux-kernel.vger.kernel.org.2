Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420733605B4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhDOJam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:30:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32818 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230290AbhDOJaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618479016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MW/mRgvf+zkYoiSHfMZp2dDTVVI25+tYOHvOtleD70I=;
        b=Yw2DfK9B+OXWM/rqVDGaXRaRMKEk2pg0ChNAqZ10dMqWVZD39Ix2sMrA1w5W/gPaHq67Pf
        GxP7oWhimamBqeSTL8pYqS+Fs6837Kl1U1V2SVYyARgVG6VS/FadHjN29L8lYrXsH54/gd
        RXnCsOlDRu6rbp5fynQYegOeMxPDVWM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-9ig1RjmSPvWzGjOcEVIztQ-1; Thu, 15 Apr 2021 05:30:14 -0400
X-MC-Unique: 9ig1RjmSPvWzGjOcEVIztQ-1
Received: by mail-wm1-f72.google.com with SMTP id b20-20020a7bc2540000b029010f7732a35fso1998570wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MW/mRgvf+zkYoiSHfMZp2dDTVVI25+tYOHvOtleD70I=;
        b=stAE9j7xtOjkytdZO/CmIJcnNoHQqeoToy5jiB7L7xRB4vIxseupCBK8+2wWw2PyQg
         GiSmQ3O50yNtKpl2FFF4Loa5sHtRHJX52hXJNSWOGMDkXX5ezQYSiMVawJoS4urJhibo
         a4ZxOlKthxRZOaVV8O/0CanmfqqRcNrZjDJr7DcE20MHi3sZ+Am6I78q0MDkehAEstNl
         71bFW8lbjAYtOvhqOFahRymQvMo9qL07zuDoYrELX2j0zpF9uhPF5/X2eLI1+d1z8WEd
         D4r6pAAlQ6Mn/tRi+6VC1yMs0J0NnDkEC/0PGARWvYeAWVdGEkbg9rucf+b3+NtNZ3pl
         z6AQ==
X-Gm-Message-State: AOAM531kCwwEjBaui7EXZdX48B99nwo/DQtU8YMxfLsLzq7I6DKnOkw+
        sXWM3nv81vgSUIL84ahPqpSzNcz9NpERcG7+vn0h6v/O6w+8tqZCUltfHiNmwdi4NvO4es00ecD
        o9batErjjb/oEuz+C65CeRuI/
X-Received: by 2002:a5d:6a84:: with SMTP id s4mr2472819wru.92.1618479013330;
        Thu, 15 Apr 2021 02:30:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8b0HIW4SQWI0F4SN4CcB7oMoecgIFl/eiaSw1ft7FPToZP8/z36BeeQADlUaxJ82PzDz6Hg==
X-Received: by 2002:a5d:6a84:: with SMTP id s4mr2472795wru.92.1618479013135;
        Thu, 15 Apr 2021 02:30:13 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6392.dip0.t-ipconnect.de. [91.12.99.146])
        by smtp.gmail.com with ESMTPSA id p17sm1659280wmq.47.2021.04.15.02.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 02:30:12 -0700 (PDT)
Subject: Re: [RFC/RFT PATCH 1/3] memblock: update initialization of reserved
 pages
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <20210407172607.8812-1-rppt@kernel.org>
 <20210407172607.8812-2-rppt@kernel.org>
 <0c48f98c-7454-1458-15a5-cc5a7e1fb7cd@redhat.com>
 <CAMj1kXGw97epyP2HdHjA8Yp6+VF1j5xmd0AgVBBv3k+h_B610w@mail.gmail.com>
 <3811547a-9057-3c80-3805-2e658488ac99@redhat.com>
 <YHdPmtpzFxHE9mAt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <f5503130-c0e7-329f-86c4-727ece1c860f@redhat.com>
Date:   Thu, 15 Apr 2021 11:30:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YHdPmtpzFxHE9mAt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Not sure we really need a new pagetype here, PG_Reserved seems to be quite
> enough to say "don't touch this".  I generally agree that we could make
> PG_Reserved a PageType and then have several sub-types for reserved memory.
> This definitely will add clarity but I'm not sure that this justifies
> amount of churn and effort required to audit uses of PageResrved().
>   
>> Then, we could mostly avoid having to query memblock at runtime to figure
>> out that this is special memory. This would obviously be an extension to
>> this series. Just a thought.
> 
> Stop pushing memblock out of kernel! ;-)

Can't stop. Won't stop. :D

It's lovely for booting up a kernel until we have other data-structures 
in place ;)


-- 
Thanks,

David / dhildenb

