Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1943835FB38
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353183AbhDNS5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233309AbhDNS5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:57:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7613608FC;
        Wed, 14 Apr 2021 18:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618426613;
        bh=p3tLoI1W999gvkPwHx3SIXj0hp7y62K3IG6+a/DlgTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sIrwRXqtQKqDOgVLarJP5tde7bi9xdvtgd0Vnm+O16WlBakzQhsmopxiIiEArN7gL
         lv0UdAeWoVWwwaw8hEDvJxt+8a3j0fijCwtqzcRtaJz3cHrkVONx2qTT2lZoeL2bQ6
         VwQaCSXI4T1lqFfdn4LjJ+yujMedwyifWsN0zr2g=
Date:   Wed, 14 Apr 2021 20:56:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] stm class: Replace uuid_t with plain u8 uuid[16]
Message-ID: <YHc68v7keeITnA3K@kroah.com>
References: <20210414171251.14672-1-alexander.shishkin@linux.intel.com>
 <20210414171251.14672-3-alexander.shishkin@linux.intel.com>
 <YHcnckePpKDujCU+@kroah.com>
 <YHcqxMLR44laX2PZ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHcqxMLR44laX2PZ@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 08:47:48PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 14, 2021 at 07:33:38PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Apr 14, 2021 at 08:12:46PM +0300, Alexander Shishkin wrote:
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > It appears that uuid_t use in STM code abuses UUID API.
> > 
> > How is it being abused?
> 
> We are using it against the buffer that is u8, and neither uuid_t nor guid_t.

And how should it be used?

> > Moreover,
> > > this type is only useful when we parse user input. Due to above
> > > replace uuid_t with u8 uuid[16] and use uuid_t only when parse
> > > user input.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > ---
> > >  drivers/hwtracing/stm/p_sys-t.c | 16 ++++++++++------
> > >  1 file changed, 10 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/hwtracing/stm/p_sys-t.c b/drivers/hwtracing/stm/p_sys-t.c
> > > index 360b5c03df95..04d13b3785d3 100644
> > > --- a/drivers/hwtracing/stm/p_sys-t.c
> > > +++ b/drivers/hwtracing/stm/p_sys-t.c
> > > @@ -76,7 +76,7 @@ enum sys_t_message_string_subtype {
> > >  				 MIPI_SYST_SEVERITY(MAX))
> > >  
> > >  struct sys_t_policy_node {
> > > -	uuid_t		uuid;
> > > +	u8		uuid[UUID_SIZE];
> > 
> > This feels wrong, what is wrong with the uuid_t type usage here?
> 
> Nothing, just will require additional export_uuid() / import_uuid() call.

Isn't that the "correct way" here?

> > >  	bool		do_len;
> > >  	unsigned long	ts_interval;
> > >  	unsigned long	clocksync_interval;
> > > @@ -92,7 +92,7 @@ static void sys_t_policy_node_init(void *priv)
> > >  {
> > >  	struct sys_t_policy_node *pn = priv;
> > >  
> > > -	generate_random_uuid(pn->uuid.b);
> > 
> > Ok, that's not good, but that looks to be a flaw in the
> > generate_random_uuid() api, not this driver implementation.
> > 
> > I don't understand why this change is needed?
> 
> Using raw buffer APIs against uuid_t / guid_t.

So you want to do that, or you do not want to do that?  Totally
confused,

greg k-h
