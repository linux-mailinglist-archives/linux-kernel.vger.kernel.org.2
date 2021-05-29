Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC367394B9A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 12:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhE2KWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 06:22:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229597AbhE2KV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 06:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622283621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rAj07ZCK5KDIXiVxu56SXtmyW8X/Uzs85mSHd9xMkE0=;
        b=VtMAfg2b+ltj1w1r9C9LxIVzKfZI8PVKpqswKF1ajeKXvvDmyUWNj0GyQveI7xpDM4ZYvg
        ysCteFrXma0aN5hWmZA4nanBHR9NZ+cKjIOyy+voJ0Zu+AKnRhBHKuT0kU1dWBIpGUgms8
        lJiwZcKEuzdDJ0kOL8QyBNwtuySR7GE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-p7sxfgcTN6S8nAUrLhOsPA-1; Sat, 29 May 2021 06:20:19 -0400
X-MC-Unique: p7sxfgcTN6S8nAUrLhOsPA-1
Received: by mail-wr1-f69.google.com with SMTP id s8-20020adff8080000b0290114e1eeb8c6so55303wrp.23
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 03:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rAj07ZCK5KDIXiVxu56SXtmyW8X/Uzs85mSHd9xMkE0=;
        b=kjxnDSboyLeb6pPljJKCnxxQPrhg1KLmfvJsI6X31KLFd7ox5OoW6SE2EgJ5Perde1
         Ck2QlpVhH6fjDSSS6z55qQ+cGXuRVTfxjDR9uLkcZRPBo/axzD5JCY70WdIr6J/jSx4P
         JB0kQioYJdYt4x/xU+x2ZYCqI6ushyBdeo4yzSJbPUrnIL/6WmJI3R4Lz8yGnDaVpRql
         UfLSNLFg1GxHu0TDEBiGIM+FSU36BCEN75/3y29Y/dUSVEf2r45qwRLeAwNjO4rPcJDO
         DX2Bwr/PHBAFUEDZE76LAeZBrpIoq9/N9yb7h3sm00VMYcseschu9UIvd3nArqQxjlnV
         P7lQ==
X-Gm-Message-State: AOAM531vHL/ddWQsCPfOMNEVZdzr3+vJM/K7XseSl05wYzV8NqN1houL
        cHD3I1l91r0+xaIa5sgFrCEyqJd7P8WOB7xcAqegqV7yBEin5BiDL+BYM2A7JIxWCf5EOsEViZY
        wuKcz3jh/z49E09Yc4N40Vv5c
X-Received: by 2002:a1c:4e0b:: with SMTP id g11mr12374214wmh.3.1622283617819;
        Sat, 29 May 2021 03:20:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKTruQR1WsSRzgozbspnFpcPccqWYRWEgR4ui7XPhdvKvdRXAA+HovZdppQC/XVpJjPue7WQ==
X-Received: by 2002:a1c:4e0b:: with SMTP id g11mr12374199wmh.3.1622283617636;
        Sat, 29 May 2021 03:20:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id 92sm7981736wrp.88.2021.05.29.03.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 May 2021 03:20:17 -0700 (PDT)
To:     "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20210528191134.3740950-1-pbonzini@redhat.com>
 <285623f6-52e4-7f8d-fab6-0476a00af68b@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] selftests: kvm: fix overlapping addresses in
 memslot_perf_test
Message-ID: <fc41bfc4-949f-03c5-3b20-2c1563ad7f62@redhat.com>
Date:   Sat, 29 May 2021 12:20:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <285623f6-52e4-7f8d-fab6-0476a00af68b@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/21 21:51, Maciej S. Szmigiero wrote:
> On 28.05.2021 21:11, Paolo Bonzini wrote:
>> The memory that is allocated in vm_create is already mapped close to
>> GPA 0, because test_execute passes the requested memory to
>> prepare_vm.  This causes overlapping memory regions and the
>> test crashes.  For simplicity just move MEM_GPA higher.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> I am not sure that I understand the issue correctly, is vm_create_default()
> already reserving low GPAs (around 0x10000000) on some arches or run
> environments?

It maps the number of pages you pass in the second argument, see
vm_create.

   if (phy_pages != 0)
     vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
                                 0, 0, phy_pages, 0);

In this case:

   data->vm = vm_create_default(VCPU_ID, mempages, guest_code);

called here:

   if (!prepare_vm(data, nslots, maxslots, tdata->guest_code,
                   mem_size, slot_runtime)) {

where mempages is mem_size, which is declared as:

         uint64_t mem_size = tdata->mem_size ? : MEM_SIZE_PAGES;

but actually a better fix is just to pass a small fixed value (e.g. 
1024) to vm_create_default, since all other regions are added by hand.

Paolo

