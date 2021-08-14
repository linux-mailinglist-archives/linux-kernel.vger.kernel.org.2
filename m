Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296823EC3AD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 17:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbhHNPxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 11:53:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232131AbhHNPx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 11:53:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4900860720;
        Sat, 14 Aug 2021 15:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628956381;
        bh=Jt0fOzF0pcEbaBGtTmsRAlN0CVIMP8qB1jbJroYoatI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wt1QRQM3rJiisOQ0IGur1mg6OixeqpJE6Md6AzDXjNLp+xbgtKbYlCeiohB9yuk1t
         3J8E7E5LjX3TXXf2EwJCub0T94/FdPU6eqHnEbdoxVw8s9omZPKFLfxv+G9cAwTxIw
         disY8x8/YwopZRNhLDxQZmHcneZVM+yiN+2kHjjB5mYANzMF2PqYWe4lmOcp7MbL8u
         bEZ/t8mBdiije0qk15p9f5CgIw58Us0uQTgXexUoVfRoiSxVvWwrDN0qwRvMHKo8ht
         grDZRyWwddiedIAueyMAzWXbtlXzPBIM30YTH+M/NH/c2PZ6l9ZBeUV+Xd2dJwBkyq
         MBz3RuVRbjJ9w==
Date:   Sat, 14 Aug 2021 18:52:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH] checkpatch: prefer = {} initializations to = {0}
Message-ID: <YRfm2RRYla7Nemsj@unreal>
References: <20210805104353.GD26417@kili>
 <1b94e688-a070-998a-3014-96bcbaed4cae@wanadoo.fr>
 <YRfVYxQ126AOuexl@unreal>
 <YRfZwrJUutB4IO+G@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRfZwrJUutB4IO+G@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 02:57:06PM +0000, Al Viro wrote:
> On Sat, Aug 14, 2021 at 05:38:27PM +0300, Leon Romanovsky wrote:
> 
> > There are number of reasons why you didn't notice any difference.
> > 1. {} is GCC extension
> > 2. {} was adopted in latest C standards, so need to check which one GCC 10
> > is using by default.
> > 3. Main difference will be in padding - {0} will set to zero fields but
> > won't touch padding, while {} will zero everything.
> 
> References on (3), please?

I reread gcc/c/c-typeck.c and at lest for GCC 10, I'm wrong about padding.
Sorry about that.

   8630 struct c_expr
   8631 pop_init_level (location_t loc, int implicit,
   8632                 struct obstack *braced_init_obstack,
   8633                 location_t insert_before)
....
   8692   switch (vec_safe_length (constructor_elements))
   8693     {
   8694     case 0:
   8695       /* Initialization with { } counts as zeroinit.  */
   8696       constructor_zeroinit = 1;
   8697       break;
   8698     case 1:
   8699       /* This might be zeroinit as well.  */
   8700       if (integer_zerop ((*constructor_elements)[0].value))
   8701         constructor_zeroinit = 1;
   8702       break;
   8703     default:
   8704       /* If the constructor has more than one element, it can't be { 0 }.  */
   8705       constructor_zeroinit = 0;
   8706       break;
   8707     }
   8708

