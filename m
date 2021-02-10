Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84F9315F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 07:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhBJGo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 01:44:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:52868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231553AbhBJGoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:44:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A4B064E4B;
        Wed, 10 Feb 2021 06:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612939422;
        bh=YOrVXXQiKglQu2Rdq4Iu7x2LG7tjwgOjO/EOjr05vk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SSfPY5dIxTjNZWnwyJpcfmY5K8q+NP69afgqi+e8SGP37IZpMF3MOzp4B+wgHZqDv
         9O/+Nd2HHo0d2V/Zd1cd4UGlQ7bONjIynkZb0or0jX8AKmFGpknIxMIJoM6gqzfIX0
         ofmRrUUvrf4FXkpKMa4DWL8MrB0mZmR+MX91W53o=
Date:   Wed, 10 Feb 2021 07:43:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, surenb@google.com,
        joaodias@google.com, willy@infradead.org
Subject: Re: [PATCH v2] mm: cma: support sysfs
Message-ID: <YCOAmXqt6dZkCQYs@kroah.com>
References: <YCHLAdabGmm7kqSH@google.com>
 <43cd6fc4-5bc5-50ec-0252-ffe09afd68ea@nvidia.com>
 <YCIoHBGELFWAyfMi@kroah.com>
 <7cc229f4-609c-71dd-9361-063ef1bf7c73@nvidia.com>
 <cd33f8b9-89e0-05bd-2b16-85855f7541bb@nvidia.com>
 <YCIyHuOX3E+tP+AO@kroah.com>
 <YCKwjz0uDPBhbFr5@google.com>
 <YCLLKDEQ4NYqb5Y5@kroah.com>
 <09e60732-6a46-dd00-f9d5-4ef17ee685c8@nvidia.com>
 <YCL67QzPiyRhhbor@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCL67QzPiyRhhbor@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 01:13:17PM -0800, Minchan Kim wrote:
> On Tue, Feb 09, 2021 at 12:11:20PM -0800, John Hubbard wrote:
> > On 2/9/21 9:49 AM, Greg KH wrote:
> > > > > That's fine if you want to add it to the parent.  If so, then the
> > > > > kobject controls the lifetime of the structure, nothing else can.
> > > > 
> > > > The problem was parent object(i.e., struct cma cma_areas) is
> > > > static arrary so kobj->release function will be NULL or just
> > > > dummy. Is it okay? I thought it was one of the what you wanted
> > > > to avoid it.
> > > 
> > > No, that is not ok.
> > > 
> > > > > Either is fine with me, what is "forbidden" is having a kobject and
> > > > > somehow thinking that it does not control the lifetime of the structure.
> > > > 
> > > > Since parent object is static arrary, there is no need to control the
> > > > lifetime so I am curious if parent object approach is okay from kobject
> > > > handling point of view.
> > > 
> > > So the array is _NEVER_ freed?  If not, fine, don't provide a release
> > > function for the kobject, but ick, just make a dynamic kobject I don't
> > > see the problem for something so tiny and not very many...
> > > 
> > 
> > Yeah, I wasn't trying to generate so much discussion, I initially thought it
> > would be a minor comment: "just use an embedded struct and avoid some extra
> > code", at first.
> > 
> > > I worry that any static kobject might be copied/pasted as someone might
> > > think this is an ok thing to do.  And it's not an ok thing to do.
> > > 
> > 
> > Overall, then, we're seeing that there is a small design hole: in order
> > to use sysfs most naturally, you either much provide a dynamically allocated
> > item for it, or you must use the static kobject, and the second one sets a
> > bad example.
> > 
> > I think we should just use a static kobject, with a cautionary comment to
> > would-be copy-pasters, that explains the design constraints above. That way,
> > we still get a nice, less-code implementation, a safe design, and it only
> > really costs us a single carefully written comment.
> > 
> > thanks,
> 
> Agreed. How about this for the warning part?
> 
> +
> +/*
> + * note: kobj_type should provide a release function to free dynamically
> + * allocated object since kobject is responsible for controlling lifespan
> + * of the object. However, cma_area is static object so technially, it
> + * doesn't need release function. It's very exceptional case so pleaes
> + * do not follow this model.
> + */
>  static struct kobj_type cma_ktype = {
>         .sysfs_ops = &kobj_sysfs_ops,
>         .default_groups = cma_groups
> +       .release = NULL, /* do not follow. See above */
>  };
> 

No, please no.  Just do it the correct way, what is the objection to
creating a few dynamic kobjects from the heap?  How many of these are
you going to have that it will somehow be "wasteful"?

Please do it properly.

thanks,

greg k-h
