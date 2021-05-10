Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF63D378DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349457AbhEJMta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241048AbhEJLh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:37:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3770C0612EF
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 04:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=TVPjZAPijAHa4LLIWNuJ7wX5h0yLsHB88OKvBcyrgOo=; b=Gw1gDi9F8ySm9OmXtdCpTxBtJg
        Nq3qzu+lXQfCZfJwhi+774DevttDiMcVEwLMIXFt6kcxjVSmJKOBvR/oN1/wZk8GwzpL6opOQwnEr
        eWvtD1szk+xiE7MTg/c6Cd4ktFdvjdYp0YELxgAg1m2R5H4h/7/R1cLpqj6ylG3WTx1ljqIocEFuv
        521+Hbg4Nb+AkVWd7EReAGd6Uq+gwPWjom7BhVcI8qV+q447UnxQ7X/JPUmtBqEUtgd4XfGQZHyk6
        5XLw1M5g+Y7DFnFv6oBshdWuk/6MEJCRw5EeShxPlFUk6obt6nFHGmcIXXK5q2/Sfyp+oRlBTNwhT
        OnHZTXCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lg48m-00E5um-VO; Mon, 10 May 2021 11:32:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 32B893002C4;
        Mon, 10 May 2021 13:32:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10A7C2028F007; Mon, 10 May 2021 13:32:00 +0200 (CEST)
Date:   Mon, 10 May 2021 13:31:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 0/3] xen: remove some checks for always present Xen
 features
Message-ID: <YJkZr7yIVVW1Fw+o@hirez.programming.kicks-ass.net>
References: <20210422151007.2205-1-jgross@suse.com>
 <3c89ca14-8790-2d0e-a115-16a0976f68e3@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3c89ca14-8790-2d0e-a115-16a0976f68e3@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 09:34:18AM +0200, Juergen Gross wrote:
> On 22.04.21 17:10, Juergen Gross wrote:
> > Some features of Xen can be assumed to be always present, so add a
> > central check to verify this being true and remove the other checks.
> >=20
> > Juergen Gross (3):
> >    xen: check required Xen features
> >    xen: assume XENFEAT_mmu_pt_update_preserve_ad being set for pv guests
> >    xen: assume XENFEAT_gnttab_map_avail_bits being set for pv guests
> >=20
> >   arch/x86/xen/enlighten_pv.c | 12 ++----------
> >   arch/x86/xen/mmu_pv.c       |  4 ++--
> >   drivers/xen/features.c      | 18 ++++++++++++++++++
> >   drivers/xen/gntdev.c        | 36 ++----------------------------------
> >   4 files changed, 24 insertions(+), 46 deletions(-)
> >=20
>=20
> Could I please get some feedback on this series?

I'm obviously in favour, but given I'm not an actual Xen user that might
not be worth much, still:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
