Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C343CE318
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 18:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349820AbhGSPgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 11:36:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21822 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245300AbhGSO6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626709130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+lFKwCAVKeBwWtdk13YauC5QOjrFzKdwp3ovNP9k6AY=;
        b=eTlO2q63EOW+QlTvtHrBScLXv+7tMfTT8vBfqsC0trOM9Ju8drqKPhOCqha897c9xCHJBr
        TPVMeBi3NtntERUWe2vXBY5CgImYn9Wf+iY9hOUdW0BOaGeWfyoJEDH5WLEpWBwKVvuvaA
        16P5cXrqda8WncAXG2q0WyaWGlfmMwo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-D_5G5JRJPCyZF0N5R_fDSQ-1; Mon, 19 Jul 2021 11:38:49 -0400
X-MC-Unique: D_5G5JRJPCyZF0N5R_fDSQ-1
Received: by mail-ed1-f69.google.com with SMTP id e3-20020a0564020883b029039ef9536577so9471084edy.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 08:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+lFKwCAVKeBwWtdk13YauC5QOjrFzKdwp3ovNP9k6AY=;
        b=SWKpXm9a8A+MKpZd1G9FVHi+c2jtasAvr8VOrI15KqcDh6Q1qiwfFADKcIPuKbq8oG
         KkYlXECpxCrHqCPyEwSPTgU6vJXkamO+CNz4Xaao2QlLi77imv4/C7McxLs4CNu+F98U
         QsBpqaZhpAe7nOlv4pG+/CwsaJy7bmrYpSY52juhXjb1dYICgxHbBBdNupmeM1OYfMDN
         c0SiErnNsowS5/Q2ChzHhTjPQEcCOyAq/Lt0EQs5FXSgeATCUNCst9dbsYowpt13GH0t
         ymTl9jgGLZaGFXCIyNVxnm49H+QNw3BmVYdzH1T715JWH5N7PcSpx0ymftSgCF20rw4V
         aP2g==
X-Gm-Message-State: AOAM5305wj0Z7HE6fte42xxjrSWkoRh2Nnqht/eNI4DhrlfZyE9Hwaue
        1rMXq+UdUhEvOX5ypvRMnvXsPGzmY/MvwR5auZAkj/F8dfWE0drA7n+ncyFPwKzLRBUwOxd6/sm
        tbOJZ+nvHmI8w2BH9sSNalI3K
X-Received: by 2002:a17:906:2752:: with SMTP id a18mr28974317ejd.458.1626709127966;
        Mon, 19 Jul 2021 08:38:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlJYprLql9Zhw1pUb/b66jZIzRDGS7wig2XiTxZjcvWhWWmHMwbRIx2nEi48m+v6BnHOglLQ==
X-Received: by 2002:a17:906:2752:: with SMTP id a18mr28974294ejd.458.1626709127731;
        Mon, 19 Jul 2021 08:38:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id t15sm6060125ejf.119.2021.07.19.08.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 08:38:47 -0700 (PDT)
To:     Hillf Danton <hdanton@sina.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <20210715102249.2205-1-hdanton@sina.com>
 <20210716020611.2288-1-hdanton@sina.com>
 <20210716075539.2376-1-hdanton@sina.com>
 <20210716093725.2438-1-hdanton@sina.com>
 <20210718124219.1521-1-hdanton@sina.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
Message-ID: <724e7951-59c8-8b2b-37b8-6b0bf696ab04@redhat.com>
Date:   Mon, 19 Jul 2021 17:38:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210718124219.1521-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/21 14:42, Hillf Danton wrote:
>> It's caused by the missing wakeup, i.e. eventfd_signal not really
>> signaling anything.
> 
> Can you please point me to the waiters in the mainline?

It's irqfd_wakeup.

> There are two cases of write_seqcount_begin in x/virt/kvm/eventfd.c, and
> in kvm_irqfd_deassign() it is surrounded by spin_lock_irq(&kvm->irqfds.lock)
> that also protects irqfd_update().
> 
> What isnt clear is if the risk is zero that either case can be preempted by
> seqcount reader. That risk may end up with the livelock described in
> x/Documentation/locking/seqlock.rst.

Since the introduction of seqcount_spinlock_t, the writers automatically 
disable preemption.  This is definitely the right thing in this case 
where the seqcount writers are small enough, and the readers are hot 
enough, that using a local lock would be too heavyweight.

Without that, the livelock would be possible, though very unlikely.  In 
practice seqcount updates should only happen while the producer is 
quiescent; and also the seqcount readers and writers will often be 
pinned to separate CPUs.

Paolo

> +A sequence counter write side critical section must never be preempted
> +or interrupted by read side sections. Otherwise the reader will spin for
> +the entire scheduler tick due to the odd sequence count value and the
> +interrupted writer. If that reader belongs to a real-time scheduling
> +class, it can spin forever and the kernel will livelock.
> 

