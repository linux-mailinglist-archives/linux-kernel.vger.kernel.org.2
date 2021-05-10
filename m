Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24709379610
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhEJRhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbhEJRg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:36:28 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F56C061231
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 10:30:27 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2so24560990lft.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 10:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VWGUpuUFEiRwS6iEGwvYVeEnSLAfGX83FWm14bOadMQ=;
        b=TryB5+5sCOw2p2JHDUFly6UFDPRMsWS1H2xS5cgcZ3qF4inIUjDfTRahdlci8khE8A
         vz8vU7LSssup2VmHDa2WFLFTGuHSbuijyjDAvp9Ca9d5m/O0j9UlcXbz9/2ZkB47E0zG
         LkUk86g5q0FucZtowbq6B8WA4FvdWESEyTHtJEpPil541JKffXO58kIuaml1l/9WuZQb
         f3Zaf8f9ds4hMRjdFLmdZ8bgP2a8Ne3ZrEKEPh4MxfODfSsEhNsD6jieZs/krJhjylKx
         86aTdMKJIxQuioORt2Z8NwNFZoZP0s6M4LQ5iN929RYBfzYz7pGa0IBQw40NrgYA8up7
         /ZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VWGUpuUFEiRwS6iEGwvYVeEnSLAfGX83FWm14bOadMQ=;
        b=AQNAu/RbYOEHCMvM9XfRo1KHbwoenAd6Lp7V9FAdGAzKiJLKBCa2tzPOfupxEIKVLH
         5SS7Hc/47EBYYHHECWB2dt5hWX4bYmjWVP+jBQBPEUjuQ3RXmkrhOq8N2exXxE2v8BsX
         TCAvN4kbwoRTGRdn3dkqRujVQ+s7U3IkC04ZJoKe8+2meEKXFbO701N5FKgWkK/G5SaX
         WN2o/ns3tr8XzA7CwzfU1UF/AtPhfpPJwVTZ7Jf3PikF4qRLF32E0PAwrjBtbx+WJloO
         WW/9jl5HctdL2ZHKeQhE/kVHwxQ6NXpvQhUyxoWiDTRDq9EEGarBLaPtrz2EcMAmO8ZB
         hVBg==
X-Gm-Message-State: AOAM533JlBzMOPF2LdYW+yj6IZUeI3UiCNlZQwEasGVO5XXFRJmpH/fh
        RwkawDqizUuk2QJhHJaaDGt8C7FYI6M/prv6Yy6n3g==
X-Google-Smtp-Source: ABdhPJxiX95gH4ekENcRKooOjRHwORcRSYGwvXl6F0iPJKYVM1J+AG3el7/DWgEhG9Uo793ClAuoc+XxKze/1Gre5qE=
X-Received: by 2002:a05:6512:1084:: with SMTP id j4mr3698207lfg.423.1620667826078;
 Mon, 10 May 2021 10:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210430123822.13825-1-brijesh.singh@amd.com> <20210430123822.13825-33-brijesh.singh@amd.com>
In-Reply-To: <20210430123822.13825-33-brijesh.singh@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Mon, 10 May 2021 11:30:14 -0600
Message-ID: <CAMkAt6oYhRmqsKzDev3V5yMMePAR7ZzpEDRLadKhhCrb9Fq2=g@mail.gmail.com>
Subject: Re: [PATCH Part2 RFC v2 32/37] KVM: SVM: Add support to handle MSR
 based Page State Change VMGEXIT
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        kvm list <kvm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, jroedel@suse.de,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Rientjes <rientjes@google.com>,
        Sean Christopherson <seanjc@google.com>, peterz@infradead.org,
        "H. Peter Anvin" <hpa@zytor.com>, tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int snp_make_page_shared(struct kvm_vcpu *vcpu, gpa_t gpa, kvm_pfn_t pfn, int level)
> +{
> +       struct rmpupdate val;
> +       int rc, rmp_level;
> +       struct rmpentry *e;
> +
> +       e = snp_lookup_page_in_rmptable(pfn_to_page(pfn), &rmp_level);
> +       if (!e)
> +               return -EINVAL;
> +
> +       if (!rmpentry_assigned(e))
> +               return 0;
> +
> +       /* Log if the entry is validated */
> +       if (rmpentry_validated(e))
> +               pr_debug_ratelimited("Remove RMP entry for a validated gpa 0x%llx\n", gpa);
> +
> +       /*
> +        * Is the page part of an existing 2M RMP entry ? Split the 2MB into multiple
> +        * of 4K-page before making the memory shared.
> +        */
> +       if ((level == PG_LEVEL_4K) && (rmp_level == PG_LEVEL_2M)) {
> +               rc = snp_rmptable_psmash(vcpu, pfn);
> +               if (rc)
> +                       return rc;
> +       }
> +
> +       memset(&val, 0, sizeof(val));
> +       val.pagesize = X86_TO_RMP_PG_LEVEL(level);

This is slightly different from Rev 2.00 of the GHCB spec. This
defaults to 2MB page sizes, when the spec says the only valid settings
for level are 0 -> 4k pages or 1 -> 2MB pages. Should this enforce the
same strictness as the spec?

> +       return rmpupdate(pfn_to_page(pfn), &val);
> +}
> +
> +static int snp_make_page_private(struct kvm_vcpu *vcpu, gpa_t gpa, kvm_pfn_t pfn, int level)
> +{
> +       struct kvm_sev_info *sev = &to_kvm_svm(vcpu->kvm)->sev_info;
> +       struct rmpupdate val;
> +       struct rmpentry *e;
> +       int rmp_level;
> +
> +       e = snp_lookup_page_in_rmptable(pfn_to_page(pfn), &rmp_level);
> +       if (!e)
> +               return -EINVAL;
> +
> +       /* Log if the entry is validated */
> +       if (rmpentry_validated(e))
> +               pr_err_ratelimited("Asked to make a pre-validated gpa %llx private\n", gpa);
> +
> +       memset(&val, 0, sizeof(val));
> +       val.gpa = gpa;
> +       val.asid = sev->asid;
> +       val.pagesize = X86_TO_RMP_PG_LEVEL(level);

Same comment as above.

> +       val.assigned = true;
> +
> +       return rmpupdate(pfn_to_page(pfn), &val);
> +}
