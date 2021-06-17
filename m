Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B923ABB00
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 19:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbhFQSAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 14:00:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231408AbhFQSAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 14:00:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F490613CE;
        Thu, 17 Jun 2021 17:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623952709;
        bh=rUjI764QttB/GaYGInrf4Tbe3/WWS/GT+QlHLDq6rwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M0QIfx4jt+jacagR6M6LJC3xQiHe796rittntIFM1prryAJ+TaikDFLq84l6AzUdj
         pPIWyoKbMjXeDPlFRUVp+UQJOu7j7qgpJZcNbYvetfWCbstYxKyH9h1+Q4Wf6NG9Js
         xQFMQyGqfWUpMsdR0NsHkwnJThihlAWqSCMDQ07svg8cAMAez0TdRLfSCnSTwMW+KR
         Cw8aTUE9Ckqqgxy8LsfC83kp2WnFZkPGQ5k2LsNESurM9VAKROrqF7TYwbGGNcdPft
         cfK1aoBJDgZ1I6eQBqCZfDjw9/RRTNUmTKWUu5VO9W4wrCaOZ+hlnPjFTbty5E2SdB
         0ZSkF2y/loFiQ==
Date:   Thu, 17 Jun 2021 18:58:23 +0100
From:   Will Deacon <will@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Huang Shijie <shijie@os.amperecomputing.com>,
        Catalin Marinas <catalin.marinas@arm.com>, tabba@google.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@amperecomputing.com,
        zwang@amperecomputing.com
Subject: Re: [PATCH] arm64: kexec: flush log to console in nmi_panic()
Message-ID: <20210617175822.GG24813@willie-the-truck>
References: <20210617125023.7288-1-shijie@os.amperecomputing.com>
 <20210617175211.GE24813@willie-the-truck>
 <CA+CK2bC5XW_AjnieWZ-ro8iqr0Jb7cz5Ss5549tJTq3Zm4GYiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bC5XW_AjnieWZ-ro8iqr0Jb7cz5Ss5549tJTq3Zm4GYiQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 01:55:08PM -0400, Pavel Tatashin wrote:
> On Thu, Jun 17, 2021 at 1:52 PM Will Deacon <will@kernel.org> wrote:
> >
> > On Thu, Jun 17, 2021 at 12:50:23PM +0000, Huang Shijie wrote:
> > > If kdump is configured, nmi_panic() may run to machine_kexec().
> > >
> > > But in NMI context, the log is put in PER-CPU nmi_print_seq.
> > > So we can not see any log on the console since we entered the NMI context,
> > > such as the "Bye!" in previous line.
> > >
> > > This patch fixes this issue by two steps:
> > >       1) Uses printk_safe_flush_on_panic() to flush the log from
> > >              nmi_print_seq to global printk ring buffer,
> > >         2) Then uses console_flush_on_panic() to flush to console.
> > >
> > > After this patch, we can see the "Bye!" log in the panic console.
> >
> > Does it matter? I'd be more inclined to remove the print altogether...
> 
> I agree, the print could be removed entirely. But, my assumption was
> that this patch meant to flush other buffered prints beside this last
> "Bye" one.

That sounds like something which should be done in the core code, rather
than the in the architecture backend (and looks like panic() might do this
already?)

Will
