Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133F833D466
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhCPMzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbhCPMx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:53:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FC1C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 05:53:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x16so7384307wrn.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 05:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YhH9qDZ7UYlwG27TDzW+MnA+T1mgb+aVZ+2GGb51p/w=;
        b=TIM3a2FTxwFa4dUcd5GxP31tl7wKFqCYuHW1RCSsYGdx7PfVWPHK4rzncWHc1Wi7o/
         d2c3Bkjb6IsOlZBuk6rn54lnPctO+Kra4AXoGrH+tT7zTPwClbOKbkcQ9wbb+rGcmK3R
         HUv2leFtOacjysyoAyc9t7BDaMfJ4EoYue76wFoHsTLkgUWeXl3xaHcENikgGzeEy2QY
         2AZ211B1x7jPAMLqwIUBhegCNV14sv6beMz36g1/kzF9w2L1N5tTi2BNhRJlm8CoN6hW
         YRmJP03BcUurDZRpbei0PZIRVONf2SXSbDMfZVUktwxp5jFGb+cUr/XXkKviaSfLxp2l
         a+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YhH9qDZ7UYlwG27TDzW+MnA+T1mgb+aVZ+2GGb51p/w=;
        b=bOBHUXNQFJSnKZTQXIWxj00kvKrZRJ+bDakrcx1n6KOXGHlv66vaT/jrNNMVcWOK0V
         /dFMPP6b7rXnwtfNiju7zBU1bRIQMkreuS7qx+Uwu58y4k88w6ae5E2l4y1qish3xLbg
         zSNuxPqZ/5oqNbFWnK+YPuNxijPhIVsjNZppYyGDyMLk0af0fZFHBm1z2rr9y7jBFxBv
         Q2ekFzTjI8uheQWNl4a2hEelujEMnll1HSYYGH/RSHeEh8YJ+4cuvk7XpiSA8Q44y561
         Qde8jrr/fnAu29cDOuDSLdWejDLMexmY+wMWt7ad7PzmZAJKLuVDe9J4/ptCax7bOMyV
         K1lg==
X-Gm-Message-State: AOAM533MxvRuOdagX/AQ97GzymH3SPUexXhbR4Ugd3zzS2VKXydPidU+
        goY5ttQpEZSmR107ZMGrJGJ+oQ==
X-Google-Smtp-Source: ABdhPJxGSb04ZRPkSOl7qX8cOElBY2c0oVdgp7I4wyUE4jKYntg8bGYi4e+uakNSKN8b4ZKHwnBiBg==
X-Received: by 2002:adf:fe48:: with SMTP id m8mr4694101wrs.135.1615899235994;
        Tue, 16 Mar 2021 05:53:55 -0700 (PDT)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id b186sm3074930wmc.44.2021.03.16.05.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 05:53:55 -0700 (PDT)
Date:   Tue, 16 Mar 2021 12:53:53 +0000
From:   Quentin Perret <qperret@google.com>
To:     Mate Toth-Pal <mate.toth-pal@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, android-kvm@google.com, seanjc@google.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com
Subject: Re: [PATCH v5 33/36] KVM: arm64: Wrap the host with a stage 2
Message-ID: <YFCqYT3Ib8kAN7/c@google.com>
References: <20210315143536.214621-1-qperret@google.com>
 <20210315143536.214621-34-qperret@google.com>
 <ec9df9a4-a419-089c-469f-1a1509597dd9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec9df9a4-a419-089c-469f-1a1509597dd9@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 Mar 2021 at 13:28:42 (+0100), Mate Toth-Pal wrote:
> Testing the latest version of the patchset, we seem to have found another
> thing related to FEAT_S2FWB.

Argh! I wish I could put my hands on hardware with FWB. Thanks again for
the report.

> This function always sets Normal memory in the stage 2 table, even if the
> address in stage 1 was mapped as a device memory. However with the current
> settings for normal memory (i.e. MT_S2_FWB_NORMAL being defined to 6)
> according to the architecture (See Arm ARM, 'D5.5.5 Stage 2 memory region
> type and cacheability attributes when FEAT_S2FWB is implemented') the
> resulting attributes will be 'Normal Write-Back' even if the stage 1 mapping
> sets device memory. Accessing device memory mapped like this causes an
> SError on some platforms with FEAT_S2FWB being implemented.

Right.

> Changing the value of MT_S2_FWB_NORMAL to 7 would change this behavior, and
> the resulting memory type would be device.

Sounds like the correct fix here -- see below.

> Another solution would be to add an else branch to the last 'if' above like
> this:
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index fffa432ce3eb..54e5d3b0b2e1 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -214,6 +214,8 @@ static int host_stage2_idmap(u64 addr)
> 
>         if (is_memory)
>                 prot |= KVM_PGTABLE_PROT_X;
> +       else
> +               prot |= KVM_PGTABLE_PROT_DEVICE;
> 
>         hyp_spin_lock(&host_kvm.lock);
>         ret = kvm_pgtable_stage2_find_range(&host_kvm.pgt, addr, prot,
> &range);

While this would work in this particular case, I don't think we should
force all non-RAM accesses as device as the host may have reasons not to
want this (e.g. accessing SRAM). Your first suggestions allows us to do
just that, so it is preferable I think.

Thanks,
Quentin
