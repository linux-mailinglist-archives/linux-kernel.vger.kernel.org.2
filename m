Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725D8325861
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbhBYVHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:07:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233403AbhBYUzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:55:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FA1B64DA3;
        Thu, 25 Feb 2021 20:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614286505;
        bh=G9IMobkduNXNp77gtGj9v6ooEe9z5eqMcQHbgs8ufx4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NQlmNhAKNAW/NF+b1b5yu69849sDzpqUW5wqAF8dEiPfDPvP6z32I9igms5SvkQ5E
         j2z/Slx6PSH0gG1X9LNjOOPoXws7qRAoKWkffl4YQx7xt0G+g3J8Tw3Hqr/C+UCd4X
         JR2fCTD7GiexA8Sku9gJNmfQGwTdfzfUzE/D+y/WavhReqtQHl3EV44kgvav89VnrR
         lmZbs7bGoQlzuXpc27ukSAjbBm//2Cr+dD4eMQu2rKz6vhPGrb2S7BmM0wwx5nvpci
         6sot38l5YL8JV7qQ3mo2tiAbe6jhgiyiP2TWI49079h2fLD3ARVDNL2IYtfsWnQ1uS
         laPAwgeZ6+OTQ==
Date:   Thu, 25 Feb 2021 21:55:01 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/2] checkpatch: add verbose mode
Message-ID: <20210225215501.2408c97b@coco.lan>
In-Reply-To: <CABJPP5AARO3h2mt-piPWuOD3kY_XzNfW-s2mi=btfOayVPURHg@mail.gmail.com>
References: <20210222075205.19834-1-dwaipayanray1@gmail.com>
        <bcee822d1934772f47702ee257bc735c8f467088.camel@perches.com>
        <CABJPP5AARO3h2mt-piPWuOD3kY_XzNfW-s2mi=btfOayVPURHg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 25 Feb 2021 23:38:03 +0530
Dwaipayan Ray <dwaipayanray1@gmail.com> escreveu:

> On Thu, Feb 25, 2021 at 11:03 PM Joe Perches <joe@perches.com> wrote:
> >
> > On Mon, 2021-02-22 at 13:22 +0530, Dwaipayan Ray wrote:  
> > > Add a new verbose mode to checkpatch. The verbose test
> > > descriptions are read from the checkpatch documentation
> > > file at `Documentation/dev-tools/checkpatch.rst`.
> > >
> > > The verbose mode is optional and can be enabled by the
> > > flag -v or --verbose.
> > >
> > > The documentation file is only parsed by checkpatch.pl
> > > if the verbose mode is enabled. The verbose mode can
> > > not be used together with the --terse option.  
> >
> > I don't have any real objection to this patch set, but as this
> > might be added to the Documentation tree and in .rst format,
> > perhaps Jonathan Corbet and/or Mauro Carvalho Chehab might have
> > some opinion.
> >
> > Also I do not want to be a maintainer of this .rst file and
> > likely neither Jon nor Mauro would either.  Perhaps you?
> >  
> 
> I could take it up if everybody is okay with it!
> 
> > Ideally, the patch order would be reversed so the .rst file
> > is added first, then checkpatch updated to use it.
> >  
> 
> Sure, if Jonathan or Mauro has no objections to it, I will be happy
> to resend it so that it can be picked up properly.

I don't have any objections, provided that I won't be maintaining
it :-)

-

Just my two cents:

IMO, maintaining this on a separate file can be a maintenance nightmare, 
as this is the kind of thing that can become obsolete real soon.

One alternative would be to use Pod::Usage module, just like
this script does:

	scripts/get_abi.pl

with something similar to that, calling

	$ checkpatch --man 

Could generate a man-page style with all options, while:

	$ checkpatch --help

would print the current help page.

Yet, this would generate more work for Joe, as, for every new
type, the corresponding help text would be needed.

Thanks,
Mauro
