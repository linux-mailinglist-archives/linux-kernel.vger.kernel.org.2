Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02845435CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhJUILw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhJUILu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:11:50 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC3CC061749
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 01:09:35 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 75so24902515pga.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 01:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CTMN7KPSN1O5qa7pBmYhGzxVKXXjGfCRzg5sewZUslM=;
        b=GTV1F9mSqqd/MCvNFw2oK1SsYaOm61Qz+NoJqypSMtO0gw4i4JISREYIVYyl0FJl5U
         D4o/Bz9hrmQLOjjmOGpVLec6cyB4q2lOdfgULri1oGcPxGdb23LP6CD9mLBZkgnzyNe+
         jYr/pmH9tE6GbXU9o9majTgk5H4G8gyA4bonk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CTMN7KPSN1O5qa7pBmYhGzxVKXXjGfCRzg5sewZUslM=;
        b=rqyiDDIgFVrHkoIKWNFxn6GU46WPcd6P4XISo//Qn7xfJgyZI7zEK2nf/EsOzrxma1
         c8FZf11/8/d9iEDCH5Yml8CbSFSdYR9b6G42qJErifJW/OIsTXixyauLTqImMs8d7fB0
         NHSwk9B7Rm+pLY3YpZvl5slMg+rx46kjuO8UO2oF/v6rBCqpfYsnz3Ms8dYjuQm5Fc5+
         yucVAc08aFHGJJslB/+xHcHULDDBMd6mAXIqDIaXOY8ig3jFeDT+Bxsyh2MpRa/EtN0H
         YAJfCzay31a9VA/PSGdQL+1gCzlIzKLemzSyPg2vL6T/k7YgImjQAuYc2FvRIbp47wAG
         j1Vw==
X-Gm-Message-State: AOAM5305qjWPKryKFUJmBkow/uEoLy+Lm5eb4xxldeeoVfJp9am4Mxme
        SG4/2QIHa9Hh/z9DxBQu9bx2WA==
X-Google-Smtp-Source: ABdhPJyRLhR6XUu5vQW3hgBB2kkNZC50u8lTO8rIcflWrlCdNJurgJv8/80QxF7Q/Wc0v3v8MUUI0g==
X-Received: by 2002:a05:6a00:1a8e:b0:44c:f3cb:2a77 with SMTP id e14-20020a056a001a8e00b0044cf3cb2a77mr3798213pfv.53.1634803775131;
        Thu, 21 Oct 2021 01:09:35 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:e48:6cef:6c37:c98e])
        by smtp.gmail.com with ESMTPSA id s13sm5724536pfk.175.2021.10.21.01.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 01:09:34 -0700 (PDT)
Date:   Thu, 21 Oct 2021 17:09:29 +0900
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
Message-ID: <YXEgOf1JzTmdRP6u@google.com>
References: <20211019153214.109519-1-senozhatsky@chromium.org>
 <20211019153214.109519-2-senozhatsky@chromium.org>
 <CALzav=cLXXZYBSH6iJifkqVijLAU5EvgVg2W4HKhqke2JBa+yg@mail.gmail.com>
 <YW9vqgwU+/iVooXj@google.com>
 <CALzav=c1LXXWSi-Z0_X35HCyQtv1rh0p2YmJ289J51SHy0DRxg@mail.gmail.com>
 <YXDU/xXkWGuDJ/id@google.com>
 <YXDeRej39voc7lJU@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXDeRej39voc7lJU@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/10/21 12:28), Sergey Senozhatsky wrote:
> > 
> > We are using TDP. And somehow I never see (literally never) async PFs.
> > It's always either hva_to_pfn_fast() or hva_to_pfn_slow() or
> > __direct_map() from tdp_page_fault().
> 
> Hmm, and tdp_page_fault()->fast_page_fault() always fails on
> !is_access_allowed(error_code, new_spte), it never handles the faults.
> And I see some ->mmu_lock contention:
> 
> 	spin_lock(&vcpu->kvm->mmu_lock);
> 	__direct_map();
> 	spin_unlock(&vcpu->kvm->mmu_lock);
> 
> So it might be that we setup guest memory wrongly and never get
> advantages of TPD and fast page faults?

No, never mind, that's probably expected and ->mmu_lock contention is not
severe.
