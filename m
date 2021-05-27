Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C707393496
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 19:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbhE0RNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 13:13:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27793 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235973AbhE0RNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 13:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622135534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Tj882GRDYNKA/Odur5I8qEQKwf2uVi6wQUPaTSmUGk=;
        b=Fdb1Ofr+zjD6hKwp0RAIB0SY0s2zTC3fQenLSmDuZr1qhM+aRpi+LamHHn3taT214BYep0
        DehQSuffonE8xRTW7SIUOuffDOr7+g9MdPthAycXj2c3TNr5W5zDs1tUEdGwwqh9uLcsN0
        rYS5KvRcFqE1GYNK+TjwcR8fr7W33rg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-JNuOuIqPNZOhlb26bN4ugA-1; Thu, 27 May 2021 13:12:13 -0400
X-MC-Unique: JNuOuIqPNZOhlb26bN4ugA-1
Received: by mail-wm1-f69.google.com with SMTP id g206-20020a1c39d70000b029016ac627fbe9so438849wma.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 10:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8Tj882GRDYNKA/Odur5I8qEQKwf2uVi6wQUPaTSmUGk=;
        b=gQnB3BUgOyQqkFTlxCUEVvGLdMftinYKi0dIzj6JMxjCr73Ltlr3gkgobdD5pPJreX
         Wqj0OKLOkNKNiUMsX1VMuCmcTMwM1W1r6XAyDJvXl4yIWzpFd303QR3OFFYkUCScYfUp
         pV/OE5n2qKscSoBLBv3W1gpcZkuA53tSIGx2xFSRiSPyNUrOCXDI000JL8DiJKYsDmMy
         uVsspAbyQVyOWek1t5vsaOho02o5wWv9qLNdMScq56tOhkoqU2yGKLYyVCYFPLOkdV0R
         cdcv723mBP/W8z/+/lcsnicpu4iJiaws2sOOGRwLevHSYT2Gb34unbYyH4UgAantCKnD
         Z/7g==
X-Gm-Message-State: AOAM532lrRuyE5u+ZSY/P9bA79tIgV66L0EnNIuWGQWOPkPnHGOET65u
        dqW4djT0G7rTZ1jWVXXrTJ1955Gt0Zs3v1YUC169t05TEq/9YKfY946LuOSsd2NZ2fgeKgxtDbh
        ai6ziosJAU8ofESRa9fD7TGD7
X-Received: by 2002:a1c:3d05:: with SMTP id k5mr4669356wma.9.1622135532221;
        Thu, 27 May 2021 10:12:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfH6a8f34/9c06VAR9VtQNYysw/6uRvDZUrv050Ei6nDvYjtR9kqnXZGaQdB/PD53PwEWPHA==
X-Received: by 2002:a1c:3d05:: with SMTP id k5mr4669322wma.9.1622135531909;
        Thu, 27 May 2021 10:12:11 -0700 (PDT)
Received: from [192.168.3.132] (p4ff230a8.dip0.t-ipconnect.de. [79.242.48.168])
        by smtp.gmail.com with ESMTPSA id l8sm4338822wry.55.2021.05.27.10.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 10:12:11 -0700 (PDT)
Subject: Re: Arm64 crash while reading memory sysfs
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Qian Cai <quic_qiancai@quicinc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <DM5PR0201MB355723819DDAC439273F68848E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
 <YK3tQ0a0S/CLxyyb@linux.ibm.com>
 <CY4PR0201MB35539FF5EE729283C4241F5A8E249@CY4PR0201MB3553.namprd02.prod.outlook.com>
 <YK6EXNZHY1xt7Kjs@linux.ibm.com>
 <d55f915c-ad01-e729-1e29-b57d78257cbb@quicinc.com>
 <YK9e0LgDOfCFo6TM@linux.ibm.com>
 <ce5a5920-3046-21b5-42c0-2237ec1eef13@quicinc.com>
 <YK/HKMgajBCwpLt8@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <3a5fa459-cd00-8a65-3ee1-debc51424a7c@redhat.com>
Date:   Thu, 27 May 2021 19:12:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YK/HKMgajBCwpLt8@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> [  259.216661][ T1417] test_pages_in_a_zone: pfn 8000 is not valid
>> [  259.226547][ T1417] page:00000000f4aa8c5c is uninitialized and poisoned
>> [  259.226560][ T1417] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> 
> Can you please try Anshuman's patch "arm64/mm: Drop HAVE_ARCH_PFN_VALID":
> 
> https://lore.kernel.org/lkml/1621947349-25421-1-git-send-email-anshuman.khandual@arm.com
> 
> It seems to me that the check for memblock_is_memory() in
> arm64::pfn_valid() is what makes init_unavailable_range() to bail out for
> section parts that are not actually populated and then we have
> VM_BUG_ON_PAGE(PagePoisoned(p)) for these pages.
> 

Oh, that makes sense to me.

-- 
Thanks,

David / dhildenb

