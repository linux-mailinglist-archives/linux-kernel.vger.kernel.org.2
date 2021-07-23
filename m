Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FC63D3724
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 10:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbhGWIPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 04:15:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34330 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229771AbhGWIPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 04:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627030566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mBWhltyKdk3REe+ChbxZxiUkfEHcCzSGpWzpsl0mPA8=;
        b=XPLK99iY7CZo0UxH7igoMon1MO7+87cnildBJc5ytKQIDVVnsNfPDSGSjs7HZXK9i+dNLj
        LvSnQVJBewEkcp89erO/nGCFEonyC1gyYEGzDLuw3JgmCRAVkYhMW1vOCoiBK0Q2NPAX01
        0zzOb9/9eFdwPni/2v0Y6KU5KvyQafM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-VRM5GtjaNt68geAKoGaaBA-1; Fri, 23 Jul 2021 04:56:03 -0400
X-MC-Unique: VRM5GtjaNt68geAKoGaaBA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBF7C8799E0;
        Fri, 23 Jul 2021 08:56:01 +0000 (UTC)
Received: from localhost (unknown [10.39.192.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E77995C1D1;
        Fri, 23 Jul 2021 08:55:57 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v2 2/2] s390:kvm: Topology expose TOPOLOGY facility
In-Reply-To: <7163cf4a-479a-3121-2261-cfb6e4024d0c@de.ibm.com>
Organization: Red Hat GmbH
References: <1626973353-17446-1-git-send-email-pmorel@linux.ibm.com>
 <1626973353-17446-3-git-send-email-pmorel@linux.ibm.com>
 <7163cf4a-479a-3121-2261-cfb6e4024d0c@de.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Fri, 23 Jul 2021 10:55:56 +0200
Message-ID: <87wnph5rz7.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23 2021, Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 22.07.21 19:02, Pierre Morel wrote:
>> We add a KVM extension KVM_CAP_S390_CPU_TOPOLOGY to tell the
>> userland hypervisor it is safe to activate the CPU Topology facility.
>
> I think the old variant of using the CPU model was actually better.
> It was just the patch description that was wrong.

I thought we wanted a cap that userspace can enable to get ptf
intercepts? I'm confused.

>   
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   arch/s390/kvm/kvm-s390.c | 1 +
>>   include/uapi/linux/kvm.h | 1 +
>>   2 files changed, 2 insertions(+)
>> 
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index b655a7d82bf0..8c695ee79612 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -568,6 +568,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>   	case KVM_CAP_S390_VCPU_RESETS:
>>   	case KVM_CAP_SET_GUEST_DEBUG:
>>   	case KVM_CAP_S390_DIAG318:
>> +	case KVM_CAP_S390_CPU_TOPOLOGY:
>>   		r = 1;
>>   		break;
>>   	case KVM_CAP_SET_GUEST_DEBUG2:
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index d9e4aabcb31a..081ce0cd44b9 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -1112,6 +1112,7 @@ struct kvm_ppc_resize_hpt {
>>   #define KVM_CAP_BINARY_STATS_FD 203
>>   #define KVM_CAP_EXIT_ON_EMULATION_FAILURE 204
>>   #define KVM_CAP_ARM_MTE 205
>> +#define KVM_CAP_S390_CPU_TOPOLOGY 206
>>   
>>   #ifdef KVM_CAP_IRQ_ROUTING
>>   
>> 

Regardless of what we end up with: we need documentation for any new cap
:)

