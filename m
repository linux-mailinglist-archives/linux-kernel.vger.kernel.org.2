Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4069D32CC75
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 07:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbhCDGLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 01:11:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234703AbhCDGKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 01:10:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C74A664EF4;
        Thu,  4 Mar 2021 06:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614838198;
        bh=+nG0rfRK4n053IrGSGk0WPCLcLlRFEry9QnCOUM0CYw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cVCe3irbldmwk3a04xwPK2/EONslovg8z5/44TFiwXQSxoXxLnGCkh/zTrJTB4YNu
         7d20tNK6YxmjRWHf4Vu44ZK15h0tgqlevOjfhSaYK4krBokghFVMfZCSaRXIPracy8
         JgUQP5UV4eQZ+k5M77d5WqSoDLOHFSIhQ4KEZLOM=
Date:   Wed, 3 Mar 2021 22:09:57 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, willy@infradead.org, surenb@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3] mm: cma: support sysfs
Message-Id: <20210303220957.0525de2aebc2c55ad9435cdc@linux-foundation.org>
In-Reply-To: <YEA6BGHO0I1hSjLq@google.com>
References: <20210303205053.2906924-1-minchan@kernel.org>
        <20210303144449.aa69518bfbaec9c71f799dc7@linux-foundation.org>
        <YEA6BGHO0I1hSjLq@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2021 17:38:12 -0800 Minchan Kim <minchan@kernel.org> wrote:

> > >  #endif
> > >  	char name[CMA_MAX_NAME];
> > > +#ifdef CONFIG_CMA_SYSFS
> > > +	struct cma_stat	*stat;
> > > +#endif
> > >  };
> > 
> > Why aren't the stat fields simply placed directly into struct cma_stat?
> 
> It have a related long discussion.
> https://lore.kernel.org/linux-mm/YCIoHBGELFWAyfMi@kroah.com/
> https://lore.kernel.org/linux-mm/YCLLKDEQ4NYqb5Y5@kroah.com/
> 
> TLDR - Greg really want to see kobject stuff working as dynamic
> property.

Please add to changelog?

> > 
> > ?
> > 
> > > +	if (!cma_stats) {
> > > +		pr_err("failed to create cma_stats\n");
> > 
> > Probably unneeded - the ENOMEM stack backtrace will point straight here.
> 
> I failed to find the point you mentioned to print backtrace.
> Where code do you mean to dump the backtrace?

The thing which __GFP_NOWARN disables.
