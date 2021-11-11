Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C532044D86B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 15:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhKKOjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 09:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbhKKOjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:39:43 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5200C061767
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 06:36:53 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id p18so5853671plf.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 06:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=34jJgzawqYQ+YIWRQzr5npm3PT61iRNMpUEdh2zYEW0=;
        b=Q9Iei7K8qZ4eZBpVsI63utgUETJb06coQ9roecARAgmfSCbcIfROT8BZMXf13XB9lK
         OmX6R8+E/iYmVz5UZO4sBFI115DQwFqvqUtghrHCwzO4AkJtKOO9ADvq3IQ2F6B+yhZ2
         ptNamZPTRYWzyZRr6g6zFSATIkdVRfBEt/jkKLXT8lLSa5c8nrqS0C06f3XNiP+ln33t
         3ZXIxC/bm0JuGNqS1StgBx1CQhyhOo6T6kAPGxJb213oZpXsEvw9jtEKGJ7NXdTSGHwx
         JLtZ/ecQ+YKRcdWxcl6LzDy3MS/Y4ufvEeVGuOm/zzCRyUmZ1ukoT7Rac8MFcpF5aXMy
         FzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=34jJgzawqYQ+YIWRQzr5npm3PT61iRNMpUEdh2zYEW0=;
        b=6Dbn01g2SBIEujgwO48viU0jta4cip6B+FfFvDEjgTbZ1s86mC6KS/xSqB0O1H/xvH
         jG6e7hnMnl7GV49bxI8fLFATXANT6NWuSOzGgjFu2l1EvIBdvdffxrD+UXZw7MLiyeDw
         ZGGXkZKGEfnulMcImGc6sEXJd5nuUR9ywjGIsfc/R8uUqqFGss1M+XLPUeoG3e3EUZWz
         9EPzP5rvs6LmkKOXItuu9Vo66/3cJDHatV+wEhNSWhtnFE07iWVR6Dx1cASjcw3dS1b4
         KLvms55vo+QTeFeLgSUFYjvGr5Zmx2WAcDN3FLEmp1NoojodH546OynW3mT0bR+20eVl
         Xdfw==
X-Gm-Message-State: AOAM532shM/ApU3K11iC01yXelgDtosquRUbFurIhX9BpfDX9KU1xmi1
        oYlY7s3rIGrCv0LNAQvNZzod+g==
X-Google-Smtp-Source: ABdhPJzlwtX57K6+V5Tv7VOOUCk5L8popOisLaIWyi20afrwM79POuBw74n+k4YSIZAIqjE9+E0+pg==
X-Received: by 2002:a17:90a:9a8e:: with SMTP id e14mr8753922pjp.231.1636641413245;
        Thu, 11 Nov 2021 06:36:53 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id v10sm3495127pfg.162.2021.11.11.06.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 06:36:52 -0800 (PST)
Date:   Thu, 11 Nov 2021 14:36:49 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] KVM: x86: Drop arbitraty KVM_SOFT_MAX_VCPUS
Message-ID: <YY0qgUqM3CuDHWgB@google.com>
References: <20211111134733.86601-1-vkuznets@redhat.com>
 <5cdb6982-d4ec-118e-2534-9498196d11b8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cdb6982-d4ec-118e-2534-9498196d11b8@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021, Paolo Bonzini wrote:
> On 11/11/21 14:47, Vitaly Kuznetsov wrote:
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index ac83d873d65b..91ef1b872b90 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -4137,7 +4137,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >   		r = !static_call(kvm_x86_cpu_has_accelerated_tpr)();
> >   		break;
> >   	case KVM_CAP_NR_VCPUS:
> > -		r = KVM_SOFT_MAX_VCPUS;
> > +		r = num_online_cpus();

I doubt it matters much in practice, but this really should be

		r = min(num_online_cpus(), KVM_MAX_VCPUS);

> >   		break;
> >   	case KVM_CAP_MAX_VCPUS:
> >   		r = KVM_MAX_VCPUS;
> > 
> 
