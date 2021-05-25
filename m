Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC00E38FA78
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 08:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhEYGH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 02:07:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55861 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229621AbhEYGH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 02:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621922759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r9QfkiWTazDYUtE1Luc4hV82nC6GoaJdxYTDUHwiTtU=;
        b=Ia3nM7wZUnyBCc69CgohhfSWkhm2cKKTvivfsm/TwyzCOekdX1g9hIBSPdk2h3xouJdpLR
        KN8W+uCcYTBU/QAM1T4eYPkb3lPkHMygQ/5rHEejg2mFAbv7HHrIzkm3j4O0McuBc5AVVX
        ysLdkFe+V47E7VnDc+yrPVn8V/fMsjA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-CBk8SG8WMry_anwHQduvIA-1; Tue, 25 May 2021 02:05:57 -0400
X-MC-Unique: CBk8SG8WMry_anwHQduvIA-1
Received: by mail-wm1-f72.google.com with SMTP id n127-20020a1c27850000b02901717a27c785so5517799wmn.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 23:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=r9QfkiWTazDYUtE1Luc4hV82nC6GoaJdxYTDUHwiTtU=;
        b=fXrRlT5PCFksWqR+GWYJMzPNE0bd+GHjJauAJxigXBX3xLYTJSWtEKto5GFlCgnsD4
         cqVI3INgDglU6ibB5lSwRED8w5iwUbgfEz9Y8xA3+A7u56+HUSjyjTzKb349m//bnsHg
         OWjfItcGcY14OrQEFpuLVkYmnHhEY6MOKvD25We5P0ZyP63pN68OXI9Vq6Sh3C4RA6TE
         IBBrwuw/bXenm4aTyUn4fSgMV3Vrhy2rrb6s/kGLG24/ISujDaBN61T9EDaARHbkZZmJ
         DfPyrdwJdWjh/CgMNOTdtjSpn0tZiRPULdEVtEbtJKGiV3zdWhq8dGcpbSw1Bl1+6B+k
         r6Ew==
X-Gm-Message-State: AOAM530O6hWF4c3keHqvL29EFzc1DSdt+9WBDBFg8Gj8ZaAWOE6ASdRn
        7Y7YtlnATBo2LtZctAFt1XTx4y2/M28grZJdCV4Npc8jat4t3Ey0fWOo5fbKAlnrPGxvoIgtpBM
        TuTjts1N6Xt93GhC6DAM5fNUN
X-Received: by 2002:a5d:64cf:: with SMTP id f15mr24582939wri.327.1621922756166;
        Mon, 24 May 2021 23:05:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfsthrHqZDORFny3PkPPPeOrcDPeoQH9q5hYHy/9xCUEv21MTIaAZm54SxRMgPqJN2wFdkfQ==
X-Received: by 2002:a5d:64cf:: with SMTP id f15mr24582933wri.327.1621922756019;
        Mon, 24 May 2021 23:05:56 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n20sm9759911wmk.12.2021.05.24.23.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 23:05:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: Fix ERROR: modpost: .kvm_vcpu_can_poll undefined!
In-Reply-To: <1621911770-11744-1-git-send-email-wanpengli@tencent.com>
References: <1621911770-11744-1-git-send-email-wanpengli@tencent.com>
Date:   Tue, 25 May 2021 08:05:54 +0200
Message-ID: <87im378i0t.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> From: Wanpeng Li <wanpengli@tencent.com>
>
> Export kvm_vcpu_can_poll to fix ERROR: modpost: .kvm_vcpu_can_poll undefined!
>

Fixes: 0fee89fbc44b ("KVM: PPC: exit halt polling on need_resched()")

> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  virt/kvm/kvm_main.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 62522c1..8eaec42 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2949,6 +2949,7 @@ bool kvm_vcpu_can_poll(ktime_t cur, ktime_t stop)
>  {
>  	return single_task_running() && !need_resched() && ktime_before(cur, stop);
>  }
> +EXPORT_SYMBOL_GPL(kvm_vcpu_can_poll);
>  
>  /*
>   * The vCPU has executed a HLT instruction with in-kernel mode enabled.

-- 
Vitaly

