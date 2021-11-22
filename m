Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6BD4595B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 20:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240133AbhKVTpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 14:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbhKVTpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 14:45:52 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2A1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 11:42:45 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so502955pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 11:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vSLPHZ8waMTanILttOmsI2fU9sL80T5EO2RMiYi/VOU=;
        b=fAn7lIm2j/EZJtQWajkaaqIHYCLG9QJqN+4Yjq8vnlxcp/iZfajJAVjdL1w2QQMdVN
         Nk8Fm7Ir2/JDSH4R2OqYw0P3tG1mriT4h4c6QZqZHTIH1L8S2rQ08FMalf11zHi+PiWI
         V0p3HNmaVUrf8qN25dxSMoLM2U7Y2o6uLU0mXkdf5z3B7WNZXcjinbQ3KpH0vQL5Aevj
         C4ZGkNqaFsYfi5In9ZfNWbQZ2vKBbfcN6Zlj8kT1jWJWNXfat7Wuv0i2xf+h1+X/jC0p
         UYbKOgfKXwsAYicVFBCdFegej5ABGtmJJlLGzKGmoVPBaI4/luitk6ihdKSUEw4+7mO5
         wLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vSLPHZ8waMTanILttOmsI2fU9sL80T5EO2RMiYi/VOU=;
        b=CSJWIm+b4h1+Actc8OZDAMtMHOcsZDOLQVzHgtTmWLW7StSfhl4uh8u3YIvLp4v9wO
         yG9YumP8ZuIdGoMpIdf2V9Guokn2NOoy4NMAxzQgsMFhRODbKnJJD7TAXmoitWC0F3oo
         oI7/lIvkicfa8yyfi5KTz9EFbGyRB+n5/1DsVuyS2QKun5j9OoLsqlAebaKoSX2OyCsu
         ohRxwEVuDlfJ6AQjEgHG9Qp1gIPUmoW07kU+6Gc2mqgS6E9zP6LoP3pdnq7a+IzZ4UHR
         GO05HM20htWg4xi15QwYMgSwaIQhxvyfnVlRxiXuAmC/k6TvGaXl0S3kgtm+JpSTi63x
         aetQ==
X-Gm-Message-State: AOAM531rVG2LhXk3b+c97StgWEMvH4p5F9BphAPOC68BWltlWyXNYKEv
        7GhkAmvSK+OuvnUAl8tE5Rd+0w==
X-Google-Smtp-Source: ABdhPJxoOmH1lTdr8EnWVUwDxWjVbD8Wd28GDqe8drNzKGj3hYGD5+P2CbX2N8iWmf5rDbgAAzr7og==
X-Received: by 2002:a17:902:a50f:b0:143:7dec:567 with SMTP id s15-20020a170902a50f00b001437dec0567mr111849132plq.18.1637610165044;
        Mon, 22 Nov 2021 11:42:45 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f7sm9827834pfv.89.2021.11.22.11.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 11:42:44 -0800 (PST)
Date:   Mon, 22 Nov 2021 19:42:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [tip:perf/core 12/17] arch/arm64/kvm/arm.c:499:15: warning: no
 previous prototype for function 'kvm_arch_vcpu_get_ip'
Message-ID: <YZvysKFSLTxDzaBs@google.com>
References: <202111222031.KekEh4ig-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111222031.KekEh4ig-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Peter, Marc

On Mon, Nov 22, 2021, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
> head:   a9f4a6e92b3b319296fb078da2615f618f6cd80c
> commit: e1bfc24577cc65c95dc519d7621a9c985b97e567 [12/17] KVM: Move x86's perf guest info callbacks to generic KVM
> All warnings (new ones prefixed by >>):
> 
> >> arch/arm64/kvm/arm.c:499:15: warning: no previous prototype for function 'kvm_arch_vcpu_get_ip' [-Wmissing-prototypes]
>    unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu)
>                  ^
>    arch/arm64/kvm/arm.c:499:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu)
>    ^
>    static 
>    1 warning generated.

Argh, the declaration is behind CONFIG_GUEST_PERF_EVENTS=y so that architectures
that don't support GUEST_PERF_EVENTS at all didn't need to provide implementations.

There are a few ways to solve this, none of which I particularly love.  I think my
first choice would be to wrap arm's implementation with an #ifdef.  Stubbing out a
getter like this feels all kinds of wrong, and moving the declaration outside of
CONFIG_GUEST_PERF_EVENTS=y will set someone up to try and use the helper when it's
not available.

---
 arch/arm64/kvm/arm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 8129ee1ed3a4..e3b46951a92d 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -496,10 +496,12 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
 	return vcpu_mode_priv(vcpu);
 }

+#ifdef CONFIG_GUEST_PERF_EVENTS
 unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu)
 {
 	return *vcpu_pc(vcpu);
 }
+#endif

 /* Just ensure a guest exit from a particular CPU */
 static void exit_vm_noop(void *info)
--

