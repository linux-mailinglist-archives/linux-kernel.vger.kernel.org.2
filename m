Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30983C9A07
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238390AbhGOIEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:04:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhGOIEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:04:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61A56610C7;
        Thu, 15 Jul 2021 08:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626336068;
        bh=vfUqgQNrCF6HXcMqf+BXNZVhd8uK0iAcKu2UItIP6mY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mn0+BajCyLEOHjajjB2NsyzKUaQPaZqOl0vfBF/jsexAU0SEZhZd/ZGLMR5BLfO9i
         no/VugIGIR8JBJ9ZA6DPqGAJADy/OH8MUIAhYP0hMhsyiJH643xocSuJfYWfuEmzDb
         f/9bzMKd8sh3MR9Yk92AwwgXXoyZYEH4nO2/ppoU=
Date:   Thu, 15 Jul 2021 10:01:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "N, Pandith" <pandith.n@intel.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: Re: [PATCH V5 1/1] misc: NOC Probe Counters
Message-ID: <YO/rQXFR4fUZaGJM@kroah.com>
References: <20210713065347.21554-1-pandith.n@intel.com>
 <YO05L5t5iauazGYQ@kroah.com>
 <BYAPR11MB3528CFCCCD87C0C6F99F5413E1129@BYAPR11MB3528.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB3528CFCCCD87C0C6F99F5413E1129@BYAPR11MB3528.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 07:13:10AM +0000, N, Pandith wrote:
> Hi Greg,
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Tuesday, July 13, 2021 12:27 PM
> > To: N, Pandith <pandith.n@intel.com>
> > Cc: arnd@arndb.de; linux-kernel@vger.kernel.org; Zhou, Furong
> > <furong.zhou@intel.com>; mgross@linux.intel.com; Sangannavar,
> > Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>;
> > andriy.shevchenko@linux.intel.com; Raja Subramanian, Lakshmi Bai
> > <lakshmi.bai.raja.subramanian@intel.com>
> > Subject: Re: [PATCH V5 1/1] misc: NOC Probe Counters
> > 
> > On Tue, Jul 13, 2021 at 12:23:47PM +0530, pandith.n@intel.com wrote:
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -12589,6 +12589,12 @@ F:	include/linux/nitro_enclaves.h
> > >  F:	include/uapi/linux/nitro_enclaves.h
> > >  F:	samples/nitro_enclaves/
> > >
> > > +NOC, DSS NOC SUPPORT
> > 
> > I have no idea what this means, please spell it out in the MAINTAINERS file for
> > everyone to understand.
> > 
> Have renamed as below:
> INTEL KEEM BAY DDR SUBSYSTEM(DSS), NETWORK ON CHIP(NOC) DRIVER

Why is "dss" needed here?
