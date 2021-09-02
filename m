Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750323FF537
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347299AbhIBU6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347198AbhIBU6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:58:13 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117CEC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 13:57:15 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id f129so3306748pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 13:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AKvoBglyKyX6FOVMBLB/URNeY80PWCKE3Lo+SAFXI3k=;
        b=I0126LUhSD04CPCw4NfU0xi6Grfk2wjNYQRqWhZ2iOjuKglbP3AD/1E2rxglR4eqNc
         DdX3w8JzqQQH3hNWFfvTPXXjh2+dFfbeO4FA6jCRnlTCTjMeF2NpPBumA3HEr0NrUdxf
         S0DkZDKDTD3ejQMUECTQNJO8OHQhjM3R33UV68hmzRwCApTNPwt+XBesICvcgmKy+uO2
         I3PyHC2gE0qNX6iNXg0+5XhUPuJSKAIiG5L700Ho3x/W/1j1mr0SY++iz+nLz2vYjnZ3
         ytFh15AkqwWicUz1FlSAPt6vWCeIrjsSHPFXb6RYhApDX/a93eOR2oNaSdqJ9P+BFRHW
         5TYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AKvoBglyKyX6FOVMBLB/URNeY80PWCKE3Lo+SAFXI3k=;
        b=NJLl/JXhdMy+jDtSNNInnQYqyIRTU8admZsOTRWMuGABmQ3AU1Ac/KM/JWoozwl5C3
         rxEo8pOoFOSTwmdQj21LI3rgOUerpB1I8Kvod5iWy5ASim8ytSv3tJpTYdegZdaEy0FP
         jD3qxVLBKEfJC5MJ1WewoCpPfRC1VP+Vdx4vGbWRN1KFCMP8s3EPCsiXa57MnDlFVly6
         6UPgAbQbKlL0s2d6BnqmcaMDRlwu7Ox1yUqGQuBPh6fnTtn2qrxvsHpGFmIbWAfwLsvF
         5MGrQethz53uzG53F4QCELj2L3qlipBNUqJe7wxtShPqWVZCq8ncnCv84a5s6Gmz4rkJ
         YtuQ==
X-Gm-Message-State: AOAM530tZv64yHMTyleQvxeFV/ZLdBn5zyeBaorI2YdqPFyQnumFLSut
        ncn5NrUEBwhZa03CDf8poCUVlw==
X-Google-Smtp-Source: ABdhPJxzTD7xp5K/i9sHGH587GJ8tZkJXnLGOqiJwoNVv8Rls8D2cm5udFmcc86bB3yp/lT+Rd2yLA==
X-Received: by 2002:a63:4917:: with SMTP id w23mr271248pga.344.1630616234252;
        Thu, 02 Sep 2021 13:57:14 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id x16sm3647924pgc.49.2021.09.02.13.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 13:57:13 -0700 (PDT)
Date:   Thu, 2 Sep 2021 20:57:10 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/8] KVM: x86: hyper-v: Avoid calling
 kvm_make_vcpus_request_mask() with vcpu_mask==NULL
Message-ID: <YTE6pk22mslvIDr6@google.com>
References: <20210827092516.1027264-1-vkuznets@redhat.com>
 <20210827092516.1027264-4-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827092516.1027264-4-vkuznets@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021, Vitaly Kuznetsov wrote:
> In preparation to making kvm_make_vcpus_request_mask() use for_each_set_bit()
> switch kvm_hv_flush_tlb() to calling kvm_make_all_cpus_request() for 'all cpus'
> case.
> 
> Note: kvm_make_all_cpus_request() (unlike kvm_make_vcpus_request_mask())
> currently dynamically allocates cpumask on each call and this is suboptimal.
> Both kvm_make_all_cpus_request() and kvm_make_vcpus_request_mask() are
> going to be switched to using pre-allocated per-cpu masks.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
