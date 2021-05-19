Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53CF3886E6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 07:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245001AbhESFoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 01:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345541AbhESFjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 01:39:18 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C99C061344
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:36:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso2201673pjq.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PF0Q9frtyuRcpG5BnVwblhIE9pTcOMwFzNkIPovg6ss=;
        b=fPntYKFrfOpVF5bsRxvyNYfSvgwcRiEFZauBnsgNc714SkShf+0dbqLl8QmDVYhrfH
         kgwFCSECHlKHRwVGCGHNvDDajtJHW6W6k8EZC8hvEZvwBw1Vt3CfRqFKSdty1pmnyJcC
         KHODAHZ3o/KfJGHNlrUR94dVV1ocjzG8NjPuf5CgVUVe37K4DALkP+uky+FyubR0mDxq
         7yudjjySKl1FF/foqnvQEba2Ra/eGdaMvVhmiAiWI9J8J2D8Gx1C0hNwm7XrAgrMX40p
         qN+i412QPwTL4OoOYS1g5p4JhO/9/zfIJfzb60IpMxup9jLBi649xfCzE+n9y77tfJvf
         MV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PF0Q9frtyuRcpG5BnVwblhIE9pTcOMwFzNkIPovg6ss=;
        b=GS2vZsej8TbfuUjNbqbMt/MCI9k0aWLxKEyuJs6aPnkE0rndAivJJ/9NE69CMpXDid
         /V6JWPKHT92jrcPWj3Pwu16a1DyhU8MMBgAOL/e3azh4gOuHJla0+tf2QOZXE+KToXVj
         maAMFywzF7dFfwC6NEjzVNPyMTw6XSHMFRAzaVqKqSrryLhiKoj6dRyRxxCP/9LyTvC4
         fxfFFmE1sCFby5H+nYRRLfyKM0ZbQhajr7O1HQb0r/hj0Y4E8/tMkybis/O4qhjtiliw
         0Z5KKkUJ/eTbd1gpdpgXIWj9pKOtd3BUJXC+Z+Ye9tZsAJlrDp1q9r9CxBiIzMd2cUr3
         lDPg==
X-Gm-Message-State: AOAM530IGzDL64G3c7jVq2jkQTK0AXYiP8dEo1ltEKDuBFLh52bQVuNa
        4uweg4g4Wo5oFgG4i0QIVdbQt9o6SG4ebYqsTjRulg==
X-Google-Smtp-Source: ABdhPJyA79FOqU3/Od6UZdXL1PxGWbUxYoT7oxm+gXEJ1WS7h82tWs1Q0kPfOgfMXPQz7HFvZPc3NztpIBNSyIqi+Nk=
X-Received: by 2002:a17:90b:1185:: with SMTP id gk5mr5791984pjb.168.1621402571226;
 Tue, 18 May 2021 22:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com> <20210424004645.3950558-34-seanjc@google.com>
In-Reply-To: <20210424004645.3950558-34-seanjc@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Tue, 18 May 2021 22:35:55 -0700
Message-ID: <CAAeT=FwtKXc6_gjf8YAx9yLn+aTXZ3rdzxXW-+dxPWR_mm=uDA@mail.gmail.com>
Subject: Re: [PATCH 33/43] KVM: VMX: Refresh list of user return MSRs after
 setting guest CPUID
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 5:55 PM Sean Christopherson <seanjc@google.com> wrote:
>
> After a CPUID update, refresh the list of user return MSRs that are
> loaded into hardware when running the vCPU.  This is necessary to handle
> the oddball case where userspace exposes X86_FEATURE_RDTSCP to the guest
> after the vCPU is running.
>
> Fixes: 0023ef39dc35 ("kvm: vmx: Set IA32_TSC_AUX for legacy mode guests")
> Fixes: 4e47c7a6d714 ("KVM: VMX: Add instruction rdtscp support for guest")
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Reiji Watanabe <reijiw@google.com>
