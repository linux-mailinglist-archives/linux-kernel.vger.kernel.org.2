Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328E63AE6C2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 12:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhFUKK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 06:10:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhFUKK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 06:10:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F322260FDA;
        Mon, 21 Jun 2021 10:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624270122;
        bh=aHrejGGcmDmIhHj+HUSwWdS8/KvXclSYfcHaMm1QTCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HZlrDwKF3G7g21ohNC77q0CggSLV737MxzTdkxPS55h0g9gslBKC1vQPJTBSsk4da
         X0DQMo89P1h0V5le6YEk5pExHOLGFEXAAbu0B9/0axX8+HSJL7xJDwj4DJilmgDnVJ
         C8WDN+GqSzc1/S5pCLKF28lIkQTELeD5UA16mbUEarov5KOIU7eG64kVvRYFDMUnKN
         RLKgqEkw1X2hIqrmBxnIhhAyz5sVYMpdgKT9au25LFzRUgrql4yD7C+a/8RLBPX+8B
         nW7j2ypbQaQzt5hn/eJ8+wZX1heeJY32nd5l1a8mDmLiiLRfmgNB3+7aTY948MOIlL
         e1L6fMpOARASQ==
Date:   Mon, 21 Jun 2021 11:08:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Huang Shijie <shijie@os.amperecomputing.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Catalin Marinas <catalin.marinas@arm.com>, tabba@google.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@amperecomputing.com,
        zwang@amperecomputing.com
Subject: Re: [PATCH] arm64: kexec: flush log to console in nmi_panic()
Message-ID: <20210621100836.GA28788@willie-the-truck>
References: <20210617125023.7288-1-shijie@os.amperecomputing.com>
 <20210617175211.GE24813@willie-the-truck>
 <CA+CK2bC5XW_AjnieWZ-ro8iqr0Jb7cz5Ss5549tJTq3Zm4GYiQ@mail.gmail.com>
 <20210617175822.GG24813@willie-the-truck>
 <YMxhXkdqU+MVJW33@hsj>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMxhXkdqU+MVJW33@hsj>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 09:03:26AM +0000, Huang Shijie wrote:
> On Thu, Jun 17, 2021 at 06:58:23PM +0100, Will Deacon wrote:
> > On Thu, Jun 17, 2021 at 01:55:08PM -0400, Pavel Tatashin wrote:
> > > On Thu, Jun 17, 2021 at 1:52 PM Will Deacon <will@kernel.org> wrote:
> > > >
> > > > On Thu, Jun 17, 2021 at 12:50:23PM +0000, Huang Shijie wrote:
> > > > > If kdump is configured, nmi_panic() may run to machine_kexec().
> > > > >
> > > > > But in NMI context, the log is put in PER-CPU nmi_print_seq.
> > > > > So we can not see any log on the console since we entered the NMI context,
> > > > > such as the "Bye!" in previous line.
> > > > >
> > > > > This patch fixes this issue by two steps:
> > > > >       1) Uses printk_safe_flush_on_panic() to flush the log from
> > > > >              nmi_print_seq to global printk ring buffer,
> > > > >         2) Then uses console_flush_on_panic() to flush to console.
> > > > >
> > > > > After this patch, we can see the "Bye!" log in the panic console.
> > > >
> > > > Does it matter? I'd be more inclined to remove the print altogether...
> We may remove the log in the arm64 code.
> 
> But in the panic() itself, it still has many log, such as:
> 
> 	..............
> 	pr_emerg("Kernel panic - not syncing: %s\n", buf);
> 	..............
> 	dump_stack();
> 	..............
> 	kdb_printf("PANIC: %s\n", msg);
> 
> Without this patch, all these log above will loss..
> 
> > > 
> > > I agree, the print could be removed entirely. But, my assumption was
> > > that this patch meant to flush other buffered prints beside this last
> > > "Bye" one.
> > 
> > That sounds like something which should be done in the core code, rather
> > than the in the architecture backend (and looks like panic() might do this
> > already?)
> In the non-kdump code path, the core code will take care of it, please read the
> code in panic().
> 
> But in the kdump code path, the architecture code should take care of it.

Why the discrepancy? Wouldn't it make more sense to do this in panic() for
both cases, if the prints that we want to display are coming from panic()
itself?

Will
