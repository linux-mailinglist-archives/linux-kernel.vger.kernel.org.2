Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05013A4788
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhFKRNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:13:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230186AbhFKRNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623431513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fN/mVV/PbyF2783Hpa69RufdmQkjHk7SYejj/LdWl0k=;
        b=hxB+dx8LaNHwVV3xpE5I1uxlL9MWKTjZAD3vhd5XLPxJEwhpKELcFbnIlx03qF+CR3wzl1
        sO5w4PYqx4tM/tfHlYxvEpzEpCQpzP5i40bv64mjfWou5ubvsFG/ypxnJI/ys2mtp4xJah
        OdqqnYmWaO74PWaDUpV5IgeS1c90qV4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-WFjAlR4wPHOZBCgIIL4cAw-1; Fri, 11 Jun 2021 13:11:52 -0400
X-MC-Unique: WFjAlR4wPHOZBCgIIL4cAw-1
Received: by mail-wr1-f70.google.com with SMTP id d5-20020a0560001865b0290119bba6e1c7so2907289wri.20
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 10:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fN/mVV/PbyF2783Hpa69RufdmQkjHk7SYejj/LdWl0k=;
        b=bJ30b1CXz4VNfvZpYEaHqVyFrDe2f+6vctrT1JMZPCsdKvCFwPb08RWlk3bx0DVHXu
         Jza9Dpxaa3ZKiVIugsDmNR9CeOZFBhMLjZeRqeQzcDQQPIEvZ10dttAMD0PAR5h9RyVR
         sw+s3WfdRHl4LuLQzrD3siulSR+A5qwghftIGKeiXWsq+OEv+fobngGn8attVRXtBnrg
         uASweP4i1Ujod7hVJu998hbtjt9PtfsA+AMrktKE2RwB/5tvOU4ysFvYgh1wKFedfexm
         pWeH45s8KjNTmpC3OVXGAQyxD4NoSdKOE0pUTkKU3jHRAs/bX9QkKWlD7NFN6KEdy2iJ
         ZpYg==
X-Gm-Message-State: AOAM533v2TE39UzYeJIFGyJ4x2qNJObz5Zi+MTj0urWuG4wvCZUY/R2A
        qoqeZR87znsSwnVfFUaTdW5EkCy9oiYB+58MWA44DA8pxaoYzg3ZvR7g4it6+EeBg2e6TAxLVzA
        5kBZK7wslBIaRxSw77V0or0bZ
X-Received: by 2002:a5d:64c3:: with SMTP id f3mr5215036wri.263.1623431511623;
        Fri, 11 Jun 2021 10:11:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqAEtDrL+JGgbe7s64y6Qwu724j6kGakolpO9O9iu4bscLtvjosb65kz5vimWchOT3ZRhvXA==
X-Received: by 2002:a5d:64c3:: with SMTP id f3mr5215010wri.263.1623431511354;
        Fri, 11 Jun 2021 10:11:51 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64b6.dip0.t-ipconnect.de. [91.12.100.182])
        by smtp.gmail.com with ESMTPSA id v18sm8416778wrb.10.2021.06.11.10.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 10:11:51 -0700 (PDT)
Subject: Re: [PATCH 2/3] s390/vfio-ap: introduce two new r/w locks to replace
 wait_queue_head_t
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, hca@linux.ibm.com
References: <20210609224634.575156-1-akrowiak@linux.ibm.com>
 <20210609224634.575156-3-akrowiak@linux.ibm.com>
 <20210611170526.GU1002214@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7ed059b0-5d58-eeec-167c-280917b47c00@redhat.com>
Date:   Fri, 11 Jun 2021 19:11:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210611170526.GU1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.06.21 19:05, Jason Gunthorpe wrote:
> On Wed, Jun 09, 2021 at 06:46:33PM -0400, Tony Krowiak wrote:
>> This patch introduces two new r/w locks to replace the wait_queue_head_t
>> that was introduced to fix a lockdep splat reported when testing
>> pass-through of AP queues to a Secure Execution guest. This was the
>> abbreviated dependency chain reported by lockdep that was fixed using
>> a wait queue:
>>
>> kvm_arch_crypto_set_masks+0x4a/0x2b8 [kvm]        kvm->lock
>> vfio_ap_mdev_group_notifier+0x154/0x170 [vfio_ap] matrix_dev->lock
>>
>> handle_pqap+0x56/0x1d0 [vfio_ap]    matrix_dev->lock
>> kvm_vcpu_ioctl+0x2cc/0x898 [kvm]    vcpu->mutex
>>
>> kvm_s390_cpus_to_pv+0x4e/0xf8 [kvm]   vcpu->mutex
>> kvm_arch_vm_ioctl+0x3ec/0x550 [kvm]   kvm->lock
> 
> Is the problem larger than kvm_arch_crypto_set_masks()? If not it
> looks easy enough to fix, just pull the kvm->lock out of
> kvm_arch_crypto_set_masks() and obtain it in vfio_ap_mdev_set_kvm()
> before the rwsem. Now your locks are in the right order and all should
> be well?
> 
>> +static int vfio_ap_mdev_matrix_store_lock(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +	if (!down_write_trylock(&matrix_mdev->rwsem))
>> +		return -EBUSY;
>> +
>> +	if (matrix_mdev->kvm) {
>> +		up_write(&matrix_mdev->rwsem);
>> +		return -EBUSY;
>> +	}
>> +
>> +	if (!down_write_trylock(&matrix_mdev->matrix.rwsem)) {
>> +		up_write(&matrix_mdev->rwsem);
>> +		return -EBUSY;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> This double locking is quite strange, at least it deserves a detailed
> comment? The comments suggest these locks protect distinct data so..
> 
>> +
>> +	ret = vfio_ap_mdev_matrix_store_lock(matrix_mdev);
>> +	if (ret)
>> +		return ret;
>>   
>>   	clear_bit_inv((unsigned long)apqi, matrix_mdev->matrix.aqm);
> 
> here it obtained both locks but only touched matrix.aqm which is only
> protected by the inner lock - what was the point of obtaining the
> outer lock?
> 
> Also, not convinced down_write_trylock() is appropriate from a sysfs
> callback, it should block and wait, surely? Otherwise userspace gets
> random racy failures depending on what the kernel is doing??

It might we worth exploring lock_device_hotplug_sysfs() which does a

"return restart_syscall()" with some delay.


-- 
Thanks,

David / dhildenb

