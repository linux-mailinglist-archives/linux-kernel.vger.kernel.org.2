Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C700C45F25A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 17:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378443AbhKZQtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 11:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238131AbhKZQrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 11:47:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E758C0613E1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 08:33:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4AFD622DD
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 16:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F09BC93056;
        Fri, 26 Nov 2021 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637944428;
        bh=xmCaT2GzT6CZatw5KD1Q984keLtGzkGYqh1jtWg33us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IjCbw62VD93Z0v6UPOPwTuv5NYyohfLX78i3SgdWyAt56L6jsH7i/FZ9T4B6mzJ2Z
         c0QqVnzRah95dSR5i+5DC/oIWBPWjJH153fRxlZ5Ps7PaiBSfouro0ObKLUAnQnF+n
         Ntk2WFP1EIHR/Fsdv0SRMKhknU/OOTLpkXzvZxQw=
Date:   Fri, 26 Nov 2021 17:33:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH 1/2] kobject: don't delay to cleanup module kobject
Message-ID: <YaEMaWMT+PmMvSwg@kroah.com>
References: <20211105063710.4092936-1-ming.lei@redhat.com>
 <20211105063710.4092936-2-ming.lei@redhat.com>
 <YaEGcEoCqVHwGEZH@kroah.com>
 <YaELQGKCQovNqTAp@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaELQGKCQovNqTAp@T590>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 12:28:48AM +0800, Ming Lei wrote:
> On Fri, Nov 26, 2021 at 05:08:16PM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Nov 05, 2021 at 02:37:09PM +0800, Ming Lei wrote:
> > > CONFIG_DEBUG_KOBJECT_RELEASE is used for debugging kobject release/cleanup
> > > issue. The module kobject is released after module_exit() returns. If
> > > this kobject is delayed too much, and may cause other kobject's
> > > cleaned up a bit earlier before freeing module, then real issue is
> > > hidden.
> > > 
> > > So don't delay module kobject's cleanup, meantime module kobject is
> > > always cleaned up synchronously, and we needn't module kobject's
> > > cleanup.
> > > 
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  lib/kobject.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/lib/kobject.c b/lib/kobject.c
> > > index ea53b30cf483..4c0dbe11be3d 100644
> > > --- a/lib/kobject.c
> > > +++ b/lib/kobject.c
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/stat.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/random.h>
> > > +#include <linux/module.h>
> > >  
> > >  /**
> > >   * kobject_namespace() - Return @kobj's namespace tag.
> > > @@ -727,6 +728,10 @@ static void kobject_release(struct kref *kref)
> > >  	struct kobject *kobj = container_of(kref, struct kobject, kref);
> > >  #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
> > >  	unsigned long delay = HZ + HZ * (get_random_int() & 0x3);
> > > +
> > > +	if (kobj->ktype == &module_ktype)
> > > +		delay = 0;
> > 
> > No, there should not be anything "special" about module kobjects to get
> > this kind of treatment.  They should work like any other kobject and
> > clean up properly when needed.
> 
> Here setting 0 delay for module kobject is just for making DEBUG_KOBJECT_RELEASE
> reliable to detect/report issues. Otherwise if the random delay for module
> kobject is bigger than other kobjects, potential use-after-after won't
> be exposed.

So you now can not debug the module kobject code?

This needs to be documented really really really well why this kobject
type is somehow "special" in the code.  We should not special-case these
things unless you have a great reason, and I am not yet convinced.

thanks,

greg k-h
