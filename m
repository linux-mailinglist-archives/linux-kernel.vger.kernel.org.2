Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8236B41C13C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 11:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244972AbhI2JE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 05:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26352 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244898AbhI2JEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 05:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632906193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7W9Fc0fF86WyXYecPV/lI8dmSptGKk8vSEWO1VbX84s=;
        b=VgUT5Wkwz6V88ZQWns3PibHMln4HGhgp//Lqv9xtWWLTUU31B+jaqn1HXLjgQC/QydaJh8
        NDkadZGDpMr/7/xCagBYELPHCNxaXtcFe2exkJT+esc+RwifmAL59hZ6W7hNVbT8JgYUIs
        S8u2Og2LtVssz/7JezgZKEYnn+I6IDY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-j5gX-FlrNEa_X-s5qUg9ww-1; Wed, 29 Sep 2021 05:03:12 -0400
X-MC-Unique: j5gX-FlrNEa_X-s5qUg9ww-1
Received: by mail-wr1-f70.google.com with SMTP id c2-20020adfa302000000b0015e4260febdso383514wrb.20
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 02:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7W9Fc0fF86WyXYecPV/lI8dmSptGKk8vSEWO1VbX84s=;
        b=EqQmJS2a/7hfAJAiMG9GQax3whgIM4iHbaBRgyA8wPMTQNidhQ9UIqPlC5T9KdxWVL
         sGL3Zcq2elmrgXuYYI70DfRjCHsWL/6UiVjZoAmAq/mkc5C1WA1rHLAKMNoGHqf2TeTP
         K3MRjEJ717hmh4xlbrkm6Gt3rRHbo03gOkM1bsuMPcHxlMua5TajVaTvCrzZaOKdZNbl
         lv4qvXXeVN/QcWRQLgkYVFflIKtwLQC3+s8810r81K86A9zV6c6lWSHzg0gcLRYD81F7
         JMI57rmoq+9BaU0qTK+swm3mvYTC3CRpJXCST8sW/Z4qJea2ZrzunxdqTtCJC2picqQz
         vjQQ==
X-Gm-Message-State: AOAM531xMPLc3cAwXbbs3G+oxYB7hkfKZwwcAzUgyZwOIaW0TfwcMn64
        KZpSIcnaVn1hDBXO8aM+LwFL4rKLCf52m0eBtlYKhrDHDh9Z3X2EBK8f/7+6Gm0iKA5xjE2nfl8
        IP0bHdAEf2JVDSe0jevZn43od
X-Received: by 2002:a7b:c219:: with SMTP id x25mr9238899wmi.125.1632906190953;
        Wed, 29 Sep 2021 02:03:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAVvczz8jUTCdMNZ0BC5qvezoqKUBOcf5OajF0CWmKLmPAPf0K3OR8WEfpMUG5vsV5dclhgg==
X-Received: by 2002:a7b:c219:: with SMTP id x25mr9238872wmi.125.1632906190770;
        Wed, 29 Sep 2021 02:03:10 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23c3b.dip0.t-ipconnect.de. [79.242.60.59])
        by smtp.gmail.com with ESMTPSA id t11sm1548498wrz.65.2021.09.29.02.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 02:03:10 -0700 (PDT)
Subject: Re: [PATCH v1 2/8] x86/xen: simplify xen_oldmem_pfn_is_ram()
From:   David Hildenbrand <david@redhat.com>
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
Organization: Red Hat
Message-ID: <e9a230f9-85cb-d4c1-8027-508b7c344d94@redhat.com>
Date:   Wed, 29 Sep 2021 11:03:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <bfe72f46-9a0d-1a87-64bd-4b03999edd1e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.21 10:45, David Hildenbrand wrote:
>>
>> How about
>>
>>       return a.mem_type != HVMMEM_mmio_dm;
>>
> 
> Ha, how could I have missed that :)
> 
>>
>> Result should be promoted to int and this has added benefit of not requiring changes in patch 4.
>>
> 
> Can we go one step further and do
> 
> 
> @@ -20,24 +20,11 @@ static int xen_oldmem_pfn_is_ram(unsigned long pfn)
>           struct xen_hvm_get_mem_type a = {
>                   .domid = DOMID_SELF,
>                   .pfn = pfn,
> +               .mem_type = HVMMEM_ram_rw,
>           };
> -       int ram;
>    
> -       if (HYPERVISOR_hvm_op(HVMOP_get_mem_type, &a))
> -               return -ENXIO;
> -
> -       switch (a.mem_type) {
> -       case HVMMEM_mmio_dm:
> -               ram = 0;
> -               break;
> -       case HVMMEM_ram_rw:
> -       case HVMMEM_ram_ro:
> -       default:
> -               ram = 1;
> -               break;
> -       }
> -
> -       return ram;
> +       HYPERVISOR_hvm_op(HVMOP_get_mem_type, &a);
> +       return a.mem_type != HVMMEM_mmio_dm;
>    }
>    #endif
> 
> 
> Assuming that if HYPERVISOR_hvm_op() fails that
> .mem_type is not set to HVMMEM_mmio_dm.
> 

Okay we can't, due to "__must_check" ...

-- 
Thanks,

David / dhildenb

