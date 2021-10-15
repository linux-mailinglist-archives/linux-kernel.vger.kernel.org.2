Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0100C42F85A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241365AbhJOQip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236948AbhJOQic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:38:32 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A53DC061768
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:36:21 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c4so6726950pls.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bNuTjMh21ZDjBhYohz0NUqfViUN9CkYGywP8rKjYXXQ=;
        b=srByqXdaiZB1vx5JOLc2pqo7KYtDXrCyqsP9LUwM20nGG0hXX+GFBs3ibK3fZ2+6P6
         qkv3rQS+7lMejdN0xsWovm8h2tnF/wQVk60r80WOndc1nvVXg/cq4T07kzO7WKFO/nyq
         E+FOY4FM0BCjaO4JJFS1JH6Cxkeo88jB5KiZ9YRzmPkoSMC6dHtC6Qifd6gVxOg907B8
         y5Sirgcz+UMrlKro0+KDG6EnNIKzRUr51p9o7mAC4bR1oVMgr9kxYiFcGg97gdZ+NJu0
         bpeZB7b1gMSFDXypYVAjTMprbxvmAw8h9M2ECooguHaKT6gEfWBpnrKZNjT7XfGzpyKd
         ZeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bNuTjMh21ZDjBhYohz0NUqfViUN9CkYGywP8rKjYXXQ=;
        b=VUTTk0j7biji5NQafpn7u8iabfStXeTWZrkvHz2uEQZEZR9yZeW3C2CeH9RaGIPR+Q
         qxeNcSbd/5YfSzWw+awLQyPPWB1jv3XjErV5fucXdMwTM0HAdX1c1X2IaCL7DU3DJyFB
         e6TdsFEyBdspmBCTnQ1TvoBTkUl16ag6XgzKJkuWVXKdCgrK6JBoTrSz+I53XsQilg6c
         dnMFeHJc94TM1F9JNZJA1JMDOTYMsTLURnDRbkqOuk/RaIfWN0XafDRtAa+BPRxfk+sK
         lynv9V25CiGpJPSWrd3mZgbYk6GtyZyzmcZe8wi7JW9xrhyZiqn+L4KxxP7VPyjgVPcr
         khBg==
X-Gm-Message-State: AOAM5312Be0zpf5S7Gvv+ps0BvicKD+jSxqq1vIyuRzZ8YkIlcjehuPA
        zjrzC8G/3yO564WnwVQKV6NYwQ==
X-Google-Smtp-Source: ABdhPJzHa77Mqwcb/UXTiiWN+F7q/weAnzXN+ZDwNq5zIfaSRjShl+af95vFZNzbpUq3Twu/Aujk5g==
X-Received: by 2002:a17:90a:191a:: with SMTP id 26mr15092301pjg.79.1634315780283;
        Fri, 15 Oct 2021 09:36:20 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id a3sm6094427pfv.174.2021.10.15.09.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:36:18 -0700 (PDT)
Date:   Fri, 15 Oct 2021 16:36:12 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] KVM: x86: Fix and cleanup for recent AVIC changes
Message-ID: <YWmt/A4pemf2050j@google.com>
References: <20211009010135.4031460-1-seanjc@google.com>
 <9e9e91149ab4fa114543b69eaf493f84d2f33ce2.camel@redhat.com>
 <YWRJwZF1toUuyBdC@google.com>
 <YWRtHmAUaKcbWEzH@google.com>
 <ebf038b7b242dd19aba1e4adb6f4ef2701c53748.camel@redhat.com>
 <YWmpKTk/7MOCzm15@google.com>
 <5faa7e49-9eb6-a075-982a-aa7947a5a3d6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5faa7e49-9eb6-a075-982a-aa7947a5a3d6@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021, Paolo Bonzini wrote:
> On 15/10/21 18:15, Sean Christopherson wrote:
> > > 
> > >                                          - now vCPU1 finally starts running the page fault code.
> > > 
> > >                                          - vCPU1 AVIC is still enabled
> > >                                            (because vCPU1 never handled KVM_REQ_APICV_UPDATE),
> > >                                            so the page fault code will populate the SPTE.
> > But vCPU1 won't install the SPTE if it loses the race to acquire mmu_lock, because
> > kvm_zap_gfn_range() bumps the notifier sequence and so vCPU1 will retry the fault.
> > If vCPU1 wins the race, i.e. sees the same sequence number, then the zap is
> > guaranteed to find the newly-installed SPTE.
> > 
> > And IMO, retrying is the desired behavior.  Installing a SPTE based on the global
> > state works, but it's all kinds of weird to knowingly take an action the directly
> > contradicts the current vCPU state.
> 
> I think both of you are correct. :)
> 
> Installing a SPTE based on global state is weird because this is a vCPU
> action; installing it based on vCPU state is weird because it is knowingly
> out of date.

If that's the argument, then kvm_faultin_page() should explicitly check for a
pending KVM_REQ_APICV_UPDATE, because I would then argue that contuining on when
KVM _knows_ its new SPTE will either get zapped (page fault wins the race) or
will get rejected (kvm_zap_gfn_range() wins the race) is just as wrong.  The SPTE
_cannot_ be used even if the page fault wins the race, becuase all vCPUs need to
process KVM_REQ_APICV_UPDATE and thus will be blocked until the initiating vCPU
zaps the range and drops the APICv lock.

And I personally do _not_ want to add a check for the request because it implies
the check is sufficient, which it is not, because the page fault doesn't yet hold
mmu_lock.

Since all answers are some form of wrong, IMO we should at least be coherent with
respect to the original page fault.
