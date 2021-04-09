Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA69935A387
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbhDIQie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbhDIQic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:38:32 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D85C061761
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 09:38:19 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id i190so4575448pfc.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 09:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GEH6ahek62aXY8iXScAwAVfTv8FrDuewq6fR1FVMQO8=;
        b=D1yFVy+LagHtHJAaz6Nq5mGOTpW/BL/vGsFvNliDBdxurJeU+SofsOb+XOkxPk1Dh9
         1712P6c3SmC44mcGJbkLyxo5wsnRmaknoP2pjnNpIuCwxIr1BgeuztCuJjbl9XY8Cucb
         m7gzrUJpyk5nT/GPS8zUf6cosW4htpylaC7gBi44deo4spgx+gVOROp1T+nEPQfKqQ/O
         G714feR20gYAkRJm1CudfDNSs8GJGWXbaEFVIKNdmIxF3eHteEbFoVfjVzSpsvpEto17
         s3mwusCkv2Z5N5ynVYNpFIKa+XvuJgSE6iah+KUijbagQTETG7lO3t73RwPJwAqcOgn/
         HCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GEH6ahek62aXY8iXScAwAVfTv8FrDuewq6fR1FVMQO8=;
        b=gjTSF2d4aTZU/LXDrf2JPnbztSqySbFu+7/rrxIzOxvIx/LiHIDulyCYaGHmCsBkKn
         vfEkCLQUFNHW/AmPvGEwofeiCP0NwcV47QIHa0bgkU96sAbyoXziFdlD8FG9mhoVusyY
         aPd/V9J4MRxaOKwrbB8z7+ViAMyzfnE1Pf3vDAGxGfDvT+sCrykpUIObzz6RXeYzApF+
         P5A6dLq8e2UTfB/cUK3KUco9MxosmTsWTAHnKXMZOFfFzJm74fr1x5Bfr8MdMOx7n2tG
         1N5ZBFkS676aiI9+zEAMr9/AgqEcIyDjHq6/eb2B2XGRtRJ7MH1+uHRQA8eqAxRM8Atv
         E/3w==
X-Gm-Message-State: AOAM531cw/sHVE1N37T116toS7bhR9zRNoHbzCZMlutUppXricltFN0J
        QoLS7EpGVCvCGf+HXh58ow1wZQ==
X-Google-Smtp-Source: ABdhPJw3Z8mbp4u+laHeW2sw15LZTArD7zhNmsSeqYL4VWJv/2AfSosiUpL3ZHLJ/9aNLSdjAvDhuw==
X-Received: by 2002:aa7:82ce:0:b029:242:deb4:9442 with SMTP id f14-20020aa782ce0000b0290242deb49442mr11941205pfn.73.1617986299273;
        Fri, 09 Apr 2021 09:38:19 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id h1sm2598442pfc.122.2021.04.09.09.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:38:18 -0700 (PDT)
Date:   Fri, 9 Apr 2021 16:38:14 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH v3] KVM: SVM: Make sure GHCB is mapped before updating
Message-ID: <YHCC9h2huV/2eixO@google.com>
References: <a5d3ebb600a91170fc88599d5a575452b3e31036.1617979121.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5d3ebb600a91170fc88599d5a575452b3e31036.1617979121.git.thomas.lendacky@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021, Tom Lendacky wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Access to the GHCB is mainly in the VMGEXIT path and it is known that the
> GHCB will be mapped. But there are two paths where it is possible the GHCB
> might not be mapped.
> 
> The sev_vcpu_deliver_sipi_vector() routine will update the GHCB to inform
> the caller of the AP Reset Hold NAE event that a SIPI has been delivered.
> However, if a SIPI is performed without a corresponding AP Reset Hold,
> then the GHCB might not be mapped (depending on the previous VMEXIT),
> which will result in a NULL pointer dereference.
> 
> The svm_complete_emulated_msr() routine will update the GHCB to inform
> the caller of a RDMSR/WRMSR operation about any errors. While it is likely
> that the GHCB will be mapped in this situation, add a safe guard
> in this path to be certain a NULL pointer dereference is not encountered.
> 
> Fixes: f1c6366e3043 ("KVM: SVM: Add required changes to support intercepts under SEV-ES")
> Fixes: 647daca25d24 ("KVM: SVM: Add support for booting APs in an SEV-ES guest")
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> 
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
