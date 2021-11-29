Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4A9460CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 03:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243055AbhK2CoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 21:44:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53513 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239504AbhK2CmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 21:42:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638153527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wra7t4P4ZBv5QtkwKs9JyUuRuz38EhYq6YFNmbJSCZk=;
        b=EYhaahrHEgjq1YPbtQrg8BlkBWPGVser7Ljbk3mh6XQOxTZ+Xo4w+9cA1TQ3RVOGnVNyxm
        +sTnCPN377DlxZs3NMRK+sKARCXu7xkBxf1FeBRy+TKaabeFchUVx4pQNFJRg7e1AOzr9t
        5kTezUkyVG+XP2NeDagTTRJn397uS74=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-50cbhO1PNyupgWD_UDrq3g-1; Sun, 28 Nov 2021 21:38:43 -0500
X-MC-Unique: 50cbhO1PNyupgWD_UDrq3g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 873CD81CCB4;
        Mon, 29 Nov 2021 02:38:42 +0000 (UTC)
Received: from T590 (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 11FCF19729;
        Mon, 29 Nov 2021 02:38:31 +0000 (UTC)
Date:   Mon, 29 Nov 2021 10:38:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH 1/2] kobject: don't delay to cleanup module kobject
Message-ID: <YaQ9Iq3qF6H76Pzt@T590>
References: <20211105063710.4092936-1-ming.lei@redhat.com>
 <20211105063710.4092936-2-ming.lei@redhat.com>
 <YaEGcEoCqVHwGEZH@kroah.com>
 <YaELQGKCQovNqTAp@T590>
 <YaEMaWMT+PmMvSwg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaEMaWMT+PmMvSwg@kroah.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 05:33:45PM +0100, Greg Kroah-Hartman wrote:
> On Sat, Nov 27, 2021 at 12:28:48AM +0800, Ming Lei wrote:
> > On Fri, Nov 26, 2021 at 05:08:16PM +0100, Greg Kroah-Hartman wrote:
> > > On Fri, Nov 05, 2021 at 02:37:09PM +0800, Ming Lei wrote:
> > > > CONFIG_DEBUG_KOBJECT_RELEASE is used for debugging kobject release/cleanup
> > > > issue. The module kobject is released after module_exit() returns. If
> > > > this kobject is delayed too much, and may cause other kobject's
> > > > cleaned up a bit earlier before freeing module, then real issue is
> > > > hidden.
> > > > 
> > > > So don't delay module kobject's cleanup, meantime module kobject is
> > > > always cleaned up synchronously, and we needn't module kobject's
> > > > cleanup.
> > > > 
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > >  lib/kobject.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/lib/kobject.c b/lib/kobject.c
> > > > index ea53b30cf483..4c0dbe11be3d 100644
> > > > --- a/lib/kobject.c
> > > > +++ b/lib/kobject.c
> > > > @@ -16,6 +16,7 @@
> > > >  #include <linux/stat.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/random.h>
> > > > +#include <linux/module.h>
> > > >  
> > > >  /**
> > > >   * kobject_namespace() - Return @kobj's namespace tag.
> > > > @@ -727,6 +728,10 @@ static void kobject_release(struct kref *kref)
> > > >  	struct kobject *kobj = container_of(kref, struct kobject, kref);
> > > >  #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
> > > >  	unsigned long delay = HZ + HZ * (get_random_int() & 0x3);
> > > > +
> > > > +	if (kobj->ktype == &module_ktype)
> > > > +		delay = 0;
> > > 
> > > No, there should not be anything "special" about module kobjects to get
> > > this kind of treatment.  They should work like any other kobject and
> > > clean up properly when needed.
> > 
> > Here setting 0 delay for module kobject is just for making DEBUG_KOBJECT_RELEASE
> > reliable to detect/report issues. Otherwise if the random delay for module
> > kobject is bigger than other kobjects, potential use-after-after won't
> > be exposed.
> 
> So you now can not debug the module kobject code?

So far, module kobject code is always released in sync way, see
mod_kobject_put(), and CONFIG_DEBUG_KOBJECT_RELEASE is basically useless
for module kobject.

> 
> This needs to be documented really really really well why this kobject
> type is somehow "special" in the code.  We should not special-case these
> things unless you have a great reason, and I am not yet convinced.

OK, I will add comment on this special usage in V2 so that you can
review it further.


Thanks,
Ming

