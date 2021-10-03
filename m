Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627B2420048
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 08:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhJCGFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 02:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhJCGFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 02:05:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC61C61872;
        Sun,  3 Oct 2021 06:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633241043;
        bh=GMxcFw+H5zCy90UDkXRSw9WX9TSeYQZzDe7rSV/Tr5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hTo8hU0HPBQedF/3L7QqO312UYzIQX1cvjyoNS8oeYshI0Y5+hEeiWVK1myHFQ+Eu
         hV19bP4CCYRP/uMsbJfLjknJT1ZT6bMsxMvBKRzKZ28Qo/+tKIyca6liApCUG6M6OL
         fN5sPatG81hS7Y2QXV/QUtkb/643UfergAs8mRUItCrt2BcNwIDI70s4o9K/XcDeVc
         8BC/C/25BFcHM5Z4CAx3ZznW3sN/gwEY1TPTSUdeubzRSqBYeIhzgjrSkx4gKc+z2V
         TYRbM16EnQXivfISYuRrtwNcbi0o+NoBCDDSz8aD5YkOq2UOWQGvlykGLJ3KtzIOWw
         KKej39z+PzGdg==
Date:   Sat, 2 Oct 2021 23:03:55 -0700
From:   Mike Rapoport <rppt@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memblock: Neaten logging
Message-ID: <YVlHy7kL1MKZaH6C@kernel.org>
References: <623750dd31aa3fe5e45c416be98ab37707e2c45d.camel@perches.com>
 <YVYoVNFBMER4bjrT@kernel.org>
 <6573ccd25ce80f5e28ed35e4c88c898b0f994fbc.camel@perches.com>
 <YVc5RYT+MovmWiiI@kernel.org>
 <06ede4d0c1bf66614c9e9e013098a876aeec883f.camel@perches.com>
 <YVeVwL24j5P5ry2z@kernel.org>
 <7c9103aee37509a28e426756bce7d6a5ae0ced16.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c9103aee37509a28e426756bce7d6a5ae0ced16.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 04:20:14PM -0700, Joe Perches wrote:
> On Fri, 2021-10-01 at 16:12 -0700, Mike Rapoport wrote:
> > On Fri, Oct 01, 2021 at 01:34:10PM -0700, Joe Perches wrote:
> > > On Fri, 2021-10-01 at 09:37 -0700, Mike Rapoport wrote:
> > > > On Thu, Sep 30, 2021 at 06:27:15PM -0700, Joe Perches wrote:
> > > > > On Thu, 2021-09-30 at 14:12 -0700, Mike Rapoport wrote:
> > > > > > Hi Joe,
> > > > > > 
> > > > > > On Wed, Sep 29, 2021 at 09:43:14PM -0700, Joe Perches wrote:
> > > > > > > Use more typical kernel logging styles.
> > > > > > > 
> > > > > > > o Add and use #define pr_fmt KBUILD_MODNAME ": " fmt
> > > > > > 
> > > > > > I don't see it as an improvement. On the contrary, the output becomes
> > > > > > somewhat tautological:
> > > > > 
> > > > > And rather easier to grep as the prefix is constant.
> > > > 
> > > > memblock_ is perfectly greppable
> > > 
> > > Of course, but only when it's there, 2 instances out of 9.
> > 
> > I didn't object to the patch as a whole. I just don't like the pr_fmt
> > definition.
> 
> You should do what you like.  I did what I like.
 
I'm perfectly fine with the current state.

-- 
Sincerely yours,
Mike.
