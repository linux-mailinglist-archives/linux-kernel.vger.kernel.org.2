Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18869352A4E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 13:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhDBLnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 07:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21956 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235204AbhDBLnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 07:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617363802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cYQHtPyS3K3kSwaJScXUV//33d808h8hffQsTIn7SxE=;
        b=BDkUo82hVntY9i9p+BRmrqO4eGsgp3bGHzZJuD5GrosEV8A+ExlIpKS8ih4P8eCk0S5s0n
        orERUiSrqJGrpksyI2LKR3Ev5yQvom0NazKEB6TaQSOF0jGF35gFuRwV+lsdwLRTNFrPdS
        cwbqB6UPT5A/D9NW6yZrNInr0PNZ8I8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-xekmM11MMdaoTBkR4pdDEQ-1; Fri, 02 Apr 2021 07:43:20 -0400
X-MC-Unique: xekmM11MMdaoTBkR4pdDEQ-1
Received: by mail-wr1-f71.google.com with SMTP id z17so4239723wrv.23
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 04:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cYQHtPyS3K3kSwaJScXUV//33d808h8hffQsTIn7SxE=;
        b=OBSZmGtGlkw9drDOc8V/dFR8/FVvvZXotw5i/lx5dE2VlX0mEHus8klV1GtNGfKUKb
         /1vD5R5Sq53Az6n2KZTSjnKBR6fmjqTOZRbp4Bwt1XRr2LsPM9f2h0hHzZk/+2Bgz4qR
         D7jm1DYCyxXAGrvMbi8T6CzqZwWPN43kP6ozhvDf/z2wfT/iKH73F9Q13quhIBes4IEF
         mNDAoOnT156nygopw2fXhPsA5hHJ8nUW7U9pHO2d4XJ+qVZoBmWNhiXMOcwgJq6iElvg
         npRAHhDGvn1y+6tlxAnuOkmgkP2pGKbQitVsOX/tP3L93Mtkz7LfzvCJIJIGeYK+HIZx
         4L6A==
X-Gm-Message-State: AOAM5306EvNZWvT4Nx3iHsOH4LvwJC+XxZcxF3US01Vu4dQXizx8cfrd
        i33BZloQtDue17DwdR2TDL8qGemChWxAUDQMdx25KArDcpmYxp9nbV+I+6D9RFmhtuHk6isgsMM
        V/EynOsA8MDIxTOeUvoslJROE
X-Received: by 2002:adf:8b45:: with SMTP id v5mr14689032wra.398.1617363799180;
        Fri, 02 Apr 2021 04:43:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwq4MTSyDihujFb6AqsRqg7LJPRX15XNFuThX5DURKh5bPitEB8MFZuROHgTc2qGTt6NCLg0A==
X-Received: by 2002:adf:8b45:: with SMTP id v5mr14689002wra.398.1617363798953;
        Fri, 02 Apr 2021 04:43:18 -0700 (PDT)
Received: from [192.168.10.118] ([93.56.169.140])
        by smtp.gmail.com with ESMTPSA id r10sm14348648wmh.45.2021.04.02.04.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 04:43:18 -0700 (PDT)
Subject: Re: [PATCH v2 00/13] More parallel operations for the TDP MMU
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210401233736.638171-1-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c630df18-c1af-8ece-37d2-3db5dc18ecc8@redhat.com>
Date:   Fri, 2 Apr 2021 13:43:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210401233736.638171-1-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/21 01:37, Ben Gardon wrote:
> Now that the TDP MMU is able to handle page faults in parallel, it's a
> relatively small change to expand to other operations. This series allows
> zapping a range of GFNs, reclaiming collapsible SPTEs (when disabling
> dirty logging), and enabling dirty logging to all happen under the MMU
> lock in read mode.
> 
> This is partly a cleanup + rewrite of the last few patches of the parallel
> page faults series. I've incorporated feedback from Sean and Paolo, but
> the patches have changed so much that I'm sending this as a separate
> series.
> 
> Ran kvm-unit-tests + selftests on an SMP kernel + Intel Skylake, with the
> TDP MMU enabled and disabled. This series introduces no new failures or
> warnings.
> 
> I know this will conflict horribly with the patches from Sean's series
> which were just queued, and I'll send a v2 to fix those conflicts +
> address any feedback on this v1.
> 
> Changelog
> v2:
> --	Rebased patches on top of kvm/queue to incorporate Sean's recent
> 	TLB flushing changes
> --	Dropped patch 5: "KVM: x86/mmu: comment for_each_tdp_mmu_root
> 	requires MMU write lock" as the following patch to protect the roots
> 	list with RCU adds lockdep which makes the comment somewhat redundant.
> 
> Ben Gardon (13):
>    KVM: x86/mmu: Re-add const qualifier in
>      kvm_tdp_mmu_zap_collapsible_sptes
>    KVM: x86/mmu: Move kvm_mmu_(get|put)_root to TDP MMU
>    KVM: x86/mmu: use tdp_mmu_free_sp to free roots
>    KVM: x86/mmu: Merge TDP MMU put and free root
>    KVM: x86/mmu: Refactor yield safe root iterator
>    KVM: x86/mmu: Make TDP MMU root refcount atomic
>    KVM: x86/mmu: handle cmpxchg failure in kvm_tdp_mmu_get_root
>    KVM: x86/mmu: Protect the tdp_mmu_roots list with RCU
>    KVM: x86/mmu: Allow zap gfn range to operate under the mmu read lock
>    KVM: x86/mmu: Allow zapping collapsible SPTEs to use MMU read lock
>    KVM: x86/mmu: Allow enabling / disabling dirty logging under MMU read
>      lock
>    KVM: x86/mmu: Fast invalidation for TDP MMU
>    KVM: x86/mmu: Tear down roots in fast invalidation thread
> 
>   arch/x86/include/asm/kvm_host.h |  21 +-
>   arch/x86/kvm/mmu/mmu.c          | 115 +++++++---
>   arch/x86/kvm/mmu/mmu_internal.h |  27 +--
>   arch/x86/kvm/mmu/tdp_mmu.c      | 375 +++++++++++++++++++++++---------
>   arch/x86/kvm/mmu/tdp_mmu.h      |  28 ++-
>   include/linux/kvm_host.h        |   2 +-
>   6 files changed, 407 insertions(+), 161 deletions(-)
> 

Applied to kvm/mmu-notifier-queue, thanks.

Paolo

