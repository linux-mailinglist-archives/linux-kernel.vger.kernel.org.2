Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24A83CB168
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 06:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhGPEQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 00:16:05 -0400
Received: from audible.transient.net ([24.143.126.66]:44780 "HELO
        audible.transient.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229507AbhGPEQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 00:16:02 -0400
Received: (qmail 2606 invoked from network); 16 Jul 2021 04:13:06 -0000
Received: from cucamonga.audible.transient.net (192.168.2.5)
  by canarsie.audible.transient.net with QMQP; 16 Jul 2021 04:13:06 -0000
Received: (nullmailer pid 854 invoked by uid 1000);
        Fri, 16 Jul 2021 04:13:06 -0000
Date:   Fri, 16 Jul 2021 04:13:06 +0000
From:   Jamie Heilman <jamie@audible.transient.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH 5.10 187/593] ACPI: resources: Add checks for ACPI IRQ
 override
Message-ID: <YPEHUkaUKZeqyqav@audible.transient.net>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Hui Wang <hui.wang@canonical.com>
References: <20210712060903.591188609@linuxfoundation.org>
 <YO/2oiphnFdacyIN@audible.transient.net>
 <YPAR0qVkTCTgCOJl@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPAR0qVkTCTgCOJl@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman wrote:
> On Thu, Jul 15, 2021 at 08:49:38AM +0000, Jamie Heilman wrote:
> > Greg Kroah-Hartman wrote:
> > > From: Hui Wang <hui.wang@canonical.com>
> > > 
> > > [ Upstream commit 0ec4e55e9f571f08970ed115ec0addc691eda613 ]
> > > 
> > > The laptop keyboard doesn't work on many MEDION notebooks, but the
> > > keyboard works well under Windows and Unix.
> > 
> > This patch makes my EPIA VIA Esther system stop booting correctly.
> > Reverting it returns things to normal operation.  The symptoms are
> > pretty strange.  When the kernel hands off to init I get none of the
> > usual output from userspace, but I still get the occasional message
> > from the kernel as modules load.  Despite some processes continuing on
> > in the background, I'm never able to ssh into the host, and it never
> > displays a getty on serial console like it should.  Sending a break
> > and a command key over serial doesn't work like it should either.
> > I've found I was able to somewhat get a little bit of IO if I plugged
> > in a keyboard or unplugged it, like just jiggling the handle of the
> > usb hot plug routines was enough to get my system to reboot so I only
> > had to resort to hard resets a few times.  At any rate, maybe this
> > patch wasn't really ready for stable.
> 
> Do you also have the same problem with 5.14-rc1?

I'm afraid so.

-- 
Jamie Heilman                     http://audible.transient.net/~jamie/
