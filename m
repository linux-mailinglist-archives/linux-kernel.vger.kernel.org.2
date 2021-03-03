Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6944732C41D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354848AbhCDALV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:11:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:44260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232698AbhCCXFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 18:05:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FEED64EE8;
        Wed,  3 Mar 2021 23:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614812677;
        bh=LLNB+UI2UPQXI+JBuT9LMYZKQEe0SOGt6ZK51L5K7K0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NlAFDFllucXS7/2/69xzyUxVXotp5BD8x968KlCxSDmbcI+kz7ORUO7IUcR1CHw21
         pz7NgC5JnrV9PeFGAH4hFe5UGxBTENWqJfvKkOgp1vbHNu8HTkF6/Qx2qdSKpQBFTA
         96BIOXwb1fRRk9O8TRxQm8FXLC0wqFNCCbarIByA=
Date:   Wed, 3 Mar 2021 15:04:36 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Cleanup and fixups for vmemmap handling
Message-Id: <20210303150436.2cec3a161532d857af421651@linux-foundation.org>
In-Reply-To: <20210303183830.GH22305@zn.tnic>
References: <20210301083230.30924-1-osalvador@suse.de>
        <20210302160935.eb91809c253d1caa7d0e896d@linux-foundation.org>
        <20210303183830.GH22305@zn.tnic>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2021 19:38:30 +0100 Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Mar 02, 2021 at 04:09:35PM -0800, Andrew Morton wrote:
> > >  arch/x86/mm/init_64.c | 189 +++++++++++++++++++++++++++++++-------------------
> > 
> > Perhaps a better route would be via an x86 tree.
> 
> I assumed you took mm stuff, even if arch-specific. I can still take
> them through tip if you prefer...
> 

I don't mind.  Some review-and-acking would be nice?
