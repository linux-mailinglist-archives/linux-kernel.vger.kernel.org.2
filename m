Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4FF35ABE6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 10:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbhDJIcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 04:32:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229632AbhDJIcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 04:32:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7CCB610C8;
        Sat, 10 Apr 2021 08:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618043503;
        bh=TLe3b6eYl5WXk+SrGIqyCYCg/bSYEiSQG3SxWxQ8LvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XOWTgARkjElBB5yfl2YiPxa34rMrEFaaSfFy4aj8LQhv51SAGx8kkJnE8Zsw5OIMQ
         GtjRRgNIG6KKlmq6Xw56aJN5xl+ZAKr1CHYAP1/AqawFIMr+nwsXnozcD5oHroHaEU
         4FBOy9Ackv95/ZB573PW3fxr9HnEq++B1TyNRpGY=
Date:   Sat, 10 Apr 2021 10:31:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mitali Borkar <mitaliborkar810@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Re: [PATCH 0/6] staging: rtl8192e: cleanup patchset for style issues
Message-ID: <YHFibAvRrun6Jk6T@kroah.com>
References: <YHEAnyO11wgp5PNZ@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHEAnyO11wgp5PNZ@kali>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 07:04:23AM +0530, Mitali Borkar wrote:
> This patches fix the cleanup style issues.
> 
> Mitali Borkar (6):
>   staging: rtl8192e: add spaces around binary operators
>   staging: rtl8192e: remove unnecessary blank line before brace
>   staging: rtl8192e: remove unncessary blank line after brace
>   staging: rtl8192e: matched alignment with open parenthesis
>   staging: rtl8192e: removed multiple blank lines
>   staging: rtl8192e: align statements properly
> 
>  drivers/staging/rtl8192e/rtl819x_HTProc.c | 43 +++++++++--------------
>  drivers/staging/rtl8192e/rtl819x_TSProc.c | 28 +++++++--------
>  2 files changed, 29 insertions(+), 42 deletions(-)

You emails are not threaded properly at all :(

Look at how this showed up on lore.kernel.org:
	https://lore.kernel.org/linux-staging/YHEAnyO11wgp5PNZ@kali/

See, only the first email shows there.

But here is a properly threaded series of patches:
	https://lore.kernel.org/r/161793058309.10062.17056551235139961080.stgit@mickey.themaw.net

Look down at the bottom of the page to see all patches, and the
responses, linked together.

Please use 'git send-email' to send your patches out as it will
correctly thread things if you do not know how to do this "by hand".
And note, "by hand" is hard to do...

I have now dropped all pending patches from you from my queue, please
fix up your two patch series and resend.

thanks,

greg k-h
