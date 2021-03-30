Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C894E34EC15
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhC3PWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:22:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231808AbhC3PVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:21:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 175F36195C;
        Tue, 30 Mar 2021 15:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617117708;
        bh=uGwUP3LzjKRd9E1KoxeHAndEnuORzm0H6YS3esSamOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i5PF2w81bVXHY5TwySMtGBo2nNi4PqgeFA/qVDFG/2rM3QM9K/7S7YEUIKXO3HBne
         1M3QsIheQ4jK+ZIEY62C/lfH8sJX1rXfqK7ndOiv9+G5vIC0+ZzHH+Ujyj2ms/oZZi
         TZSsMkAX8ZN3CL4lQEBDoiG2G8bUwsZFS1IkwQTHhfD08H8CdKS3daBbvKqOJP/IJq
         Re96AJv434bJ362Rwqfyb2xxnYRB62v+lP3xQElI++Gml8ko5h277pNBnddX3F87Q5
         KzUD+4HQakv6avPe4N8zYdFiJOUtePIerogCzdcK5AoyrX6PtoEFobedlvsGIJLX8b
         TWU0RlBtTdHLA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRGC1-0002Y3-Sc; Tue, 30 Mar 2021 17:22:09 +0200
Date:   Tue, 30 Mar 2021 17:22:09 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] USB: serial: add support for multi-interface
 functions
Message-ID: <YGNCIT1ocatZ3V3/@hovoldconsulting.com>
References: <20210330143820.9103-1-johan@kernel.org>
 <20210330143820.9103-4-johan@kernel.org>
 <e0b2984e7de0287c5811a10faaac4d5d6d7d91ef.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0b2984e7de0287c5811a10faaac4d5d6d7d91ef.camel@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 04:44:32PM +0200, Oliver Neukum wrote:
> Am Dienstag, den 30.03.2021, 16:38 +0200 schrieb Johan Hovold:
> > @@ -1115,6 +1161,8 @@ static void usb_serial_disconnect(struct usb_interface *interface)
> >         if (serial->type->disconnect)
> >                 serial->type->disconnect(serial);
> >  
> > +       release_sibling(serial, interface);
> > +
> >         /* let the last holder of this object cause it to be cleaned up */
> >         usb_serial_put(serial);
> >         dev_info(dev, "device disconnected\n");
> 
> Hi,
> 
> does this assume you are called for the original interface first?

No, I handle either interface being unbound first (e.g. see
release_sibling()).

> I am afraid that is an assumption you cannot make. In fact, if somebody
> is doing odd things with sysfs you cannot even assume both will see a
> disconnect()

Right, but disconnect() will still be called also for the sibling
interface as part of release_sibling() above.

Johan
