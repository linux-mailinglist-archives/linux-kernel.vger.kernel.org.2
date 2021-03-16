Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B3A33DC63
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbhCPSRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:17:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24922 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236022AbhCPSQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615918612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rWvC3plWxRUcrq0wECmuV30Rqwzs1WlHNCdPKpsOEDg=;
        b=bvp8OtNSIYFOe6W11diCLTs+405fTImwpwvsMlbLYu+SG2XwcQXq4Ni7lPovqsQb9Eo0Vl
        y4mrz9odklcOQJA7eBmcmY67X+qc4oe+TDUxHIh7NnsupE5TXeuvDl2BrCifQK8ix6XPEB
        YQt7hbXLQDNgpaVViKqNrDiJFKQ3PsM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-Co6JRF0ZNTq3_YiJIgbC9A-1; Tue, 16 Mar 2021 14:16:49 -0400
X-MC-Unique: Co6JRF0ZNTq3_YiJIgbC9A-1
Received: by mail-wr1-f69.google.com with SMTP id h21so16923263wrc.19
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rWvC3plWxRUcrq0wECmuV30Rqwzs1WlHNCdPKpsOEDg=;
        b=FtUu0Bqah43hcOcoUrGGHcOkizNvJIfwd+ZEtm31ucTgde7M5JAjbT9JoAHux5HOhx
         V1VWbfxqRFYlLA9S64lKKQLHdfoU46yV4iCTDiMLJVAVpspdBf8klSf6yUkVOAr+exUY
         0gniqo/VIZruERlQqMX/k10zUrEiYxL28OO9VDbMQh/MFrrSW+ZMgScvxYSEDzOnBEB5
         nGgGaY7pTij+Q3yFl4U55jrLwoPHeXs7cGs48cyGLeyzPFw4l/cu5m/y6DVRyGqoB9ek
         4nWiO4MWtkZgI7xz8qABHodopmK0qYQ3hgA/DLrgecEg4MJDHv6vr2y0uh+4CjVyZeKT
         SsFA==
X-Gm-Message-State: AOAM5313H4o10DE7xeIugewckfxySxcSHnn42evvBszRr0otQl9pOsqu
        36/GIlxeyXywV4dblUhiBhEozbk1Cws3FLgi8+ush2fcMnVRW7Y3eKLtROZ8fq3IiL6p+Sys7kS
        CPWm6Kt877INO2bksqMTXlUL8
X-Received: by 2002:a5d:58ce:: with SMTP id o14mr369715wrf.4.1615918608479;
        Tue, 16 Mar 2021 11:16:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYoG+t52TxYVDOkJgWCB+uFgojkq4p3glPLifuvRtEpvSPpFLQps7WXsAkJ7+8ZJoRrt1lPw==
X-Received: by 2002:a5d:58ce:: with SMTP id o14mr369695wrf.4.1615918608272;
        Tue, 16 Mar 2021 11:16:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id s3sm22977552wrt.93.2021.03.16.11.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 11:16:47 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] Fix RCU warnings in TDP MMU
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Jim Mattson <jmattson@google.com>
References: <20210315233803.2706477-1-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1b03ae88-2b5c-5806-1cac-0e44a2395d0c@redhat.com>
Date:   Tue, 16 Mar 2021 19:16:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210315233803.2706477-1-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/21 00:37, Ben Gardon wrote:
> The Linux Test Robot found a few RCU warnings in the TDP MMU:
> https://www.spinics.net/lists/kernel/msg3845500.html
> https://www.spinics.net/lists/kernel/msg3845521.html
> 
> Fix these warnings and cleanup a hack in tdp_mmu_iter_cond_resched.
> 
> Tested by compiling as suggested in the test robot report and confirmed
> that the warnings go away with this series applied. Also ran
> kvm-unit-tests on an Intel Skylake machine with the TDP MMU enabled and
> confirmed that the series introduced no new failures.
> 
> Ben Gardon (3):
>    KVM: x86/mmu: Fix RCU usage in handle_removed_tdp_mmu_page
>    KVM: x86/mmu: Fix RCU usage when atomically zapping SPTEs
>    KVM: x86/mmu: Factor out tdp_iter_return_to_root
> 
> Sean Christopherson (1):
>    KVM: x86/mmu: Store the address space ID in the TDP iterator
> 
>   arch/x86/kvm/mmu/mmu_internal.h |  5 +++++
>   arch/x86/kvm/mmu/tdp_iter.c     | 30 +++++++++++++++----------
>   arch/x86/kvm/mmu/tdp_iter.h     |  4 +++-
>   arch/x86/kvm/mmu/tdp_mmu.c      | 40 +++++++++++++--------------------
>   4 files changed, 41 insertions(+), 38 deletions(-)
> 

Queued, thanks.

Paolo

