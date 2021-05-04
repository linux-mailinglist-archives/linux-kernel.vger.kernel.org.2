Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957A4372E1E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 18:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhEDQc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 12:32:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231651AbhEDQcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 12:32:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0758F61153;
        Tue,  4 May 2021 16:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620145888;
        bh=HEoVuMMyCorXHFHNK57tOLdo4fFFRxsjN8iPfCi0MYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CDz28VDaiBdh+oS+J5Hsd7fdo1jci0IMZDJ/78vzOaTYIpFTFWonccp5UolZUNCWk
         i9kQGE58djvjdWNpWYPLvR0ZLq0YpfB9wQxY/qgyXXT8ov64V1js+MoGqO3V4JtIMK
         94PmOzqRmWFRQz0vnVhdaBQfDDgBg17v0KB5nNnY=
Date:   Tue, 4 May 2021 18:31:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 37/69] ALSA: usx2y: check for failure of usb_alloc_urb()
Message-ID: <YJF23p/IK1VzODIf@kroah.com>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
 <20210503115736.2104747-38-gregkh@linuxfoundation.org>
 <aa185e3d-981f-ca5a-ea40-d266e62b82fe@perex.cz>
 <s5hczu6rjih.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hczu6rjih.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 10:27:34AM +0200, Takashi Iwai wrote:
> On Mon, 03 May 2021 22:33:52 +0200,
> Jaroslav Kysela wrote:
> > 
> > Dne 03. 05. 21 v 13:57 Greg Kroah-Hartman napsal(a):
> > > While it is almost impossible to hit an error calling usb_alloc_urb(),
> > > to make systems like syzbot which does error injection, and some static
> > > analysis tools happy, properly handle errors on this path by unwinding
> > > the previously allocated urbs and freeing them.
> > 
> > Perhaps, I miss something, but this revert and add the cleanup to the wrong
> > place makes things worse:
> > 
> > The usb_stream_free() is called when init_urbs() fails (returns an error), so
> > all urbs are freed there and pointers are reset to NULL. Your code frees urbs
> > twice on an allocation error.
> > 
> > The reverted code does the job better.
> 
> Right, the suggested patch will cause the double-free, and the
> reverted code is fine in this regard.

That wasn't obvious at all, sorry about that.

> In anyway, the cleanup of this driver code is on my post-15.3 TODO
> list.  So, Greg, could you drop the revert and the additional fix at
> this round for usx2y driver?

Ok, will drop the revert and this patch, thanks for the review and sorry
for the noise.

greg k-h
