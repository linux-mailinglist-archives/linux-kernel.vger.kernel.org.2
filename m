Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6F43CB70D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 13:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbhGPL63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 07:58:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36597 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232088AbhGPL60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 07:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626436531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P7vOCrL7ymn5lzl6wGJsSLq/fO1ofEKKbNjmiQHOWvk=;
        b=Da6eLilYR+8fVHyI2hfsDhGC3FT7urboZzInrKJKTpp5tUinqw379c8bElV1zYRNKGcr3p
        fBMQBNqVimSl2g4aklaF519f9pSvwFdtdn2AZ6HoHW6rkTWgjaDnvuyn6wrXTmSnzD+MSI
        K3aBkR4KIQE7AknEycPmPlQ+1vpPQK4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-LgLw8uQDM0Kthc736c6rbQ-1; Fri, 16 Jul 2021 07:55:30 -0400
X-MC-Unique: LgLw8uQDM0Kthc736c6rbQ-1
Received: by mail-wm1-f72.google.com with SMTP id z127-20020a1c7e850000b02901e46e4d52c0so2296416wmc.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 04:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P7vOCrL7ymn5lzl6wGJsSLq/fO1ofEKKbNjmiQHOWvk=;
        b=M9hzyRzZKbTlrZHCMPy+auuO6KduYXhQA0x79rlMVycQiXcYV1/Ys6nRgRDVBBE8sU
         fm/ZbIcr3/yzvgpuw829PeQDP+YL0GY7ap97Lp4Em4sUICMLdFYAr5o0Lh48XmuMAaUC
         JEn+uCb7m9vm4aqy5gORl+reBPMsjvqD1Q7/SnBHRIOBEfXXnI3YHyVzcIqyfGj62/zB
         8JP/sGiIjKXpbVDYYx9f3e1JHMI3OpIlDBrdTdpkf8iwrfKSiDtI5eEvkc/Dpzuqo5Ey
         +a8j1VOtpeWlbVLCmoBt3aSmGpdxyvy0LoJZ1NAWMcuhPS1K1W34tRFMSQvbq7tnieFg
         kuQg==
X-Gm-Message-State: AOAM530kAUtN0FtHKmghnPkKqy0pWl+Zt3BGtFAn0Mu7FZVIlD82K3M6
        xvYCJr8XpyEU8VfNTbcpCX0/mZbppIYOwGwb1NMQudBDmXglNieYiQvYA3fWiO6pL/uAAUhiiD5
        J8QYkg5J2tKG8VCFukdGFhzQe
X-Received: by 2002:a5d:5609:: with SMTP id l9mr11956965wrv.123.1626436529155;
        Fri, 16 Jul 2021 04:55:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwllltGZrc4GVOYhpZ2e16qs3ywz/mJ7myRuixUkila1t/EUl17a2fW1CG3hgNxEx2yvxj+JA==
X-Received: by 2002:a5d:5609:: with SMTP id l9mr11956934wrv.123.1626436528864;
        Fri, 16 Jul 2021 04:55:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j16sm9583935wrw.62.2021.07.16.04.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 04:55:28 -0700 (PDT)
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Juri Lelli <jlelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        He Zhe <zhe.he@windriver.com>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <20210715102249.2205-1-hdanton@sina.com>
 <20210716020611.2288-1-hdanton@sina.com>
 <20210716075539.2376-1-hdanton@sina.com>
 <20210716093725.2438-1-hdanton@sina.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
Message-ID: <a2f3f9ac-dac2-eadc-269e-91652d78ebd3@redhat.com>
Date:   Fri, 16 Jul 2021 13:55:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716093725.2438-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/21 11:37, Hillf Danton wrote:
> On Fri, 16 Jul 2021 09:59:15 +0200 Paolo Bonzini wrote:
>> * the warning only occurs if preemption occurs during the
>> spin_lock_irqsave critical section (and therefore it can only occur in
>> PREEMPT_RT kernels)
> 
> With that lock held, no waitqueue entry can be added on to the WQ - IOW no
> wakeup will go stray.
> 
>> * the warning causes an early return 0 that messes up the VM's networking
> 
> Is the messup due to the zero or wakeup?

It's caused by the missing wakeup, i.e. eventfd_signal not really 
signaling anything.

Paolo

