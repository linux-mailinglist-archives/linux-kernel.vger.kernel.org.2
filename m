Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44E83761F8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 10:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbhEGI3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 04:29:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39926 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236218AbhEGI3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 04:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620376114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2EtsHTWG0I945KmFB2rvkJ4C7JnZYKjnyrdpp2fnzKI=;
        b=fvTIL1Z3QDkm2RhwLHYUksiXz/9ci24ADiDSY9sX4z87RdfMddbzwAzQAG7AjWhI0eSTZE
        6D1hz2bQRbtQAE7UfkoAmHsHzxbHj5qATa7et3SOypHuihFGJK8QQE6AwSKkike+dsWqib
        4e03uSTy8N+TGXv8pNzdrKK4WIMMs+g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-9xAI6RUPMGqG1tubrlK0sg-1; Fri, 07 May 2021 04:28:32 -0400
X-MC-Unique: 9xAI6RUPMGqG1tubrlK0sg-1
Received: by mail-wr1-f72.google.com with SMTP id l2-20020adf9f020000b029010d6bb7f1cbso3265570wrf.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 01:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2EtsHTWG0I945KmFB2rvkJ4C7JnZYKjnyrdpp2fnzKI=;
        b=fiNrwN623ASj9JEK6n4vqPczHSNsdPQJ1pcKVxveddCVWUT5pE7xqcQuolQqyT6AXA
         k9dIlxnFdpvabPnELS9B3g0Qx0xATnQRYbBldFiTmO0hW3yzfCdW87xdiKRPuKFjFbvj
         vaTavQi3+Nfxfa08B+G9bSlR3vNM2RDgcPNI0DpqH8kx+aghGPGiM4qPIB/YlBLqUA3s
         1BB2EvIFKAGqDpU1HfoxQia2i0Ufk0Z0699uvLcqmcweBvnaD2qr/IWs1gBY9JUlagUP
         FSOr7IW+skYygTkdBfA0/phfamxzTKiT602xD/j53PiOqWYO3wbhg+pDBKE1DEz9npYs
         X/Jg==
X-Gm-Message-State: AOAM532S2Gf0Nxf0+1/z7X7331gm86ojPNRUYQvnqIAALjlvo3vmxeNu
        4q2+T7KcLaTRWfiUsUSZI5GmM74F7eZFavROiIxVLxP0pu38mqLncd+rl7G7f24Y1LvdXeIMAiw
        UaLWF8IBoUvVOmyY8IylAEIh0
X-Received: by 2002:a1c:4e06:: with SMTP id g6mr8566103wmh.30.1620376111671;
        Fri, 07 May 2021 01:28:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7DglUp/7+aIhLhSphLrJcy6WZJYfjkEbPnKZcfDzBYJtlkC3FZlonDpDwsI35pPuGY73A3A==
X-Received: by 2002:a1c:4e06:: with SMTP id g6mr8566077wmh.30.1620376111514;
        Fri, 07 May 2021 01:28:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id l21sm12474008wme.10.2021.05.07.01.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 01:28:30 -0700 (PDT)
Subject: Re: [PATCH v3 5/8] KVM: x86/mmu: Add a field to control memslot rmap
 allocation
To:     Ben Gardon <bgardon@google.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
References: <20210506184241.618958-1-bgardon@google.com>
 <20210506184241.618958-6-bgardon@google.com>
 <CANgfPd-eJsHRYARTa0tm4EUVQyXvdQxGQfGfj=qLi5vkLTG6pw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a12eaa7e-f422-d8f4-e024-492aa038a398@redhat.com>
Date:   Fri, 7 May 2021 10:28:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CANgfPd-eJsHRYARTa0tm4EUVQyXvdQxGQfGfj=qLi5vkLTG6pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/21 01:44, Ben Gardon wrote:
>>   struct kvm_vm_stat {
>> @@ -1853,4 +1859,6 @@ static inline int kvm_cpu_get_apicid(int mps_cpu)
>>
>>   int kvm_cpu_dirty_log_size(void);
>>
>> +inline bool kvm_memslots_have_rmaps(struct kvm *kvm);
> Woops, this shouldn't be marked inline as it creates build problems
> for the next patch with some configs.
> 

Possibly stupid (or at least lazy) question: why can't it be a "normal" 
static inline function?

Paolo

