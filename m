Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2995E3EF25D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhHQS7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:59:45 -0400
Received: from smtprelay0141.hostedemail.com ([216.40.44.141]:35474 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232923AbhHQS7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:59:44 -0400
Received: from omf10.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 2AF69183F91F9;
        Tue, 17 Aug 2021 18:59:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id D81DD2351F7;
        Tue, 17 Aug 2021 18:59:08 +0000 (UTC)
Message-ID: <ccad90a4a9fa881ecf042e748aeccf9f81070b2f.camel@perches.com>
Subject: Re: [PATCH] staging: r8188eu: refactor
 rtw_is_cckrates{only}_included()
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Michael Straube <straube.linux@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Tue, 17 Aug 2021 11:59:07 -0700
In-Reply-To: <YRwEyrSLTPl/KY9t@kroah.com>
References: <20210816193125.15700-1-straube.linux@gmail.com>
         <YRv4po3sLcH9VLuo@kroah.com>
         <11a09af791c5453175a6bdac1c51bd9fcb0685bd.camel@perches.com>
         <YRwEyrSLTPl/KY9t@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: D81DD2351F7
X-Stat-Signature: dtmxqupo3kd6uaq5fx1nnh11tgkrscxa
X-Spam-Status: No, score=1.27
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/FEtOuC4ogtIQZhRbE4/jDcq40+mrUwkM=
X-HE-Tag: 1629226748-383559
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-08-17 at 20:49 +0200, Greg KH wrote:
> On Tue, Aug 17, 2021 at 11:36:09AM -0700, Joe Perches wrote:
> > On Tue, 2021-08-17 at 19:57 +0200, Greg KH wrote:
> > > On Mon, Aug 16, 2021 at 09:31:25PM +0200, Michael Straube wrote:
> > > > Refactor functions rtw_is_cckrates_included() and
> > > > rtw_is_cckratesonly_included(). Add new helper function rtw_is_cckrate()
> > > > that allows to make the code more compact. Improves readability and
> > > > slightly reduces object file size. Change the return type to bool to
> > > > reflect that the functions return boolean values.
> > []
> > > > diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
> > []
> > > > +bool rtw_is_cckratesonly_included(u8 *rate)
> > > >  {
> > > > -	u32 i = 0;
> > > > +	u8 r;
> > > >  
> > > > 
> > > > -	while (rate[i] != 0) {
> > > > -		if  ((((rate[i]) & 0x7f) != 2) && (((rate[i]) & 0x7f) != 4) &&
> > > > -		     (((rate[i]) & 0x7f) != 11)  && (((rate[i]) & 0x7f) != 22))
> > > > +	while ((r = *rate++)) {
> > > 
> > > Ick, no.
> > > 
> > > While it might be fun to play with pointers like this, trying to
> > > determine the precidence issues involved with reading from, and then
> > > incrementing the pointer like this is crazy.
> > > 
> > > The original was obvious as to how it was walking through the array.
> > 
> > It's sad to believe *ptr++ is not obvious to you as it's very commonly
> > used in the kernel sources (over 10,000 instances).
> 
> There's lots of sad things in life :(

Your difficulty reading very standard c is relatively low on my list.

Still, it's you not this particular patch to the realtek staging code.

What's really poor about this code is using a 0 terminated list rather
than passing the array size.

But then again, almost all of the realtek code in staging is really poor.

cheers, Joe

