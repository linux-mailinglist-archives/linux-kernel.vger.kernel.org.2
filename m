Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50793B0A55
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 18:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhFVQaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 12:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231135AbhFVQaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 12:30:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 660A1611BF;
        Tue, 22 Jun 2021 16:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624379275;
        bh=dJ5aLN8czXJLyCE9mU3GrqfcmvFhdzmWGyXt4pBlP3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ikePdOKpQfn/YyA0kI2IYzbqtQU0Tj304Vljmvt/AA6ETbZY1A20sTV70TOw9RMj4
         8CTB2YNS3jbXyul+VAcOyrKIaE6E82b5cxexoyX3+G398pLIltrAwelMGHT3Gubh1z
         emd6V2QwrUu2VtqKMl1Gdg3B/7AXe/nSO9a04qCc=
Date:   Tue, 22 Jun 2021 18:27:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     minchan@kernel.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, jpoimboe@redhat.com, tglx@linutronix.de,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] zram: fix deadlock with sysfs attribute usage and
 driver removal
Message-ID: <YNIPiDb3TPamz5cF@kroah.com>
References: <20210621233013.562641-1-mcgrof@kernel.org>
 <20210621233634.595649-1-mcgrof@kernel.org>
 <YNGUIzh7aR3C/Hoz@kroah.com>
 <20210622152713.fqwyuqpamwgaxomc@garbanzo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622152713.fqwyuqpamwgaxomc@garbanzo>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 08:27:13AM -0700, Luis Chamberlain wrote:
> On Tue, Jun 22, 2021 at 09:41:23AM +0200, Greg KH wrote:
> > On Mon, Jun 21, 2021 at 04:36:34PM -0700, Luis Chamberlain wrote:
> > > +	ssize_t __ret; \
> > > +	if (!try_module_get(THIS_MODULE)) \
> > 
> > try_module_get(THIS_MODULE) is always racy and probably does not do what
> > you want it to do.  You always want to get/put module references from
> > code that is NOT the code calling these functions.
> 
> In this case, we want it to trump module removal if it succeeds. That's all.

True, but either you stop the race, or you do not right?  If you are so
invested in your load/unload test, this should show up with this code
eventually as well.

> > > +		return -ENODEV; \
> > > +	__ret = _name ## _store(dev, attr, buf, len); \
> > > +	module_put(THIS_MODULE); \
> > 
> > This too is going to be racy.
> > 
> > While fun to poke at, I still think this is pointless.
> 
> If you have a better idea, which does not "DOS" module removal, please
> let me know!

I have yet to understand why you think that the load/unload in a loop is
a valid use case.

thanks,

greg k-h
