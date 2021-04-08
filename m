Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15FA358207
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 13:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhDHLe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 07:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231448AbhDHLex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 07:34:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1C3661107;
        Thu,  8 Apr 2021 11:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617881681;
        bh=jyaO0qglGyFdhPEM06gVFnPGc0e+8xQPP2hnY0QpVqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eV0F5TSU2bp/hGiIrSd+oZHtY2de7+gdwSpPzqLCSWbVqhFazCZrzW0mcBwdtJOzT
         rzZIHeDfuWFKff0fyM6vxueM7Q4kp47WjxOhQxPPd6UKleNDoAk58NEAtLySsj92b5
         3+6CoL3sMCPAtDIZ4jRS7LhrDGicbvF9FjRBo7d0=
Date:   Thu, 8 Apr 2021 13:34:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mitali Borkar <mitaliborkar810@gmail.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        mitali_s@me.iitr.ac.in
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8712: added spaces around
 '+'
Message-ID: <YG7qTib76wKhQeoU@kroah.com>
References: <YG690ZIRdCEcjoM6@kali>
 <alpine.DEB.2.22.394.2104081027100.3155@hadrien>
 <YG7oOezBpYsi3Fr8@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG7oOezBpYsi3Fr8@kali>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 04:55:45PM +0530, Mitali Borkar wrote:
> On Thu, Apr 08, 2021 at 10:30:09AM +0200, Julia Lawall wrote:
> > The subject line should be in the imperative, so "add" instead of "added".
> > 
> Ok Ma'am
> > On Thu, 8 Apr 2021, Mitali Borkar wrote:
> > 
> > > Clean up Check:spaces preferred around that '+' (ctx:VxV)
> > > Reported by checkpatch
> > 
> > Please try to rephrase to explain what you did and why.  "Clean up" kind
> > of states what the goal is, but your opinion about what is a clean up
> > might be different than someone else's.  It's also not necessary to cite
> > the checkpatch warning exactly.
> > 
> OKay Ma'am, will rewrite the appopriate commit message. May I know while
> resending this patch, what should I write in subject description, 
> RESEND PATCH or PATCH v2

"RESEND" is only ok if the patch and changelog text is identical to the
previous version and something got lost so it needed to be resent.

I do not think that is the case here.

thanks,

greg k-h
