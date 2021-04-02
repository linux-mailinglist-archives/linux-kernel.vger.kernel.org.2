Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29D8352C06
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbhDBO7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 10:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbhDBO7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 10:59:48 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4ACC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 07:59:47 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so4706472pjq.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 07:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XauO+Tpx/QqvLfsNf0EieVcjgezYHlrLlZApCjoCcwc=;
        b=Tzgme0UQBGKuB+zSlD0xeHc77Hy6oWyrRyYiRZQFSKSope2ZlQuprlNPAFIGno9HCF
         19mRDkj5ZlfoNjs328k6GhD8eNbfCsQBcei3BTgXY+lndiulxllK9urmRZpNbnawPSHF
         1VntLWcNLRE/v2TUKfmWJP3RUU9JLl2aM0LmT3koOB9K6//ZWjl40DmwLdcbMuXOftRy
         vY7bpTZFLIxlRDiIvxlrah94VXX6FYPLZOMp+MPalyOIzbjG3+pDcx1vJhHFGSEmzlRs
         VifckWbHZsxI2muXBZVeIADxXGgNHUOjgsjNw0sHYg1S4nsynZoWCREOXUk86kfL7DYo
         Pc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XauO+Tpx/QqvLfsNf0EieVcjgezYHlrLlZApCjoCcwc=;
        b=Qsp5GuQFMhw5nIWz4ErbKEYqaCSuFpSG34dj+wh8nsIN1a2Ab0/+kivJgqq4OSvccw
         PfnrItsPvl+a692QjsPH/wvISGq8PsZcMNhR0M/bCztikN4i8FwHjBq5ZCBQoWyBG3Rw
         KlMyORhbiic4Qu7zpPo8+geHC3jZLP4HlnTCKjODjgklDj/yPI2Di87aX2ms9cSBL7yG
         3oTfwgLvaK+BbhvZ+ZqLnxasRIOj2JsRdCbJOmfSqOwQLzXhmuTEg+MbGifheCQ018Iq
         ZsRBe1EGAjYCZ7fEWAJuYFd8+7Vf16yWzxPd61NhMsCQOyOIPB30RChsQo5oue6myMYf
         +OKg==
X-Gm-Message-State: AOAM532MjySfqo3//pjnWIx7Aju24HDsPopHXCA3AO60XaNomIjPcZhr
        04NtQwOuPrJNgK4JRthgUq9+dA==
X-Google-Smtp-Source: ABdhPJxioQlQNRTARxdEppiGDcKbsI4noyv87TJnoDznkG+oVESSh/n5TV8EGFMcsMJo2RSOZZ0Vdg==
X-Received: by 2002:a17:90a:b889:: with SMTP id o9mr14181347pjr.97.1617375586898;
        Fri, 02 Apr 2021 07:59:46 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id n24sm8673883pgl.27.2021.04.02.07.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 07:59:46 -0700 (PDT)
Date:   Fri, 2 Apr 2021 14:59:42 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH v2 07/10] KVM: Move MMU notifier's mmu_lock acquisition
 into common helper
Message-ID: <YGcxXvrluFJ+7o9X@google.com>
References: <20210402005658.3024832-1-seanjc@google.com>
 <20210402005658.3024832-8-seanjc@google.com>
 <a30f556a-40b2-f703-f0ee-b985989ee4b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a30f556a-40b2-f703-f0ee-b985989ee4b7@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021, Paolo Bonzini wrote:
> On 02/04/21 02:56, Sean Christopherson wrote:
> > +		.handler	= (void *)kvm_null_fn,
> > +		.on_lock	= kvm_dec_notifier_count,
> > +		.flush_on_ret	= true,
> 
> Doesn't really matter since the handler is null, but I think it's cleaner to
> have false here.

Agreed.
