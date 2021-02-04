Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5C530EC7E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 07:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhBDG1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 01:27:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:42006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232327AbhBDG1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 01:27:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0EF364DFF;
        Thu,  4 Feb 2021 06:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612420011;
        bh=DSoG/oJWMOu+0RpOPNhN7HpCx5+rWaZ/ag40G8wz3D4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vZvcw3PhGDFN5T/fIZQNMsrR36BbQ2XytPNc9vZqn7rwefnl2XKxG2LeWyC+bk7Uc
         WeoGm0BSfiVZYG7UbpB2bRqnmQYhNHhbTAXClwvG+mSBCcMtH3ZNsn6B34wGgNtU63
         Bo+ylE+r0z/u/HRG3yKzaJOj3joEoKGqpDfOEmGA=
Date:   Thu, 4 Feb 2021 07:26:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Tso <kyletso@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        pmalani@chromium.org, Benson Leung <bleung@chromium.org>,
        Benson Leung <bleung@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: pd: Reland VDO definitions of PD2.0
Message-ID: <YBuTp7zIKswiXfWn@kroah.com>
References: <20210204005036.1555294-1-kyletso@google.com>
 <CAGZ6i=3fdLt=MWZunfRDPpjcxjDO9K+v=64bpadvbpaxCUpHYg@mail.gmail.com>
 <CAGZ6i=3fgda+8brU49qG1pxc=1icM7eeuHx+oH6-bA9oa4qK1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ6i=3fgda+8brU49qG1pxc=1icM7eeuHx+oH6-bA9oa4qK1Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 02:17:56PM +0800, Kyle Tso wrote:
> On Thu, Feb 4, 2021 at 8:55 AM Kyle Tso <kyletso@google.com> wrote:
> >
> > Hi, Benson and Prashant,
> >
> > On Thu, Feb 4, 2021 at 8:50 AM Kyle Tso <kyletso@google.com> wrote:
> > >
> > > Reland VDO definitions of PD Revision 2.0 as they are still used in
> > > PD2.0 products.
> > >
> > > Fixes: 0e1d6f55a12e ("usb: pd: Update VDO definitions")
> > > Signed-off-by: Kyle Tso <kyletso@google.com>
> > > ---
> > >  include/linux/usb/pd_vdo.h | 69 ++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 66 insertions(+), 3 deletions(-)
> > >
> > Is there any chance that you have free time to verify this patch with
> > CrOS configuration?
> >
> > thanks,
> > Kyle
> >
> 
> Hi,
> 
> I tried to enable the config "CONFIG_CROS_EC_TYPEC=m" and it can make now.

Thanks for verifying, I'll go queue this up to keep the tree building
properly.

greg k-h
