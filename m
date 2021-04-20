Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E891E36624D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 00:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbhDTWuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 18:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbhDTWu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 18:50:27 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88D2C06138A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 15:49:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id e9so3526964plj.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 15:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ic6FjpwF7Xkken8Ucx4Nz5LmHL8W+41sn4P8VJGP+wc=;
        b=aK2BXN/BPPPOJpibk2BHop24spCwPzrHBgRDyrjmi1tjX8XsTjPo+VjM39WZfdICJ0
         d+nAtMGMeRs6BOcVk6wVKQhq/9yG/pEIg/g7BoteEVK/uIYCJEM/U3Xq34YzX4xcA4hD
         6S93GcMhZTD0kFqMqGY3vQMTCzSmhEzw+esCDVzfK/pcYjdvIKd/UUBRCM3oiZBVze1C
         mCtd1cYnhCBF8hMDTl3NNtFosBWzn7Yb0JdCu/DS4tlmEHNWXnqgfTkRd0+wn9EI263o
         4FsnZonWEjGTGGY3AZx/xyO5iGBkRd0SFRf7jiYsH1VJH/blq3+0Iysao8CNsTgzIIuO
         5CLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ic6FjpwF7Xkken8Ucx4Nz5LmHL8W+41sn4P8VJGP+wc=;
        b=Tqn7TLFO1oehGLB1xcmfs1H4C6l3cgHfZ2V1JtO0e30EPlDfSz6TUio6+uXhrpMvw5
         CtDiuW9ezYWbuQo4i1eOvdRvcUIp4k3p9jvVqxEtYs7zcUCS7X2FVR+eoz3JZK8Jz0xI
         Wn7//l1A6C6x2iJwErc1gYQ4KChfhoMDVmXe0g3tpBP5zVWmb3h8lzmVEOGlAYc0sInW
         cBzXgfzgabkYUO0f1VvaXhm/5MP4RVNwlz/zaADB81cszl39xjvTCyTOsd7geidy8o8q
         rjds6xaMptqzFUDU6aUy0YYQQa19xPOuqIA3Iy77Vd+0jS36KiWyHTqsOKCP5vky0PRa
         Wc5Q==
X-Gm-Message-State: AOAM530TbMhOfaFIFIkghlxEI8FoWUIns5CpIuOxbLx0jezoJ5s7/p8n
        c6PMI0uAnxpUTdta+GchB58JNg==
X-Google-Smtp-Source: ABdhPJxT4DSy53GVLbTVm97xMLTVN9yrt8J5z+8aTz8CmULKJqpiw5yYwB1O5xa315bwx8ieM5qbjw==
X-Received: by 2002:a17:903:310d:b029:eb:1fd1:1b6d with SMTP id w13-20020a170903310db02900eb1fd11b6dmr30111148plc.46.1618958995172;
        Tue, 20 Apr 2021 15:49:55 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id i62sm76194pfc.162.2021.04.20.15.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 15:49:54 -0700 (PDT)
Date:   Tue, 20 Apr 2021 22:49:51 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        srutherford@google.com, joro@8bytes.org, brijesh.singh@amd.com,
        thomas.lendacky@amd.com, venu.busireddy@oracle.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH 0/3] KVM: x86: guest interface for SEV live migration
Message-ID: <YH9aj8FLQ4z4Po/x@google.com>
References: <20210420112006.741541-1-pbonzini@redhat.com>
 <YH8P26OibEfxvJAu@google.com>
 <05129de6-c8d9-de94-89e7-6257197433ef@redhat.com>
 <YH8lMTMzfD7KugRg@google.com>
 <YH82qgTLCKUoSyNa@google.com>
 <4b96c4fc-23a4-0bd2-ea58-fa6d81e50b15@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b96c4fc-23a4-0bd2-ea58-fa6d81e50b15@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021, Paolo Bonzini wrote:
> On 20/04/21 22:16, Sean Christopherson wrote:
> > On Tue, Apr 20, 2021, Sean Christopherson wrote:
> > > On Tue, Apr 20, 2021, Paolo Bonzini wrote:
> > > > In this particular case, if userspace sets the bit in CPUID2 but doesn't
> > > > handle KVM_EXIT_HYPERCALL, the guest will probably trigger some kind of
> > > > assertion failure as soon as it invokes the HC_PAGE_ENC_STATUS hypercall.
> > 
> > Oh!  Almost forgot my hail mary idea.  Instead of a new capability, can we
> > reject the hypercall if userspace has _not_ set KVM_CAP_ENFORCE_PV_FEATURE_CPUID?
> > 
> > 			if (vcpu->arch.pv_cpuid.enforce &&
> > 			    !guest_pv_has(vcpu, KVM_FEATURE_HC_PAGE_ENC_STATUS)
> > 				break;
> 
> Couldn't userspace enable that capability and _still_ copy the supported
> CPUID blindly to the guest CPUID, without supporting the hypercall?

Yes.  I was going to argue that we get to define the behavior, but that's not
true because it would break existing VMMs that blindly copy.  Capability it is...
