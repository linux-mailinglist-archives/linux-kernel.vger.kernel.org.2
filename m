Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A00141F0A7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 17:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354960AbhJAPL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 11:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354932AbhJAPL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 11:11:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEB7761139;
        Fri,  1 Oct 2021 15:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633101012;
        bh=/Js9Yw80cdggEJrcCDcgqSAGfR+XZpT+CdcFWr2btw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iNukeuDsBBf0EgHv8PveefzXGcAJ4a/uA0d/HmKYKbdBCJuNjheK0TptlYhrcybLP
         xQ3CyixKSp038OytFU/AubDcWpZaV96adbHZjnSOuISmZwtMae0st5c6hfcRYIoLiP
         hbpODd1OXyLnz6T93reyInaG1yib2cNad45G2KO4=
Date:   Fri, 1 Oct 2021 17:10:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, linux-kernel@vger.kernel.org,
        Fei Li <fei1.li@intel.com>
Subject: Re: [PATCH v1 1/1] virt: acrn: Drop internal kernel type from ABI
Message-ID: <YVck0pu9wkUM++Rf@kroah.com>
References: <20211001135644.1884-1-andriy.shevchenko@linux.intel.com>
 <YVcUxXJeduv1OHrz@kroah.com>
 <YVciKWdHJMaEwQu6@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVciKWdHJMaEwQu6@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 05:58:49PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 01, 2021 at 04:01:41PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Oct 01, 2021 at 04:56:44PM +0300, Andy Shevchenko wrote:
> > > guid_t is internal type of the kernel which is mistakenly had been exposed
> > > to the user space. Replace it with raw buffers.
> > 
> > Wait, why is it a mistake to expose it to userspace?  What does this
> > conflict with?  Is it a namespace issue?  Or something else?
> 
> It is the type which is defined solely for kernel use and what user space
> should do is to use types defined by respective libraries, such as libuuid.

But that does not work here.  We want to expose a common uuid type that
userspace can use in these structures, as well as the kernel.  Do you
really want to "open code" arrays all over the place?

> If you read the commit message to the end, you will notice that I have
> mentioned the possible scenario what happened here. They seems misusing
> guid_t as uuid_t, but the latter is not available for the users from
> the kernel headers (and this is good). So this is an exact example why
> guid_t shouldn't be exposed.

Then we should create a type that we can use here.  The kernel can not
use libuuid, so what is wrong with using the kernel variable type
namespace for this?  __guid?  __uuid?

thanks,

greg k-h
