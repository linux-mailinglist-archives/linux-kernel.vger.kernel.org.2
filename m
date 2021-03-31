Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099B134F974
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbhCaHIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:08:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:59092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233940AbhCaHIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:08:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617174499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a1hXApR+/n3Tm8UPNKP9JBk/yexpBOlO3b/93PdVzrQ=;
        b=i+P4oz+Ia5QucybiB2GYs8tsmxkTSxDmmsms11xvTktT+qr8dzRE4MIXQv3uD5cTY2iy3X
        qAMS3iIbY34387FOEX6LyzKNvtlF5PY6UWU/BQO8mbEZcgvGDbpQz4V2L2XJzeOEOZhbpE
        JirNZbJLQGt/DXIgkx9XMGTmY0NNML0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 50EACAD80;
        Wed, 31 Mar 2021 07:08:19 +0000 (UTC)
Message-ID: <e4d3d21cdfe94068c76ceb4ba38630d76fa9418c.camel@suse.com>
Subject: Re: [PATCH 3/4] USB: serial: add support for multi-interface
 functions
From:   Oliver Neukum <oneukum@suse.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 31 Mar 2021 09:08:07 +0200
In-Reply-To: <YGNCIT1ocatZ3V3/@hovoldconsulting.com>
References: <20210330143820.9103-1-johan@kernel.org>
         <20210330143820.9103-4-johan@kernel.org>
         <e0b2984e7de0287c5811a10faaac4d5d6d7d91ef.camel@suse.com>
         <YGNCIT1ocatZ3V3/@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 30.03.2021, 17:22 +0200 schrieb Johan Hovold:
> On Tue, Mar 30, 2021 at 04:44:32PM +0200, Oliver Neukum wrote:
> > Am Dienstag, den 30.03.2021, 16:38 +0200 schrieb Johan Hovold:
> > > @@ -1115,6 +1161,8 @@ static void usb_serial_disconnect(struct usb_interface *interface)
> > >         if (serial->type->disconnect)
> > >                 serial->type->disconnect(serial);
> > >  
> > > +       release_sibling(serial, interface);
> > > +
> > >         /* let the last holder of this object cause it to be cleaned up */
> > >         usb_serial_put(serial);
> > >         dev_info(dev, "device disconnected\n");
> > 
> > Hi,
> > 
> > does this assume you are called for the original interface first?
> 
> No, I handle either interface being unbound first (e.g. see
> release_sibling()).
> 
> > I am afraid that is an assumption you cannot make. In fact, if somebody
> > is doing odd things with sysfs you cannot even assume both will see a
> > disconnect()
> 
> Right, but disconnect() will still be called also for the sibling
> interface as part of release_sibling() above.

OK, sorry I overlooked that.

	Regards
		Oliver


