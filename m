Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D933D3EF242
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbhHQSuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:50:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230373AbhHQSuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:50:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 100E360EFF;
        Tue, 17 Aug 2021 18:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629226188;
        bh=73uDmglhFa2Hv+Ss/Ge1RAyd3aFjULzjDAvCHOaTvbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BVAAjFdSK9/ZEtasvTnZ02YfRwAS1hgnukhAdPA27hNGudIZCxYIEAt0qY2vx5yH+
         FbjhkK4E+eRGJlcifSZqofXGyuQJoTp2uqvYzSal8jwmkJAqHe4CmsO7Co3+Glpv7G
         5/8cASn/hDhIRIz+AQsQSt2dsfJiXMzfkOkOox4w=
Date:   Tue, 17 Aug 2021 20:49:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Michael Straube <straube.linux@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: refactor
 rtw_is_cckrates{only}_included()
Message-ID: <YRwEyrSLTPl/KY9t@kroah.com>
References: <20210816193125.15700-1-straube.linux@gmail.com>
 <YRv4po3sLcH9VLuo@kroah.com>
 <11a09af791c5453175a6bdac1c51bd9fcb0685bd.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11a09af791c5453175a6bdac1c51bd9fcb0685bd.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 11:36:09AM -0700, Joe Perches wrote:
> On Tue, 2021-08-17 at 19:57 +0200, Greg KH wrote:
> > On Mon, Aug 16, 2021 at 09:31:25PM +0200, Michael Straube wrote:
> > > Refactor functions rtw_is_cckrates_included() and
> > > rtw_is_cckratesonly_included(). Add new helper function rtw_is_cckrate()
> > > that allows to make the code more compact. Improves readability and
> > > slightly reduces object file size. Change the return type to bool to
> > > reflect that the functions return boolean values.
> []
> > > diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
> []
> > > +bool rtw_is_cckratesonly_included(u8 *rate)
> > >  {
> > > -	u32 i = 0;
> > > +	u8 r;
> > >  
> > > 
> > > -	while (rate[i] != 0) {
> > > -		if  ((((rate[i]) & 0x7f) != 2) && (((rate[i]) & 0x7f) != 4) &&
> > > -		     (((rate[i]) & 0x7f) != 11)  && (((rate[i]) & 0x7f) != 22))
> > > +	while ((r = *rate++)) {
> > 
> > Ick, no.
> > 
> > While it might be fun to play with pointers like this, trying to
> > determine the precidence issues involved with reading from, and then
> > incrementing the pointer like this is crazy.
> > 
> > The original was obvious as to how it was walking through the array.
> 
> It's sad to believe *ptr++ is not obvious to you as it's very commonly
> used in the kernel sources (over 10,000 instances).

There's lots of sad things in life :(
