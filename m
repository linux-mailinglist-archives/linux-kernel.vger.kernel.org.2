Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8CE4379A7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbhJVPOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:14:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21386 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233189AbhJVPOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634915507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WKiggae/426DturMbr/QSmFYLXEnY75fix64qeEqrqM=;
        b=Q06cubTl1w9QOGr8RA+qcn1RVNS0RaTUtFdfSjLXgeiVPYxGROrmNMWeb0lTAvpBd5CL6B
        gTx3+8G86N6QUjU/CUTZVvgnDm8T6oG5NFmVpa4maXFhCMjYAOpxCBzY+z4PXT+gMjCAEO
        dArrf1JPS+O3PgCBhwaJV+PfGuDR63U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-U6kj2MjyNay7fz5tYRcO8Q-1; Fri, 22 Oct 2021 11:11:43 -0400
X-MC-Unique: U6kj2MjyNay7fz5tYRcO8Q-1
Received: by mail-ed1-f69.google.com with SMTP id g6-20020a056402424600b003dd2b85563bso1308836edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 08:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WKiggae/426DturMbr/QSmFYLXEnY75fix64qeEqrqM=;
        b=Wsh7OaJa2D0/ZvZeqwKLi9aExNO7EvkubXbenMPLwgQLXOsY5lPE2ru3WX+PNXd/Bl
         tj6Wy3lNMgZZ4gxq37PMjgIb+4omqaXfS2MssusV2sbF+GIoKS28UqNtoHxPQtOUgjQH
         GYVXho9tlgdHixRKxQjdeYSJ7NwYXDudabOy7mVi4kZvRLywUDwfa8i+yEMKCuhsZ+fd
         8uVuT7LhGwd20/8Vtj9qLTerNtIKDVg6THZEjIFLHJ7IXFsc0ekHDLkRD9PcwgRD3SCt
         cmu4YOmmnModc5Ut+Ty4fKcVygTHrv26jMSMvKGDhvdHzEVy6/F3BEUDNRrWR1EidNHP
         coyg==
X-Gm-Message-State: AOAM531Fz5v1D19RbaDgwnzXzB48iEHRfOapnJGk2PrljCDj8FDnwF4b
        ly5/dRlwUpf0lX7L5iebWDLnGkf83MZPdCvAO8Ta37l1AnKr0gP0HAoeSHxxSOSpwVTfnx1oWgu
        V21l96byz9cR4whj4NctfkXpe
X-Received: by 2002:a17:906:7fd8:: with SMTP id r24mr238502ejs.80.1634915502303;
        Fri, 22 Oct 2021 08:11:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGXnOInftvuDRU3p7mAky5KKD18JBW8HqABTWuYZgHNmIhjubVpfsk1MkAGluhEzkPC1yOeQ==
X-Received: by 2002:a17:906:7fd8:: with SMTP id r24mr238475ejs.80.1634915502059;
        Fri, 22 Oct 2021 08:11:42 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id rv25sm3918677ejb.21.2021.10.22.08.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 08:11:41 -0700 (PDT)
Message-ID: <b4f98a3a-40e4-7a27-f240-54ed4874f154@redhat.com>
Date:   Fri, 22 Oct 2021 17:11:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 0/3] KVM: x86/mmu: Clean up kvm_zap_gfn_range()
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
        Ben Gardon <bgardon@google.com>
References: <20211022010005.1454978-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211022010005.1454978-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/21 03:00, Sean Christopherson wrote:
> Fix overzealous flushing in kvm_zap_gfn_range(), and clean up the mess
> that it's become by extracting the legacy MMU logic to a separate
> helper.
> 
> Sean Christopherson (3):
>    KVM: x86/mmu: Drop a redundant, broken remote TLB flush
>    KVM: x86/mmu: Drop a redundant remote TLB flush in kvm_zap_gfn_range()
>    KVM: x86/mmu: Extract zapping of rmaps for gfn range to separate
>      helper

Queued, with Cc: stable for patch 1.  (The other two patches depend on 
it, so I don't feel like including it in 5.15-rc).

Paolo

