Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82864497EB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 16:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237899AbhKHPP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 10:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241055AbhKHPOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 10:14:21 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03FDC061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 07:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dxaRhZt5F08/udnZL3CT8J1LOmJHz7WyeU2TgGdEl3U=; b=ZYlxcYrANbLZOibAhF/IENDrFq
        8darFlH3eoI0uZ7T38r9vgIUO0SbL9MCfLDTsVuyqXOPH9q+41BxOp9julYgXd4J7qWj52i6Ktcx+
        OkXQDZxItZ+SK5YuUZP0qAbFZTqV8NvdkWNLnbIMXyD6tbMd0BRCmD/czn6j89W5ZYSFy/n9PU3ei
        hw4y7LWmR2hSpxiljrFbFNWYUPfZxoHZNhFRIWrCB3dVplbrDB8RiB3f3aZ3HaWNsMaCdPYbO6G8/
        G5D/XIMtUApg0H5wwY41prTHDbcEKw9vyOQKb117TlL051INr0gnWhlH0QMjDAOQ5M9h7WdBPeOgA
        7AP3rRHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mk6Ij-00Eu4k-7h; Mon, 08 Nov 2021 15:11:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 023D130030B;
        Mon,  8 Nov 2021 16:11:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 83AD3202A012E; Mon,  8 Nov 2021 16:11:11 +0100 (CET)
Date:   Mon, 8 Nov 2021 16:11:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, jgross@suse.com
Subject: Re: [PATCH] x86/smp: Factor out parts of native_smp_prepare_cpus()
Message-ID: <YYk+D17oIOGKWNtN@hirez.programming.kicks-ass.net>
References: <1635896196-18961-1-git-send-email-boris.ostrovsky@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635896196-18961-1-git-send-email-boris.ostrovsky@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 07:36:36PM -0400, Boris Ostrovsky wrote:
> Commit 66558b730f25 ("sched: Add cluster scheduler level for x86")
> introduced cpu_l2c_shared_map mask which is expected to be initialized
> by smp_op.smp_prepare_cpus(). That commit only updated
> native_smp_prepare_cpus() version but not xen_pv_smp_prepare_cpus().
> As result Xen PV guests crash in set_cpu_sibling_map().
> 
> While the new mask can be allocated in xen_pv_smp_prepare_cpus() one can
> see that both versions of smp_prepare_cpus ops share a number of common
> operations that can be factored out. So do that instead.
> 
> Fixes: 66558b730f25 ("sched: Add cluster scheduler level for x86")
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Thanks! I'll go stick that somewhere /urgent (I've had another report on
that here:

  https://lkml.kernel.org/r/20211105074139.GE174703@worktop.programming.kicks-ass.net
)

But looking at those functions; there seems to be more spurious
differences. For example, the whole sched_topology thing.

Should we re-architect this whole smp_prepare_cpus() thing instead? Have
a common function and a guest function? HyperV for instance seems to
call native_smp_prepare_cpus() and then does something extra (as does
xen_hvm).
