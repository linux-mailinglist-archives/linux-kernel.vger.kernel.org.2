Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A6941F816
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 01:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhJAXNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 19:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhJAXNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 19:13:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97D1E61A56;
        Fri,  1 Oct 2021 23:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633129926;
        bh=zXrRFKYFnzDxZpyFAhZ2wpdjQvNuybBFe1IPJSuaa68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fYmNRF74XZxBmlqjGgKWDIrgfg9KxKGnnkE1wwh/3WzmmEY+FuMgA78aVn6pQTpcD
         kY2c7m0r3p9UtBGBYHyCt3SZPRWTEgO8xgMpy3h/hAVRZv0Y1QRF1KKglkQLX69LxP
         Lz45hgAMzqsuFMblCoSq0cbHCLHl5o28JEdU8WVvYuQblHw/lETlC35WgGck2owN/G
         PMYfGU7keSJIzK+cS0eW5wwY50D48snRa4Lp/yX5lw/j3KPDfaDJRH5xfrhIAMv2QT
         y5AcSDBrOqcW+wCWrjakq1p7xOFLFT2apdqInjDNVYXX4Qn9VVWICv0WHOXc5UJtN0
         KxFHnGsfa6VEA==
Date:   Fri, 1 Oct 2021 16:12:00 -0700
From:   Mike Rapoport <rppt@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memblock: Neaten logging
Message-ID: <YVeVwL24j5P5ry2z@kernel.org>
References: <623750dd31aa3fe5e45c416be98ab37707e2c45d.camel@perches.com>
 <YVYoVNFBMER4bjrT@kernel.org>
 <6573ccd25ce80f5e28ed35e4c88c898b0f994fbc.camel@perches.com>
 <YVc5RYT+MovmWiiI@kernel.org>
 <06ede4d0c1bf66614c9e9e013098a876aeec883f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06ede4d0c1bf66614c9e9e013098a876aeec883f.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 01:34:10PM -0700, Joe Perches wrote:
> On Fri, 2021-10-01 at 09:37 -0700, Mike Rapoport wrote:
> > On Thu, Sep 30, 2021 at 06:27:15PM -0700, Joe Perches wrote:
> > > On Thu, 2021-09-30 at 14:12 -0700, Mike Rapoport wrote:
> > > > Hi Joe,
> > > > 
> > > > On Wed, Sep 29, 2021 at 09:43:14PM -0700, Joe Perches wrote:
> > > > > Use more typical kernel logging styles.
> > > > > 
> > > > > o Add and use #define pr_fmt KBUILD_MODNAME ": " fmt
> > > > 
> > > > I don't see it as an improvement. On the contrary, the output becomes
> > > > somewhat tautological:
> > > 
> > > And rather easier to grep as the prefix is constant.
> > 
> > memblock_ is perfectly greppable
> 
> Of course, but only when it's there, 2 instances out of 9.

I didn't object to the patch as a whole. I just don't like the pr_fmt
definition.
 
> $ git grep '\bpr_' mm/memblock.c
> mm/memblock.c:          pr_warn("Could not allocate %pap bytes of mirrored memory\n",
> mm/memblock.c:          pr_err("memblock: Failed to double %s array from %ld to %ld entries !\n",
> mm/memblock.c:          pr_warn("Could not allocate %pap bytes of mirrored memory\n",

These can have %s for __func__ as a prefix,

> mm/memblock.c:          pr_warn("%s: No memory registered yet\n", __func__);

this one already has it,

> mm/memblock.c:  pr_info(" %s.cnt  = 0x%lx\n", type->name, type->cnt);
> mm/memblock.c:          pr_info(" %s[%#x]\t[%pa-%pa], %pa bytes%s flags: %#x\n",
> mm/memblock.c:  pr_info("MEMBLOCK configuration:\n");
> mm/memblock.c:  pr_info(" memory size = %pa reserved size = %pa\n",

and these are just fine now even without the prefix.

-- 
Sincerely yours,
Mike.
