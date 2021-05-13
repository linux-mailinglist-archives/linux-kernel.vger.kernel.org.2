Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DFF37FC36
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 19:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhEMRQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 13:16:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230235AbhEMRQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 13:16:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76EFC61408;
        Thu, 13 May 2021 17:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620926122;
        bh=gkYB58Zv652AxS7gt1nDSfOQyePra0vUUbzM/X8tEug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fdoHk8b6QwTf/XAGUBVdAoVqYCVrg+tehep+CwO/MNYMWXqkClSJNsCIDIkkcebKp
         ak2mZjWsvy/QhLUpf/z3iBK97C3F9yXq4HEGKMV8V/rJPsdW5RoIB6adhWVE9rDtfx
         LD+Gi+vklm44RMENce+DFEMpsS5EUSSTIkk98lm0=
Date:   Thu, 13 May 2021 19:15:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Savo Novakovic <savox.novakovic@intel.com>
Subject: Re: [PATCH v3 12/14] intel_gna: add a 'misc' device
Message-ID: <YJ1ep2RyCT8hcxGd@kroah.com>
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
 <20210513110040.2268-13-maciej.kwapulinski@linux.intel.com>
 <YJ0K7f0NiRwQBPPA@kroah.com>
 <85r1iaimwl.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85r1iaimwl.fsf@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 07:06:18PM +0200, Maciej Kwapulinski wrote:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Thu, May 13, 2021 at 01:00:38PM +0200, Maciej Kwapulinski wrote:
> >> The new 'misc' device is the node for applications in user space to
> >> interact with the driver.
> >> 
> >> Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
> >> Tested-by: Savo Novakovic <savox.novakovic@intel.com>
> >> ---
> >>  drivers/misc/intel/gna/device.c | 52 +++++++++++++++++++++++++++++++--
> >>  drivers/misc/intel/gna/device.h | 11 +++----
> >>  2 files changed, 55 insertions(+), 8 deletions(-)
> >> 
> >> diff --git a/drivers/misc/intel/gna/device.c b/drivers/misc/intel/gna/device.c
> >> index 0e31b8c6bb70..1e6345a8325b 100644
> >> --- a/drivers/misc/intel/gna/device.c
> >> +++ b/drivers/misc/intel/gna/device.c
> >> @@ -20,6 +20,18 @@ module_param(recovery_timeout, int, 0644);
> >>  MODULE_PARM_DESC(recovery_timeout, "Recovery timeout in seconds");
> >>  #endif
> >>  
> >> +struct file;
> >> +
> >> +static int gna_open(struct inode *inode, struct file *f)
> >> +{
> >> +	return -EPERM;
> >> +}
> >
> > That sucks, why have an open that does nothing but fail?
> 
> next patch provides complete implementation of gna_open(), here it's
> just a protection if someone would incidentally run gna in the middle of patch series

Then don't provide an open at all, and it will be fine :)

> 
> >
> >> +
> >> +static const struct file_operations gna_file_ops = {
> >> +	.owner		=	THIS_MODULE,
> >> +	.open		=	gna_open,
> >> +};
> >> +
> >>  static void gna_devm_idr_destroy(void *data)
> >>  {
> >>  	struct idr *idr = data;
> >> @@ -27,6 +39,36 @@ static void gna_devm_idr_destroy(void *data)
> >>  	idr_destroy(idr);
> >>  }
> >>  
> >> +static void gna_devm_deregister_misc_dev(void *data)
> >
> > Why is this a void *?
> 
> it goes to devm_add_action() api.

Ah.  That's not obvious :(



