Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CA137AB08
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhEKPq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:46:58 -0400
Received: from toccata2.tricolour.ca ([204.225.221.17]:40037 "EHLO
        toccata2.tricolour.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhEKPq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:46:56 -0400
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 May 2021 11:46:56 EDT
Received: by toccata2.tricolour.ca (Postfix, from userid 1000)
        id D1FAF1F2FD; Tue, 11 May 2021 11:39:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=tricolour.ca;
        s=default; t=1620747593;
        bh=IVVLkIAVUSLZJLWKlKI8PzNwcm4d3uM2TisEJJTmiss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J459RmxJY5QDycJUPqk2DtFa52bG96PshdJrZDAae74my1dqlQ+R4QUMX/Cd68Y6n
         E+FqHK7vjilO7KcDrwIcYwcfKaxq8YGmatc1KZ1cdPf7ZN/8b1izscTULVgwxiul6k
         llW3JTnPXyjnU+t540RmYDl73/V5J15qfJ3b8/xI=
Date:   Tue, 11 May 2021 11:39:53 -0400
From:   Richard Guy Briggs <rgb@tricolour.ca>
To:     Metztli Information Technology <jose.r.r@metztli.com>
Cc:     Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        tech-board@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Report on University of Minnesota Breach-of-Trust Incident
Message-ID: <20210511153953.GL1724@tricolour.ca>
References: <202105051005.49BFABCE@keescook>
 <20210506082616.GA20224@duo.ucw.cz>
 <202105061042.E99B414F0A@keescook>
 <4eb59c7815d86d85e42b50c45f10e47273c5e0e0.camel@metztli.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eb59c7815d86d85e42b50c45f10e47273c5e0e0.camel@metztli.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-06 14:02, Metztli Information Technology wrote:
> On Thu, 2021-05-06 at 11:40 -0700, Kees Cook wrote:
> > On Thu, May 06, 2021 at 10:26:16AM +0200, Pavel Machek wrote:
> This has aged well:
> 
> "Linux has a problem, which is that with success it is attracting
> people with more skill than what it started with, and it is not doing a
> very good job of handling that. In fact, it downright stinks at it,
> behaving in the worst way it could choose for handling that. [Linux]
> have lost quite a number of FS developers who just don't want to deal
> with people who know less than they do but are obnoxious and
> disrespectful to submissions because they enjoy powertripping...
> *[Linux] should develop a culture in which acceptance is more based on
> whose code measurably performs well [,i.e, meritocracy, rather] than on
> who is friends with whom.*~
> 
> < https://lkml.org/lkml/2006/7/21/109 >

This sounds very Objectivist to me.  It doesn't appear you read the rest
of the thread.  The very first reply to that thread resonates:

	https://lkml.org/lkml/2006/7/21/135

This is one of the reasons I gravitated to Linux just over 29 years ago
after a couple of years of exprience in other open source communities.

> Best Professional Regards.
> Jose R R

	slainte mhath, RGB

--
Richard Guy Briggs               --  ~\    -- ~\             <hpv.tricolour.ca>
<www.TriColour.ca>                 --  \___   o \@      @        Ride yer bike!
Ottawa, ON, CANADA                  --  Lo_>__M__\\/\%__\\/\%
Vote! -- <greenparty.ca>_____GTVS6#790__(*)__(*)________(*)(*)_________________
