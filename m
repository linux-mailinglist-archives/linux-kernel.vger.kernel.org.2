Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C2E40A3D8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbhINCvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:51:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38240 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234374AbhINCvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631587818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Z4WlMnYOyHOSH+4kEx86uVtPCIPHAH4x7UGSngJSTE=;
        b=LfhJxOBKOo4yXuldRrHIsuu5617fbtj1ceMgGDHFJZaFM4uufqzPsoa/tZJRjcLoqZ9NsX
        WI1vhcdME61fNo3hGX5l/lTB3EHP+9QO2oKxnpt2rAwMYO25pzW756wRF4mg6PEMOIx0Bx
        4/jLKOAr8vU+tv6tp0nKDGhwPD/wBA0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-rQ46pKN8PYGRzdFVueVUAw-1; Mon, 13 Sep 2021 22:50:17 -0400
X-MC-Unique: rQ46pKN8PYGRzdFVueVUAw-1
Received: by mail-pj1-f72.google.com with SMTP id n3-20020a17090a394300b0019765b9bd7bso1244948pjf.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 19:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5Z4WlMnYOyHOSH+4kEx86uVtPCIPHAH4x7UGSngJSTE=;
        b=ka5uqv3O/0gi9YzPFFob1s8ZrZQrnwrry+vEfMSU16lfMwtJkY9VscXcPiwqjpoEAr
         9/P371OG1nLXIbG9n/6p9iQU10i0k7laFvSuHP+mPFjICq7OoiYAn7kiB/fm7GUeUce0
         EQgiY6SD9daHqPKwl0J7DD8YnWEQ4/X52l7A39ix+Ch/iqq4A6NuU78XP12gdzAlIcgN
         Xyv5GhttQZX0GnDtueskA8IL8HopAE3gx/jCJWe0yO+Ig4QP5sMq2pnydEZ0hzlD9e4S
         V6Y0ks8fyxUrrY+hcfaYvoeUm7VXLblbBY+Ww9XvD7dLHu1hyjbWGBqAId/Eo19agmZc
         CnpA==
X-Gm-Message-State: AOAM530GWNMhlWyzmDXS2hZbyEE09lKPqA+AZDQ6lIjIh0zYm8uU3xCs
        6Oj7Gm5KDhB4k3s6tb9PkQ2qzj75qGwsAXyipxTrMTX3Bk/UVjBc2Y3rrLS+58Gx5FZ1YrkpF7t
        xOSEIvmBeYVusLZ/vcpdTGm+J
X-Received: by 2002:a17:90b:4b4b:: with SMTP id mi11mr2950169pjb.41.1631587815901;
        Mon, 13 Sep 2021 19:50:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaZk3eUn5jFr9FI6lgplmOjTDOf4oWYe0qRP9KxwgXpc8j2j/7kSjDP/1mlEOCALECN1KCfQ==
X-Received: by 2002:a17:90b:4b4b:: with SMTP id mi11mr2950140pjb.41.1631587815526;
        Mon, 13 Sep 2021 19:50:15 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v17sm8091760pff.6.2021.09.13.19.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 19:50:15 -0700 (PDT)
