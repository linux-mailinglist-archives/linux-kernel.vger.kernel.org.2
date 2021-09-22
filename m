Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A4A41499F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbhIVMvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbhIVMvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:51:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F6AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 05:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oAPrbliIVMtJ6nyhmSrbiDdRqfA8JQhJf2UshZDVT88=; b=tEhxQE1Rmf1aTw5P1Xwbfp0kSE
        YhEyVwt1OomoAedgQy7bd0MGsyzpJuDb6xfOPGIy5Aam6rrlnutVUT6hpOPH+vxUDYZKFZIMGrEKh
        3gQSU0/TwUk/ouYEPzD5cUnwbDumaIhLYrnr3h/7NXqphYNEu8c7OmvWIaaA1SrqbRyZW2o1nMIiw
        DpHkDrSzUBUtp8+fMzfqTHvg1AMcupoiR7sQUybbpk52IWxGnkXmOTbMpPhMF+/HhKfq773SzI5mN
        Vn/f9OxoFZzS4dAcBzm+5xJ8UuNUR2znLUvU2M4Emmgi5x28KyDkgbQlbACPLVWxFjqR07SKJXdSc
        3aNbmczA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT1do-004mud-Fa; Wed, 22 Sep 2021 12:46:36 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C64A9816EA; Wed, 22 Sep 2021 14:46:24 +0200 (CEST)
Date:   Wed, 22 Sep 2021 14:46:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
Subject: Re: [PATCH v2 0/2] x86/xen: simplify irq pvops
Message-ID: <20210922124623.GR4323@worktop.programming.kicks-ass.net>
References: <20210922103102.3589-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922103102.3589-1-jgross@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 12:31:00PM +0200, Juergen Gross wrote:
> The pvops function for Xen PV guests handling the interrupt flag are
> much more complex than needed.
> 
> With the supported Xen hypervisor versions they can be simplified a
> lot, especially by removing the need for disabling preemption.
> 
> Juergen Gross (2):
>   x86/xen: remove xen_have_vcpu_info_placement flag
>   x86/xen: switch initial pvops IRQ functions to dummy ones
> 
>  arch/x86/include/asm/paravirt_types.h |   2 +
>  arch/x86/kernel/paravirt.c            |  13 ++-
>  arch/x86/xen/enlighten.c              | 116 ++++++--------------------
>  arch/x86/xen/enlighten_hvm.c          |   6 +-
>  arch/x86/xen/enlighten_pv.c           |  28 ++-----
>  arch/x86/xen/irq.c                    |  61 +-------------
>  arch/x86/xen/smp.c                    |  24 ------
>  arch/x86/xen/xen-ops.h                |   4 +-
>  8 files changed, 53 insertions(+), 201 deletions(-)

That looks awesome, I'm totally in favour of deleting code :-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
