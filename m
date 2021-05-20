Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F3838B71B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbhETTSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238033AbhETTR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:17:57 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF432C061761
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:16:34 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q6so9663013pjj.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=smKiHw5OQd4fwAG2JqPuRCbGi+3F97jqBcqxvD0K62k=;
        b=LXdCGMLe068A0DF5XUh4EnYQMnXQEU+9Ck1fxUlBT56cvkmhAfCQinLkl1HMmMPrgs
         e/ufs9InVKO/0lw1M0X+5uqDe6gl9oUj0Zx8c/oyLmbNdz6RuufzkQ4g1hh3dpoZaoRD
         Hv4Bo9KemqpPyC6fnSiHmhiu7eodTyCizJd/h8EteO5VZaVmmKVq3cN60BCP0MqWO/MR
         NY4zCur4y/OzxI2wrVlT43upC/0uA/EQtkrAnRUjigP+kNNlZUm+jMKgdytvZOnisQio
         N+kWj1YFnCqxJD8Ppg8oSzvkWOqPd6iGkCsOOa/nbHidtJiuZlgk6MUL5UYdDsdvV3aQ
         YxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=smKiHw5OQd4fwAG2JqPuRCbGi+3F97jqBcqxvD0K62k=;
        b=l2usgyWjYD9XKzfUk4A5bLyWcDG/ktBGMPyCL4m/yXoEcZFAePvOeuGPpI1ETltsY/
         d+v/YZpoxff8JZziw3mGrs4opkrVFEktOmrNYZQE5Robs83GmLGytuZKlsZWEmkeZYx3
         +pmL8xuiUcx7fwWlWWpMQWss9OfBQI6qDmv0gEI47KAQBvtPebYgJ565zGLyXj6dAQhC
         1QBCNUeuBx0EmaAsbiu2P12FV5oKFo2Z2zG/Ar4S39TzfsDzoO7QJCPjGosA3cZLIDL8
         zaxj6mV3VjZkAKVR+8rPOSVh5ueG25uUHUIaeHXX5PixWgRvSRleB5qB0FXUzn3vcu8O
         +DSg==
X-Gm-Message-State: AOAM53272luv5uYUpZmkbvxtlSSORvfI2pN9tA+BB1xLBHyKt7QS566K
        dAOfZxwDAUW2Q/e/0Pnxq2yuaA==
X-Google-Smtp-Source: ABdhPJzAdSck/qTuMCpmymv4WlyjxEafj2wr5OLSSExohGycRc9hBR2Nk2GNCaYVpuV5TvtRnU1CpA==
X-Received: by 2002:a17:902:dac6:b029:f3:16f3:d90d with SMTP id q6-20020a170902dac6b02900f316f3d90dmr7793310plx.42.1621538194114;
        Thu, 20 May 2021 12:16:34 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id w124sm2520674pfb.73.2021.05.20.12.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 12:16:33 -0700 (PDT)
Date:   Thu, 20 May 2021 19:16:29 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Peter Gonda <pgonda@google.com>, kvm list <kvm@vger.kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] KVM: SVM: Do not terminate SEV-ES guests on GHCB
 validation failure
Message-ID: <YKa1jduPK9JyjWbx@google.com>
References: <f8811b3768c4306af7fb2732b6b3755489832c55.1621020158.git.thomas.lendacky@amd.com>
 <CAMkAt6qJqTvM0PX+ja3rLP3toY-Rr4pSUbiFKL1GwzYZPG6f8g@mail.gmail.com>
 <324d9228-03e9-0fe2-59c0-5e41e449211b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <324d9228-03e9-0fe2-59c0-5e41e449211b@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021, Tom Lendacky wrote:
> On 5/14/21 6:06 PM, Peter Gonda wrote:
> > On Fri, May 14, 2021 at 1:22 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>
> >> Currently, an SEV-ES guest is terminated if the validation of the VMGEXIT
> >> exit code and parameters fail. Since the VMGEXIT instruction can be issued
> >> from userspace, even though userspace (likely) can't update the GHCB,
> >> don't allow userspace to be able to kill the guest.
> >>
> >> Return a #GP request through the GHCB when validation fails, rather than
> >> terminating the guest.
> > 
> > Is this a gap in the spec? I don't see anything that details what
> > should happen if the correct fields for NAE are not set in the first
> > couple paragraphs of section 4 'GHCB Protocol'.
> 
> No, I don't think the spec needs to spell out everything like this. The
> hypervisor is free to determine its course of action in this case.

The hypervisor can decide whether to inject/return an error or kill the guest,
but what errors can be returned and how they're returned absolutely needs to be
ABI between guest and host, and to make the ABI vendor agnostic the GHCB spec
is the logical place to define said ABI.

For example, "injecting" #GP if the guest botched the GHCB on #VMGEXIT(CPUID) is
completely nonsensical.  As is, a Linux guest appears to blindly forward the #GP,
which means if something does go awry KVM has just made debugging the guest that
much harder, e.g. imagine the confusion that will ensue if the end result is a
SIGBUS to userspace on CPUID.

There needs to be an explicit error code for "you gave me bad data", otherwise
we're signing ourselves up for future pain.

> I suppose the spec could suggest a course of action, but I don't think the
> spec should require a specific course of action.
> 
> Thanks,
> Tom
> 
> > 
