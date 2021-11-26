Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A531D45E828
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 07:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345566AbhKZHAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 02:00:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30656 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237577AbhKZG6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 01:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637909738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zISC7zdL90TAjqxUC3DjVYlJwtWD93wRpENuKgM6xtw=;
        b=cC64eiVnoh8ZeuBXe2xgIJwtjAvUwYKNxlqrpTP32AYWqvsymEV7RQY+lZsd/EsM91nsJ9
        IRa6+S9hgJpqX32+zouurpoHYU7+NIqWbLI293x7T8U4Kv8dwCfyh6iXI2PunnZpVZ8rt3
        tmqMC2yzqc63QKG2vN0P1QIjGX/LKX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-Xw97vxp3MauIUam8ZlwUQA-1; Fri, 26 Nov 2021 01:55:32 -0500
X-MC-Unique: Xw97vxp3MauIUam8ZlwUQA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 003DC344AF;
        Fri, 26 Nov 2021 06:55:30 +0000 (UTC)
Received: from starship (unknown [10.40.192.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3E2D57CA5;
        Fri, 26 Nov 2021 06:55:13 +0000 (UTC)
Message-ID: <a33c5f6fb887973fc69a0586c615aea6461cad6e.camel@redhat.com>
Subject: Re: [PATCH v2 0/6] nSVM optional features
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Bandan Das <bsd@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Wei Huang <wei.huang2@amd.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Date:   Fri, 26 Nov 2021 08:55:12 +0200
In-Reply-To: <f983e2e343f600ab5196aef8389d719bc2ab7308.camel@redhat.com>
References: <20211101140324.197921-1-mlevitsk@redhat.com>
         <f983e2e343f600ab5196aef8389d719bc2ab7308.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-16 at 23:38 +0200, Maxim Levitsky wrote:
> On Mon, 2021-11-01 at 16:03 +0200, Maxim Levitsky wrote:
> > This is a resend of a few patches that implement few
> > SVM's optional features for nesting.
> > 
> > I was testing these patches during last few weeks with various nested configurations
> > and I was unable to find any issues.
> > 
> > I also implemented support for nested vGIF in the last patch.
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 
> > Maxim Levitsky (6):
> >   KVM: x86: SVM: add module param to control LBR virtualization
> >   KVM: x86: nSVM: correctly virtualize LBR msrs when L2 is running
> >   KVM: x86: nSVM: implement nested LBR virtualization
> >   KVM: x86: nSVM: implement nested VMLOAD/VMSAVE
> >   KVM: x86: nSVM: support PAUSE filter threshold and count when
> >     cpu_pm=on
> >   KVM: x86: SVM: implement nested vGIF
> > 
> >  arch/x86/kvm/svm/nested.c |  86 ++++++++++++++++++++---
> >  arch/x86/kvm/svm/svm.c    | 140 ++++++++++++++++++++++++++++++++------
> >  arch/x86/kvm/svm/svm.h    |  38 +++++++++--
> >  3 files changed, 228 insertions(+), 36 deletions(-)
> > 
> > -- 
> > 2.26.3
> > 
> > 
> Kind ping on these patches.

Another kind ping on these patches.

Best regards,
	Maxim Levitsky
> 
> Best regards,
> 	Maxim Levitsky


