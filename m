Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFDD4005EF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 21:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349865AbhICTju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 15:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349852AbhICTjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 15:39:47 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ACEC061764
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 12:38:47 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so250078pjr.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 12:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qzhaz9XxDSm1ugGQAic1jSV4h3dO1CWRqJG/Wa1eKqo=;
        b=Q4g8O/XPm2u0b/cy1Hw89zcNMj9oiX+bRd+8mJDYqYQ8LqTxTaTrNWdtwP4bLcnUkU
         eMWjtXHzk5yzQKvQBZz1g+zzocaHQ9MQmA8qY4buy+vaNmp5diQC16nhwre2uxT+p8vV
         JaPlc6nRsTMCMhGj/qmDvfSk+tKUB6VvKpq9Gv4jj25FmVwK/Bdzgw/LlzdZO6aAJQv5
         f1EqIV23Wb6apk3n3WO4d0Tzr00atX0sfTt+1Q6zmCti6z/NPft5/mzAJJpR+1wmv7ml
         Q385PdhiwJginqPZ/Re4d9EE91NU4GLKOycCnmXK4odaYvOj4A5XwF2/tqj8Hh6UoDX4
         Ku8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qzhaz9XxDSm1ugGQAic1jSV4h3dO1CWRqJG/Wa1eKqo=;
        b=TcKR2vK3HTHPGy8LtY423lCA4iPIj0yiJB0KgfBx3YAYX4dD1ZFxTv6gJ64fPrhGxw
         BByj/TEszaB4o8vyQ48CvRCXDqTlMpo1vTY7L66jaeiZL1pi/hJ/H/Ew2W07pKti2miK
         MGF98O6S/DL3+i/KLkaf2dqwgNbN/8DLLECaY4R6pSZGxAj7xivNHt4qPdOL/+OGB0hK
         BYSf2rPfxZG7fsQxi8PsfGVlTaZO23dXF969f7lDbRLLjE2nBiZeo/eqj7YzZOBB+w85
         jh2SLgUcnRp3DtQ9OIckhRPaTsUc5i2SBlM45W7rHnPtMepiF5PJqI+nIN1IAcX1OUNv
         NSNQ==
X-Gm-Message-State: AOAM531PFkuLqT53oS8ntutD82Mpl1fLGmjm6HOdDPQdfwL+BH+3+PrC
        angIpTM8F1fEJizNUySZSUgaQg==
X-Google-Smtp-Source: ABdhPJxAbMzCuFmt0f4TsCM6x099HH8zwapkycmIw+PDBp1H5EAVUuuq+cobTGIsNH17Vprk8NCwxQ==
X-Received: by 2002:a17:90b:4b4f:: with SMTP id mi15mr497532pjb.120.1630697926927;
        Fri, 03 Sep 2021 12:38:46 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q20sm180458pgu.31.2021.09.03.12.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 12:38:46 -0700 (PDT)
Date:   Fri, 3 Sep 2021 19:38:42 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alper Gun <alpergun@google.com>,
        Borislav Petkov <bp@alien8.de>,
        David Rienjes <rientjes@google.com>,
        Marc Orr <marcorr@google.com>, Peter Gonda <pgonda@google.com>,
        Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v2 3/4] KVM: SVM: move sev_bind_asid to psp
Message-ID: <YTJ5wjNShaHlDVAp@google.com>
References: <20210818053908.1907051-1-mizhang@google.com>
 <20210818053908.1907051-4-mizhang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818053908.1907051-4-mizhang@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021, Mingwei Zhang wrote:
> @@ -336,11 +322,9 @@ static int sev_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  		goto e_free_session;
>  
>  	/* Bind ASID to this guest */
> -	ret = sev_bind_asid(kvm, start.handle, error);
> -	if (ret) {
> -		sev_guest_decommission(start.handle, NULL);
> +	ret = sev_guest_bind_asid(sev_get_asid(kvm), start.handle, error);
> +	if (ret)
>  		goto e_free_session;
> -	}
>  
>  	/* return handle to userspace */
>  	params.handle = start.handle;

