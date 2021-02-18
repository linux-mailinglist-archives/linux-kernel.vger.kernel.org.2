Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3920231EEE7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhBRSuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbhBRQkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 11:40:13 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B76C061756
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 08:39:30 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id cl8so1670790pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 08:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tAXH7YAvVuou21SXxWV1oEs6Zbi0HoK7NLFcDJuhkUA=;
        b=RaylJLQWFDukLtP3lYtl5lQ33ROSeOwO/SaAsdJFq7bR03ReAHTpTVKqq1d9ctYIjc
         r2v02QbKpPOQLqvscd+VcbprwB0nT0FPsGMqfjpZloEhKgSuM0iFQPBUbrItZezAtysL
         SvyQALCnKYzuBiIcG0KdU28l1ouOFPwyZlIM6i9xKjrsvvSLBJbsgARTfrZZ0dKOZ6tU
         +ohiKEStWWILnaEYFv/bipW8TYsKNNok211hOpPLeuojZDQsRA8SAF192qdagD57F6jB
         LK/kN0cHSl+darl9LTLSEPekZiEWjKIQl8MVFRmUW+ueTZdBkieZ99bxhkE/gPRampiG
         GpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tAXH7YAvVuou21SXxWV1oEs6Zbi0HoK7NLFcDJuhkUA=;
        b=GVPVPd2j6TDr/PSoohgejsypFIlAWKWWuQ/4yx/MkFju83/hAa1RdXGyz3LShQ/7pF
         TbR9O3QpSP0ATvbhB/a8jVdyltyZZWyYv0oiIEFRLxo55RWaSVV9XGcMDsM0nSvXHRHZ
         K8EzQ7RBjH9nELoTHkDtAYrhONtVN9CMpbJDuJcfRWlG9EeNcFzZE+PDbQWViqSRpI+Z
         hsWefcxV7sR9TVdYVgJ3cqt3EhlVc0x6TfC7Vmv2E/k0h3DeeXVSOthPq+XL2Z4UflEg
         9ak/ha3FCiFYUlnQTUg4d05s4WG2r4tdDZvbpQLZWE9tCzYkgQoYS+uaGQBHbDODMgSR
         ghww==
X-Gm-Message-State: AOAM531hvBN3EhgGE9jmQz2KehReImGcEjX2UdLB745o6yCHecDph42e
        4wMW0hEvK/pxXh/7gnKLp+xfQA==
X-Google-Smtp-Source: ABdhPJwubJnoW5ptbBz//HSdFUifLFNVclJakKkrpbIvA9T+sfPDIzNCeNzlNhEjk4nRGe8nE1PkCQ==
X-Received: by 2002:a17:90a:4083:: with SMTP id l3mr4785105pjg.109.1613666369535;
        Thu, 18 Feb 2021 08:39:29 -0800 (PST)
Received: from google.com ([2620:15c:f:10:dc76:757f:9e9e:647c])
        by smtp.gmail.com with ESMTPSA id l190sm6691625pfl.205.2021.02.18.08.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 08:39:29 -0800 (PST)
Date:   Thu, 18 Feb 2021 08:39:22 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     "Kalra, Ashish" <Ashish.Kalra@amd.com>
Cc:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "joro@8bytes.org" <joro@8bytes.org>, "bp@suse.de" <bp@suse.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "srutherford@google.com" <srutherford@google.com>,
        "venu.busireddy@oracle.com" <venu.busireddy@oracle.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH v10 10/16] KVM: x86: Introduce KVM_GET_SHARED_PAGES_LIST
 ioctl
Message-ID: <YC6YOuJyNlSxKVR4@google.com>
References: <cover.1612398155.git.ashish.kalra@amd.com>
 <7266edd714add8ec9d7f63eddfc9bbd4d789c213.1612398155.git.ashish.kalra@amd.com>
 <YCxrV4u98ZQtInOE@google.com>
 <SN6PR12MB2767168CA61257A85B29C26D8E869@SN6PR12MB2767.namprd12.prod.outlook.com>
 <YC1AkNPNET+T928c@google.com>
 <SN6PR12MB27676C0BF3BBA872E55D5FC78E859@SN6PR12MB2767.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR12MB27676C0BF3BBA872E55D5FC78E859@SN6PR12MB2767.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021, Kalra, Ashish wrote:
> From: Sean Christopherson <seanjc@google.com> 
> 
> On Wed, Feb 17, 2021, Kalra, Ashish wrote:
> >> From: Sean Christopherson <seanjc@google.com> On Thu, Feb 04, 2021, 
> >> Ashish Kalra wrote:
> >> > From: Brijesh Singh <brijesh.singh@amd.com>
> >> > 
> >> > The ioctl is used to retrieve a guest's shared pages list.
> >> 
> >> >What's the performance hit to boot time if KVM_HC_PAGE_ENC_STATUS is 
> >> >passed through to userspace?  That way, userspace could manage the 
> >> >set of pages >in whatever data structure they want, and these get/set ioctls go away.
> >> 
> >> What is the advantage of passing KVM_HC_PAGE_ENC_STATUS through to 
> >> user-space ?
> >> 
> >> As such it is just a simple interface to get the shared page list via 
> >> the get/set ioctl's. simply an array is passed to these ioctl to 
> >> get/set the shared pages list.
> 
> > It eliminates any probability of the kernel choosing the wrong data
> > structure, and it's two fewer ioctls to maintain and test.
> 
> The set shared pages list ioctl cannot be avoided as it needs to be issued to
> setup the shared pages list on the migrated VM, it cannot be achieved by
> passing KVM_HC_PAGE_ENC_STATUS through to user-space.

Why's that?  AIUI, KVM doesn't do anything with the list other than pass it back
to userspace.  Assuming that's the case, userspace can just hold onto the list
for the next migration.

> So it makes sense to add both get/set shared pages list ioctl, passing
> through to user-space is just adding more complexity without any significant
> gains.

No, it reduces complexity for KVM by avoiding locking and memslot dependencies.
