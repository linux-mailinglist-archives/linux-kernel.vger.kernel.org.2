Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263C343B660
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbhJZQHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbhJZQG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:06:59 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44F6C061348
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:04:33 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y1so10644878plk.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4WWQGYrQCvtEZnOxLDKvqrp7vtMClIRGrA2VVosNxMg=;
        b=e2ZR7eRJoZP0usdtriUJ+SrF+NnmKLfIhJWwBKdVNTiwiHS46Oy+LfMa65CnJ7uhJq
         xSsDMelUoga+5PRYmsXijqw67w5dZrZQ+iNv5rd+kpKH+AJ9JbS4K5UOD2/x9Ql/qpto
         jvx2hpUWkmAj5ffiaz4pR8XI3eU7a2JQDeFFTOBHXYbVTDP07v1rHAogKpbcC1U3Mppq
         6y9WGfrNAWQZ8mM/N4Ru2MsyJFvlZpwCudUr4HlqLRftLXh5IYL6AZP3eVo9dHcvWQ8A
         snlKz6b0JAat0NyeA6mvvcukWIdX9QETG2T4Tpb7k3KgBXi+upSyoKMJxb9ZYMuXcund
         r2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4WWQGYrQCvtEZnOxLDKvqrp7vtMClIRGrA2VVosNxMg=;
        b=i/cvyYBi1xvgzC6hjNAE718O70JyRNTKGvXaMXpkK/bEDYHAGv3oy/aoq0FJI+/6hP
         8jCWX6FGKu0F0yMfBRBVk11m9v0MhR4hV2DrGGReGMzeQsmSRJzPtHGXFFuETfELglzx
         xqxtnoj8V/i4qYtZnnsO7jid0J+utMIb2aJIZbKcvUwSHyghw9A0pza6zMNdIJcshh6U
         e3roCEjxNUO03np4Z3SZSF2YJqFrZWDtw+k3PuZjMm7Pq/HP9kwl2W4w2bp1y1fNA4Gd
         JovmgQL87urhog7de/eBzbU0R3VJmZBt2yJ8iMVfzzcF6tIQWKrg+qvOFuDSJD+bbk0D
         ch3Q==
X-Gm-Message-State: AOAM530dYOS2USiIE0w8F9CGZVo0XPV6vDOjk/X7DDMwD+rxE9nR7CDC
        1jvJ0Quv3Q0XAV0LjBFpvlcrJg==
X-Google-Smtp-Source: ABdhPJzxwDp2GSt/EEYcM2AYIWmy4Dai4riGyxZYe458XIKeYNyhC7aXxAzhZ4uZwTYC4Lcbb9xrkA==
X-Received: by 2002:a17:90b:1511:: with SMTP id le17mr25542928pjb.99.1635264273125;
        Tue, 26 Oct 2021 09:04:33 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 141sm8576391pge.23.2021.10.26.09.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 09:04:32 -0700 (PDT)
Date:   Tue, 26 Oct 2021 16:04:28 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     Wanpeng Li <kernellwp@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Wanpeng Li <wanpengli@tencent.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] x86/kvm: Introduce boot parameter no-kvm-pvipi
Message-ID: <YXgnDBOXh2v3gzU4@google.com>
References: <20211020120726.4022086-1-pizhenwei@bytedance.com>
 <CANRm+CxAVA-L0wjm72eohXXWvh9fS7wVFzfKHuEjrsiRFuk9fg@mail.gmail.com>
 <YXB4FHfzh99707EH@google.com>
 <08757159-1673-5c7b-3efc-e5b54e82d6c3@bytedance.com>
 <CANRm+CzcTUWYJeaj3eWKH84YZYgeMZz3kbpn13c8i97iYGGHFQ@mail.gmail.com>
 <5b718b32-cd92-920e-c474-27b9cafeec60@bytedance.com>
 <ec014e8d-eb5f-03cc-3ed1-da58039ef034@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec014e8d-eb5f-03cc-3ed1-da58039ef034@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021, zhenwei pi wrote:
> Hi, Wanpeng & Sean
> 
> Also benchmark redis(by 127.0.0.1) in a guest(2vCPU), 'no-kvm-pvipi' gets
> better performance.
> 
> Test env:
> Host side: pin 2vCPU on 2core in a die.
> Guest side: run command:
>   taskset -c 1 ./redis-server --appendonly no
>   taskset -c 0 ./redis-benchmark -h 127.0.0.1 -d 1024 -n 10000000 -t get
> 
> 1> without no-kvm-pvipi:
> redis QPS: 193203.12 requests per second
> kvm_pv_send_ipi exit: ~18K/s
> 
> 2> with no-kvm-pvipi:
> redis QPS: 196028.47 requests per second
> avic_incomplete_ipi_interception exit: ~5K/s

Numbers look sane, but I don't think that adding a guest-side kernel param is
the correct "fix".  As evidenced by Wanpeng's tests, PV IPI can outperform AVIC
in overcommit scenarios, and there's also no guarantee that AVIC/APICv is even
supported/enabled.  In other words, blindly disabling PV IPIs from within the
guest makes sense if and only if the guest knows that AVIC is enabled and that
its vCPUs are pinned.  If the guest has that info, then the host also has that
info, in which case the correct way to handle this is to simply not advertise
KVM_FEATURE_PV_SEND_IPI to the guest in CPUID.
