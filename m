Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B0535AD91
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 15:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhDJN1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 09:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234091AbhDJN1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 09:27:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5E0D61028;
        Sat, 10 Apr 2021 13:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618061207;
        bh=rPcqecjTvR3ky4zAY9nAY6o/ftBaMVw2xbvS/QjaU7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xdNb3ctGMcQ5Z2mb8Do+Hs9vL3Ur6qOKYFdQF6Zou2geHqapx9aTilw+CXoRikCyX
         oVAFlxCy2JGRt21rHBokDnp8poIxdHT7qIHlvW9fgKK3VmMfJDTYHbM4DGLHmteF9o
         ATwQYu23e8iHN+QFQPLaV7B7Un487yvsQssnJO8E=
Date:   Sat, 10 Apr 2021 15:26:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Mitali Borkar <mitaliborkar810@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Re: [Outreachy kernel] [PATCH v2] staging: rtl8192e: fixed pointer
 error by adding '*'
Message-ID: <YHGnlCrZgqjFTgTH@kroah.com>
References: <YHGhdtldqAlRsPHT@kali>
 <alpine.DEB.2.22.394.2104101523140.2975@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2104101523140.2975@hadrien>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 03:23:35PM +0200, Julia Lawall wrote:
> 
> 
> On Sat, 10 Apr 2021, Mitali Borkar wrote:
> 
> > Fixed Comparison to NULL can be written as '!...' by replacing it with
> > simpler form i.e. boolean expression. This makes code more readable
> > alternative.
> > Reported by checkpatch.
> >
> > Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
> > ---
> > Changes from v1:- added pointer to the function, which was missed during
> > fixing v1.
> >
> >  drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
> > index 4457c1acfbf6..78b5b4eaec5f 100644
> > --- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
> > +++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
> > @@ -327,7 +327,7 @@ bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS,
> >  	}
> >
> >  	*ppTS = SearchAdmitTRStream(ieee, Addr, UP, TxRxSelect);
> > -	if (ppTS)
> > +	if (*ppTS)
> 
> This looks like a patch against your previous patch, and not against the
> original code.

That's fine as I already accepted the previous patch.

thanks,

greg k-h
