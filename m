Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B88F365A9C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhDTN5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:57:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40747 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231422AbhDTN5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618926993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2swGFScfNKtndGubsPyzcMB/R/9UWctxaEjz506YT0I=;
        b=i5qMX7rR6a6dQanEzIZMc9zReuhmekT6n2E9Xw4w1rxBtKRgoe+0o1VqZlxXFhUW7dRmmG
        nusbCdb1IgO+8pB3vbp3WhQbJVZ/RruZV8X7Tgj5eLl7lhQmdWTj/xSt8zYR7g0v/D25mo
        Rc1sMxaW6g+1RUtYN438qyuOP8HjXlY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-s_NOvnkHMIe7wBmRG8V3iQ-1; Tue, 20 Apr 2021 09:56:30 -0400
X-MC-Unique: s_NOvnkHMIe7wBmRG8V3iQ-1
Received: by mail-wr1-f72.google.com with SMTP id h60-20020adf90420000b029010418c4cd0cso10054307wrh.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 06:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2swGFScfNKtndGubsPyzcMB/R/9UWctxaEjz506YT0I=;
        b=GIzRyO+5CDjuOAKvogUvY/SdwPr+dDvRzlZjBhKa3+7hCEAR3lQkP3wCpAi4ETshU9
         1RJeT7NV7iUeKabgoqnN3zTk4XkuCJ1Qu5aHAPEwfpUx4UwOWbb76M7bc3vSjGjCBE8G
         8XjfrA0pk7OCWt3i6pPP5HkugwVSlr4rJQrG1B1j3+52ZFXNYW+RnDfmJDEN0ajGivHy
         rAN9Cc5al4YbfX6RRppNV3j06eAR6bjFpb5ww42s/KDcUHIcuqontqPkOuXmsv0Ez3I6
         wGWjoBznAHuPAfrQP3KeXeVpQPZ8mbTJwDGa1lpxfUsTIyF/8yGQNcaoMKh8tpRRfsrt
         r26g==
X-Gm-Message-State: AOAM533xR+lX7jjJ6C2X6inbwR22nHttKqTrtIRAjdHhJx9eCV4wpUg0
        pcTBdTk+J+Zz91OkzCgNd0lPNFVFn49M9SOdLdQRUL9OSlNs2mZsNd4yhoftI7uQBw3tMBtzvKH
        9s+4sooFB8qph54qgkCsilBs2
X-Received: by 2002:a1c:7714:: with SMTP id t20mr4773898wmi.24.1618926989412;
        Tue, 20 Apr 2021 06:56:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXffdbVbO4EhLxZXboPYwUyY34Zz8JQIixcWjehp7ikNXXuUMfZAGOffqPbzkJhVg2Dv9JJQ==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr4773877wmi.24.1618926989194;
        Tue, 20 Apr 2021 06:56:29 -0700 (PDT)
Received: from [192.168.3.132] (p4ff2390a.dip0.t-ipconnect.de. [79.242.57.10])
        by smtp.gmail.com with ESMTPSA id c18sm27378176wrn.92.2021.04.20.06.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 06:56:28 -0700 (PDT)
To:     Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210420090925.7457-1-rppt@kernel.org>
 <20210420090925.7457-3-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 2/4] memblock: update initialization of reserved pages
Message-ID: <ed8f10a0-9b68-1d12-0305-90fd378af6b9@redhat.com>
Date:   Tue, 20 Apr 2021 15:56:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210420090925.7457-3-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.21 11:09, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The struct pages representing a reserved memory region are initialized
> using reserve_bootmem_range() function. This function is called for each
> reserved region just before the memory is freed from memblock to the buddy
> page allocator.
> 
> The struct pages for MEMBLOCK_NOMAP regions are kept with the default
> values set by the memory map initialization which makes it necessary to
> have a special treatment for such pages in pfn_valid() and
> pfn_valid_within().

Just a general question while thinking about it:

Would we right now initialize the memmap of these pages already via 
memmap_init_zone()->memmap_init_range()? (IOW, not marking the 
PageReserved?)

-- 
Thanks,

David / dhildenb

