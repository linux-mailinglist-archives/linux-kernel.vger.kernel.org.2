Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD554358F7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 05:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhJUDa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 23:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhJUDa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 23:30:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0148BC061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 20:28:10 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a15-20020a17090a688f00b001a132a1679bso2106667pjd.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 20:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pnh8bcyRjTrFkmOUHRbArZzuERhrJtMq46zgeHiKn8Y=;
        b=Cauuv1ujQRryXJrICExsWu7CW72/1HWtrSb1GYwtYwkBFkUYrpj6ApUheJRnh2swyG
         O3vIPOYG0u3bLtQMAVbsIIxkOBliaB4RBU0S/JmihkqQNQuMdmHCN10KCH8Swx5uhw7F
         qY7hqiSbNgvLr6TVG7w71gWOlWavsV9ebke9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pnh8bcyRjTrFkmOUHRbArZzuERhrJtMq46zgeHiKn8Y=;
        b=mzWf+kHdwbjFT5KMVzGUcy4XS/bbZaFjiea2s2LzY/BqPB8RooBaOoikFTX8MRk7KY
         IXsuCzxmJsH8+UIobWQMWsxi0rmGO/cuPc7s67u2h26h2iXaW3g+sz8SDWbQ9RproRX+
         bBLzTSufR0j0HY5B6u6oYKBkgxDhqCgSXJrFR11Ka7kjeloLVPNaVaivsfxoy2BkJMyl
         xjZfoTaFL1kzBI1IHVNamLNXroN8WpWNVWo6jSbHkCGHdEXNAcVOtgFge0kiyJgYmJUm
         pISaSTQaPjIQ6tz14xKdsY51Afrk4Wz08pBY5742AcPjn/NOEOPlDphIqKs7JqjKxAA2
         +pRQ==
X-Gm-Message-State: AOAM531K/SDyPZsWc1cYXF2fHGk9u6siigm80F+o2P7xRU4nHrxuSwDe
        0EjeYUXmtwkaBIRU5wnCiliDXg==
X-Google-Smtp-Source: ABdhPJwaIRddrQYFUanxcxcEgN/hjpiSMRxc12ELAY7BZjXycEPojgJ0N6zrRC73e8qptCTdmq4pPg==
X-Received: by 2002:a17:90a:c08d:: with SMTP id o13mr3559912pjs.181.1634786890448;
        Wed, 20 Oct 2021 20:28:10 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:3bbb:903f:245c:8335])
        by smtp.gmail.com with ESMTPSA id qe7sm374163pjb.1.2021.10.20.20.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 20:28:09 -0700 (PDT)
Date:   Thu, 21 Oct 2021 12:28:05 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     David Matlack <dmatlack@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Suleiman Souhlal <suleiman@google.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHV2 1/3] KVM: x86: introduce kvm_mmu_pte_prefetch structure
Message-ID: <YXDeRej39voc7lJU@google.com>
References: <20211019153214.109519-1-senozhatsky@chromium.org>
 <20211019153214.109519-2-senozhatsky@chromium.org>
 <CALzav=cLXXZYBSH6iJifkqVijLAU5EvgVg2W4HKhqke2JBa+yg@mail.gmail.com>
 <YW9vqgwU+/iVooXj@google.com>
 <CALzav=c1LXXWSi-Z0_X35HCyQtv1rh0p2YmJ289J51SHy0DRxg@mail.gmail.com>
 <YXDU/xXkWGuDJ/id@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXDU/xXkWGuDJ/id@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/10/21 11:48), Sergey Senozhatsky wrote:
> 
> We are using TDP. And somehow I never see (literally never) async PFs.
> It's always either hva_to_pfn_fast() or hva_to_pfn_slow() or
> __direct_map() from tdp_page_fault().

Hmm, and tdp_page_fault()->fast_page_fault() always fails on
!is_access_allowed(error_code, new_spte), it never handles the faults.
And I see some ->mmu_lock contention:

	spin_lock(&vcpu->kvm->mmu_lock);
	__direct_map();
	spin_unlock(&vcpu->kvm->mmu_lock);

So it might be that we setup guest memory wrongly and never get
advantages of TPD and fast page faults?
