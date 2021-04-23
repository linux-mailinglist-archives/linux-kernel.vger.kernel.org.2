Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D70368995
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 02:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbhDWAEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 20:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbhDWAET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 20:04:19 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF059C061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 17:03:43 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i190so32877151pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 17:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QWRme8W90t1BPTeoXEcFelQYikUvUd/HuwmVxLORM6Q=;
        b=gFBLejZmWYtwWuTbUzXrKVzwnRinJd2NDYaixKXbcMVTKTkTFJD5G29Fmaw6ukvp2g
         kiDQQ4mbkZlpkqSpolEsWqjz65mPpQLL9lGq2eDwRrSsLwSvKNRotY03yT1Ap/tPaHfm
         THy4S89Bpv6M0bNUc1JqdLBxFWELnuPQ1uhimcodJNU8zByseVj0EdUVRIKunkr/RGBB
         xhZP94F9yddMKYdyYH48PFjg/osYDJrhBB1+O/2+Qf3lIsQDE7A/qp0WvOlN+ceL+jrR
         fVWakjHTYnhrSZ7/8L4VwbmnQEJVMtVEHpKr9p+eEnb5z+NMC335lPmWT1dPoC8lC0Ty
         R4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QWRme8W90t1BPTeoXEcFelQYikUvUd/HuwmVxLORM6Q=;
        b=stMs6MohAXJ41i/RvzJ9wSw/YRoN6sn+U/wqLeMxDpSHf/OKMz1pF1qIFeiaQjmT6u
         qJcKVj7ekJR+hPZZTD12YqlQ2Z+9LeHvRkKvo4MmlowaKgdOZipAadjojNop56MOYF5F
         HKGuH+MNZA5kwGu0LLcoUD4WhV3MMD3X6ruBpE3Gmvqi+2o1wo99iTT5mAxPZAxOPt/k
         oK5YwOAGJQGcycZpDf5Ul9sodKNYcyAWTChIUmOHEPdXA/Bumd+SCqKGFsBOwxVHhYNU
         rz+0sktZRf2/fy75jgGwuykDZ4ebSr8eHj5WJoAzu2+ZwSsBp04HzSq5tcsu2kPEMLxW
         szrA==
X-Gm-Message-State: AOAM532QhrAk9oKNXZRA9WRPyGwVFzpicFM01Ew6XpTmuo3hO7zn70f/
        Dh1b/xNkD4obpPwTF7wVM+iLoQ==
X-Google-Smtp-Source: ABdhPJxEbZ7nzcHxEZ6WSTvN/ARrDhrTpdP+eAUgFOHzIyiWl+s74b+BkGvs5YUkzPirrG0+T9YwIw==
X-Received: by 2002:aa7:90d3:0:b029:241:21a1:6ffb with SMTP id k19-20020aa790d30000b029024121a16ffbmr1089728pfk.43.1619136223169;
        Thu, 22 Apr 2021 17:03:43 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id pc17sm3135335pjb.19.2021.04.22.17.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 17:03:41 -0700 (PDT)
Date:   Fri, 23 Apr 2021 00:03:31 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, joro@8bytes.org, bp@suse.de,
        thomas.lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, srutherford@google.com,
        venu.busireddy@oracle.com, brijesh.singh@amd.com
Subject: Re: [PATCH 1/4] KVM: x86: Add AMD SEV specific Hypercall3
Message-ID: <YIIO0wtHeNK6pyri@google.com>
References: <cover.1619124613.git.ashish.kalra@amd.com>
 <c33adc91aa57df258821f78224c0a2b73591423a.1619124613.git.ashish.kalra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c33adc91aa57df258821f78224c0a2b73591423a.1619124613.git.ashish.kalra@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021, Ashish Kalra wrote:
> From: Brijesh Singh <brijesh.singh@amd.com>
> 
> KVM hypercall framework relies on alternative framework to patch the
> VMCALL -> VMMCALL on AMD platform. If a hypercall is made before
> apply_alternative() is called then it defaults to VMCALL. The approach
> works fine on non SEV guest. A VMCALL would causes #UD, and hypervisor
> will be able to decode the instruction and do the right things. But
> when SEV is active, guest memory is encrypted with guest key and
> hypervisor will not be able to decode the instruction bytes.
> 
> Add SEV specific hypercall3, it unconditionally uses VMMCALL. The hypercall
> will be used by the SEV guest to notify encrypted pages to the hypervisor.

I still think we should invert the default and avoid having an SEV specific
variant of kvm_hypercall3().

https://lore.kernel.org/kvm/X8gyhCsEMf8QU9H%2F@google.com/
