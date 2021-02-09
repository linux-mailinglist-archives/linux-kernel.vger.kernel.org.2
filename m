Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031F9314886
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 07:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhBIGOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 01:14:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230077AbhBIGOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 01:14:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52CFD64EB4;
        Tue,  9 Feb 2021 06:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612851232;
        bh=vXvZjO+dJ8YWmqHgcCh15Ljh8Qtw2DaVGWOZH6EHT0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Po3kesrKpij7luyyByApUUHGyuySlg8ir7gDdTWQMwPAG2oVcqY7PkOYOyyZkdHR
         9UCuHmQUNEgynRm8VV3Y8+52dGbPgvuzT4YLztJfyDhpku52eLhKzsg0h3UyV7E2DJ
         mJv3z2j3BLNRH9lPryeE/m71TG8Z7rOffQwEK4Ik=
Date:   Tue, 9 Feb 2021 07:13:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, surenb@google.com,
        joaodias@google.com, willy@infradead.org
Subject: Re: [PATCH v2] mm: cma: support sysfs
Message-ID: <YCIoHBGELFWAyfMi@kroah.com>
References: <20210208180142.2765456-1-minchan@kernel.org>
 <e01c111b-fb20-0586-c7a9-dd6d922c0e57@nvidia.com>
 <YCHLAdabGmm7kqSH@google.com>
 <43cd6fc4-5bc5-50ec-0252-ffe09afd68ea@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43cd6fc4-5bc5-50ec-0252-ffe09afd68ea@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 05:57:17PM -0800, John Hubbard wrote:
> On 2/8/21 3:36 PM, Minchan Kim wrote:
> ...
> > > >    	char name[CMA_MAX_NAME];
> > > > +#ifdef CONFIG_CMA_SYSFS
> > > > +	struct cma_stat	*stat;
> > > 
> > > This should not be a pointer. By making it a pointer, you've added a bunch of pointless
> > > extra code to the implementation.
> > 
> > Originally, I went with the object lifetime with struct cma as you
> > suggested to make code simple. However, Greg KH wanted to have
> > release for kobj_type since it is consistent with other kboject
> > handling.
> 
> Are you talking about the kobj in your new struct cma_stat? That seems
> like circular logic if so. I'm guessing Greg just wanted kobj methods
> to be used *if* you are dealing with kobjects. That's a narrower point.
> 
> I can't imagine that he would have insisted on having additional
> allocations just so that kobj freeing methods could be used. :)

Um, yes, I was :)

You can not add a kobject to a structure and then somehow think you can
just ignore the reference counting issues involved.  If a kobject is
part of a structure then the kobject is responsible for controling the
lifespan of the memory, nothing else can be.

So by making the kobject dynamic, you properly handle that memory
lifespan of the object, instead of having to worry about the lifespan of
the larger object (which the original patch was not doing.)

Does that make sense?

thanks,

greg k-h
