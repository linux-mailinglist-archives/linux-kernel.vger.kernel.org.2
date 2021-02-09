Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE0431565E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 19:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhBISzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 13:55:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:33318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233273AbhBIRuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:50:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA43D64E2F;
        Tue,  9 Feb 2021 17:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612892971;
        bh=kvqH3pPX5LDjExP8UWGU7+aGNBkGtGwA6c29Yki1G/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kfQCsMZVeNCO1n8A99eeKPGg4wsmfZSq3yujcquPUvwyZ8TL5Zqd+oBq54VgkrrJ4
         K88Lu8IZOJiXEh2jJzYGNvEVeKxcIK5iK5dlAVv9BOI6bBa88Z11/I+RA3+PgeoDjv
         T2oV2b4+OXfHNONKDwDk1oe84ploilQdSVU7xyog=
Date:   Tue, 9 Feb 2021 18:49:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, surenb@google.com,
        joaodias@google.com, willy@infradead.org
Subject: Re: [PATCH v2] mm: cma: support sysfs
Message-ID: <YCLLKDEQ4NYqb5Y5@kroah.com>
References: <20210208180142.2765456-1-minchan@kernel.org>
 <e01c111b-fb20-0586-c7a9-dd6d922c0e57@nvidia.com>
 <YCHLAdabGmm7kqSH@google.com>
 <43cd6fc4-5bc5-50ec-0252-ffe09afd68ea@nvidia.com>
 <YCIoHBGELFWAyfMi@kroah.com>
 <7cc229f4-609c-71dd-9361-063ef1bf7c73@nvidia.com>
 <cd33f8b9-89e0-05bd-2b16-85855f7541bb@nvidia.com>
 <YCIyHuOX3E+tP+AO@kroah.com>
 <YCKwjz0uDPBhbFr5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YCKwjz0uDPBhbFr5@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 07:55:59AM -0800, Minchan Kim wrote:
> On Tue, Feb 09, 2021 at 07:56:30AM +0100, Greg KH wrote:
> > On Mon, Feb 08, 2021 at 10:34:51PM -0800, John Hubbard wrote:
> > > On 2/8/21 10:27 PM, John Hubbard wrote:
> > > > On 2/8/21 10:13 PM, Greg KH wrote:
> > > > > On Mon, Feb 08, 2021 at 05:57:17PM -0800, John Hubbard wrote:
> > > > > > On 2/8/21 3:36 PM, Minchan Kim wrote:
> > > > > > ...
> > > > > > > > >         char name[CMA_MAX_NAME];
> > > > > > > > > +#ifdef CONFIG_CMA_SYSFS
> > > > > > > > > +    struct cma_stat    *stat;
> > > > > > > > 
> > > > > > > > This should not be a pointer. By making it a pointer, you've added a bunch of pointless
> > > > > > > > extra code to the implementation.
> > > > > > > 
> > > > > > > Originally, I went with the object lifetime with struct cma as you
> > > > > > > suggested to make code simple. However, Greg KH wanted to have
> > > > > > > release for kobj_type since it is consistent with other kboject
> > > > > > > handling.
> > > > > > 
> > > > > > Are you talking about the kobj in your new struct cma_stat? That seems
> > > > > > like circular logic if so. I'm guessing Greg just wanted kobj methods
> > > > > > to be used *if* you are dealing with kobjects. That's a narrower point.
> > > > > > 
> > > > > > I can't imagine that he would have insisted on having additional
> > > > > > allocations just so that kobj freeing methods could be used. :)
> > > > > 
> > > > > Um, yes, I was :)
> > > > > 
> > > > > You can not add a kobject to a structure and then somehow think you can
> > > > > just ignore the reference counting issues involved.  If a kobject is
> > > > > part of a structure then the kobject is responsible for controling the
> > > > > lifespan of the memory, nothing else can be.
> > > > > 
> > > > > So by making the kobject dynamic, you properly handle that memory
> > > > > lifespan of the object, instead of having to worry about the lifespan of
> > > > > the larger object (which the original patch was not doing.)
> > > > > 
> > > > > Does that make sense?
> > > > > 
> > > > That part makes sense, yes, thanks. The part that I'm trying to straighten
> > > > out is, why was kobject even added to the struct cma_stat in the first
> > > > place? Why not just leave .stat as a static member variable, without
> > > > a kobject in it, and done?
> > > > 
> > > 
> > > Sorry, I think I get it now: this is in order to allow a separate lifetime
> > > for the .stat member. I was sort of implicitly assuming that the "right"
> > > way to do it is just have the whole object use one lifetime management,
> > > but as you say, there is no kobject being added to the parent.
> > > 
> > > I still feel odd about the allocation and freeing of something that seems
> > > to be logically the same lifetime (other than perhaps a few, briefly pending
> > > sysfs reads, at the end of life). So I'd still think that the kobject should
> > > be added to the parent...
> 
> sruct cma_stat {
> 	spinlock_t lock;
> 	unsigned long pages_attemtp;
> 	unsigned long pages_fail;
> };
> 
> struct cma {
> 	..
> 	..
> 	struct kobject kobj;
> 	struct cma_stat stat;
> };
> 
> I guess this is what Johan suggested. I agree with it.
> 
> > 
> > That's fine if you want to add it to the parent.  If so, then the
> > kobject controls the lifetime of the structure, nothing else can.
> 
> The problem was parent object(i.e., struct cma cma_areas) is
> static arrary so kobj->release function will be NULL or just
> dummy. Is it okay? I thought it was one of the what you wanted
> to avoid it.

No, that is not ok.

> > Either is fine with me, what is "forbidden" is having a kobject and
> > somehow thinking that it does not control the lifetime of the structure.
> 
> Since parent object is static arrary, there is no need to control the
> lifetime so I am curious if parent object approach is okay from kobject
> handling point of view.

So the array is _NEVER_ freed?  If not, fine, don't provide a release
function for the kobject, but ick, just make a dynamic kobject I don't
see the problem for something so tiny and not very many...

I worry that any static kobject might be copied/pasted as someone might
think this is an ok thing to do.  And it's not an ok thing to do.

thanks,

greg k-h
