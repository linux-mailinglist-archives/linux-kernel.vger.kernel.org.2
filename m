Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE62C36D1F0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 08:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbhD1GCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 02:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhD1GCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 02:02:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93EB761418;
        Wed, 28 Apr 2021 06:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619589686;
        bh=DMvmZdizmahSdLy38H1KdUaziGayCrN6I19m9A9ZYWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h1Qj0gdCXNxTtk/HV/D/SXrBefjYaeC7pF9jVQ9iWIol9/BoLQP3cS29/mwIlT8s2
         3IqWOD4X8waD+h3iJ7xJfdKEe2xzt2fCCxOdhNMCjNgqCpATrShKx0PW2/uXghnG+r
         ojF5TFt+zEZFImtiVhyshYWglV3bSokT8q7wNkNw=
Date:   Wed, 28 Apr 2021 08:01:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jitendra <jkhasdev@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: fix array of flexible structures
Message-ID: <YIj6MUO5+EDBzOwl@kroah.com>
References: <20210427174945.1323-1-jkhasdev@gmail.com>
 <YIhTjGpmLSYKuCi3@kroah.com>
 <20210427185844.GA1030@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427185844.GA1030@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 12:28:44AM +0530, Jitendra wrote:
> On Tue, Apr 27, 2021 at 08:10:20PM +0200, Greg KH wrote:
> > On Tue, Apr 27, 2021 at 11:19:45PM +0530, Jitendra Khasdev wrote:
> > > This patch fixes sparse warning "array of flexible structures"
> > > for rtllib.h.
> > > 
> > > eg. drivers/staging/rtl8192e/rtllib.h:832:48: warning: array of
> > > flexible structures
> > > 
> > > Signed-off-by: Jitendra Khasdev <jkhasdev@gmail.com>
> > > ---
> > >  drivers/staging/rtl8192e/rtllib.h | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
> > > index 4cabaf2..c7cb318 100644
> > > --- a/drivers/staging/rtl8192e/rtllib.h
> > > +++ b/drivers/staging/rtl8192e/rtllib.h
> > > @@ -802,7 +802,7 @@ struct rtllib_authentication {
> > >  	__le16 transaction;
> > >  	__le16 status;
> > >  	/*challenge*/
> > > -	struct rtllib_info_element info_element[];
> > > +	struct rtllib_info_element *info_element;
> > 
> > You just changed the definition of this structure, and the other
> > structures here.  Are you sure this is working properly?
> > 
> 
> I have compiled the driver and install it on my vm, but I don't this specific
> hardware, so couldn't test it.
> 
> I fixed in context of sparse.

Please verify that this change is correct by looking at how the
structures are being created (i.e. is this being treated as a flexible
array or a pointer?)

I think we have been through this before and that sparse is not right,
but I can't remember...

thanks,

greg k-h
