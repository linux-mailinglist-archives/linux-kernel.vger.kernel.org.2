Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9713B433607
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbhJSMfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:35:22 -0400
Received: from smtp2.axis.com ([195.60.68.18]:15637 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhJSMfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1634646789;
  x=1666182789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VZejVFBRwmJpF+m8eEegQmLVGPM2SFg4rdhcPABbUcE=;
  b=QbLMzpPSJG69EYgTc4xywmI/CXIguP6te2Tr8254VAFi79Yng4eHzDdL
   fvFBnEpBthnVh/IIUEbrjjgYPvIrVxlEzFbbhpepSIDTrSAca4bzS0UC+
   Y4x0io0GwkFYxR6WDf8BTt3piJB5dFmyb+emf3Fou0O40WoadjGuIGYfo
   545Pk/oV3ZR8T3kYUDHwGRNWcgBke6eqHD8zF0RcEMgRidTNqHb9lGRUP
   LsjbEEFPcxia0OBSFf44pjTB7W4VvgwuxhiqtNLBf4+grmSw3m1c+wS/i
   eoD6GdIB3OknSnU7kjghmmcxQzLlMMwkb+PLOK1gNIwnMRwBhVAApmPfO
   w==;
Date:   Tue, 19 Oct 2021 14:33:08 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Will Deacon <will@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        kernel <kernel@axis.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: ptdump: Allow dumping user page tables
Message-ID: <20211019123307.GA20031@axis.com>
References: <20211001145603.22024-1-vincent.whitchurch@axis.com>
 <20211019120931.GJ13251@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211019120931.GJ13251@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 02:09:32PM +0200, Will Deacon wrote:
> On Fri, Oct 01, 2021 at 04:56:03PM +0200, Vincent Whitchurch wrote:
> > Add a user_page_tables debugfs file (similar to kernel_page_tables) to
> > dump out the userspace page tables for the current process.  This
> > provides details which are not available via pagemap (such as the memory
> > type) and is useful when, for example, debugging ->mmap()
> > implementations.
> > 
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > ---
> >  arch/arm64/mm/ptdump.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> How does this serialise with things like task exit?

A task can only read its own page tables using this file, and the mm
lock is held during the walk in ptdump_walk_pgd().  Isn't that
sufficient?
