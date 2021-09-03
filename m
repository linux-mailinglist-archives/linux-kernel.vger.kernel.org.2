Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5733040032E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 18:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349626AbhICQXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 12:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhICQXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:23:52 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82409C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 09:22:52 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v1so3591241plo.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 09:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U4gSKygMy1v3hSUk26JFGqP9BbnBTuwk+HivEu33xTc=;
        b=bm7C2loHcNSqICOE6wqb/YAx54Z1/y11DMtdxmquiyORFrc/3neqn9rd4VRiDZ2ufr
         7N/oaznyxExeXHZwE79WPBnEFmGZlbKwq3uY7rPAzZQkMBpAyrGNmNdrCyCPYZVNCHJm
         AkIE3oBfsFy3Y2mFSjd6Tkznx87SM6OatjAwsumOi/ENo536yi3Yi/cD5w6BZFS4YhjG
         qyn0x14Wg5qQ9Na2yapKlnJuZIQ0fV+QueDUcSIG6/uCToad5ghXVaFeONXbgDcG77aC
         ncChtPni/bnk0B3AzAYaLDEXegs7ZfqeP/Rv3Xw4sF4Wwr3mKHqX85OQOmvDmJ0CarUe
         osjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U4gSKygMy1v3hSUk26JFGqP9BbnBTuwk+HivEu33xTc=;
        b=cTbhTENE3j3xlJ6DEA0D7LxCn/Mi+hbJS3sw8pV4zZ6CtZ6gRmxLS8TkLgC1mq0Z0W
         TU6YJrrqYkGZkmFWb/5fTD9x9uUBChvEGJvO/w3fNa1/rZNHIu2QbhSSBlwIYF0Oq/EG
         eQD94HTmP9wfhnVxNEECtlOTBrxElrnQx15yh77QjNgHA152zYl8SBBI2DVT3jIr5uZ5
         juzHGVZHuimtyKvwmnUaanqh6SYCYQvg4keHymEMvSWQcBySipQU5fGCX7TPyP7pzdNU
         8n7mOeoE55Cb8xpJYwtKJHM+cgRVb+HuKdTE9HChiL0sjK0qZeqZkgU9SP0jzBUb+KK4
         TomA==
X-Gm-Message-State: AOAM531bU9kJDEl5KZQcSo2uJVJhX+o0Y23X6NV6PkYnpVswmulP52YS
        XVWtllQkvJDsm24uG+9hTIgytw==
X-Google-Smtp-Source: ABdhPJwfiWMejHIF12XcDH0NOTfMsb+1nSFRomkVt8qC02/bphwgTB11FZFx9g4po4vVDjwzWG1LUg==
X-Received: by 2002:a17:90b:c04:: with SMTP id bp4mr10656583pjb.230.1630686171816;
        Fri, 03 Sep 2021 09:22:51 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g18sm5368983pfj.80.2021.09.03.09.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 09:22:51 -0700 (PDT)
Date:   Fri, 3 Sep 2021 16:22:47 +0000
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
Subject: Re: [PATCH v5 4/8] KVM: Optimize kvm_make_vcpus_request_mask() a bit
Message-ID: <YTJL1yOC2iwHwd9B@google.com>
References: <20210903075141.403071-1-vkuznets@redhat.com>
 <20210903075141.403071-5-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903075141.403071-5-vkuznets@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021, Vitaly Kuznetsov wrote:
> Iterating over set bits in 'vcpu_bitmap' should be faster than going
> through all vCPUs, especially when just a few bits are set.
> 
> Drop kvm_make_vcpus_request_mask() call from kvm_make_all_cpus_request_except()
> to avoid handling the special case when 'vcpu_bitmap' is NULL, move the
> code to kvm_make_all_cpus_request_except() itself.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>

>  bool kvm_make_vcpus_request_mask(struct kvm *kvm, unsigned int req,
>  				 struct kvm_vcpu *except,
>  				 unsigned long *vcpu_bitmap, cpumask_var_t tmp)
>  {
> -	int i, cpu, me;
>  	struct kvm_vcpu *vcpu;
> +	int i, me;
>  	bool called;

Uber nit, if you're moving "int i, me;" to get reverse fir tree ordering, it
should be moved below "bool called;" as well, which you amusingly did do in the
below function :-)
>  
>  	me = get_cpu();
>  

...

> @@ -316,12 +323,23 @@ bool kvm_make_vcpus_request_mask(struct kvm *kvm, unsigned int req,
>  bool kvm_make_all_cpus_request_except(struct kvm *kvm, unsigned int req,
>  				      struct kvm_vcpu *except)
>  {
> +	struct kvm_vcpu *vcpu;
>  	cpumask_var_t cpus;
>  	bool called;
> +	int i, me;
