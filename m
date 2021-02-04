Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7094231005B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 23:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhBDWxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 17:53:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54793 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhBDWxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 17:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612479109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lq9nuNPtZLBS+cbRJ5imk1NIAv935j3u3Kxk6L5bw/E=;
        b=RGjAC+B0RfN2TFKWpj3xqMWXvOdTFTHQGydUuRuyb95T3X6cTax3WB1xst8kELpB69/cdD
        4GKRZyCmv74rRTPwzh/vUrRcsPK8YjGsdT1X7VYFylz5iRmfJnvoSQP4akETkvDxglnAho
        wzMXbjQHE2Daux8OzpG9aOm1eqBkFLc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-IPLjzWaTPZCoqVxozNoySA-1; Thu, 04 Feb 2021 17:51:47 -0500
X-MC-Unique: IPLjzWaTPZCoqVxozNoySA-1
Received: by mail-qv1-f69.google.com with SMTP id dh16so3450169qvb.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 14:51:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lq9nuNPtZLBS+cbRJ5imk1NIAv935j3u3Kxk6L5bw/E=;
        b=MDAfQGMffjuydBcRL/M2X37ToAQqAn10KoKRnd79h+2I6XH/3P3bmv5rad+MJDaKe6
         Vg7luj+LMy0ahYn+Y+Vb8Xgskix0kZsi2N1vQAG2ukMy5e12BRBO6QXt+BuQNfTzB8G1
         lWwms8Af8EktebE3RxwMr4se0HvxWmFC37NakJ4JzsILo1K2+hf0TIyLC4EmIRPUWGk9
         tSQMAW59HxbAHchlhLdx/Q7zF9X5fKfFP8wjM8e4hl5oiSkR1msUH59knms2QgUbUbR5
         v7OV9oJ2H6GMEx23sWfZDfS6I0Uzly0+ORXqHPEdIOg0kHVgWdKnD+dvN8cMoogU+x+D
         9dFQ==
X-Gm-Message-State: AOAM533LnxcjGo5VefOAojtCNg3ZVhs25o/S6q+MWf8x8SdYVsNMnOE0
        RqzrnbWU5EIz9yuy9bxc7IxUANfvjGBRAxJY3DWOVqwb2MjbQ2+xKU9mBzFtdvae2WK97wNnl+E
        6uGnT9km+0/rW1vp1Qj/Cb20U
X-Received: by 2002:a05:6214:9d3:: with SMTP id dp19mr1610770qvb.40.1612479107471;
        Thu, 04 Feb 2021 14:51:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxV17SHLrE+uX2s2MUEyXHm7kffYBSerSRCUe9yZR1kBi+IVmixUgCm6vr7S1S8Sgvus5iIw==
X-Received: by 2002:a05:6214:9d3:: with SMTP id dp19mr1610750qvb.40.1612479107239;
        Thu, 04 Feb 2021 14:51:47 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id u7sm5407925qta.75.2021.02.04.14.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 14:51:46 -0800 (PST)
Date:   Thu, 4 Feb 2021 17:51:44 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH] KVM: VMX: Optimize flushing the PML buffer
Message-ID: <20210204225144.GU6468@xz-x1>
References: <20210204221959.232582-1-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210204221959.232582-1-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ben,

On Thu, Feb 04, 2021 at 02:19:59PM -0800, Ben Gardon wrote:
> The average time for each run demonstrated a strange bimodal distribution,
> with clusters around 2 seconds and 2.5 seconds. This may have been a
> result of vCPU migration between NUMA nodes.

Have you thought about using numactl or similar technique to verify your idea
(force both vcpu threads binding, and memory allocations)?

From the numbers it already shows improvements indeed, but just curious since
you raised this up. :)

> @@ -5707,13 +5708,18 @@ static void vmx_flush_pml_buffer(struct kvm_vcpu *vcpu)
>  	else
>  		pml_idx++;
>  
> +	memslots = kvm_vcpu_memslots(vcpu);
> +
>  	pml_buf = page_address(vmx->pml_pg);
>  	for (; pml_idx < PML_ENTITY_NUM; pml_idx++) {
> +		struct kvm_memory_slot *memslot;
>  		u64 gpa;
>  
>  		gpa = pml_buf[pml_idx];
>  		WARN_ON(gpa & (PAGE_SIZE - 1));
> -		kvm_vcpu_mark_page_dirty(vcpu, gpa >> PAGE_SHIFT);
> +
> +		memslot = __gfn_to_memslot(memslots, gpa >> PAGE_SHIFT);
> +		mark_page_dirty_in_slot(vcpu->kvm, memslot, gpa >> PAGE_SHIFT);

Since at it: make "gpa >> PAGE_SHIFT" a temp var too?

Thanks,

-- 
Peter Xu

