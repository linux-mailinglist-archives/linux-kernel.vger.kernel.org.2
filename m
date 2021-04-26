Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AFF36B798
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhDZRKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235341AbhDZRJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:09:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB85961077;
        Mon, 26 Apr 2021 17:08:19 +0000 (UTC)
Date:   Mon, 26 Apr 2021 19:08:17 +0200
From:   Greg KH <greg@kroah.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Tavis Ormandy <taviso@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 186/190] Revert "virt: vbox: Only copy_from_user the
 request-header once"
Message-ID: <YIbzgRAT9j4HR3xK@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-187-gregkh@linuxfoundation.org>
 <s5pfgl$all$1@ciao.gmane.io>
 <YIDOUetRRiizeOBX@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIDOUetRRiizeOBX@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 01:16:01AM +0000, Al Viro wrote:
> On Wed, Apr 21, 2021 at 03:14:29PM -0000, Tavis Ormandy wrote:
> > On 2021-04-21, Greg Kroah-Hartman wrote:
> > > This reverts commit bd23a7269834dc7c1f93e83535d16ebc44b75eba.
> > >
> > > -	*((struct vbg_ioctl_hdr *)buf) = hdr;
> > > -	if (copy_from_user(buf + sizeof(hdr), (void *)arg + sizeof(hdr),
> > > -			   hdr.size_in - sizeof(hdr))) {
> > > +	if (copy_from_user(buf, (void *)arg, hdr.size_in)) {
> > >  		ret = -EFAULT;
> > >  		goto out;
> > >  	}
> > 
> > This one seems like a real bugfix, otherwise there's a double-fetch from
> > userspace, and a TOCTOU with the hdr fields that could cause a OOB read.
> 
> 	ACK, except that typecasts in there are messy as hell.  But that's,
> alas, consistent with the rest of the function...
> 
> 	Patch itself is correct, and AFAICS Wenwen Wang <wang6495@umn.edu>
> might be an innocent collateral damage from that mess - commits from that
> source appear to be fairly well-written.

I've dropped it from my tree now, thanks for the review.

greg k-h
