Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62555305DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhA0OGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:06:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232456AbhA0OEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:04:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30FF6207B7;
        Wed, 27 Jan 2021 14:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611756239;
        bh=ROh69qiSoUMvgZqdt5G7yeSYyGncADOq/fcqQaGyQnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r1UYdLX7W/IbCSpeLjznQn7Aj+4VHaVCJvmT/dXMUCNg4qh0BoqZ9/EgoEXQAxIZM
         MI2E9Ee/PrioUk03iAEWSjL5sH0g9MgdG2DP6Bof6Vy8Abm42wPQq84fDQ/SlApEH7
         jck3bklSgCEuRgdxbq5EKGaqSBCDpU6+TxV11jYQ=
Date:   Wed, 27 Jan 2021 15:03:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Chen, Mike Ximing" <mike.ximing.chen@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v9 04/20] dlb: add device ioctl layer and first three
 ioctls
Message-ID: <YBFyzX87hvpaYJWK@kroah.com>
References: <20210122190138.7414-1-mike.ximing.chen@intel.com>
 <20210122190138.7414-5-mike.ximing.chen@intel.com>
 <YBFckMGGRKZBYXRd@kroah.com>
 <BYAPR11MB30958F6A70E6B7C005F7B8FCD9BB9@BYAPR11MB3095.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB30958F6A70E6B7C005F7B8FCD9BB9@BYAPR11MB3095.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 01:59:50PM +0000, Chen, Mike Ximing wrote:
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Wednesday, January 27, 2021 7:29 AM
> > To: Chen, Mike Ximing <mike.ximing.chen@intel.com>
> > Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Williams, Dan J
> > <dan.j.williams@intel.com>; pierre-louis.bossart@linux.intel.com; Gage Eads
> > <gage.eads@intel.com>
> > Subject: Re: [PATCH v9 04/20] dlb: add device ioctl layer and first three ioctls
> > 
> > On Fri, Jan 22, 2021 at 01:01:22PM -0600, Mike Ximing Chen wrote:
> > > --- /dev/null
> > > +++ b/include/uapi/linux/dlb.h
> > > @@ -0,0 +1,167 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > 
> > As the bot points out, this is an "odd" license for a uapi .h file, are
> > you SURE about this?
> > 
> > If so, I need an Intel lawyer's signed-off-by on it as well, so we know
> > to talk to in the future about it.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Sorry, it should be "GPL-2.0-only WITH Linux-syscall-note".
> Should I correct it and submit a new patch set (v10) now, or wait for more feedback on the current patch set?

Please consult your corporate lawyers when picking licenses for your
kernel files.  I doubt they want me telling you what to do :)

good luck!

greg k-h