Subject: Re: [PATCH 7/9] virtio-pci: harden INTX interrupts
To:     Thomas Gleixner <tglx@linutronix.de>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-8-jasowang@redhat.com> <875yv4f99j.ffs@tglx>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <dae944d8-a658-cb52-2c4b-076c6a41c458@redhat.com>
Date:   Tue, 14 Sep 2021 10:50:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <875yv4f99j.ffs@tglx>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/9/14 ÉÏÎç5:36, Thomas Gleixner Ð´µÀ:
> Jason,
>
> On Mon, Sep 13 2021 at 13:53, Jason Wang wrote:
>> This patch tries to make sure the virtio interrupt handler for INTX
>> won't be called after a reset and before virtio_device_ready(). We
>> can't use IRQF_NO_AUTOEN since we're using shared interrupt
>> (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
>> intx_soft_enabled variable and toggle it during in
>> vp_disable/enable_vectors(). The INTX interrupt handler will check
>> intx_soft_enabled before processing the actual interrupt.
> Ah, there it is :)
>
> Cc'ed our memory ordering wizards as I might be wrong as usual.
>
>> -	if (vp_dev->intx_enabled)
>> +	if (vp_dev->intx_enabled) {
>> +		vp_dev->intx_soft_enabled = false;
>> +		/* ensure the vp_interrupt see this intx_soft_enabled value */
>> +		smp_wmb();
>>   		synchronize_irq(vp_dev->pci_dev->irq);
> As you are synchronizing the interrupt here anyway, what is the value of
> the barrier?
>
>   		vp_dev->intx_soft_enabled = false;
>    		synchronize_irq(vp_dev->pci_dev->irq);
>
> is sufficient because of:
>
> synchronize_irq()
>     do {
>     	raw_spin_lock(desc->lock);
>          in_progress = check_inprogress(desc);
>     	raw_spin_unlock(desc->lock);
>     } while (in_progress);
>
> raw_spin_lock() has ACQUIRE semantics so the store to intx_soft_enabled
> can complete after lock has been acquired which is uninteresting.
>
> raw_spin_unlock() has RELEASE semantics so the store to intx_soft_enabled
> has to be completed before the unlock completes.
>
> So if the interrupt is on the flight then it might or might not see
> intx_soft_enabled == false. But that's true for your barrier construct
> as well.
>
> The important part is that any interrupt for this line arriving after
> synchronize_irq() has completed is guaranteed to see intx_soft_enabled
> == false.
>
> That is what you want to achieve, right?


Right.


>
>>   	for (i = 0; i < vp_dev->msix_vectors; ++i)
>>   		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
>> @@ -43,8 +47,12 @@ void vp_enable_vectors(struct virtio_device *vdev)
>>   	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>>   	int i;
>>   
>> -	if (vp_dev->intx_enabled)
>> +	if (vp_dev->intx_enabled) {
>> +		vp_dev->intx_soft_enabled = true;
>> +		/* ensure the vp_interrupt see this intx_soft_enabled value */
>> +		smp_wmb();
> For the enable case the barrier is pointless vs. intx_soft_enabled
>
> CPU 0                                           CPU 1
>
> interrupt                                       vp_enable_vectors()
>    vp_interrupt()
>      if (!vp_dev->intx_soft_enabled)
>         return IRQ_NONE;
>                                                    vp_dev->intx_soft_enabled = true;
>
> IOW, the concurrent interrupt might or might not see the store. That's
> not a problem for legacy PCI interrupts. If it did not see the store and
> the interrupt originated from that device then it will account it as one
> spurious interrupt which will get raised again because those interrupts
> are level triggered and nothing acknowledged it at the device level.


I see.


>
> Now, what's more interesting is that is has to be guaranteed that the
> interrupt which observes
>
>          vp_dev->intx_soft_enabled == true
>
> also observes all preceeding stores, i.e. those which make the interrupt
> handler capable of handling the interrupt.
>
> That's the real problem and for that your barrier is at the wrong place
> because you want to make sure that those stores are visible before the
> store to intx_soft_enabled becomes visible, i.e. this should be:
>
>
>          /* Ensure that all preceeding stores are visible before intx_soft_enabled */
> 	smp_wmb();
> 	vp_dev->intx_soft_enabled = true;


Yes, I see.


>
> Now Micheal is not really enthusiatic about the barrier in the interrupt
> handler hotpath, which is understandable.
>
> As the device startup is not really happening often it's sensible to do
> the following
>
>          disable_irq();
>          vp_dev->intx_soft_enabled = true;
>          enable_irq();
>
> because:
>
>          disable_irq()
>            synchronize_irq()
>
> acts as a barrier for the preceeding stores:
>
>          disable_irq()
>     	  raw_spin_lock(desc->lock);
>            __disable_irq(desc);
>     	  raw_spin_unlock(desc->lock);
>
>            synchronize_irq()
>              do {
>     	      raw_spin_lock(desc->lock);
>                in_progress = check_inprogress(desc);
>     	      raw_spin_unlock(desc->lock);
>              } while (in_progress);
>
>          intx_soft_enabled = true;
>
>          enable_irq();
>
> In this case synchronize_irq() prevents the subsequent store to
> intx_soft_enabled to leak into the __disable_irq(desc) section which in
> turn makes it impossible for an interrupt handler to observe
> intx_soft_enabled == true before the prerequisites which preceed the
> call to disable_irq() are visible.
>
> Of course the memory ordering wizards might disagree, but if they do,
> then we have a massive chase of ordering problems vs. similar constructs
> all over the tree ahead of us.
>
>  From the interrupt perspective the sequence:
>
>          disable_irq();
>          vp_dev->intx_soft_enabled = true;
>          enable_irq();
>
> is perfectly fine as well. Any interrupt arriving during the disabled
> section will be reraised on enable_irq() in hardware because it's a
> level interrupt. Any resulting failure is either a hardware or a
> hypervisor bug.


Thanks a lot for the detail clarifications. Will switch to use 
disable_irq()/enable_irq() if no objection from memory ordering wizards.


>
> Thanks,
>
>          tglx
>

