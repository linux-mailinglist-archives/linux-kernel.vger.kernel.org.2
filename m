Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E49A45AA8B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 18:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbhKWRyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 12:54:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231597AbhKWRyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 12:54:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8579260F6E;
        Tue, 23 Nov 2021 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637689857;
        bh=WKYNL/9N4GLwSGaYzXyap1kJP+9X+sVzPH05htv7clA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V6U6e9MgkAYnsnIO+DSA3NrAKsGAOfMp0wZn2nMFl90IUs64nYbZIbKLY1gD5wp12
         67mh/o0SUUB/iRaqZbTnb0ZaJKW3jS2b4zRq8Howfp1u2ynDyLjLqV2zZ+PyElUh3b
         DC2IYHJBkPO7oqwZqWpMAHXOlDA5B9J46PsNTVYYp4gLRueh7UX/vKO+0auyBF5f0+
         OREYTJrhj1Wqnx6slyv7zfht/oLFKhGcE8YOHQOQk/epeBMpyStqDiR33IlHAv+Kcn
         c6nHBYz/jgvPDTt2adkLGOXv025F88j9WxgwtKF/4OcQD2b49LwK9GQQUGRc97GYq2
         D8iyyK38YeGbA==
Date:   Tue, 23 Nov 2021 11:56:10 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: arch/mips/mm/tlbex.c:2243:3: warning: unannotated fall-through
 between switch labels
Message-ID: <20211123175610.GA8713@embeddedor>
References: <202111230719.OZDUHU4z-lkp@intel.com>
 <20211123005528.GA550759@embeddedor>
 <ea07a2f1e20503965c7c2eba7c0a7a4538457265.camel@perches.com>
 <20211123165057.GA7382@embeddedor>
 <b73d287a696c10279cd0c931840ce95b03876d58.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b73d287a696c10279cd0c931840ce95b03876d58.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 09:25:17AM -0800, Joe Perches wrote:
> On Tue, 2021-11-23 at 10:50 -0600, Gustavo A. R. Silva wrote:
> > On Tue, Nov 23, 2021 at 12:52:30AM -0800, Joe Perches wrote:
> > > 
> > > Perhaps this would be better:
> > 
> > Feel free to send a proper patch.
> 
> I commented on your proposed patch.

And I reply giving you an option if you want to proceed.

> And I'd prefer you actually look at and improve the code instead
> of merely silencing warnings.

If this is a matter of preference then I should express my preferences, too.
So, I prefer to give you the opportunity of improving the code and not being
pedantic at the same time. :)

Thanks
--
Gustavo
> 
