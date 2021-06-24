Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FB43B32BC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 17:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhFXPjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 11:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbhFXPjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 11:39:04 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826A7C061760
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 08:36:45 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id v12so3140607plo.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oSmcLkLaYmb30K4x2o5V0PgF5sReFf2n8jT9UaERRsg=;
        b=bSQo4DhU2KuL3CjUZN64j4WcwdggQch/R7XnEdix2NVuOf40qPGfYHBno8Xm619GAr
         wg2kvoNy4VPNerE1UJQqTO/mn+wSl2WW8B9f7dL8xOzOgdg74JEfehGKdbWSQ0+1rr/t
         2LEY4HKbsscIOGINiR9uO5OVpBxOglyxXqSvwqqzzZpKt1BhIehu/QDEuFSbgcAbmd1A
         2Vn5BfcWryEpw7ny/6e9BAwB13V5uLq3/TeIlPL3nNBaDSZ9vfocg3yuStOuQjDnW2a3
         vbLINUOPqFtht9Zb0kQj2xFTxtidhP/wmPjkGUm290ZvEfhGiSSc1t+MN7azCayA+NIy
         PYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oSmcLkLaYmb30K4x2o5V0PgF5sReFf2n8jT9UaERRsg=;
        b=hBA5OnJVNcHqMobDp41itI0jBgT+o1fVP4k5Hk/OQrRzqfhkz0MDc+wQCeeD1Lncf6
         0qoQ0GAG4I5hoamt1/hGs8C7K6H2Rbti1FTP0nWQQLrWgS/0pvmToLSnXrPsZhPnBueY
         MX7Zid8JMlcTcrPj7Uifxfg1tbYaKdGtw/ZJLq65pMyqvfCtpzfaMfBY+xGKGtzhn4pY
         3GFTPGjA2Jjwr5tjw9jUDv8ZuRgu+PHu8nqKZh1F9WhPF8UXcbpEp40kqYLXq12MG/kb
         nQb9OOFoYaxBaN6xSrp0YczE7ApvUsYUeWxIazJkfQVv79AjRJ7huFCl8BsfCDpYc991
         NnAA==
X-Gm-Message-State: AOAM533IXIf8/oidvJEZQZDbF5+2Rny6VF7IBIzXJ2E/EXpqFf9JGnNR
        MZLem5czgeWNOO6t6omOg5l3vw==
X-Google-Smtp-Source: ABdhPJxfmbtVti63yi0rwniZ/V3vp7ddChowhbbwk916pZwapRYWPu+wwBqr+2N8fYjWJaOb0U93+Q==
X-Received: by 2002:a17:90a:8542:: with SMTP id a2mr14115924pjw.185.1624549004763;
        Thu, 24 Jun 2021 08:36:44 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p1sm3132065pfp.137.2021.06.24.08.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 08:36:44 -0700 (PDT)
Date:   Thu, 24 Jun 2021 15:36:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        David Stevens <stevensd@chromium.org>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        James Morse <james.morse@arm.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvmarm@lists.cs.columbia.edu,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/6] KVM: x86/mmu: release audited pfns
Message-ID: <YNSmiOsmJin4UPcG@google.com>
References: <20210624035749.4054934-1-stevensd@google.com>
 <20210624035749.4054934-2-stevensd@google.com>
 <1624524156.04etgk7zmz.astroid@bobo.none>
 <4816287a-b9a9-d3f4-f844-06922d696e06@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4816287a-b9a9-d3f4-f844-06922d696e06@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021, Paolo Bonzini wrote:
> On 24/06/21 10:43, Nicholas Piggin wrote:
> > Excerpts from David Stevens's message of June 24, 2021 1:57 pm:
> > > From: David Stevens <stevensd@chromium.org>
> > 
> > Changelog? This looks like a bug, should it have a Fixes: tag?
> 
> Probably has been there forever... The best way to fix the bug would be to
> nuke mmu_audit.c, which I've threatened to do many times but never followed
> up on.

Yar.  It has only survived because it hasn't required any maintenance.
