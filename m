Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3616131492E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 07:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhBIG53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 01:57:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:60804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229745AbhBIG5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 01:57:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE4E264E66;
        Tue,  9 Feb 2021 06:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612853794;
        bh=VgVI55Qj2fE2DYtRsTjeiTilPdRtitr2xXBpsmkbtK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gQHAWC7TnpY+LGErYA+VxHmESG50VC2KBUsKgEtJjOwys6FYVmS1o+Mz2tVzrH2yh
         5K52uFUmCQ9KZdjkt+2SYMTepFhaoXDNVNC3YQqZdRxs2Ua5ApvAuYrkEuQMt5GJmX
         nU2Qht2hY8Ds511juTbYONpwhluAwMuM9jbrPjkg=
Date:   Tue, 9 Feb 2021 07:56:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, surenb@google.com,
        joaodias@google.com, willy@infradead.org
Subject: Re: [PATCH v2] mm: cma: support sysfs
Message-ID: <YCIyHuOX3E+tP+AO@kroah.com>
References: <20210208180142.2765456-1-minchan@kernel.org>
 <e01c111b-fb20-0586-c7a9-dd6d922c0e57@nvidia.com>
 <YCHLAdabGmm7kqSH@google.com>
 <43cd6fc4-5bc5-50ec-0252-ffe09afd68ea@nvidia.com>
 <YCIoHBGELFWAyfMi@kroah.com>
 <7cc229f4-609c-71dd-9361-063ef1bf7c73@nvidia.com>
 <cd33f8b9-89e0-05bd-2b16-85855f7541bb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd33f8b9-89e0-05bd-2b16-85855f7541bb@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 10:34:51PM -0800, John Hubbard wrote:
> On 2/8/21 10:27 PM, John Hubbard wrote:
> > On 2/8/21 10:13 PM, Greg KH wrote:
> > > On Mon, Feb 08, 2021 at 05:57:17PM -0800, John Hubbard wrote:
> > > > On 2/8/21 3:36 PM, Minchan Kim wrote:
> > > > ...
> > > > > > >         char name[CMA_MAX_NAME];
> > > > > > > +#ifdef CONFIG_CMA_SYSFS
> > > > > > > +    struct cma_stat    *stat;
> > > > > > 
> > > > > > This should not be a pointer. By making it a pointer, you've added a bunch of pointless
> > > > > > extra code to the implementation.
> > > > > 
> > > > > Originally, I went with the object lifetime with struct cma as you
> > > > > suggested to make code simple. However, Greg KH wanted to have
> > > > > release for kobj_type since it is consistent with other kboject
> > > > > handling.
> > > > 
> > > > Are you talking about the kobj in your new struct cma_stat? That seems
> > > > like circular logic if so. I'm guessing Greg just wanted kobj methods
> > > > to be used *if* you are dealing with kobjects. That's a narrower point.
> > > > 
> > > > I can't imagine that he would have insisted on having additional
> > > > allocations just so that kobj freeing methods could be used. :)
> > > 
> > > Um, yes, I was :)
> > > 
> > > You can not add a kobject to a structure and then somehow think you can
> > > just ignore the reference counting issues involved.  If a kobject is
> > > part of a structure then the kobject is responsible for controling the
> > > lifespan of the memory, nothing else can be.
> > > 
> > > So by making the kobject dynamic, you properly handle that memory
> > > lifespan of the object, instead of having to worry about the lifespan of
> > > the larger object (which the original patch was not doing.)
> > > 
> > > Does that make sense?
> > > 
> > That part makes sense, yes, thanks. The part that I'm trying to straighten
> > out is, why was kobject even added to the struct cma_stat in the first
> > place? Why not just leave .stat as a static member variable, without
> > a kobject in it, and done?
> > 
> 
> Sorry, I think I get it now: this is in order to allow a separate lifetime
> for the .stat member. I was sort of implicitly assuming that the "right"
> way to do it is just have the whole object use one lifetime management,
> but as you say, there is no kobject being added to the parent.
> 
> I still feel odd about the allocation and freeing of something that seems
> to be logically the same lifetime (other than perhaps a few, briefly pending
> sysfs reads, at the end of life). So I'd still think that the kobject should
> be added to the parent...

That's fine if you want to add it to the parent.  If so, then the
kobject controls the lifetime of the structure, nothing else can.

Either is fine with me, what is "forbidden" is having a kobject and
somehow thinking that it does not control the lifetime of the structure.

thanks,

greg k-h
