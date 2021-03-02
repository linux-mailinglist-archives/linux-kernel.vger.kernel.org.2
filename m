Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA72832AD08
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837335AbhCBVTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244199AbhCBS06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:26:58 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0FAC061797
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 10:17:55 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id l7so10138871pfd.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 10:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xjoxtDeZVJmNWTGHn0H0lCFPaR4VqFxzOXXzxPha6EE=;
        b=rhf3oxsfGGo53nh4GOrvv+Y0oL6pgnfzdfDpSwL7grZyiEvJt5I8RnPJS5gLORMQB0
         tRi7n2bU9MDbNOfjCGBZkGIxHX6BEDDZIy2lDJYe8a1Tm1roXPMLfVn0AOeWh8LZeZeU
         FqWXR1qCpf4FZiIQaY5P2nzD1yAKZaB9Uz+eDvyM/DJ8zlkRRaaQfYAopSSW/tPdEp1Q
         22RfhArWksh0wudozmgGGspI4Y5Xovj21C16DjDxn2UQSJPfFbYD0FczMShFUuKe5zzZ
         v5KMNSX/rRFjJZ80FDpwSg3GNJcrcVIGQiAqVHhe86EohH18ykIYcMmy1+kzLFGSShj7
         xTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xjoxtDeZVJmNWTGHn0H0lCFPaR4VqFxzOXXzxPha6EE=;
        b=ERi14X/5Ya4H22IxBvbrMrkyPfBHB2sUCnHnZ4apB2ARXBBiac/BUYVVkwsyDYqETd
         LzHQMubSJMzt5iuNqbJjGqIXGlOmE8n0o3oDJImiD7R+id/Zc38LAw3cl8CsNHC/QSX7
         DeOWkI9lI2pfWQDwX/8mYNm/8ZRPWc9uLa00Qu+SapPq5YuViJWl04CyPpSbbqPnlk/0
         U9Um037/kOjJrK2deAkSAyRYmjBvVVFSEPxZrnd6OVMVbbCPrDEjXl0XdGjAbM2+XWbl
         c3YAzmI6QT2h4Mu3+/IuYIsgi0NvCIxQvW6XjNUgF2wxxHjj4ufMX4FCSAvB1Gdwuvat
         dhkA==
X-Gm-Message-State: AOAM533M53zkLzoIXDr9pzh9K2IpU4roTWdWC8DZbll/cunIyQXDxPC2
        sBA9mM3jweLK25IjLImQ1mXoCg==
X-Google-Smtp-Source: ABdhPJyir8Hi4ETXFhsFfHVZO9TJ7tP2YR7BNYQHcZZJV1WrhVCyOwHfDk/SeDwYG/5ICfDidf0ZYw==
X-Received: by 2002:aa7:948d:0:b029:1ed:a489:dd7a with SMTP id z13-20020aa7948d0000b02901eda489dd7amr4446965pfk.29.1614709074340;
        Tue, 02 Mar 2021 10:17:54 -0800 (PST)
Received: from google.com ([2620:15c:f:10:805d:6324:3372:6183])
        by smtp.gmail.com with ESMTPSA id o127sm21816244pfg.202.2021.03.02.10.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 10:17:53 -0800 (PST)
Date:   Tue, 2 Mar 2021 10:17:47 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 0/2] KVM: x86: Emulate L2 triple fault without killing L1
Message-ID: <YD6BS0PR/+d6iC5Q@google.com>
References: <20210302174515.2812275-1-seanjc@google.com>
 <04aa253c-9708-d707-3ee9-7595da4029ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04aa253c-9708-d707-3ee9-7595da4029ad@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021, Paolo Bonzini wrote:
> On 02/03/21 18:45, Sean Christopherson wrote:
> > If KVM (L0) intercepts #GP, but L1 does not, then L2 can kill L1 by
> > triggering triple fault.  On both VMX and SVM, if the CPU hits a fault
> > while vectoring an injected #DF (or I supposed any #DF), any intercept
> > from the hypervisor takes priority over triple fault.  #PF is unlikely to
> > be intercepted by L0 but not L1.  The bigger problem is #GP, which is
> > intercepted on both VMX and SVM if enable_vmware_backdoor=1, and is also
> > now intercepted for the lovely VMRUN/VMLOAD/VMSAVE errata.
> > 
> > Based on kvm/queue, commit fe5f0041c026 ("KVM/SVM: Move vmenter.S exception
> > fixups out of line").  x86.c and svm/nested.c conflict with kvm/master.
> > They are minor and straighforward, but let me know if you want me to post
> > a version based on kvm/master for easier inclusion into 5.12.
> 
> I think it would be too intrusive.  Let's stick this in 5.13 only.

Hmm, agreed, especially since most of the paths are not properly tested.  In
that case, probably best to also drop stable@kernel.org?
