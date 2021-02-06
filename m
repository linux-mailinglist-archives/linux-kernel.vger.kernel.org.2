Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A67D311908
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 03:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhBFCx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 21:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhBFCfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:35:41 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB63C08EE20
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 16:13:04 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id n10so5659783pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 16:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3gRTKh6ImIBqQGsQL+QoYKSXz0Ojnm2JgYPA7s+gs/0=;
        b=Cz0Rbou6R2GfMkFcHRTSj91dNPzf4snQdMPb3lVCZg0aSdWFga6SQV+mrMoeqeFeZA
         JXn3/+w23rL+7j+JlO2JYIOQOjvYWqENSH5xsKl5bGJvsgITKvTn4Hv6obQYApdcn7q6
         72KKMCNvq7RZXLFdEFwedrzBiQGbnlMsdW5tzgIcD1gj83pyAE/O0JrWLBrxefqa9Cx+
         2g34QVQ73UcIvzwUzsuKFI69dM0RXA9Fv51Tvpt6CJSguuem6H3YuysJriTkSSQ3K6wx
         idVeJcs+BATmC41tPlRZ3dUSKiUZGGZcd1q15QM3t1Y6P0g73gxfA0O+VlPeIP6Xe+cE
         ekEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3gRTKh6ImIBqQGsQL+QoYKSXz0Ojnm2JgYPA7s+gs/0=;
        b=cpaqt9tqaSzB6CMdUQFNVLQV6jboOq35X2jZIRAtnA+p4jOqWDG6wbJG4qUQU/+rYe
         j8SenXKGReluLP6t5GMwrhTx0ixW3/mofTBSzHBaWbrS09SLEEkm+SZj1oXo9ZpSLUlL
         TMs7BYMJm333y2FOZ0NNNBCPTSndlh2RAi6OUypXJIUzjwQnwBHVpTUJr+V2KzHjQORL
         DaksDjfjoCXw9SMB1IS4STc13JZN163bVBDJYS/Tz6fMcMtOBYpIzs0lx2BWT5rS326U
         ieu6OshY+BzS8RvfIeUV7gs4MhQa6ABvEcdylkWFiC5mao0uyIDRsGOETeJ93z+aL7/l
         JM1A==
X-Gm-Message-State: AOAM532ooCo3eXNWO9BITGrRCBQH6C8S+uXE0JqcFrfNoe+6qQyrY08m
        +9sfedm4VFNo2plpAFBfs2K+uA==
X-Google-Smtp-Source: ABdhPJziJQ2M+f24DSt9+DWu8gxxbl93d+hjLo80R4gAsZRVzR02Wc/FWamcEw0pcYYDENcE1T14Mw==
X-Received: by 2002:aa7:87d9:0:b029:1b7:1c6c:56e0 with SMTP id i25-20020aa787d90000b02901b71c6c56e0mr6604785pfo.25.1612570383996;
        Fri, 05 Feb 2021 16:13:03 -0800 (PST)
Received: from google.com ([2620:15c:f:10:d169:a9f7:513:e5])
        by smtp.gmail.com with ESMTPSA id s13sm5957080pgq.40.2021.02.05.16.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 16:13:03 -0800 (PST)
Date:   Fri, 5 Feb 2021 16:12:56 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ben Gardon <bgardon@google.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Subject: Re: [PATCH v2 23/28] KVM: x86/mmu: Allow parallel page faults for
 the TDP MMU
Message-ID: <YB3fCO+QOXaR2Kcj@google.com>
References: <20210202185734.1680553-1-bgardon@google.com>
 <20210202185734.1680553-24-bgardon@google.com>
 <d2c4ae90-1e60-23ed-4bda-24cf88db04c9@redhat.com>
 <CANgfPd-ELyPrn5z0N+o8R6Ci=O25XF+EDU-HDGgvVXGV7uF-dQ@mail.gmail.com>
 <39751a29-3a47-a108-f626-8abf0008ea09@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39751a29-3a47-a108-f626-8abf0008ea09@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021, Paolo Bonzini wrote:
> On 03/02/21 18:46, Ben Gardon wrote:
> > enum kvm_mmu_lock_mode lock_mode =
> > get_mmu_lock_mode_for_root(vcpu->kvm, vcpu->arch.mmu->root_hpa);
> > ....
> > kvm_mmu_lock_for_mode(lock_mode);
> > 
> > Not sure if either of those are actually clearer, but the latter
> > trends in the direction the RCF took, having an enum to capture
> > read/write and whether or not yo yield in a lock mode parameter.
> 
> Could be a possibility.  Also:
> 
> enum kvm_mmu_lock_mode lock_mode =
>   kvm_mmu_lock_for_root(vcpu->kvm, vcpu->arch.mmu->root_hpa);
> 
> kvm_mmu_unlock(vcpu->kvm, lock_mode);
> 
> Anyway it can be done on top.

Maybe go with a literal name, unless we expect additional usage?  E.g. 
kvm_mmu_(un)lock_for_page_fault() isn't terrible.

I'm not a fan of the kvm_mmu_lock_for_root() variants.  "for_root" doesn't have
an obvious connection to the page fault handler or to the read/shared mode of
the TDP.  But, the name is also specific enough to pique my curiosity and make
me wonder what's it's doing.
