Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2523754C1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbhEFNcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 09:32:19 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44608 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233461AbhEFNcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 09:32:18 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 146DV3kH003361
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 May 2021 09:31:04 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 72CD515C39BD; Thu,  6 May 2021 09:31:03 -0400 (EDT)
Date:   Thu, 6 May 2021 09:31:03 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Carlos Bilbao <bilbao@vt.edu>, corbet@lwn.net, hdegoede@redhat.com,
        Jonathan.Cameron@huawei.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed typos in all directories of Documentation/ABI/
Message-ID: <YJPvl6Si9Xi0w5tG@mit.edu>
References: <2219636.ElGaqSPkdT@iron-maiden>
 <20210506084237.1f8363ba@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506084237.1f8363ba@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 08:42:37AM +0200, Mauro Carvalho Chehab wrote:
>  
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> > index ef00fada2efb..bfd017204563 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -139,7 +139,7 @@ Description:
> >  		binary file containing the Vital Product Data for the
> >  		device.  It should follow the VPD format defined in
> >  		PCI Specification 2.1 or 2.2, but users should consider
> > -		that some devices may have malformatted data.  If the
> > +		that some devices may have malformed data.  If the
> >  		underlying VPD has a writable section then the
> >  		corresponding section of this file will be writable.
> >  
> 
> (not a native English speaker here)
> 
> I'm in doubt about this one. The description is talking about the
> "VPD format".

Maybe "badly formatted" or to be more clear, "some devices may be
reported incorrectly forrmatted data"?

						- Ted
