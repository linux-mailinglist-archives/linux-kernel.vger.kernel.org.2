Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B128F44C2F3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 15:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbhKJOcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 09:32:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231558AbhKJOcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 09:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636554562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bnca2yMtA4WzvVxShB8WJkPxX9FUiW0h7CO30+UcGxs=;
        b=HeG1niTYkeOL0vTCWVJalnrrrir8Yre0033LK+i1oqBMDTyyl1kX6GPgTTi4JNZCpck2C4
        VQKV//nAgnLhC1IDx+tK03cLthw2JupoSkBs3Dhxe7LH18iuhDQxdFj4ugqQE0sxWGDLsx
        clSlBKg9Xex290+JNR7PME1D/hwt7PI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-BIJ310nfPrSL4nvJQ_qAhQ-1; Wed, 10 Nov 2021 09:29:21 -0500
X-MC-Unique: BIJ310nfPrSL4nvJQ_qAhQ-1
Received: by mail-wm1-f69.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so1184173wmj.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 06:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bnca2yMtA4WzvVxShB8WJkPxX9FUiW0h7CO30+UcGxs=;
        b=Kh934ADtaxMaRWLfmYghrVOcOpDshZS0u4QrpJjaX9FCCkSKv7Y2y60c2jJ1lauPN1
         k6vYWFyS3uXq1ufHJkTY97aowzY+/Xe9aNAFSo3RTmdYTmQw4tniE/oLV96AJByMjLMM
         uO889om5u+kc5I/D5Ccvsjofr0tOeoKsPcKbmcoabuONj1HL05c3JQQtCsQBWxWnWTq1
         gmMbJ0ih9kVGvrhHzMZor1dMnUByeNQmYnyEpnUrkQgw76jc+YY8J0t2VHkp/9HA6bjj
         Vn3zZKoZoA28wsZMNyfdRsj/AjQVkAM6Jk9PCFFBNKPqT43QdplYb3+cwH0mIjGNgKuV
         MPCA==
X-Gm-Message-State: AOAM531M7b+iI+sZtjUonDJ16ET96O61R/XXA3JjRJMO7vd/pHnVk9ZA
        Dzr9Lo5bKDmaUgdV+KpSf5THMoXVjVDabT3d1o0LML+hlbbynRUpHED7YYw6cIEsZ4lyJUOiFkh
        sjliZTUBjpSzjck5g1QJTGfdC
X-Received: by 2002:adf:f10d:: with SMTP id r13mr180076wro.414.1636554560272;
        Wed, 10 Nov 2021 06:29:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2szMrbPauSa/I+sU8autgCEFlMAC/W1iydquyymlOm2eFXJw326dRVjIhcOSCJVvTEJzr0A==
X-Received: by 2002:adf:f10d:: with SMTP id r13mr180037wro.414.1636554560015;
        Wed, 10 Nov 2021 06:29:20 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id o4sm23362wry.80.2021.11.10.06.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 06:29:19 -0800 (PST)
Subject: Re: [PATCH v4 00/21] Support SDEI Virtualization
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
References: <20210815001352.81927-1-gshan@redhat.com>
 <eee7eeb2-cedf-e52f-1e5f-403d9edabd94@redhat.com>
From:   Eric Auger <eauger@redhat.com>
Message-ID: <7f5e86dd-b38d-8699-58bd-35db78ec1b7a@redhat.com>
Date:   Wed, 10 Nov 2021 15:29:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <eee7eeb2-cedf-e52f-1e5f-403d9edabd94@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

On 8/15/21 2:19 AM, Gavin Shan wrote:
> On 8/15/21 10:13 AM, Gavin Shan wrote:
>> This series intends to virtualize Software Delegated Exception Interface
>> (SDEI), which is defined by DEN0054A. It allows the hypervisor to deliver
>> NMI-alike event to guest and it's needed by asynchronous page fault to
>> deliver page-not-present notification from hypervisor to guest. The code
>> and the required qemu changes can be found from:
>>
>>     https://developer.arm.com/documentation/den0054/latest
>>     https://github.com/gwshan/linux    ("kvm/arm64_sdei")
>>     https://github.com/gwshan/qemu     ("kvm/arm64_sdei")
>>
>> The SDEI event is identified by a 32-bits number. Bits[31:24] are used
>> to indicate the SDEI event properties while bits[23:0] are identifying
>> the unique number. The implementation takes bits[23:22] to indicate the
>> owner of the SDEI event. For example, those SDEI events owned by KVM
>> should have these two bits set to 0b01. Besides, the implementation
>> supports SDEI events owned by KVM only.
>>
>> The design is pretty straightforward and the implementation is just
>> following the SDEI specification, to support the defined SMCCC intefaces,
>> except the IRQ binding stuff. There are several data structures
>> introduced.
>> Some of the objects have to be migrated by VMM. So their definitions are
>> split up for VMM to include the corresponding states for migration.
>>
>>     struct kvm_sdei_kvm
>>        Associated with VM and used to track the KVM exposed SDEI events
>>        and those registered by guest.
>>     struct kvm_sdei_vcpu
>>        Associated with vCPU and used to track SDEI event delivery. The
>>        preempted context is saved prior to the delivery and restored
>>        after that.
>>     struct kvm_sdei_event
>>        SDEI events exposed by KVM so that guest can register and enable.
>>     struct kvm_sdei_kvm_event
>>        SDEI events that have been registered by guest.
>>     struct kvm_sdei_vcpu_event
>>        SDEI events that have been queued to specific vCPU for delivery.
>>
>> The series is organized as below:
>>
>>     PATCH[01]    Introduces template for smccc_get_argx()
>>     PATCH[02]    Introduces the data structures and infrastructure
>>     PATCH[03-14] Supports various SDEI related hypercalls
>>     PATCH[15]    Supports SDEI event notification
>>     PATCH[16-17] Introduces ioctl command for migration
>>     PATCH[18-19] Supports SDEI event injection and cancellation
>>     PATCH[20]    Exports SDEI capability
>>     PATCH[21]    Adds self-test case for SDEI virtualization
>>
> 
> [...]
> 
> I explicitly copied James Morse and Mark Rutland when posting the series,
> but something unknown went wrong. I'm including them here to avoid
> reposting the whole series.
I don't see James nor Mark included here either

Eric
> 
> Thanks,
> Gavin
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> 

