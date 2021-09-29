Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BB641C4FF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 14:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343947AbhI2M5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 08:57:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42462 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343940AbhI2M5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 08:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632920155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oHHoz5hSfSYkAdHIHrMpSEd2w0Wf9S7kBxpqY6OLo4c=;
        b=GjTMWOGfnnTEoU7HlpYXbY35QnE6qqWWwPHDh1GfCfFpYcAx2E2ZIH2MEvucbMWS2CUTRo
        urwO+CvN0HvZBsi/FdHAPbJqaw3ZZhRQShXu0a8dLFtkkAPP0GvoZNeYvFt8nFHU+LseXE
        fYmz8aPqbVdtJRTKbBW3S7K2swcDq9M=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-Kc-FvtodMuWyNB2Yo-fh7g-1; Wed, 29 Sep 2021 08:55:52 -0400
X-MC-Unique: Kc-FvtodMuWyNB2Yo-fh7g-1
Received: by mail-ed1-f72.google.com with SMTP id a7-20020a509e87000000b003da71d1b065so2332225edf.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 05:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oHHoz5hSfSYkAdHIHrMpSEd2w0Wf9S7kBxpqY6OLo4c=;
        b=doUuxWHQTH1xkV9VvTM2ecmFl73r1N82jkgVFjbDxrl1D8hXrBLblmIvtrMrWzo17h
         chJiUovvIZqUfJDnPPV+4A6kKwq74zN4mkndYKywPuKnZd22nY8yXT+ZQXB/5P54TSkS
         hPR5ie5vPECSIbUOa+VZ5L85GQDHkgEIegCeJ+69yMm5A3L8Cr/wBFLEuqIN1HgrlLwd
         pKBFrdAsPrnCNN6UnvbkCrzxCbuPYeMjZzdYZHjDLkn+YyOZ7yPIVEUL+x3yZNqhp6oy
         YUHE1ZuVJVlM7zz6f3YaWQifZScfNzNDd8IcVQqqVh1A0nTMjZvXgUpAzpQ5cN1cimrG
         MQAA==
X-Gm-Message-State: AOAM533WQPxhNrDH/7yzvuPO7vQVfZX1lLJyrNxXpF4iuYfCxp5b63rB
        s6J9Zjn5Rd4/TVCwqEjEZWzqiMibEtB9Dga2xydfFGzgXaM0pnUlJJNCFhDlJygB3mMjVcTveGS
        ZH08H95RkeYQL/ReMgtsoG++h
X-Received: by 2002:a50:da07:: with SMTP id z7mr14803663edj.301.1632920151488;
        Wed, 29 Sep 2021 05:55:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnijlA+Suv1yZ7nvg6/PmlavVog5wCQhvw8hN3J1hEM8QAnQNFWgkO9hGUcLAsv1xKMPFzOQ==
X-Received: by 2002:a50:da07:: with SMTP id z7mr14803641edj.301.1632920151269;
        Wed, 29 Sep 2021 05:55:51 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id dc8sm1518212edb.28.2021.09.29.05.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 05:55:50 -0700 (PDT)
Message-ID: <3721a326-b728-787e-0ef7-a1925941b17b@redhat.com>
Date:   Wed, 29 Sep 2021 14:55:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 0/2] Cleanups for pointer usages in nVMX.
Content-Language: en-US
To:     Yu Zhang <yu.c.zhang@linux.intel.com>, seanjc@google.com,
        vkuznets@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org
References: <20210929175154.11396-1-yu.c.zhang@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20210929175154.11396-1-yu.c.zhang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/21 19:51, Yu Zhang wrote:
> Replace usages of "-1ull" with INVALID_GPA. And reset the vmxon_ptr
> when emulating vmxoff.
> 
> v2:
>    Added patch to replace usages of "-1ull" with INVALID_GPA.
> 
> Vitaly Kuznetsov (1):
>    KVM: nVMX: Reset vmxon_ptr upon VMXOFF emulation.
> 
> Yu Zhang (1):
>    KVM: nVMX: Use INVALID_GPA for pointers used in nVMX.
> 
>   arch/x86/kvm/vmx/nested.c | 61 ++++++++++++++++++++-------------------
>   arch/x86/kvm/vmx/vmx.c    |  5 ++--
>   2 files changed, 34 insertions(+), 32 deletions(-)
> 

Queued, thanks.

Paolo

