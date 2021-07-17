Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C95B3CC178
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 08:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhGQGPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 02:15:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229379AbhGQGPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 02:15:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B4C56101A;
        Sat, 17 Jul 2021 06:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626502377;
        bh=8cLLirT0hvzwP0lrOx0mYq7s2nFKexMw23WQLVT2LaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hco7pen6gNCqtDfle51bfDisW7MKsJ7n/yhJi/ea0Luopx32VeCXVFVzqjXe1fHsv
         im88Oz/kBkydDPFmD0wThbs3xhZ7b2i6UZFwJBk6c87sOh3hMd7ha2yC9lJ+sZiRyD
         I44xXq/isGnKo9KsybOIgKXsc0N8UQhHswUeWkm4=
Date:   Sat, 17 Jul 2021 08:12:52 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Winiarska, Iwona" <iwona.winiarska@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "jason.m.bills@linux.intel.com" <jason.m.bills@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "jae.hyun.yoo@linux.intel.com" <jae.hyun.yoo@linux.intel.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 06/14] peci: Add core infrastructure
Message-ID: <YPJ05JUiOggKajIx@kroah.com>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
 <20210712220447.957418-7-iwona.winiarska@intel.com>
 <59428599ef7efb2521bd62c49a3bc55c710f29de.camel@intel.com>
 <6807a14deb52956ad2fe390b1811dd98901a642a.camel@intel.com>
 <CAPcyv4ifjCZSUuk5H5qw6sjt5vdAkTfNzd+4imu+9e_iOt74gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ifjCZSUuk5H5qw6sjt5vdAkTfNzd+4imu+9e_iOt74gQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 02:50:04PM -0700, Dan Williams wrote:
> On Fri, Jul 16, 2021 at 2:08 PM Winiarska, Iwona
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(peci_controller_add, PECI);
> > >
> > > I think it's cleaner to declare symbol namespaces in the Makefile. In
> > > this case, add:
> > >
> > > cflags-y += -DDEFAULT_SYMBOL_NAMESPACE=PECI
> > >
> > > ...and just use EXPORT_SYMBOL_GPL as normal in the C file.
> > >
> >
> > I kind of prefer the more verbose EXPORT_SYMBOL_NS_GPL - it also
> > doesn't "hide" the fact that we're using namespaces (everything is in
> > the C file rather than mixed into Makefile), but it's not a strong
> > opinion, so sure - I can change this.
> >
> 
> Perhaps as a tie breaker, the maintainer you are submitting this to,
> Greg, uses the -DDEFAULT_SYMBOL_NAMESPACE scheme in his subsystem,
> drivers/usb/.

We did that because namespaces were added _after_ the kernel code was
already there.  For new code like this, the original use of
EXPORT_SYMBOL_NS_GPL() is best as it is explicit and obvious.  No need
to dig around in a Makefile to find out the namespace name.

thanks,

greg k-h
