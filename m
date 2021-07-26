Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AAB3D6934
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 00:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhGZVXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 17:23:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42262 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233380AbhGZVX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 17:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627337035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WeoSATKCsUczJoZWnPn33Qg+mplhNYCcnwstKUtpHBs=;
        b=iDC+E6JIpUXgLXUJMv0XOcWN+j5pUYTlfWKTNqIbvHGnS2BUioqYXt8ls/+z0eO8HvirLa
        Oo5tgpknlBVoeCVUCWUEkZVuX9Eso4QvoX+umQ1zLRIFH9tbexlQVFo7MuJThStyvdEV/A
        jF5J8egffPwwcIACDErkNDYahHVxKxg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-u7IkuenBMCqDZGY2-0Xbdw-1; Mon, 26 Jul 2021 18:02:48 -0400
X-MC-Unique: u7IkuenBMCqDZGY2-0Xbdw-1
Received: by mail-ej1-f69.google.com with SMTP id n9-20020a1709063789b02905854bda39fcso866683ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 15:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WeoSATKCsUczJoZWnPn33Qg+mplhNYCcnwstKUtpHBs=;
        b=MeNtpSoAdLGYFhiOMcPrTV4jKvf53fNlAeUEHXvXdbczT5hhdk/xJm9pbJlTfZLcRI
         Y8WIfAxoWIecVOyWWCl5QZ8Foz/omAhp7c7qqArUly1pwUnEDHCGjc6/M5Gmf1d4gc/v
         b/wQjsQDLF3OoV5IOfEAspzVis09noPasQZ6ZIcDHXJKM0KelenZxnwEr+CszNCzDHsM
         GMx7EMv7YhMvsLAsXaq8HURpTZByvKY3oUU7MFYbnweC2UVDvQiyC0a2ziI8hOiHFcQU
         0lXGC/yPSSPPxY//Cux6j40qB/Kgi0geQWGWIOXXXXJtrKXT0JYKbBmO/tmcRRG5/qM9
         AqxQ==
X-Gm-Message-State: AOAM533t1D6SQfmCs0MTHmUJjz+ybe4bETC+kiyAzAujAFArFhKMyC8G
        Z9CZwnmMwwmf0qyrvU8uHMOgVJTa2Gzi47ozJ5zYv0Mb3lYYS337kN/uU7tFXdv3soo/9LL2jQ7
        3c8/H2Dv37jyoVVzFbfdtkqY/
X-Received: by 2002:a17:906:c834:: with SMTP id dd20mr12151125ejb.371.1627336967604;
        Mon, 26 Jul 2021 15:02:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvH/3aCqmYYflBf/gRwLdTFogim/fAaLvtF2xdQqxRPsK9uaxN0bsiIQHQ3PcBI8SRCAJd/g==
X-Received: by 2002:a17:906:c834:: with SMTP id dd20mr12151108ejb.371.1627336967433;
        Mon, 26 Jul 2021 15:02:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id n13sm262249ejk.97.2021.07.26.15.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 15:02:46 -0700 (PDT)
Subject: Re: [PATCH 4.19 111/120] KVM: do not assume PTE is writable after
 follow_pfn
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        David Stevens <stevensd@google.com>, 3pvd@google.com,
        Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Ovidiu Panait <ovidiu.panait@windriver.com>
References: <20210726153832.339431936@linuxfoundation.org>
 <20210726153836.031515657@linuxfoundation.org>
 <CADVatmOcg_7eQno88nu4ijX9QOoA0h2QY=hoj3TZU+tNqj0TMg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8cf86f5f-480a-7093-e890-467f290b0ed3@redhat.com>
Date:   Tue, 27 Jul 2021 00:02:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CADVatmOcg_7eQno88nu4ijX9QOoA0h2QY=hoj3TZU+tNqj0TMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/21 23:17, Sudip Mukherjee wrote:
> Hi Greg,
> 
> On Mon, Jul 26, 2021 at 4:58 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> From: Paolo Bonzini <pbonzini@redhat.com>
>>
>> commit bd2fae8da794b55bf2ac02632da3a151b10e664c upstream.
> 
> The build of mips malta_kvm_defconfig fails with the error:
> In file included from arch/mips/kvm/../../../virt/kvm/kvm_main.c:21:
> arch/mips/kvm/../../../virt/kvm/kvm_main.c: In function 'hva_to_pfn_remapped':
> ./include/linux/kvm_host.h:70:33: error: conversion from 'long long
> unsigned int' to 'long unsigned int' changes value from
> '9218868437227405314' to '2' [-Werror=overflow]
>     70 | #define KVM_PFN_ERR_RO_FAULT    (KVM_PFN_ERR_MASK + 2)
>        |                                 ^
> arch/mips/kvm/../../../virt/kvm/kvm_main.c:1530:23: note: in expansion
> of macro 'KVM_PFN_ERR_RO_FAULT'
>   1530 |                 pfn = KVM_PFN_ERR_RO_FAULT;
> 
> It built fine after reverting this patch.
> gcc version 11.1.1 20210723

I'll resend a version that works tomorrow (including the second patch 
too, which depends on this one for context).

Paolo

