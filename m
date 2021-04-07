Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF1835728A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354428AbhDGRAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347954AbhDGRAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:00:07 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894B2C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 09:59:57 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id ay2so9661177plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Qka4XP86mo9tivOZXeavKjVRjtUNs3I7vqQxIv9BF4o=;
        b=sKeG7jF4DC6TkXssMwfoL5Yb2M1BIPx0VHweK89YLof7HVvwYTDocHqwKP9iyPbezs
         eBMc5Fx/A7j66s9Pr/5DHJYgatXOlXejrVfzhzwyPWOfpEH/2OhT3qyGDFRCVxiVW5cH
         jj49DGK2wrNlvBo44yjLpWvx3KfAQktiCjCPQ54YSK0ylxusD7IiO/AmCxv9jx4Ak6Of
         g5U5BoNKlaCYQ2dMW3D2isrgvjyEw70ZJwI+I37gxZJMTvnyRRoUnWyUfbkdCitbiH/8
         R675Wd6nzsuPnsOR6DGaLMsmk3g2Nx/MQvR0+IH6P6a1YlP2TLdodzEWCrOVjV7mTr+L
         ORRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Qka4XP86mo9tivOZXeavKjVRjtUNs3I7vqQxIv9BF4o=;
        b=Y/wTFdbmxIrgSCKYQsUUKKVS3MpszOYsdpk4eK+YjDGSoyFa5mPSRUyb575Ghn5y3D
         tFYuZzxAYKmJNvVv1JfOmY0V+Zb8En2FqAkDVDLv4On7qI21hwK64O+UW12N8N1cits8
         0/MPAuV3vf/fHUgTswYES/1o+jGXD6OPwB0TPiY8TL0w06msu9Ntgkc2XYBmugK+O9ZR
         cg9wQtOaa9xjiNmNvmdDiqC0//fUj7oRnIyVpZJGMs60jzkeOoVRXUJWbjuvlV2OX3l1
         50FN1I0LaKuRLKFX87NhjdoBOfHuejwaZLZgP5o5ViMpE9cwpA2Cq3fpqAt9lkA8sAz9
         8NhA==
X-Gm-Message-State: AOAM532bTtPS6A8iYwujXGNO+6GyTSLJu2ruupPgYBTdTXSBTEsUfcEf
        P19kPlqW662T8S4QI9i3/1K2pw==
X-Google-Smtp-Source: ABdhPJwRHR+AB/msn9dCF+HMY/knTGJpePFjMSnYGVO76q0g1jJjsff5eYDRDkH7v8g1ezxKMhfgdQ==
X-Received: by 2002:a17:90a:7064:: with SMTP id f91mr4337107pjk.89.1617814796875;
        Wed, 07 Apr 2021 09:59:56 -0700 (PDT)
Received: from [2620:15c:17:3:c4a4:628a:2d06:e140] ([2620:15c:17:3:c4a4:628a:2d06:e140])
        by smtp.gmail.com with ESMTPSA id u1sm21982451pgg.11.2021.04.07.09.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 09:59:56 -0700 (PDT)
Date:   Wed, 7 Apr 2021 09:59:55 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Sean Christopherson <seanjc@google.com>
cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [PATCH v2] KVM: Explicitly use GFP_KERNEL_ACCOUNT for 'struct
 kvm_vcpu' allocations
In-Reply-To: <20210406190740.4055679-1-seanjc@google.com>
Message-ID: <bed5081-1f13-bc1e-6328-b2bb4517c54@google.com>
References: <20210406190740.4055679-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Apr 2021, Sean Christopherson wrote:

> Use GFP_KERNEL_ACCOUNT when allocating vCPUs to make it more obvious that
> that the allocations are accounted, to make it easier to audit KVM's
> allocations in the future, and to be consistent with other cache usage in
> KVM.
> 
> When using SLAB/SLUB, this is a nop as the cache itself is created with
> SLAB_ACCOUNT.
> 
> When using SLOB, there are caveats within caveats.  SLOB doesn't honor
> SLAB_ACCOUNT, so passing GFP_KERNEL_ACCOUNT will result in vCPU
> allocations now being accounted.   But, even that depends on internal
> SLOB details as SLOB will only go to the page allocator when its cache is
> depleted.  That just happens to be extremely likely for vCPUs because the
> size of kvm_vcpu is larger than the a page for almost all combinations of
> architecture and page size.  Whether or not the SLOB behavior is by
> design is unknown; it's just as likely that no SLOB users care about
> accounding and so no one has bothered to implemented support in SLOB.
> Regardless, accounting vCPU allocations will not break SLOB+KVM+cgroup
> users, if any exist.
> 
> Cc: Wanpeng Li <kernellwp@gmail.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Always happy to see this ambiguity (SLAB_ACCOUNT vs GFP_KERNEL_ACCOUNT) 
resolved for slab allocations.

Acked-by: David Rientjes <rientjes@google.com>
