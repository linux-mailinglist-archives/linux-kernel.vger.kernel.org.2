Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B043F7D06
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 22:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242570AbhHYUK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 16:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238571AbhHYUK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 16:10:26 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B7FC0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 13:09:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so4572148pje.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 13:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZFFjML9smF7WsET9dQOV7mfQFBicnrpHkuw0z9j2oAc=;
        b=DKwaEyQ3aYPp4addUNdIXUXLbcQVxq62IyFfvLqcrqh5RCdUGg8hmIue4b5wSXn3Wd
         RXrMq9UnkzG960carDxoDjn++v9pjNBycfq2fM9L1KvMUAPc5G/zLgR9C+4EXNhNFzBI
         MAhkwRuRJwZmEgTDTaOeVxFaBBxg/heTL7w6DaGXHz0jbpV/Y3AoTaz74BEQ90VYvHtQ
         8fV2ihh+e6riAj6nviPuCwDFAmsdpqfTvUS7A8j2WZgANuDpSnOlYxki/p41zGs+3E1p
         9/mDhlgHhUyDTO9owyxaDtBGFqJ+jqkfIKtHX9hAiT56ZRFYZqoKnS/8jnHjuTlXXt+9
         ZySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZFFjML9smF7WsET9dQOV7mfQFBicnrpHkuw0z9j2oAc=;
        b=QP0mWy0/dWfizch39ftoVe2+KyJXIlSDBuwDkPtc2C0iM9y28S49ie2S78btnyieQE
         n7Gar51WoBh7qv8QvbLyd6iFwvXhDlNdbAz3FK58qh6qJ9YeKLKSdr88C/3aayP8rVZb
         kHjeLCyifKgeBQJocbYIJDKdSwU3YybtyFoCMMUppiOD8FHfgnlsObW5v8XdxYazFoWY
         JXdeAvcG1/c+Db2RYD3KHoEaGTOj7UXcdMxYLBejw1SSSwnOvvsoBMjGJC2zPFB+cawB
         Iay8i6sh42LF72dEWLacQyAtwvdeRL7NQG7yJaCnxz4XALgU45dGgT6ASJjDa+dpqB5I
         9KPA==
X-Gm-Message-State: AOAM53273nI+pptFq9LsyQXsLvrAhj59RS91ndMn2qQrgTlQh+cyHtjx
        XHo8SLTSTf9RqdJdBKU19Eoaiw==
X-Google-Smtp-Source: ABdhPJwF/oxCbdIBThueC+vdJjv3Rsb+QwC2K8FdOyywgM5pIfWZzcgW/d8Ou21uA0W/B1kRQnrR1A==
X-Received: by 2002:a17:90b:120a:: with SMTP id gl10mr69115pjb.234.1629922179122;
        Wed, 25 Aug 2021 13:09:39 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u24sm554378pfm.85.2021.08.25.13.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 13:09:38 -0700 (PDT)
Date:   Wed, 25 Aug 2021 20:09:34 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Artem Kashkanov <artem.kashkanov@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] KVM: x86: Register Processor Trace interrupt hook
 iff PT enabled in guest
Message-ID: <YSajfuw7P2wacTGY@google.com>
References: <20210823193709.55886-1-seanjc@google.com>
 <20210823193709.55886-3-seanjc@google.com>
 <3021c1cc-a4eb-e3ab-d6b7-558cbaefd03b@gmail.com>
 <YSZa7dkw6t7yN6vL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSZa7dkw6t7yN6vL@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021, Sean Christopherson wrote:
> On Wed, Aug 25, 2021, Like Xu wrote:
> > On 24/8/2021 3:37 am, Sean Christopherson wrote:
> > > @@ -11061,6 +11061,8 @@ int kvm_arch_hardware_setup(void *opaque)
> > >   	memcpy(&kvm_x86_ops, ops->runtime_ops, sizeof(kvm_x86_ops));
> > >   	kvm_ops_static_call_update();
> > > +	if (ops->intel_pt_intr_in_guest && ops->intel_pt_intr_in_guest())
> > > +		kvm_guest_cbs.handle_intel_pt_intr = kvm_handle_intel_pt_intr;
> > 
> > Emm, it's still buggy.
> > 
> > The guest "unknown NMI" from the host Intel PT can still be reproduced
> > after the following operation:
> > 
> > 	rmmod kvm_intel
> > 	modprobe kvm-intel pt_mode=1 ept=1
> > 	rmmod kvm_intel
> > 	modprobe kvm-intel pt_mode=1 ept=0
> > 
> > Since the handle_intel_pt_intr is not reset to NULL in kvm_arch_hardware_unsetup(),
> > and the previous function pointer still exists in the generic KVM data structure.
> 
> Ooof, good catch.  Any preference between nullifying handle_intel_pt_intr in
> setup() vs. unsetup()?  I think I like the idea of "unwinding" during unsetup(),
> even though it splits the logic a bit.

Never mind, I figured out a way to clean all this up and land the PT interrupt
handler in vmx.c where it belongs.  Getting there is a bit of a journey, but it's
very doable.  That means unwinding in unsetup() is the preferred approach,
otherwise there would be potential for leaving a dangling pointer if a different
vendor module was succesfully loaded.
