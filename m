Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE333794AF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhEJQ5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhEJQ5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:57:37 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24610C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:56:32 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n16so9437980plf.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ie5AYmqK63xzjFssLcNkkP7A6mi6riGq/9HKzXNVk6A=;
        b=SepcazzDfwcqb7zkKwhVhYcOakZPshV+SlDOgSATAzQaPDFRyfm0SCzNeTyVwrxU+N
         buq8UGFWATYjEHXZoW4ieGWKBhxiD2ERcd/i5FZ+6W6C48Js1KQo7Sg2THdAXARR8GPk
         Q0yf9N6Wmso6uB0rrEOEyZ6Z8SlfmXnVpYo9uISLbfL2QLt52sgsLnjaS5Of9P1/35zI
         vJTWUV6/c2tdjwNa6tVQbVikPDB5Vzuqnz4dw4HIOq5kxaOhzh4qBqV2Hceruzjvq0Tb
         DOXY/0FN0UxeWWZBJElv0U+O7O41D1n98sgg+hGppVwb61UN/YTaV8h2yrQCY7XZrjGl
         czsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ie5AYmqK63xzjFssLcNkkP7A6mi6riGq/9HKzXNVk6A=;
        b=LRo5MCr1ZWjlVTfNOp1PHIYoNJPx9yKXEvNHRIxdGVHZYQV5Zu2xEv5w+IVLOPORKZ
         9ICXAru09bWd1FY3dZ69WWxrfNysw1yVrR3PbzC37JLXo0apq8HZELNMHrrwfDei47Jd
         Vq8XIBYpi4+RFSwdh47M5qytsckTO+Lz9rg8rkpwLurcIg+E/i1/bBTNYE//aVmdBvkW
         VCrDZyWRuFBXEseKCP5ZCtc8mF2CCdF8bXEvgrk67JqZHK3qo3xeGwJZoKTY/iyhxQo5
         2AmsguNan/Wp4mMpjl7hiOU3AKW1UfIa/R2ml7UeLnOfG13Ae2NrWpjUIJ3aMVrIGyXo
         gqEQ==
X-Gm-Message-State: AOAM532rd7HFVbNjMWDatr/q/3YsoKgWLK9cj/7CY9Vy1765MNL4vdaB
        FSembpHok91TccVLBGmNRUszGQ==
X-Google-Smtp-Source: ABdhPJysmU+4T6LyJRwuT+O5zxMdfqgXZAfHCgL3iAoHnEl4RCd+O61QSobdgHOsiO9AZQ/QJ9q/yw==
X-Received: by 2002:a17:90b:370a:: with SMTP id mg10mr28773364pjb.219.1620665791522;
        Mon, 10 May 2021 09:56:31 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id d18sm11877725pgo.66.2021.05.10.09.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 09:56:31 -0700 (PDT)
Date:   Mon, 10 May 2021 16:56:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH 03/15] KVM: SVM: Inject #UD on RDTSCP when it should be
 disabled in the guest
Message-ID: <YJlluzMze2IfUM6S@google.com>
References: <20210504171734.1434054-1-seanjc@google.com>
 <20210504171734.1434054-4-seanjc@google.com>
 <CALMp9eSvXRJm-KxCGKOkgPO=4wJPBi5wDFLbCCX91UtvGJ1qBg@mail.gmail.com>
 <YJHCadSIQ/cK/RAw@google.com>
 <1b50b090-2d6d-e13d-9532-e7195ebffe14@redhat.com>
 <CALMp9eSSiPVWDf43Zed3+ukUc+NwMP8z7feoxX0eMmimvrznzA@mail.gmail.com>
 <4a4b9fea4937da7b0b42e6f3179566d73bf022e2.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a4b9fea4937da7b0b42e6f3179566d73bf022e2.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021, Maxim Levitsky wrote:
> On Tue, 2021-05-04 at 14:58 -0700, Jim Mattson wrote:
> > On Tue, May 4, 2021 at 2:57 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > On 04/05/21 23:53, Sean Christopherson wrote:
> > > > > Does the right thing happen here if the vCPU is in guest mode when
> > > > > userspace decides to toggle the CPUID.80000001H:EDX.RDTSCP bit on or
> > > > > off?
> > > > I hate our terminology.  By "guest mode", do you mean running the vCPU, or do
> > > > you specifically mean running in L2?
> > > > 
> > > 
> > > Guest mode should mean L2.
> > > 
> > > (I wonder if we should have a capability that says "KVM_SET_CPUID2 can
> > > only be called prior to KVM_RUN").
> > 
> > It would certainly make it easier to reason about potential security issues.
> > 
> I vote too for this.

Alternatively, what about adding KVM_VCPU_RESET to let userspace explicitly
pull RESET#, and defining that ioctl() to freeze the vCPU model?  I.e. after
userspace resets the vCPU, KVM_SET_CPUID (and any other relevant ioctls() is
disallowed.

Lack of proper RESET emulation is annoying, e.g. userspace has to manually stuff
EDX after vCPU creation to get the right value at RESET.  A dedicated ioctl()
would kill two birds with one stone, without having to add yet another "2"
ioctl().
