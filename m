Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFBF73A43FD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 16:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhFKOZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 10:25:13 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:46777 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhFKOZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 10:25:11 -0400
Received: by mail-pl1-f174.google.com with SMTP id e1so2902250pld.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 07:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V9LKi/CMslAloLgYPHzBrk4CvXkpDoxlbZy7HuBfzEg=;
        b=pkuhK9c5qSAPBGSLwWk+Hr741IHbVI+7ULYa8ELKHZ9nn1cTQ6T14xvPtMYI/uzrHL
         dEEsxctFTc3CytAFHWrgjn6SOm0MdhQX7VttOigsxfg7qOFY8MpCfb1+tmGoSLp3QLCt
         srmysUEWlnM9mps9qIznOnBE64amJQCW4wclfuDOO8g9t3eZiKZtHuD/Gx+Of9YOT/aV
         JReidt4565mUOCKXsYv4PrwvNQo2y3dP5ZcacRrohyrBQxzFyNef0SxPDkbh71ul1iqy
         wcEDRq2UsehWCXA8G8j7opMEgckgvuKcCcGrub9FoyPzTbChe+DWPMm3XYVG0UrmuDHg
         1s/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V9LKi/CMslAloLgYPHzBrk4CvXkpDoxlbZy7HuBfzEg=;
        b=iwsFD2iVu/q7hDMPUV26fcjtsoGV+eys8+ypi7L0yDHau6/0ghRXu3WqrDFkSF0ZlI
         tr/B9wPY8Si6O2V6JYpD+QI6XjBDPkPVomiSN8ktFnyisUd4XJZD4gcmDj/R8flJiwsF
         o1YeL7L5A5WRcYJVBIIaTTDDYUp6ECOU0n87pX0JYNeq6rhVYeGhc/MMItB3nc4f6+f9
         tOXG2IMlOmv3/WYA1BgBdn7+bo+OCmOERLLaFVMEmb2VC66L/wI98BwVvQ/qVxOYMtub
         XZ6Kkei7knQ456ETE1gCw7ee3xBc8IvAp3Ik62zBzcr0STqtqK1oiETrFf6zKe4C966T
         Vf3g==
X-Gm-Message-State: AOAM532hcsBFoekk8NdT0jf5UgqieLggno1sTe9Ea7pRjRc5OxLcq4ng
        FyfaIRw3ASVs5UHihVRmmHu36Q==
X-Google-Smtp-Source: ABdhPJwHHxZK3iZe6LilvAzAWn3mvPXw4rKGFSgD6Uq9obg5LrUMj5tKJ1/m5mkA2ZQuEk0lLjoV5w==
X-Received: by 2002:a17:90b:38ca:: with SMTP id nn10mr4926433pjb.127.1623421333642;
        Fri, 11 Jun 2021 07:22:13 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j12sm5659788pgs.83.2021.06.11.07.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 07:22:12 -0700 (PDT)
Date:   Fri, 11 Jun 2021 14:22:09 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/mmu: Calculate and check "full" mmu_role for
 nested MMU
Message-ID: <YMNxkRq5IIv+RWLN@google.com>
References: <20210610220026.1364486-1-seanjc@google.com>
 <87bl8cye1k.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bl8cye1k.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021, Vitaly Kuznetsov wrote:
> What I don't quite like (besides the fact that this 'nested_mmu' exists
> but I don't see an elegant way to get rid of it) is the fact that we now
> have the same logic to compute 'level' both in
> kvm_calc_nested_mmu_role() and init_kvm_nested_mmu(). We could've
> avoided that by re-aranging code in init_kvm_nested_mmu() I
> guess. Something like (untested):

Yep, cleaning all that up is on my todo list, but there are some hurdles to
clear first.

My thought is to either (a) initialize the context from the role, or (b) drop the
duplicate context information altogether.  For (a), the NX bit is calculated
incorrectly in the role stuff, e.g. if paging is disabled then NX is effectively 0,
and I need that fix for the vCPU RESET/INIT series.  It's benign for the role,
but not for the context.  And (b) will require auditing for all flavors of MMUs;
I wouldn't be the least bit surprised to discover there's a corner case (or just
a regular case) that I'm overlooking.
