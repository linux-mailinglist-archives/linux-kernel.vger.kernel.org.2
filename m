Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5480840F86A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244777AbhIQM4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:56:55 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:35459 "EHLO mail.acc.umu.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238675AbhIQM4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:56:49 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by amavisd-new (Postfix) with ESMTP id 3BEC844B92;
        Fri, 17 Sep 2021 14:55:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=acc.umu.se; s=mail1;
        t=1631883326; bh=qgLCfyVcFX8eGrLJ6lf5eXw1WGfFQEn6MFUa2VUu68k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vDV1uVSivB0gfN0PY6XbhTacmLcV3fzDZkKcJa3ftJLJchyhBq+UgNGMPOL1xPi9X
         avgDp9+dYOOO84zujHqtEfCG0O20ogK8h5xRYcE1/i8daX7zf/aaHiICPX7gpq5ezV
         HU4CXPkEHx50tuU5kjg49aHXufcPGTI8aMqQwqaiQG9GGZP7kj/u48XWL3hO58t3qR
         Y3Xh/bY2dmaX9ttRJwxjnYm8WL8RCSukXD04kwLw5afUnBn9DMLGl5Jv9n01WR1mYS
         WkrytiLRPnKbsQdZHXfN4acNpaiMM3jnZxFVrIqb4CkSfPj3K7RuYCP6IVPbb3yOp/
         r/Cy8mOKS/WQQ==
Received: by mail.acc.umu.se (Postfix, from userid 24471)
        id D2CD144B93; Fri, 17 Sep 2021 14:55:25 +0200 (CEST)
Date:   Fri, 17 Sep 2021 14:55:25 +0200
From:   Anton Lundin <glance@acc.umu.se>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Issue with panic handling and ipmi
Message-ID: <20210917125525.GF108031@montezuma.acc.umu.se>
References: <20210916145300.GD108031@montezuma.acc.umu.se>
 <20210916163945.GY545073@minyard.net>
 <20210917101419.GE108031@montezuma.acc.umu.se>
 <20210917120758.GA545073@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210917120758.GA545073@minyard.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 September, 2021 - Corey Minyard wrote:

> On Fri, Sep 17, 2021 at 12:14:19PM +0200, Anton Lundin wrote:
> > On 16 September, 2021 - Corey Minyard wrote:
> > 
> > > On Thu, Sep 16, 2021 at 04:53:00PM +0200, Anton Lundin wrote:
> > > > Hi.
> > > > 
> > > > I've just done a upgrade of the kernel we're using in a product from
> > > > 4.19 to 5.10 and I noted a issue.
> > > > 
> > > > It started that with that we didn't get panic and oops dumps in our erst
> > > > backed pstore, and when debugging that I noted that the reboot on panic
> > > > timer didn't work either.
> > > > 
> > > > I've bisected it down to 2033f6858970 ("ipmi: Free receive messages when
> > > > in an oops").
> > > 
> > > Hmm.  Unfortunately removing that will break other things.  Can you try
> > > the following patch?  It's a good idea, in general, to do as little as
> > > possible in the panic path, this should cover a multitude of issues.
> > > 
> > > Thanks for the report.
> > > 
> > 
> > I'm sorry to report that the patch didn't solve the issue, and the
> > machine locked up in the panic path as before.
> 
> I missed something.  Can you try the following?  If this doesn't work,
> I'm going to have to figure out how to reproduce this.
> 

Sorry, still no joy.

My guess is that there is something locking up due to these Supermicro
machines have their ERST memory backed by the BMC, and the same BMC is
is the other end of all the ipmi communications.

I've reproduced this on Server/X11SCZ-F and Server/H11SSL-i but I'm
guessing it can be reproduced on most, if not all, of their hardware
with the same setup.

We're using the ERST backend for pstore, because we're still
bios-booting them and don't have efi services available to use as pstore
backend.


I've tested to just yank out the ipmi modules from the kernel and that
fixes the panic timer and we get crash dumps to pstore.

//Anton
