Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330DD326313
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 14:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhBZNEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 08:04:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:45704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230079AbhBZNEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 08:04:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32C5F64EE2;
        Fri, 26 Feb 2021 13:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614344639;
        bh=ZiJl8DpWEVCvIAtlfcxEMZ4oXLoAHaJv04eh0CYE7d0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0ml3fDh2uFY/AjFC4lthT/HDZ5Erk4mxqDdTIeSgPurDjrs59TOBDrcccL2Jm6kpG
         L45u7ZKpIcpRsrKRLwvbznTMT3RGKEGZ61K83V+IXy5uCszoRL96WhwekWnqt5iZxs
         iEMtOPFVEno5yP8A6ssdBpAGY2IeiPl2YoiY6H3Q=
Date:   Fri, 26 Feb 2021 14:03:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: Re: [PATCH v1 01/12] gna: add driver module
Message-ID: <YDjxu+0zvz3zsRb3@kroah.com>
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
 <20210216160525.5028-2-maciej.kwapulinski@linux.intel.com>
 <YCwFBNa2npYcEIQ+@kroah.com>
 <85wnuvrnml.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85wnuvrnml.fsf@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 01:59:14PM +0100, Maciej Kwapulinski wrote:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Tue, Feb 16, 2021 at 05:05:14PM +0100, Maciej Kwapulinski wrote:
> ....
> >> --- /dev/null
> >> +++ b/drivers/misc/gna/gna_driver.h
> >> @@ -0,0 +1,41 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only */
> >> +/* Copyright(c) 2017-2021 Intel Corporation */
> >> +
> >> +#ifndef __GNA_DRIVER_H__
> >> +#define __GNA_DRIVER_H__
> >> +
> >> +#include <linux/kernel.h>
> >> +#include <linux/mutex.h>
> >> +#include <linux/types.h>
> >> +
> >> +#define GNA_DRV_NAME	"gna"
> >
> > Way too generic, no one knows what "gna" is.
> >
> 
> "intel gna" is much more verbose in search engines.
> As we do not (plan to) have more "gna" drivers, is the following ok?:
> 
> intel-gna
> 
> the change would imply the following:
> 
> prompt$ lspci -s 00:00.3 -vvvv
> 00:00.3 System peripheral: Intel Corporation Device 3190 (rev 03)
> 	Subsystem: Intel Corporation Device 2072
>   ....
> 	Kernel driver in use: intel-gna
> 	Kernel modules: gna
> 
> is it ok?

Why not intel-gna as the kernel module as well?

> also, how about the interface to library (it's part of one of next patches)?:
> prompt$ file /dev/gna0
> /dev/gna0: character special (235/0)
> 
> can "gna" stay intact here?

Again, I have no idea what "gna" is, so you might want to pick something
more descriptive?

> I'm pointing this out, because gna exists on the market for a while and
> changing the above may have some impact we'd like to avoid.

If it exists but Linux does not support it, how would anyone know about
it?  :)

Please use real terms where possible.

thanks,

greg k-h
