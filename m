Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE1A4597CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 23:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbhKVWoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 17:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbhKVWn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 17:43:58 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59094C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 14:40:51 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id k4so15342722plx.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 14:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kyLZi3PpmHyfmopW/0k/0+LP8Sn51a/gYYGa2kBv86o=;
        b=I5pXmJGkPb+93uqXYZnS5FsYESZqGcTujZHlTPdD6joHshT+v3EqSt+6bF8A/HKO4K
         QVxM3eDzQ+TkGPxjBy+dM0fEK/EeMXmO/OrUVxY2ZNktRYhc5wX3tQ080X3+R/yK28eQ
         Heoc9ts3oTmZ60vH6yRzCgaIdSHhwTTPGSojTatjZ6ZDsV+nK9/L5jPrsGz6ncrmarnZ
         L92GVmz2+gNqDzfgGZHg7Ufw2CnHRyOShnZ4k1Ja7opHgOAnd1o1gwqk2ekH3j8XHHQa
         0zKDVQHZut3JL0a6YpwG2d7uzOwGKe/fxuhowO6mTuvNwJ7WYVXxc/AeczyyWfWEtUSQ
         BprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kyLZi3PpmHyfmopW/0k/0+LP8Sn51a/gYYGa2kBv86o=;
        b=oZec+sdRhbOAsipRa3OB13OSDifIRrEVGSMEQbDWSvBKAPkycx7xy46CTWsPAKPBN5
         M/eHppt3P/yF/Lv4WWL7YKbRhxNwuQ7Qm/6z7X4IatdfP8pBH1hZ9lhXhYDVCy1Ggpp7
         r6ng/6WqEqv1pR7ZbFh2qrivmLA2B1/W2q8py1ufMhMfJvbY/0ejURaw+CjBTDfnKMDB
         SX5Og6yaeFZROZnN8EzqijB5ZbgVANXcfhWUby9K2j9d+X9N+OQT5KgRPGXNndNjMaer
         NNfONsa14KHvoqP4lKJig1EzY82B5N6XPJ14JDUWyB/oLAZJI8vpm0jFkM/oddV07AyT
         Y8Xg==
X-Gm-Message-State: AOAM533Qv9Rl6ywS5jcBVpEnnTQsPxDKW8hAMr9qiXiTg4aM0IfXoNaZ
        go3LgSt3ZWmqBVZFDIK4tsXdPA==
X-Google-Smtp-Source: ABdhPJxEPccZkqsw4Ee9A1/PnjC6cBbJHkvXs/nFs6u3vTe20nV9Hh2/n78GP0aOF5w774AVDqkpCw==
X-Received: by 2002:a17:90a:c506:: with SMTP id k6mr512036pjt.74.1637620850737;
        Mon, 22 Nov 2021 14:40:50 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id x33sm9944652pfh.133.2021.11.22.14.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 14:40:50 -0800 (PST)
Date:   Mon, 22 Nov 2021 22:40:46 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hou Wenlong <houwenlong93@linux.alibaba.com>
Subject: Re: [PATCH 10/28] KVM: x86/mmu: Allow yielding when zapping GFNs for
 defunct TDP MMU root
Message-ID: <YZwcbu/qt3obyWSK@google.com>
References: <20211120045046.3940942-1-seanjc@google.com>
 <20211120045046.3940942-11-seanjc@google.com>
 <CANgfPd_H3CZn_rFfEZoZ7Sa==Lnwt4tXSMsO+eg5d8q9n39BSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgfPd_H3CZn_rFfEZoZ7Sa==Lnwt4tXSMsO+eg5d8q9n39BSQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021, Ben Gardon wrote:
> On Fri, Nov 19, 2021 at 8:51 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > Allow yielding when zapping SPTEs for a defunct TDP MMU root.  Yielding
> > is safe from a TDP perspective, as the root is unreachable.  The only
> > potential danger is putting a root from a non-preemptible context, and
> > KVM currently does not do so.
> >
> > Yield-unfriendly iteration uses for_each_tdp_mmu_root(), which doesn't
> > take a reference to each root (it requires mmu_lock be held for the
> > entire duration of the walk).
> >
> > tdp_mmu_next_root() is used only by the yield-friendly iterator.
> >
> > kvm_tdp_mmu_zap_invalidated_roots() is explicitly yield friendly.
> >
> > kvm_mmu_free_roots() => mmu_free_root_page() is a much bigger fan-out,
> > but is still yield-friendly in all call sites, as all callers can be
> > traced back to some combination of vcpu_run(), kvm_destroy_vm(), and/or
> > kvm_create_vm().
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> Reviewed-by: Ben Gardon <bgardon@google.com>
> 
> I'm glad to see this fixed. I assume we don't usually hit this in
> testing because most of the teardown happens in the zap-all path when
> we unregister for MMU notifiers

Or more likely, when the userspace process exits and kvm_mmu_notifier_ops.release
is invoked.  But yeah, same difference, VM teardown is unlikely to trigger zapping
by putting the last TDP MMU reference.

> and actually deleting a fully populated root while the VM is running is pretty
> rare.

Hmm, probably not that rare, e.g. guest reboot (emulated RESET) is all but
guaranteed to trigger kvm_mmu_reset_context() on all vCPUs and thus drop all roots,
and QEMU at least doesn't (always) do memslot updates as part of reboot.
