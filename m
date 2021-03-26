Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A7134A93C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCZOHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:07:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhCZOG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:06:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9725961A24;
        Fri, 26 Mar 2021 14:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616767618;
        bh=Zs7G2VZRCMsfXdjZurww9AAYubVChEXpje6NACEqXak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1/X9EmcrFBsei8WYjtN8gNxxS/y/bjAUgBd97Z5l3if/9+5FmKFG4GGQcoEC7npfE
         We+vmY76D0R/Xp50ZOSXahxlvMmNoPeBcCnDmz88bn+yT/1DcfDqg/LihgEET5WCRe
         6tH3XYLAZRHo7ST9EcW3z8hMrimlQ/ihAMgXaZT8=
Date:   Fri, 26 Mar 2021 15:06:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] staging: rtl8723bs: put parentheses on macros with
 complex values in include/basic_types.h
Message-ID: <YF3qf7DdqotjTEeV@kroah.com>
References: <cover.1616748885.git.fabioaiuto83@gmail.com>
 <2c7c198ccef194b06921bc476eda7d5102ab70dc.1616748885.git.fabioaiuto83@gmail.com>
 <20210326100408.GE1717@kadam>
 <20210326111241.GD1452@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326111241.GD1452@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 12:12:42PM +0100, Fabio Aiuto wrote:
> On Fri, Mar 26, 2021 at 01:04:08PM +0300, Dan Carpenter wrote:
> > On Fri, Mar 26, 2021 at 10:09:11AM +0100, Fabio Aiuto wrote:
> > > fix the following checkpatch warnings:
> > > 
> > > ERROR: Macros with complex values should be enclosed in parentheses
> > > 154: FILE: drivers/staging/rtl8723bs/include/basic_types.h:154:
> > > +#define SET_BITS_TO_LE_4BYTE(__pstart, __bitoffset, __bitlen, __val) \
> > > --
> > > ERROR: Macros with multiple statements should be enclosed in
> > > a do - while loop
> > > 161: FILE: drivers/staging/rtl8723bs/include/basic_types.h:161:
> > > +#define SET_BITS_TO_LE_2BYTE(__pstart, __bitoffset, __bitlen, __val) \
> > > --
> > > ERROR: Macros with complex values should be enclosed in parentheses
> > > 168: FILE: drivers/staging/rtl8723bs/include/basic_types.h:168:
> > > +#define SET_BITS_TO_LE_1BYTE(__pstart, __bitoffset, __bitlen, __val) \
> > > 
> > > parentheses solution preferred for all fixes and made macros more
> > > readables
> > > 
> > > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > > ---
> > >  .../staging/rtl8723bs/include/basic_types.h   | 30 +++++++++++--------
> > >  1 file changed, 18 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/staging/rtl8723bs/include/basic_types.h b/drivers/staging/rtl8723bs/include/basic_types.h
> > > index 76304086107a..5054c2e3384c 100644
> > > --- a/drivers/staging/rtl8723bs/include/basic_types.h
> > > +++ b/drivers/staging/rtl8723bs/include/basic_types.h
> > > @@ -152,24 +152,30 @@
> > >  /* 		Set subfield of little-endian 4-byte value to specified value. */
> > >  /*  */
> > >  #define SET_BITS_TO_LE_4BYTE(__pstart, __bitoffset, __bitlen, __val) \
> > > -		*((u32 *)(__pstart)) =				\
> > > -		(						\
> > > -		LE_BITS_CLEARED_TO_4BYTE(__pstart, __bitoffset, __bitlen) | \
> > > -		((((u32)__val) & BIT_LEN_MASK_32(__bitlen)) << (__bitoffset)) \
> > > +		(\
> > > +			*((u32 *)(__pstart)) =				\
> > > +			(						\
> > > +				LE_BITS_CLEARED_TO_4BYTE(__pstart, __bitoffset, __bitlen) | \
> > > +				((((u32)__val) & BIT_LEN_MASK_32(__bitlen)) << (__bitoffset)) \
> > > +			)\
> > >  		)
> > >  
> > 
> > These macros are terrible and this makes it uglier.  Better to just
> > ignore checkpatch until we can figure out a way to re-write this
> > properly.
> > 
> > regards,
> > dan carpenter
> > 
> 
> I see, will drop the patch for now.

Please resend a v2 set of this series so I know what to apply here...

thanks,

greg k-h
