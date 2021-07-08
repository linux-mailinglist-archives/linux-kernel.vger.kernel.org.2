Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB54D3C1715
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 18:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhGHQd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 12:33:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57641 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229469AbhGHQd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 12:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625761843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n3O76+nvGmM0mqj/tRy/JidZpIj8VUJL+4rKAr009LU=;
        b=hQ2SMJSFVBDX5kbJW+BFAmS+8L5Ai8YQmY/xtlYbYUqG3DiWfsdwto01a/yNC1etpLZ+WU
        mbUTB0VOnhQEPCfJ189XdhfveZ0Y4lSQm4aIbPvmMysbOhAptvo5EtRXqyevUalOUpKyrh
        v6KJ2BY+SpiujgL6OrwlRyICzKI7F7s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-LMsEXpenP4uxCDLskS7lEg-1; Thu, 08 Jul 2021 12:30:42 -0400
X-MC-Unique: LMsEXpenP4uxCDLskS7lEg-1
Received: by mail-ej1-f71.google.com with SMTP id 16-20020a1709063010b029037417ca2d43so2078908ejz.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 09:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n3O76+nvGmM0mqj/tRy/JidZpIj8VUJL+4rKAr009LU=;
        b=p0CnvjdkmZrpgIdZ9I4gBOtOK20gG9kFdDL3IkB5bIbQTQef5rE2JHbO+6VvBJ62va
         7QC1ufpTk4ZsVp3xJ5b1B0ocu860/phrOlO9WAJ9YfXmjltozXKr4x7g+d72Jm4hGV2T
         ZMRwxyMtCPtWc9cAGLHq/LAjxcBnrKYTj7V48wKzBN2iGeyeQpVwvAOAhxvqRpvd8nPj
         6k0ZjYFuERP8Fi//qLIRff/U/1rObfDa23WoK+NFe+TI9PhOtQfrDXhCyfQAj6HxFP0r
         tG5XgnnV8OhwutpnrZ9dySE4lK97izC+4I2PnhUWMkXqYKeOdVcmH/9Tn5YACiNVtYnc
         DpZg==
X-Gm-Message-State: AOAM53097KqKJOIQVFU1WaFR/1U7OVQq6gYzs1tZtY18RayWfILKNawy
        N/RDUcdAxakWyWG7mO6W/BI0i6ITO6AmXNgaQKPQliveaUF9yIIHHozhDJZ4DMJrnzExtO8FHNp
        yb8VGXnHGanM+Wt4ZC1dv8DQf
X-Received: by 2002:a05:6402:5203:: with SMTP id s3mr32864308edd.353.1625761841459;
        Thu, 08 Jul 2021 09:30:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyasSg+PY1RAPaYCFiCyAbI/uYXfdvuQUyEoZ6VHLFFAVFYbfTsHADOeVyRlOHkyrlbVl+wdQ==
X-Received: by 2002:a05:6402:5203:: with SMTP id s3mr32864280edd.353.1625761841267;
        Thu, 08 Jul 2021 09:30:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id dd24sm1532844edb.45.2021.07.08.09.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 09:30:40 -0700 (PDT)
Subject: Re: [PATCH 0/2] KVM: SVM: Final C-bit fixes?
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Gonda <pgonda@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210625020354.431829-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e406b31f-64bd-eb88-51bb-dd534719fb6e@redhat.com>
Date:   Thu, 8 Jul 2021 18:30:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625020354.431829-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/21 04:03, Sean Christopherson wrote:
> Patch 01 reverts the C-bit truncation patch as the reserved #PF was
> confirmed to be due to a magic HyperTransport region (how many magic
> addresses are there!?!).  Hopefully the original patch simply be dropped,
> but just in case...
> 
> Patch 02 reverts the C-bit clearing in the #NPF handler.  If that somehow
> turns out to be incorrect, i.e. there are flows where the CPU doesn't
> mask off the C-bit, then it can be conditional on a SEV guest.
> 
> I'll be offline for the next two weeks, fingers crossed I've undone all
> the damage.  :-)
> 
> Thanks!
> 
> Sean Christopherson (2):
>    Revert "KVM: x86: Truncate reported guest MAXPHYADDR to C-bit if SEV
>      is supported"
>    KVM: SVM: Revert clearing of C-bit on GPA in #NPF handler
> 
>   arch/x86/kvm/cpuid.c   | 11 -----------
>   arch/x86/kvm/svm/svm.c | 39 +++++++++------------------------------
>   arch/x86/kvm/x86.c     |  3 ---
>   arch/x86/kvm/x86.h     |  1 -
>   4 files changed, 9 insertions(+), 45 deletions(-)
> 

Queued, thanks.

Paolo

