Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647593CEAB1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 20:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376841AbhGSRQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347301AbhGSPjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:39:25 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCC9C0533A0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 08:30:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c12so4639522wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 08:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lqk2jkzthWLyzhPPwl9UElGn40y2Dt6x0oKXE1RM9g8=;
        b=jI3en6+L35OGQjtiyLEBUmVWVLufhxwq/1aOfwuDJV44bcq1jbW0DRpXwwWlYvSdMk
         e4Xm3XmGv35SIVRFvfDV0Fdm1m0G59WRs/JZYelzbtxZfeEOv0+E2rKlGbQ1frzNzc76
         fXzvmTXp+dnZBCwUIz5YNwPAkhnsQdXVRzQKoZsBp43fwvrYi9RgXPvTk1n7ltpWSPVQ
         IZp88OIXUDGh7cL1PTzzyxgcCC1TNFv7J2WYENBPUFn78VP+iJbtcr9SZZkNqNjdndnk
         FQG0OmlrWdFs0XoRXmu2H2p3Dl+9wpibmflX0a+iE/KQ2XvTufMt3nNZvVUNv9GRNHov
         34sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lqk2jkzthWLyzhPPwl9UElGn40y2Dt6x0oKXE1RM9g8=;
        b=Y1XBrNGCQR0abYOiqUzr/21hPVRhUfnmqE3gan2HkGovcGO9BKTFMj1RAiqC9x2ZPb
         Hck39rMDhSJJDToO33IxL8PmJuhXLK2SoYPca0UviYrPe/obyv+sZN9G+w2wLyATaG7M
         KzVXO2ZjIxgQPIIANO1Lf9kbs0cKiRM/U0ZLhlk3FGIetHcexHJMFYVfo0d8l+GgSUUq
         SghQLa+kHwJBOgr/Mh3WOY/UGskajQEQb6Gs9ZH4N4WyHGsOmUKVivDl640OT3T/7wwu
         ILtp18/l/8PpsloXRZNfmOpzGq88TX01PUcsZgd9BhqK46kmqwOHaAhutQ+eCsaRv3ma
         fT2A==
X-Gm-Message-State: AOAM530EJhDcg9gitbwdOf5c+eAZ7xMOqoiSBYVkgvJDekhJEsgjUs+y
        JaR8NVOhOywnA99hD/C9XZKspg==
X-Google-Smtp-Source: ABdhPJxpNsB2RMnrXBTt9Gp1trnlhrfx+X5PhpEBH6aIheVp4g43w00+TxDIiSELO95IVAOEFTQhhA==
X-Received: by 2002:adf:a41e:: with SMTP id d30mr30429082wra.10.1626710221588;
        Mon, 19 Jul 2021 08:57:01 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:83e0:11ac:c870:2b97])
        by smtp.gmail.com with ESMTPSA id w16sm6652930wru.58.2021.07.19.08.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 08:57:01 -0700 (PDT)
Date:   Mon, 19 Jul 2021 16:56:57 +0100
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com
Subject: Re: [PATCH 09/14] KVM: arm64: Mark host bss and rodata section as
 shared
Message-ID: <YPWgyS7i2sMtiX8S@google.com>
References: <20210719104735.3681732-1-qperret@google.com>
 <20210719104735.3681732-10-qperret@google.com>
 <87eebujqjv.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eebujqjv.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 Jul 2021 at 16:01:40 (+0100), Marc Zyngier wrote:
> On Mon, 19 Jul 2021 11:47:30 +0100,
> Quentin Perret <qperret@google.com> wrote:
> > +static int finalize_mappings(void)
> > +{
> > +	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_RWX;
> > +	int ret;
> > +
> > +	/*
> > +	 * The host's .bss and .rodata sections are now conceptually owned by
> > +	 * the hypervisor, so mark them as 'borrowed' in the host stage-2. We
> > +	 * can safely use host_stage2_idmap_locked() at this point since the
> > +	 * host stage-2 has not been enabled yet.
> > +	 */
> > +	prot |= KVM_PGTABLE_STATE_SHARED | KVM_PGTABLE_STATE_BORROWED;
> > +	ret = host_stage2_idmap_locked(__hyp_pa(__start_rodata),
> > +				       __hyp_pa(__end_rodata), prot);
> 
> Do we really want to map the rodata section as RWX?

I know, feels odd, but for now I think so. The host is obviously
welcome to restrict things in its stage-1, but for stage-2, this is
just 'memory' so far, the host is allowed to patch it if it wants too.

Eventually, yes, I think we should make it RO in the host stage-2, but
maybe that's for another series?

> > +	if (ret)
> > +		return ret;
> > +
> > +	return host_stage2_idmap_locked(__hyp_pa(__hyp_bss_end),
> > +					__hyp_pa(__bss_stop), prot);
> 
> If the 'locked' state implies SHARED+BORROWED, maybe consider moving
> the ORRing of the prot into host_stage2_idmap_locked()?

Ah no, sorry for the confusion, but 'locked' means that we already hold
the pgtable lock. That is not actually true here, but this is a special
case as only the current CPU can be messing with it at this point in
time so taking the lock would just be wasted cycles.

> > +}
> > +
> >  void __noreturn __pkvm_init_finalise(void)
> >  {
> >  	struct kvm_host_data *host_data = this_cpu_ptr(&kvm_host_data);
> > @@ -167,6 +199,10 @@ void __noreturn __pkvm_init_finalise(void)
> >  	if (ret)
> >  		goto out;
> >  
> > +	ret = finalize_mappings();
> > +	if (ret)
> > +		goto out;
> > +
> >  	pkvm_pgtable_mm_ops = (struct kvm_pgtable_mm_ops) {
> >  		.zalloc_page = hyp_zalloc_hyp_page,
> >  		.phys_to_virt = hyp_phys_to_virt,

Thanks,
Quentin
