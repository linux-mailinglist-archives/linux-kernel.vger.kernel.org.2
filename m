Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5643EC64B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 02:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbhHOAUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 20:20:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28181 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229453AbhHOAU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 20:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628986799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oP82YO7+Ud/EWaS5q3iuRU5WSJgOBi/uyPbz0miSSSw=;
        b=YiQvrR25EWSHr8aMoi00XEcLbqSYy2KepwIqLLzC5E84pSa5+MI+bwUfKPrNv0TcbYz4G9
        +qFP0XW9IiIK+BXKpcZBEf0lXS9Rx8y8Iu4Kki08/85Gk3IRaqRzuJ1jR462MP6lCHI/0a
        avXe6wztR6UQQg+1UgR0rkAgZkUXtNk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-Vt-w2ZTWP2Skp8E15Gp2eQ-1; Sat, 14 Aug 2021 20:19:57 -0400
X-MC-Unique: Vt-w2ZTWP2Skp8E15Gp2eQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CE71801AC0;
        Sun, 15 Aug 2021 00:19:56 +0000 (UTC)
Received: from [10.64.54.103] (vpn2-54-103.bne.redhat.com [10.64.54.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8443B60C4A;
        Sun, 15 Aug 2021 00:19:52 +0000 (UTC)
Subject: Re: [PATCH v4 00/21] Support SDEI Virtualization
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20210815001352.81927-1-gshan@redhat.com>
Message-ID: <eee7eeb2-cedf-e52f-1e5f-403d9edabd94@redhat.com>
Date:   Sun, 15 Aug 2021 10:19:46 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20210815001352.81927-1-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/21 10:13 AM, Gavin Shan wrote:
> This series intends to virtualize Software Delegated Exception Interface
> (SDEI), which is defined by DEN0054A. It allows the hypervisor to deliver
> NMI-alike event to guest and it's needed by asynchronous page fault to
> deliver page-not-present notification from hypervisor to guest. The code
> and the required qemu changes can be found from:
> 
>     https://developer.arm.com/documentation/den0054/latest
>     https://github.com/gwshan/linux    ("kvm/arm64_sdei")
>     https://github.com/gwshan/qemu     ("kvm/arm64_sdei")
> 
> The SDEI event is identified by a 32-bits number. Bits[31:24] are used
> to indicate the SDEI event properties while bits[23:0] are identifying
> the unique number. The implementation takes bits[23:22] to indicate the
> owner of the SDEI event. For example, those SDEI events owned by KVM
> should have these two bits set to 0b01. Besides, the implementation
> supports SDEI events owned by KVM only.
> 
> The design is pretty straightforward and the implementation is just
> following the SDEI specification, to support the defined SMCCC intefaces,
> except the IRQ binding stuff. There are several data structures introduced.
> Some of the objects have to be migrated by VMM. So their definitions are
> split up for VMM to include the corresponding states for migration.
> 
>     struct kvm_sdei_kvm
>        Associated with VM and used to track the KVM exposed SDEI events
>        and those registered by guest.
>     struct kvm_sdei_vcpu
>        Associated with vCPU and used to track SDEI event delivery. The
>        preempted context is saved prior to the delivery and restored
>        after that.
>     struct kvm_sdei_event
>        SDEI events exposed by KVM so that guest can register and enable.
>     struct kvm_sdei_kvm_event
>        SDEI events that have been registered by guest.
>     struct kvm_sdei_vcpu_event
>        SDEI events that have been queued to specific vCPU for delivery.
> 
> The series is organized as below:
> 
>     PATCH[01]    Introduces template for smccc_get_argx()
>     PATCH[02]    Introduces the data structures and infrastructure
>     PATCH[03-14] Supports various SDEI related hypercalls
>     PATCH[15]    Supports SDEI event notification
>     PATCH[16-17] Introduces ioctl command for migration
>     PATCH[18-19] Supports SDEI event injection and cancellation
>     PATCH[20]    Exports SDEI capability
>     PATCH[21]    Adds self-test case for SDEI virtualization
> 

[...]

I explicitly copied James Morse and Mark Rutland when posting the series,
but something unknown went wrong. I'm including them here to avoid
reposting the whole series.

Thanks,
Gavin

