Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32A03676B0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 03:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbhDVBQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 21:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbhDVBQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 21:16:36 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51279C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 18:16:02 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lZNwn-007BKe-42; Thu, 22 Apr 2021 01:16:01 +0000
Date:   Thu, 22 Apr 2021 01:16:01 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tavis Ormandy <taviso@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 186/190] Revert "virt: vbox: Only copy_from_user the
 request-header once"
Message-ID: <YIDOUetRRiizeOBX@zeniv-ca.linux.org.uk>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-187-gregkh@linuxfoundation.org>
 <s5pfgl$all$1@ciao.gmane.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5pfgl$all$1@ciao.gmane.io>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:14:29PM -0000, Tavis Ormandy wrote:
> On 2021-04-21, Greg Kroah-Hartman wrote:
> > This reverts commit bd23a7269834dc7c1f93e83535d16ebc44b75eba.
> >
> > -	*((struct vbg_ioctl_hdr *)buf) = hdr;
> > -	if (copy_from_user(buf + sizeof(hdr), (void *)arg + sizeof(hdr),
> > -			   hdr.size_in - sizeof(hdr))) {
> > +	if (copy_from_user(buf, (void *)arg, hdr.size_in)) {
> >  		ret = -EFAULT;
> >  		goto out;
> >  	}
> 
> This one seems like a real bugfix, otherwise there's a double-fetch from
> userspace, and a TOCTOU with the hdr fields that could cause a OOB read.

	ACK, except that typecasts in there are messy as hell.  But that's,
alas, consistent with the rest of the function...

	Patch itself is correct, and AFAICS Wenwen Wang <wang6495@umn.edu>
might be an innocent collateral damage from that mess - commits from that
source appear to be fairly well-written.
