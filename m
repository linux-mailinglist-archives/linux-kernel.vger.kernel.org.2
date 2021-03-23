Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B47346802
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbhCWSoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:44:13 -0400
Received: from p3plsmtpa09-04.prod.phx3.secureserver.net ([173.201.193.233]:52213
        "EHLO p3plsmtpa09-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231979AbhCWSn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:43:57 -0400
Received: from chrisHP110 ([76.103.216.188])
        by :SMTPAUTH: with ESMTPA
        id Om0SlPpknntfUOm0SleHTF; Tue, 23 Mar 2021 11:43:56 -0700
X-CMAE-Analysis: v=2.4 cv=QsybYX+d c=1 sm=1 tr=0 ts=605a36ec
 a=ZkbE6z54K4jjswx6VoHRvg==:117 a=ZkbE6z54K4jjswx6VoHRvg==:17
 a=kj9zAlcOel0A:10 a=tbtrcCN1n_p49eprWO4A:9 a=CjuIK1q_8ugA:10
X-SECURESERVER-ACCT: don@thebollingers.org
From:   "Don Bollinger" <don@thebollingers.org>
To:     "'Greg KH'" <gregkh@linuxfoundation.org>
Cc:     <arndb@arndb.de>, <linux-kernel@vger.kernel.org>,
        <brandon_chuang@edge-core.com>, <wally_wang@accton.com>,
        <aken_liu@edge-core.com>, <gulv@microsoft.com>,
        <jolevequ@microsoft.com>, <xinxliu@microsoft.com>,
        <don@thebollingers.org>
References: <20210215193821.3345-1-don@thebollingers.org> <YFn3ahkF4w/IClaw@kroah.com>
In-Reply-To: <YFn3ahkF4w/IClaw@kroah.com>
Subject: RE: [PATCH v2] eeprom/optoe: driver to read/write SFP/QSFP/CMIS EEPROMS
Date:   Tue, 23 Mar 2021 11:43:55 -0700
Message-ID: <008d01d72014$7b113900$7133ab00$@thebollingers.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQKX2ThEytgxSBCv+zte4L/P7xUGAgJXyZnIqP2o+uA=
Content-Language: en-us
X-CMAE-Envelope: MS4xfODNq/eIJb5ZFkPlzI7gU72TThtfkC4roNiMZGUehG/yKONjOHF5A2HRKE+o10WOIj1laIJBRLxBZZ+/pODqsohkulnPSRVOSSanUwTD8bjkyA9swQiV
 8W3yxxPha0E+BPxY3RU7KospCKHgl/wweMQHDksITPrAmzrlNaQFVEKpjiFOJKvRtgcXSjMgMJAEx7+fa+npEEPq7bMZekLu2Ex8ExDhsw+6y5hn5CMOIdMN
 Zdsz80RgDKCNDlIELjMG2i0RdfQmGoBEPd5Etn+C6Av0Ww8JCtWFdexGWgeANa/1pNTDS61Bv1FPOR0Ncw9S8XB+3xz0rBKJV8GbPDhoghhdB2o4uxm9mrwL
 uQgNWDI+7r9OuUyrgLq01WQAUHzwJK3/V4RpswveNJBbNyeAdTb2vv9JT2eMZr+9/VqWSxgn8Gygu+/E7ZKNHyPGbUu3mXNtPSRDsnueBimWC9f6OankhnMX
 50WIq/PrJOBdz+AvbdrGOUF3wDti27cBQejjLg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 7:12AM-0700, Greg KH wrote: 
> On Mon, Feb 15, 2021 at 11:38:21AM -0800, Don Bollinger wrote:
> > optoe is an i2c based driver that supports read/write access to all
> > the pages (tables) of MSA standard SFP and similar devices (conforming
> > to the SFF-8472 spec), MSA standard QSFP and similar devices
> > (conforming to the SFF-8636 spec) and CMIS and similar devices
> > (conforming to the Common Management Interface Specfication).
> 

I promise not to engage in a drawn out email exchange over this, but I would
like to appeal your decision, just once...

> Given this thread, I think that using the SFP interface/api in the kernel
> already seems like the best idea forward.
> 
> That being said, your api here is whack, and I couldn't accept it anyway.

I don't understand.  I don't mean you are wrong, I literally don't
understand what is whack about it.  The interface is provided by nvmem.  I
modeled the calls on at24.  The layout of the data provided by the driver is
exactly the same layout that ethtool provides (device, offset, length).
Mapping i2c address, page and offset is exactly what ethtool provides.  So,
which part of this is whack?

> 
> Not for the least being it's not even documented in Documentation/ABI/
like
> all sysfs files have to be :)

This could obviously be fixed.  I wasn't aware of this directory.  Now that
you've pointed it out, I see that nvmem is actually documented there, which
is the API I am using.  I document that optoe uses the nvmem interface, and
the mapping of paged memory to linear memory in my patch in
Documentation/misc-devices/optoe.rst.  If you think it would be useful, I
could provide similar information in Documentation/ABI/stable.

> 
> And it feels like you are abusing sysfs for things it was not ment for,
you
> might want to look into configfs?

I'm using nvmem, which in turn uses sysfs, just like at24.  Why should optoe
be different?  I would think it is actually better to use the same API (and
code) as at24, and NOT to put it in a different place.

> 
> But really, these are networking devices, so they should be controllable
using
> the standard networking apis, not one-off sysfs files.  Moving to the
Linux-
> standard tools is a good thing, and will work out better in the end
instead of
> having to encode lots of device-specific state in userspace like this
"raw" api
> seems to require.

This is the real issue.  It turns out, on these switches, there are two
kinds of networking.  Linux kernel networking handles one port, of 1Gb (or
less), which functions as a management port.  This is typically used for
console access.  It is configured and managed as an ordinary network port,
with a kernel network driver and the usual networking utilities.  'ip addr'
will show this port as well as loopback ports.  The linux kernel has no
visibility to the switch networking ports.  'ip addr' will not show any of
the switch networking ports.

The switch functions, switching at 25Tb/s, are completely invisible to the
linux kernel.  The switch ASIC is managed by a device driver provided by the
ASIC vendor.  That driver is driven by management code from the ASIC vendor
and a host of network applications.  Multiple vendors compete to provide the
best, most innovative, most secure, easiest...  network capabilities on top
of this architecture.  NONE of them use a kernel network driver, or the
layers of control or management that the linux kernel offers.  On these
systems, if you ask ethtool to provide EEPROM data, you get 'function not
implemented'.

On these systems, SFP/QSFP/CMIS devices are actually not 'networking
devices' from a Linux kernel perspective.  They are GPIO targets and EEPROM
memory.  Switch networking just needs the kernel to toggle the GPIO lines
and read/write the EEPROM.  optoe is just trying to read/write the EEPROM.

One last note...  The networking folks need a better SFP/QSFP/CMIS EEPROM
driver to access more pages, and to support the new CMIS standard.  optoe
could provide that, and I would love to collaborate on integrating optoe
into that stack.  It wouldn't be hard, and it would be useful.  I am not
opposed to netdev/netlink/phylink.  I have been commenting on Moshe's KAPI
proposal, with several of my suggestions adopted there.  I am not insisting
on my approach INSTEAD of theirs.  I am insisting on my approach IN ADDITION
TO theirs.  Without the nvmem interface, optoe is useless to my community.

> 
> thanks,
> 
> greg k-h

Thanks

Don

