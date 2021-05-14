Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759AD38054C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbhENIdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:33:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhENIdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:33:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 288F861442;
        Fri, 14 May 2021 08:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620981130;
        bh=xu2oLOgWDImEy3UAklFSVgTWGQJIJ7KjJ6FuDnVx580=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WbqwXwpZXwcF0Bftzqxhv4soKjL1/cQ8bysTrtM3b3XdnnTBTlPyrjHTc5Lcnzwog
         Kjm8KAnoVnrVkHd6M889UmX/B6l0bFQdcZ1Ui9uoLwRDuvIEkr3yGIAj0wDKM7Y0D+
         E+DqsjRq8XsLTiwQ0FVzrEVFZmQk+lWOyQR49rIQ=
Date:   Fri, 14 May 2021 10:32:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: Re: [PATCH v3 11/14] intel_gna: add ioctl handler
Message-ID: <YJ41h6lt8lSqaH7r@kroah.com>
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
 <20210513110040.2268-12-maciej.kwapulinski@linux.intel.com>
 <YJ0MXK2XSISC1fIl@kroah.com>
 <85o8ddiv51.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85o8ddiv51.fsf@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 10:20:42AM +0200, Maciej Kwapulinski wrote:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Thu, May 13, 2021 at 01:00:37PM +0200, Maciej Kwapulinski wrote:
> >> From: Tomasz Jankowski <tomasz1.jankowski@intel.com>
> >> 
> >> Add ioctl handler into GNA driver.
> >> The ioctl interface provides the ability to do the following:
> >>  - Map and unmap memory buffers for GNA computation requests.
> >>  - Retrieve capabilities of the underlying GNA IP.
> >>  - Submit GNA computation requests.
> >>  - Request notification of scoring completion.
> >
> > Do you have a pointer to the userspace code that uses this ioctl?
> > That's kind of required here, otherwise we have no idea how this all
> > works.
> >
> 
> yes, it's present under following link:
> 
> https://github.com/intel/gna

Then that needs to go here in this changelog text, right?
