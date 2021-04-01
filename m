Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC49351050
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 09:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhDAHqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 03:46:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233327AbhDAHqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:46:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6B7C6101E;
        Thu,  1 Apr 2021 07:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617263166;
        bh=AQWEF0EII9igzQR3BAdlFeDDeBGdVba7SzCII5XIQhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e6q8Y4yV3Q7XxrDJFHPw2EIYwQnA37Ph59gl2wB3GXdFobCzk6NawPM/FBxKuRemW
         mODPw3Z+XB5a1eZwiKVcZBPPyigsdz799nOfpj6pHRdnQ4J4SImvmJcCYP/EF8tjH5
         oNxteu+W44MUHwTkG3zrqH/4bMy5gT5SL/Sehmsj4ZjsYj2Orn/IeZtTUQT29jGgHU
         e550g5n2HYMk6mB2fNr4eVqghy+PrvsvsdwOdngtUvSGxSl5V7turD5Sz8xr+YkulE
         Tvt1KD2awoCE3lijCTmnsWYxyrM1joHTqUmtwz9RoyYlaI0q86c8HxjOVf10jZngib
         pyWyVWM51pl7g==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRs1j-0003gX-Rt; Thu, 01 Apr 2021 09:46:03 +0200
Date:   Thu, 1 Apr 2021 09:46:03 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] USB: serial: add support for multi-interface
 functions
Message-ID: <YGV6O5jycIj9Nv9Z@hovoldconsulting.com>
References: <20210330143820.9103-1-johan@kernel.org>
 <20210330143820.9103-4-johan@kernel.org>
 <e0b2984e7de0287c5811a10faaac4d5d6d7d91ef.camel@suse.com>
 <YGNCIT1ocatZ3V3/@hovoldconsulting.com>
 <e4d3d21cdfe94068c76ceb4ba38630d76fa9418c.camel@suse.com>
 <3ae68552f3c689c23cbf2573772239c00e2c94be.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ae68552f3c689c23cbf2573772239c00e2c94be.camel@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 01:21:15PM +0200, Oliver Neukum wrote:
> Am Mittwoch, den 31.03.2021, 09:08 +0200 schrieb Oliver Neukum:
> > Am Dienstag, den 30.03.2021, 17:22 +0200 schrieb Johan Hovold:
> > > On Tue, Mar 30, 2021 at 04:44:32PM +0200, Oliver Neukum wrote:
> > > > Am Dienstag, den 30.03.2021, 16:38 +0200 schrieb Johan Hovold:
> > > > > @@ -1115,6 +1161,8 @@ static void usb_serial_disconnect(struct usb_interface *interface)
> > > > >         if (serial->type->disconnect)
> > > > >                 serial->type->disconnect(serial);
> > > > >  
> > > > > +       release_sibling(serial, interface);
> > > > > +
> > > > >         /* let the last holder of this object cause it to be cleaned up */
> > > > >         usb_serial_put(serial);
> > > > >         dev_info(dev, "device disconnected\n");
> > > > 
> > > > Hi,
> > > > 
> > > > does this assume you are called for the original interface first?
> > > 
> > > No, I handle either interface being unbound first (e.g. see
> > > release_sibling()).
> > > 
> > > > I am afraid that is an assumption you cannot make. In fact, if somebody
> > > > is doing odd things with sysfs you cannot even assume both will see a
> > > > disconnect()
> > > 
> > > Right, but disconnect() will still be called also for the sibling
> > > interface as part of release_sibling() above.
> > 
> > OK, sorry I overlooked that.
> 
> Hi,
> 
> on the third hand, the more I look at this, would you mind putting
> sibling_release() with a modified name into usbcore? This functionality
> is not limited to serial drivers. btusb needs it; cdc-acm needs it;
> usbaudio neds it. We have code duplication.

Tell me about it. ;) Unfortunately, drivers all tend to handle this
slightly different, for example, using a disconnected flag, some claim
more than one other interface, others look like they may be using their
interface data as a flag for other purposes, etc.

At some point we could unify all this but until then I don't think
putting only half of an interface into core makes much sense.

Johan