...

> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index e2d49bedc0ef..325e79360d9e 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -903,6 +903,21 @@ int sev_guest_activate(struct sev_data_activate *data, int *error)
>  }
>  EXPORT_SYMBOL_GPL(sev_guest_activate);
>  
> +int sev_guest_bind_asid(int asid, unsigned int handle, int *error)
> +{
> +	struct sev_data_activate activate;
> +	int ret;
> +
> +	/* activate ASID on the given handle */
> +	activate.handle = handle;
> +	activate.asid   = asid;
> +	ret = sev_guest_activate(&activate, error);
> +	if (ret)
> +		sev_guest_decommission(handle, NULL);

Hrm, undoing state like this is a bad API.  It assumes the caller is well-behaved,
e.g. has already done something that requires decommissioning, and it surprises
the caller, e.g. the KVM side (above) looks like it's missing error handling.
Something like this would be cleaner overall:

	/* create memory encryption context */
	ret = __sev_issue_cmd(argp->sev_fd, SEV_CMD_RECEIVE_START, &start,
				error);
	if (ret)
		goto e_free_session;

	/* Bind ASID to this guest */
	ret = sev_guest_activate(sev_get_asid(kvm), start.handle, error);
	if (ret)
		goto e_decommision;

	params.handle = start.handle;
	if (copy_to_user((void __user *)(uintptr_t)argp->data,
			 &params, sizeof(struct kvm_sev_receive_start))) {
		ret = -EFAULT;
		goto e_deactivate;
	}

    	sev->handle = start.handle;
	sev->fd = argp->sev_fd;

e_deactivate:
	sev_guest_deactivate(sev_get_asid(kvm), start.handle, error);
e_decommision:
	sev_guest_decommission(start.handle, error);
e_free_session:
	kfree(session_data);
e_free_pdh:
	kfree(pdh_data);


However, I don't know that that's a good level of abstraction, e.g. the struct
details are abstracted from KVM but the exact sequencing is not, which is odd
to say the least.

Which is a good segue into my overarching complaint about the PSP API and what
made me suggest this change in the first place.  IMO, the API exposed to KVM (and
others) is too low level, e.g. KVM is practically making direct calls to the PSP
via sev_issue_cmd_external_user().  Even the partially-abstracted helpers that
take a "struct sev_data_*" are too low level, KVM really shouldn't need to know
the hardware-defined structures for an off-CPU device.

My intent with the suggestion was to start driving toward a mostly-abstracted API
across the board, with an end goal of eliminating sev_issue_cmd_external_user()
and moving all of the sev_data* structs out of psp-sev.h and into a private
header.  However, I think we should all explicitly agree on the desired level of
abstraction before shuffling code around.

My personal preference is obviously to work towards an abstracted API.  And if
we decide to go that route, I think we should be much more aggressive with respect
to what is abstracted.   Many of the functions will be rather gross due to the
sheer number of params, but I think the end result will be a net positive in terms
of readability and separation of concerns.

E.g. get KVM looking like this

static int sev_receive_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
{
	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
	struct kvm_sev_receive_start params;
	int ret;

	if (!sev_guest(kvm))
		return -ENOTTY;

	/* Get parameter from the userspace */
	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data,
			sizeof(struct kvm_sev_receive_start)))
		return -EFAULT;

	ret = sev_guest_receive_start(argp->sev_fd, &arpg->error, sev->asid,
				      &params.handle, params.policy,
				      params.pdh_uaddr, params.pdh_len,
				      params.session_uaddr, params.session_len);
	if (ret)
		return ret;

	/* Copy params back to user even on failure, e.g. for error info. */
	if (copy_to_user((void __user *)(uintptr_t)argp->data,
			 &params, sizeof(struct kvm_sev_receive_start)))
		return -EFAULT;

    	sev->handle = params.handle;
	sev->fd = argp->sev_fd;
	return 0;
}
