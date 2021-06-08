Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6061239F323
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhFHKGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhFHKGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:06:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78A6461029;
        Tue,  8 Jun 2021 10:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623146665;
        bh=EK4el4APpWCVjBrcLKlrQLh70FOtGjt4sfJI+r/oQbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D4bKQmu6jUCjqPf81K8pwAh+t3QvnyhMzv723S1kIkRsTF/TJzXnYMevmDgfbwy1v
         ZWo8ikCJP5rQVC+vCnxFO3S0Q6hrOKsannfUCZMx2K3kL0A+BYM66jKgHEmNJeyBKz
         IrDuXU7eTs39I7bR1bLcocZbZmoyatU89XU1cGU0=
Date:   Tue, 8 Jun 2021 12:04:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?SmnFmcOt?= Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 5/5] nvmem: eeprom: add documentation of sysfs fram
 and sernum file
Message-ID: <YL9AptarCWwSwuvq@kroah.com>
References: <20210607161201.223697-1-jiri.prchal@aksignal.cz>
 <20210607161201.223697-6-jiri.prchal@aksignal.cz>
 <YL8yveuSWTC9iEEz@kroah.com>
 <d0aa3003-0cb7-53c8-6d0e-f1c2dcd90479@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0aa3003-0cb7-53c8-6d0e-f1c2dcd90479@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 11:50:03AM +0200, Jiří Prchal wrote:
> 
> 
> On 08. 06. 21 11:05, Greg Kroah-Hartman wrote:
> > On Mon, Jun 07, 2021 at 06:12:01PM +0200, Jiri Prchal wrote:
> > > Added sysfs fram and sernum file documentation.
> > > 
> > > Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
> > > ---
> > > v5: new
> > > v6: no change here
> > > v7: no change here
> > > v8: added fram file doc
> > > ---
> > >   Documentation/ABI/testing/sysfs-class-spi-eeprom | 13 +++++++++++++
> > >   1 file changed, 13 insertions(+)
> > >   create mode 100644 Documentation/ABI/testing/sysfs-class-spi-eeprom
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-class-spi-eeprom b/Documentation/ABI/testing/sysfs-class-spi-eeprom
> > > new file mode 100644
> > > index 000000000000..b41420fe1329
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-class-spi-eeprom
> > > @@ -0,0 +1,13 @@
> > > +What:		/sys/class/spi_master/spi<bus>/spi<bus>.<dev>/sernum
> > > +Date:		May 2021
> > > +KernelVersion:	5.13
> > > +Contact:	Jiri Prchal <jiri.prchal@aksignal.cz>
> > > +Description:
> > > +		(RO) Exports serial number of Cypress FRAM (FM25VN). 8 bytes as is in chip in hex string.
> > 
> > Please properly wrap your lines.
> > 
> > What is "(RO)" here?
> 
> Read Only, as seen in another doc.

Perhaps this should say something like:
	Contains the serial number of the Cypress FRAM (FM25VN) if it is
	present.  It will be displayed as a 8 byte hex string, as read
	from the device.

	This is a read-only attribute.

> > And the grammer is a bit odd, what is the second sentence supposed to
> > mean?
> > 
> > > +
> > > +What:		/sys/class/spi_master/spi<bus>/spi<bus>.<dev>/fram
> > > +Date:		June 2021
> > > +KernelVersion:	5.13
> > 
> > Obviously it can not make 5.13, right?
> 
> Sorry for missunderstanding, what number should be here?

5.14 if all goes well, right?

thanks,

greg k-h
