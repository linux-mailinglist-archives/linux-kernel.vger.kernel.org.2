Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5203B078B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhFVOjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:39:17 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36080 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhFVOjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:39:15 -0400
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 5A12B2012D1;
        Tue, 22 Jun 2021 14:36:58 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 0C55780162; Tue, 22 Jun 2021 16:36:31 +0200 (CEST)
Date:   Tue, 22 Jun 2021 16:36:30 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: v5.13-rcX regression - NULL pointer dereference - MFD and
 software node API
Message-ID: <YNH1bo6BesNGY3gu@owl.dominikbrodowski.net>
References: <CAHp75VfP2h_aLVR9cgfXWHmqNbUZg-KZj2UwMs6dAkbS5eSghg@mail.gmail.com>
 <YM8rY5hi+zuAekg+@owl.dominikbrodowski.net>
 <CAHp75VdSyM7JdGDhdo5t+FbmouEA7ZSOwGAtSwSRD8vTwTc+LA@mail.gmail.com>
 <CAHp75Ve=j+u-9TF0az3o82wOyzixCezkgOm=yUHh37JS_Awiig@mail.gmail.com>
 <YNBU3Jjme1lQ3MdV@owl.dominikbrodowski.net>
 <YNBjJnxrXaWmfUqo@smile.fi.intel.com>
 <YNBsB6zIo4A4vD4w@kuha.fi.intel.com>
 <YNCw5k9vwdQiS0u4@owl.dominikbrodowski.net>
 <YNGa021IIj+C8H7h@kuha.fi.intel.com>
 <YNHvZGLE9lgS/FRe@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNHvZGLE9lgS/FRe@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, Jun 22, 2021 at 05:10:44PM +0300 schrieb Heikki Krogerus:
> On Tue, Jun 22, 2021 at 11:09:58AM +0300, Heikki Krogerus wrote:
> > On Mon, Jun 21, 2021 at 05:31:50PM +0200, Dominik Brodowski wrote:
> > > Am Mon, Jun 21, 2021 at 01:37:59PM +0300 schrieb Heikki Krogerus:
> > > > On Mon, Jun 21, 2021 at 01:00:06PM +0300, Andy Shevchenko wrote:
> > > > > Can you, please, attach this to the bug report?
> > > > > 
> > > > > Long story here is that the device creation fails but we already have added
> > > > > swnode to it. Meanwhile, device itself is not completely instantiated (yet)
> > > > > and dev_name(dev) is NULL. The software_node_notify() is called with such
> > > > > device and Oopses in the following line
> > > > > 
> > > > > 	sysfs_remove_link(&swnode->kobj, dev_name(dev));
> > > > > 
> > > > > My patch fixes another issue that might happen before this and in the code
> > > > > that retrieves swnode itself in the device_remove_software_node().
> > > > > 
> > > > > Of course my patch won't fix this issue.
> > > > > 
> > > > > I have heard that Heikki is looking how to fix the issue in your case and
> > > > > potentially in any other cases where device_add_software_node() is called
> > > > > against not formed object instance.
> > > > 
> > > > Dominik, can you test the attached patch to confirm if this really is
> > > > the case.
> > > 
> > > With this patch applied, the panic disappears.
> > 
> > Thanks Dominik. I'll clean it and send it out today.
> 
> Before I send the patch to Rafael and Greg, can you confirm that the
> appropriate API (device_is_registered()) also works? I'm attaching
> patch that should be the final version (if it works).

Heikki, that works perfectly. Many thanks, especially for the speedy
development of the bugfix!

Best,
	Dominik
