Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6700D403196
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 01:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347000AbhIGXim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 19:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhIGXil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 19:38:41 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ADAC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 16:37:34 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so164256pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 16:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nPlOnObV+7IafwUpE6JONJNl4l7ItG2KBzqpYLFaSDI=;
        b=lWWLU21jXgpKCcMeJzCV3mM/lYIHHadbLLphHrMJR6nzn7nm2hNVFSLmcqJrNG0Qwp
         bnQJJAnfVzg4zo6YOeHON52TeqlHsw4Drj7PZIScPVABqqMLRnlfAftu1J/nOHlphYj3
         AENC5G+npvkCsN1bC0NYqOLRePIIGmz8Pxxyf0H97Uv+0AczlJ/j16ADKk8nSSo3x2XE
         Fp+NPLlky2UtHIBoZTqz/epUy8trKjNxNlGpcO6mK9eHXkHosjfqo7Cd9489Jra2zIGc
         NwjhHFqBdWRHvkCEQ7h3diyH+2pgz1UtjgxZH8dM/hWQVsztbBSbJyOYj6nsjCjDD0Jm
         6X1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nPlOnObV+7IafwUpE6JONJNl4l7ItG2KBzqpYLFaSDI=;
        b=Es5caBbiwTG+cS8BszF8lf3tWVorQ2xj2Qzco1W4sh+xHJIYzw5+OZutlh+WEEjcxU
         VFF9GrDGF9WTGjoRI3fINZ1UJKUFVyLZ0uZcXpJi7Z04A4H0mFBGK70kDVoRmrPneJoh
         sOFiFjYuA99/Q+/gLQlf+0nYmskMALiFbBdFlDiHChBiKAy1RY9rfTvGXkLeKxNf5w3y
         m6Mqpg+jpDlsobth+IeR4awsdNGa81FszLsHRu7BL2rmPooFsU34r8mqs/DO9pAtimI5
         mWRoMejK/udoyuYfJg0un6+ZRdgmRnp0/idfBKys/N0BfJwXPHutMdpMXwaRYoRcbzko
         QDbQ==
X-Gm-Message-State: AOAM532NrI611pZCoTVUUqFikcXAHMM0qdymxf9c/EW/98RAT+OO4xRf
        p0tg/Q4p4BqEzl2b3LW0MJ2WUQ==
X-Google-Smtp-Source: ABdhPJyJqG6oPEYS1iJvCqYIi+YU5oYd8fIoUn5t6j6xhWDd2stQtnMMncIdKYaRCEKIlXO024qe8Q==
X-Received: by 2002:a17:90a:192:: with SMTP id 18mr945730pjc.119.1631057853662;
        Tue, 07 Sep 2021 16:37:33 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b13sm146800pjk.35.2021.09.07.16.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 16:37:32 -0700 (PDT)
Date:   Tue, 7 Sep 2021 23:37:29 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Mingwei Zhang <mizhang@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
Message-ID: <YTf3udAv1TZzW+xA@google.com>
References: <20210818053908.1907051-1-mizhang@google.com>
 <20210818053908.1907051-4-mizhang@google.com>
 <YTJ5wjNShaHlDVAp@google.com>
 <fcb83a85-8150-9617-01e6-c6bcc249c485@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcb83a85-8150-9617-01e6-c6bcc249c485@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021, Brijesh Singh wrote:
> 
> On 9/3/21 2:38 PM, Sean Christopherson wrote:
> > My personal preference is obviously to work towards an abstracted API.  And if
> > we decide to go that route, I think we should be much more aggressive with respect
> > to what is abstracted.   Many of the functions will be rather gross due to the
> > sheer number of params, but I think the end result will be a net positive in terms
> > of readability and separation of concerns.
> > 
> > E.g. get KVM looking like this
> > 
> > static int sev_receive_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
> > {
> > 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> > 	struct kvm_sev_receive_start params;
> > 	int ret;
> > 
> > 	if (!sev_guest(kvm))
> > 		return -ENOTTY;
> > 
> > 	/* Get parameter from the userspace */
> > 	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data,
> > 			sizeof(struct kvm_sev_receive_start)))
> > 		return -EFAULT;
> > 
> > 	ret = sev_guest_receive_start(argp->sev_fd, &arpg->error, sev->asid,
> > 				      &params.handle, params.policy,
> > 				      params.pdh_uaddr, params.pdh_len,
> > 				      params.session_uaddr, params.session_len);
> > 	if (ret)
> > 		return ret;
> > 
> > 	/* Copy params back to user even on failure, e.g. for error info. */
> > 	if (copy_to_user((void __user *)(uintptr_t)argp->data,
> > 			 &params, sizeof(struct kvm_sev_receive_start)))
> > 		return -EFAULT;
> > 
> >      	sev->handle = params.handle;
> > 	sev->fd = argp->sev_fd;
> > 	return 0;
> > }
> > 
> 
> I have no strong preference for either of the abstraction approaches. The
> sheer number of argument can also make some folks wonder whether such
> abstraction makes it easy to read. e.g send-start may need up to 11.

Yeah, that's brutal, but IMO having a few ugly functions is an acceptable cost if
it means the rest of the API is cleaner.  E.g. KVM is not the right place to
implement sev_deactivate_lock, as any coincident DEACTIVATE will be problematic.
The current code "works" because KVM is the only in-tree user, but even that's a
bit of a grey area because sev_guest_deactivate() is exported.

If large param lists are problematic, one idea would be to reuse the sev_data_*
structs for the API.  I still don't like the idea of exposing those structs
outside of the PSP driver, and the potential user vs. kernel pointer confusion
is more than a bit ugly.  On the other hand it's not exactly secret info,
e.g. KVM's UAPI structs are already excrutiatingly close to sev_data_* structs.

For future ioctls(), KVM could even define UAPI structs that are bit-for-bit
compatible with the hardware structs.  That would allow KVM to copy userspace's
data directly into a "struct sev_data_*" and simply require the handle and any
other KVM-defined params to be zero.  KVM could then hand the whole struct over
to the PSP driver for processing.

We can even do a direct copy to sev_data* with KVM's current UAPI by swapping
fields as necessary, e.g. swap policy<->handle before and after send-start, but
that's all kinds of gross and probably not a net positive.
