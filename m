Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29224319D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 14:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhJRMuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 08:50:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57237 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231217AbhJRMuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 08:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634561269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8JFX9G5eFubsgdU5Ex1aOVO29fHmKQKM0WaLaufKwIk=;
        b=UZ6q+OCCvaDOkvRcicnnDeunFa9VIHdBN7orHw0pjPayMewGqXyOdJjAM17644UznyOv07
        f3wvQaZwTrLZ9SGAM51OoqaVjsov5dTK6Q+jbTuhwwihbTdkbkkcCX3ILqQ4+lIlOIWDXy
        5FlRufXI8W8hfS5ijoJTRI7t85w3Djg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-_zG2Cu6hPbCAlp4ZxXr2fA-1; Mon, 18 Oct 2021 08:47:48 -0400
X-MC-Unique: _zG2Cu6hPbCAlp4ZxXr2fA-1
Received: by mail-wm1-f70.google.com with SMTP id p12-20020a05600c204c00b0030da46b76daso3137773wmg.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 05:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8JFX9G5eFubsgdU5Ex1aOVO29fHmKQKM0WaLaufKwIk=;
        b=NxkIsENjw6hclqIFQiaLLL1VgqR4upeXOn/uc0vhSICS32LVZ1ei82NsGGfkNU3y0c
         wekTlDST9WspgGOzG+Lv1w9+Qd+WAmcwFIEEFS1+97n2mxD4hO2XjjGCPdBOmO+ilcGe
         WG1VwbCLubjmmUEQdIqGUJjKpnjML+rRU1jtKn2Ys36PBSohh1S7OOT0q3jh/XnC9PKK
         VCATVvoKNKCuL0DqKDJqqPMaWTM5tczIVq18a0dbYuBTj8JwHqJ8YPYQAGo7dNkYHEGG
         U0Z4c7o0JUbImxiAdTDFlHunnHbMNp4VG7Z/g/d09xgMJyq+5uPUXgCJIhYobzimPKTv
         5Low==
X-Gm-Message-State: AOAM532//0EX0SAvH/rgW4Di46yNM9k6xNJ7XNziSpYhdUeWiFQm7RGT
        34QcUoHvX1rwvFnRQnIZB1u/VpPKxfPdc2jySgKQ8zVu8l01i8kiLFncwLC7MWdzLqFj2Qgp43c
        QnTDq05aaiYzVAb6q5F75QBhm
X-Received: by 2002:a1c:730a:: with SMTP id d10mr43095905wmb.105.1634561266960;
        Mon, 18 Oct 2021 05:47:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpbxymiK7HvhZV/hiCGUSa6vHsz0zAq1NVT52GU1Q8BSr7o/WIPwl6O3/wWZGo7uocBbaYZQ==
X-Received: by 2002:a1c:730a:: with SMTP id d10mr43095880wmb.105.1634561266763;
        Mon, 18 Oct 2021 05:47:46 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id r128sm11944216wma.44.2021.10.18.05.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 05:47:46 -0700 (PDT)
Message-ID: <486f0075-494d-1d84-2d85-1d451496d1f0@redhat.com>
Date:   Mon, 18 Oct 2021 14:47:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 6/7] KVM: VMX: Check Intel PT related CPUID leaves
Content-Language: en-US
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210827070249.924633-1-xiaoyao.li@intel.com>
 <20210827070249.924633-7-xiaoyao.li@intel.com> <YTp/oGmiin19q4sQ@google.com>
 <a7988439-5a4c-3d5a-ea4a-0fad181ad733@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <a7988439-5a4c-3d5a-ea4a-0fad181ad733@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/21 03:59, Xiaoyao Li wrote:
>> 
>> Ugh, looking at the rest of the code, even this isn't sufficient
>> because pt_desc.guest.addr_{a,b} are hardcoded at 4 entries, i.e.
>> running KVM on hardware with >4 entries will lead to buffer
>> overflows.
> 
> it's hardcoded to 4 because there is a note of "no processors support
>  more than 4 address ranges" in SDM vol.3 Chapter 31.3.1, table
> 31-11

True, but I agree with Sean that it's not pretty.

>> One option would be to bump that to the theoretical max of 15,
>> which doesn't seem too horrible, especially if pt_desc as a whole
>> is allocated on-demand, which it probably should be since it isn't
>> exactly tiny (nor ubiquitous)
>> 
>> A different option would be to let userspace define whatever it
>> wants for guest CPUID, and instead cap nr_addr_ranges at
>> min(host.cpuid, guest.cpuid, RTIT_ADDR_RANGE).

This is the safest option.

Paolo

