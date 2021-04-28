Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E89B36D22B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 08:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbhD1G0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 02:26:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22565 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235991AbhD1G0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 02:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619591125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v0drg1VHfipH5003vzixu1Xfr6Q82RdEZBTA4Npc/7s=;
        b=Nx7YrRMiv8ip5Vs2MmxfUsJWRTgfrP+I2CqA35HeDPpT+qekIy6A3AERg+TFZvyiVJ/2U6
        9446x/K8p1ZFC23u7Dp2Tgf7vc3IVC8+3Zncw0us6xp6sw7jzA/lZAY2d5cocfoVrhBqWJ
        HzAouvHxBA2YXbaGpwmIzB1c6frF+h0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-Swu6IY-qNoyFRJCy4zBvog-1; Wed, 28 Apr 2021 02:25:24 -0400
X-MC-Unique: Swu6IY-qNoyFRJCy4zBvog-1
Received: by mail-ej1-f71.google.com with SMTP id f15-20020a170906738fb029037c94426fffso12005250ejl.22
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 23:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v0drg1VHfipH5003vzixu1Xfr6Q82RdEZBTA4Npc/7s=;
        b=KugPKX+y8IPjUkjxEkwWLGasGWCMDEXGgZqF+S4H0CgVRZqrK8N6/pi/5PXcyZKHDt
         DQZUE41XFyAGdh5ZWOUhVhAs/yCY7AoXoVDSLwzCGJmWsxBJ/s2g+vVbfWdkUIKOhvk3
         pWjEW09QIqG2/fW/aH5iXTg3UdHe/EkIErUckUkUSNbki3vdScXxcnCSMrdlVU2SJyqh
         lQR4W888d186zntgjp9IlHEeoItZJvah3GceG6ugzrfJbkpCuTLWKDeO92wKUVLDA6lW
         cFcbF41VQdSC0F/EjE6BZ1+X60FNMGIZ+La95hbSeSGxvtD6VaZOdFCaA9iM+a2Vc54L
         Lgzg==
X-Gm-Message-State: AOAM531C2v6/++P1bxlZAgUSVjPibfgS0j7aFY5TZIyDkzYwAcosuIrr
        GJuZXKuFnFzN0gTCrc6Lr5+GdTerxLJG2oQZAaBobLcysTErb1+augz4ugq1ClhlyMO69vV7dAw
        nppEo04yW4FctTSPf9x6zKmED
X-Received: by 2002:a17:907:daa:: with SMTP id go42mr27083718ejc.120.1619591122835;
        Tue, 27 Apr 2021 23:25:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfJKK/7NS8s2qR0C9EInsE0sUkN0nqgW1XP1hhavLbbRD2SK/F6z2RAt3f2yLMVaFqLr0UeQ==
X-Received: by 2002:a17:907:daa:: with SMTP id go42mr27083699ejc.120.1619591122628;
        Tue, 27 Apr 2021 23:25:22 -0700 (PDT)
Received: from [192.168.10.118] ([93.56.169.140])
        by smtp.gmail.com with ESMTPSA id kx3sm1264228ejc.44.2021.04.27.23.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 23:25:22 -0700 (PDT)
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210427223635.2711774-1-bgardon@google.com>
 <20210427223635.2711774-6-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5/6] KVM: x86/mmu: Protect kvm->memslots with a mutex
Message-ID: <997f9fe3-847b-8216-c629-1ad5fdd2ffae@redhat.com>
Date:   Wed, 28 Apr 2021 08:25:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210427223635.2711774-6-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/21 00:36, Ben Gardon wrote:
> +void kvm_arch_assign_memslots(struct kvm *kvm, int as_id,
> +			     struct kvm_memslots *slots)
> +{
> +	mutex_lock(&kvm->arch.memslot_assignment_lock);
> +	rcu_assign_pointer(kvm->memslots[as_id], slots);
> +	mutex_unlock(&kvm->arch.memslot_assignment_lock);
> +}

Does the assignment also needs the lock, or only the rmap allocation?  I 
would prefer the hook to be something like kvm_arch_setup_new_memslots.

(Also it is useful to have a comment somewhere explaining why the 
slots_lock does not work.  IIUC there would be a deadlock because you'd 
be taking the slots_lock inside an SRCU critical region, while usually 
the slots_lock critical section is the one that includes a 
synchronize_srcu; I should dig that up and document that ordering in 
Documentation/virt/kvm too).

Paolo

