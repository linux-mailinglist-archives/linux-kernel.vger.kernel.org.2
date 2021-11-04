Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2D84458EC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbhKDRuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhKDRug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:50:36 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCA7C061203
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 10:47:58 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t7so6059873pgl.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 10:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CRX1JnII6cf5ITH/Jx7bQ6CXI3KNmsN3e/xj+NX8tLs=;
        b=DRa/4CE2xbSxUb4DTb/SaciEp90VRfojqjaz5rVMI81JCzV5hpLdlzifgZLEqJw9nc
         xO6Lg6yaSYgA/BgZZpcFyPaiXTIhKEy7GKslGtonCJXhOtp8Dpxnw++vaLN+59NOhNwq
         5qQNAKHon8CinY1uJv/3GB3e0yk9a6RbaYP+G7dhSrygQS2Z8Pev+CIFYeIE4hCNx+6/
         nHaL6V7WDVHBKKCoUl4chm5YkHsdH+ImZaJSKRJ74xl4F/A0Obpu30S9UnOMdePpMI07
         klwYnFkq9pOivk2p1dSlNRb83vXXCPsZfZ+XzAtj4UKswAC4DcgB7u4qlBFbBcp5TZmO
         JBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CRX1JnII6cf5ITH/Jx7bQ6CXI3KNmsN3e/xj+NX8tLs=;
        b=CEHti+qrxtiDnbrSkmde3t7pSzrfye5YmUwZpnSDfjU0ohxweAY6EgG/85Syjx3SAG
         XecZevpeL+HIg3UPUV6WYGC6+0wwPULEFqEP3I8z/Js9x1WDyXstjrXe+Sx/qiAUGo6Y
         8u6IHmdH7D4hycC7+w9u9Afp97XbaxqxM9rOCQ+6FNO+yItlyhKHVKXCphWv0YIr73r3
         a/2Cy+LxwgXdPZ3u80fchckSNO2CfVtO4dqsSDfKTfo21F9V9z2h0QpysWM3YKHSWskO
         NIbb4pTu2h61NdOx3g8gi3IODp165fxQncvCb62HVwoHbcersI+YKLuH07IqGzEc1dp6
         Yhvw==
X-Gm-Message-State: AOAM530HYxD+u9kE9nazU+2UUOLthEoEQPc0ERTMNOW/DKk3oHmc+dXZ
        lnKyxNpP4HxaSH3KyZlY0pVBjw==
X-Google-Smtp-Source: ABdhPJx+JTRHhER8zYwwTZ9ujmlUrIKuGaiF0GSqUl7D3R+EJvn/J+CQG6deXJYOtSai0cpXoz6LUA==
X-Received: by 2002:a05:6a00:181a:b0:47c:1057:52e with SMTP id y26-20020a056a00181a00b0047c1057052emr53703965pfa.76.1636048077649;
        Thu, 04 Nov 2021 10:47:57 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z3sm5554510pfh.79.2021.11.04.10.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 10:47:56 -0700 (PDT)
Date:   Thu, 4 Nov 2021 17:47:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 23/37] KVM: nVMX: Add helper to handle TLB flushes on
 nested VM-Enter/VM-Exit
Message-ID: <YYQcyVyD4qY3aCqh@google.com>
References: <20200320212833.3507-1-sean.j.christopherson@intel.com>
 <20200320212833.3507-24-sean.j.christopherson@intel.com>
 <CAJhGHyD=S6pVB+OxM7zF0_6LnMUCLqyTfMK4x9GZsdRHZmgN7Q@mail.gmail.com>
 <YXrAM9MNqgLTU6+m@google.com>
 <CAJhGHyBKVUsuKdvfaART6NWF7Axk5=eFQLidhGrM=mUO2cv2vw@mail.gmail.com>
 <YXwq+Q3+I81jwv7G@google.com>
 <CAJhGHyBNazRUiwPT5nGC=JNYX96J1dP9Y+KWFz7TeYuT3teYZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyBNazRUiwPT5nGC=JNYX96J1dP9Y+KWFz7TeYuT3teYZg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2021, Lai Jiangshan wrote:
> A small comment in your proposal: I found that KVM_REQ_TLB_FLUSH_CURRENT
> and KVM_REQ_TLB_FLUSH_GUEST is to flush "current" vpid only, some special
> work needs to be added when switching mmu from L1 to L2 and vice versa:
> handle the requests before switching.

Oh, yeah, that's this snippet of my pseudo patch, but I didn't provide the
kvm_service_pending_tlb_flush_on_nested_transition() implementation so it's not
exactly obvious what I intended.  The current code handles CURRENT, but not GUEST,
the idea is to shove those into a helper that can be shared between nVMX and nSVM.

And I believe the "flush" also needs to service KVM_REQ_MMU_SYNC.  For L1=>L2 it
should be irrelevant/impossible, since L1 can only be unsync if L1 and L2 share
an MMU, but the L2=>L1 path could result in a lost sync if something, e.g. an IRQ,
prompted a nested VM-Exit before re-entering L2.

Let me know if I misunderstood your comment.  Thanks!

@@ -3361,8 +3358,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
        };
        u32 failed_index;

-       if (kvm_check_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu))
-               kvm_vcpu_flush_tlb_current(vcpu);
+       kvm_service_pending_tlb_flush_on_nested_transition(vcpu);

        evaluate_pending_interrupts = exec_controls_get(vmx) &
                (CPU_BASED_INTR_WINDOW_EXITING | CPU_BASED_NMI_WINDOW_EXITING);
