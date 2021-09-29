Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4172E41C7D6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 17:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345026AbhI2PI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 11:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59867 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344941AbhI2PI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632928035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gapF6Q7MxbKj+/Jpg0HNCHa+0ngI63VYNLFNHFDInM4=;
        b=LhgWWRM1iezTsTbyUR0RtFUrGC/j9CAkX9XNLkr26OzJ0jzngXIVrJF8SNuHREeS62SorG
        grdPpCCVlxAKIK7wd6VSRyO/nJC1x12+3E+HeHD8exYmlE9MnyiAy+Nd9zpHxCnqS3NrRI
        k6aF7ceeafd+YR3eQZqEfJTwbyfUP/8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-EHDs65w8OiS0oNt3rXd86A-1; Wed, 29 Sep 2021 11:07:14 -0400
X-MC-Unique: EHDs65w8OiS0oNt3rXd86A-1
Received: by mail-wm1-f71.google.com with SMTP id x23-20020a05600c21d700b0030d23749278so609243wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 08:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gapF6Q7MxbKj+/Jpg0HNCHa+0ngI63VYNLFNHFDInM4=;
        b=Xx0YXqXb4aWiXS1f56AZjK8fKsBgz/M5XT3uzL7b+XpT5lEUO9t7GIsnBX5WX0hdld
         3BQPWPY9rNVsdo362p4h6xL+y3QPtkgOTjIJAX/oDdR1lyzhFl0tPBkpcxC/UjWbykPq
         M8MjjwtjdWCksjR9TqLwArniofkOpumYlC/Urm26Tz1+cfitO0nlhhEY+GBET/JTEiZA
         aYcq9Sewdu0CxynVPudZtl28uOHLoHih5aTRayLQ+iNAeyknIpsBardxy22LI7NwqLxE
         WjYodKynf+RcVvfm3E6BedCIsXZDG5vR68Xt6FWNSsBzXmf3GhEFGc5bWJQErxh7Rny7
         DdqQ==
X-Gm-Message-State: AOAM533Vbp5z4kaUJ6nTJwac1z+An4vckaMOQ0kam+MR+KbSpC8nF7yA
        L65m05iM5RHHhwpL42ajtnnXw6Wrkj4lYTH/9jAlOlK/Qe93Ut4imj6Qz1RtZMOt/L66ZuRd/jB
        pl0zpAiCynG18ELwZHlBVqkqo
X-Received: by 2002:a5d:4e4e:: with SMTP id r14mr378687wrt.147.1632928032837;
        Wed, 29 Sep 2021 08:07:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxo/OiD1pi8Vj8uvbtvhFWxk5A000qCxnhsR/1CMHH5asTCVBPsn8x+8H3lxRFK4haIMhJq1A==
X-Received: by 2002:a5d:4e4e:: with SMTP id r14mr378630wrt.147.1632928032598;
        Wed, 29 Sep 2021 08:07:12 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23c3b.dip0.t-ipconnect.de. [79.242.60.59])
        by smtp.gmail.com with ESMTPSA id f8sm177044wrx.15.2021.09.29.08.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 08:07:12 -0700 (PDT)
Subject: Re: [PATCH v1 2/8] x86/xen: simplify xen_oldmem_pfn_is_ram()
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org,
        virtualization@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210928182258.12451-1-david@redhat.com>
 <20210928182258.12451-3-david@redhat.com>
 <4ab2f8c2-c3d5-30b3-a670-a8b38e218b6e@oracle.com>
 <bfe72f46-9a0d-1a87-64bd-4b03999edd1e@redhat.com>
 <e9a230f9-85cb-d4c1-8027-508b7c344d94@redhat.com>
 <3b935aa0-6d85-0bcd-100e-15098add3c4c@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <e6ace8c8-8a2d-9bf7-e65b-91d0037c4d08@redhat.com>
Date:   Wed, 29 Sep 2021 17:07:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3b935aa0-6d85-0bcd-100e-15098add3c4c@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.21 16:22, Boris Ostrovsky wrote:
> 
> On 9/29/21 5:03 AM, David Hildenbrand wrote:
>> On 29.09.21 10:45, David Hildenbrand wrote:
>>>>
>>> Can we go one step further and do
>>>
>>>
>>> @@ -20,24 +20,11 @@ static int xen_oldmem_pfn_is_ram(unsigned long pfn)
>>>            struct xen_hvm_get_mem_type a = {
>>>                    .domid = DOMID_SELF,
>>>                    .pfn = pfn,
>>> +               .mem_type = HVMMEM_ram_rw,
>>>            };
>>> -       int ram;
>>>     -       if (HYPERVISOR_hvm_op(HVMOP_get_mem_type, &a))
>>> -               return -ENXIO;
>>> -
>>> -       switch (a.mem_type) {
>>> -       case HVMMEM_mmio_dm:
>>> -               ram = 0;
>>> -               break;
>>> -       case HVMMEM_ram_rw:
>>> -       case HVMMEM_ram_ro:
>>> -       default:
>>> -               ram = 1;
>>> -               break;
>>> -       }
>>> -
>>> -       return ram;
>>> +       HYPERVISOR_hvm_op(HVMOP_get_mem_type, &a);
>>> +       return a.mem_type != HVMMEM_mmio_dm;
> 
> 
> I was actually thinking of asking you to add another patch with pr_warn_once() here (and print error code as well). This call failing is indication of something going quite wrong and it would be good to know about this.

Will include a patch in v2, thanks!


-- 
Thanks,

David / dhildenb

