Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59B832F78E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 02:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhCFBki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 20:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhCFBkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 20:40:06 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391B4C06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 17:40:06 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so75383pjc.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 17:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=xX/55P6fzvPP+kG+riEc/RE6T+vgX3JT/FeKbV8wZec=;
        b=cqkjENhf6SfmvG3cJTO5IOLbDHJOY2IKbtMCIWiigCb/iJinZ+7WIlNn5WPNnlJjJk
         OlR0qk+8k/5RHOBFyZY1pL9CfTMZYtmADUwLHEiCBTwPz0F2OGa/PasdauGZw6/GaNnP
         wNVxyLoEq3mtVfd8E2/Co7Y6onzV1RcXYhY4v2Xr54AwfQ2wtcRfpdaoPWg6wdRd3n7J
         d9FVYBmQ/9C+XNJrCrYrbdJlIomB1TcsxvRNAyVV/cSZbaScNyhOFN6jhkLImiXKa6jq
         mvzAMUrm1+MyGBO0FFvxzo4kNXegZT7YU+/1CC0QYyBdnHnt0KuEVOcT5fRuCnAASykE
         Fwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=xX/55P6fzvPP+kG+riEc/RE6T+vgX3JT/FeKbV8wZec=;
        b=k80vrJ+yW5giXA/iRMH20BJTb3CNR3GpbrWS4IjLsXKHNyxEeT/vbB8AWPnN4lSzEH
         ifOhz67MvZ/Uy5zugOoJ4XHa6wOXkWYyTyg0gwujZ5H+ROlK17GZV/n+V1cZDar7bz6I
         hj/pahhbOxYZBqiAz99t5z0cBrJ5GpeTBRcaCdoSjCA9bgWpd00EbHEWj2+0Ws1zXDqi
         rIWCSuXgi+5qciWSEyJBNTnmlTBpAMs5myhCXk1b73ozn96yFUdSsxlguaajMCJdxMEn
         mooGUbSKgEvD8VfjjCR693+mGMdFc+aPqUDHuCFiahvC0h5WMpa4Xc2f7NoqBm3k7uOk
         rtLA==
X-Gm-Message-State: AOAM532cSMbCVzqvxGBtZap7rosLpdawxUzm+PKtrBl7aUaGADWYUBf1
        QmBg63JWMotjJxL8Qct9nnnwGw==
X-Google-Smtp-Source: ABdhPJw4UarDJ5mYAf08tWOWBCaTWJdKCJjmp6ylq+RSgegSnMASdCGiDyV8GCT7AgWZ5jFf78sPNQ==
X-Received: by 2002:a17:90a:f010:: with SMTP id bt16mr13191132pjb.116.1614994805665;
        Fri, 05 Mar 2021 17:40:05 -0800 (PST)
Received: from google.com ([2620:15c:f:10:fc04:f9df:1efb:bf0c])
        by smtp.gmail.com with ESMTPSA id g6sm3609630pfi.15.2021.03.05.17.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 17:40:04 -0800 (PST)
Date:   Fri, 5 Mar 2021 17:39:58 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, mlevitsk@redhat.com,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH 03/28] KVM: nSVM: inject exceptions via
 svm_check_nested_events
Message-ID: <YELdblXaKBTQ4LGf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526172308.111575-4-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hopefully I got the In-Reply-To header right...

On Thu, May 28, 2020, Paolo Bonzini wrote:
> This allows exceptions injected by the emulator to be properly delivered
> as vmexits.  The code also becomes simpler, because we can just let all
> L0-intercepted exceptions go through the usual path.  In particular, our
> emulation of the VMX #DB exit qualification is very much simplified,
> because the vmexit injection path can use kvm_deliver_exception_payload
> to update DR6.

Sadly, it's also completely and utterly broken for #UD and #GP, and a bit
sketchy for #AC.

Unless KVM (L0) knowingly wants to override L1, e.g. KVM_GUESTDBG_* cases, KVM
shouldn't do a damn thing except forward the exception to L1 if L1 wants the
exception.

ud_interception() and gp_interception() do quite a bit before forwarding the
exception, and in the case of #UD, it's entirely possible the #UD will never get
forwarded to L1.  #GP is even more problematic because it's a contributory
exception, and kvm_multiple_exception() is not equipped to check and handle
nested intercepts before vectoring the exception, which means KVM will
incorrectly escalate a #GP->#DF and #GP->#DF->Triple Fault instead of exiting
to L1.  That's a wee bit problematic since KVM also has a soon-to-be-fixed bug
where it kills L1 on a Triple Fault in L2...

I think this will fix the bugs, I'll properly test and post next week.

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 90a1704b5752..928e11646dca 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -926,11 +926,11 @@ static int nested_svm_intercept(struct vcpu_svm *svm)
        }
        case SVM_EXIT_EXCP_BASE ... SVM_EXIT_EXCP_BASE + 0x1f: {
                /*
-                * Host-intercepted exceptions have been checked already in
-                * nested_svm_exit_special.  There is nothing to do here,
-                * the vmexit is injected by svm_check_nested_events.
+                * Note, KVM may already have snagged exceptions it wants to
+                * handle even if L1 also wants the exception, e.g. #MC.
                 */
-               vmexit = NESTED_EXIT_DONE;
+               if (vmcb_is_intercept(&svm->nested.ctl, exit_code))
+                       vmexit = NESTED_EXIT_DONE;
                break;
        }
        case SVM_EXIT_ERR: {
@@ -1122,19 +1122,23 @@ int nested_svm_exit_special(struct vcpu_svm *svm)
        case SVM_EXIT_INTR:
        case SVM_EXIT_NMI:
        case SVM_EXIT_NPF:
+       case SVM_EXIT_EXCP_BASE + MC_VECTOR:
                return NESTED_EXIT_HOST;
-       case SVM_EXIT_EXCP_BASE ... SVM_EXIT_EXCP_BASE + 0x1f: {
+       case SVM_EXIT_EXCP_BASE + DB_VECTOR:
+       case SVM_EXIT_EXCP_BASE + BP_VECTOR: {
+               /* KVM gets first crack at #DBs and #BPs, if it wants them. */
                u32 excp_bits = 1 << (exit_code - SVM_EXIT_EXCP_BASE);
                if (svm->vmcb01.ptr->control.intercepts[INTERCEPT_EXCEPTION] &
                    excp_bits)
                        return NESTED_EXIT_HOST;
-               else if (exit_code == SVM_EXIT_EXCP_BASE + PF_VECTOR &&
-                        svm->vcpu.arch.apf.host_apf_flags)
-                       /* Trap async PF even if not shadowing */
-                       return NESTED_EXIT_HOST;
                break;
        }
+       case SVM_EXIT_EXCP_BASE + PF_VECTOR:
+               /* Trap async PF even if not shadowing */
+               if (svm->vcpu.arch.apf.host_apf_flags)
+                       return NESTED_EXIT_HOST;
+               break;
        default:
                break;
        }
