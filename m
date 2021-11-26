Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4ED45F1E5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 17:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbhKZQeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 11:34:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45067 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230241AbhKZQcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 11:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637944147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dm5YxVikGIEz3sRqCWSi6yuJcTiabnvcQxgoKgt87pg=;
        b=cAnx5IWzhFCfIyALcGYQ1aAiaaOHcrRINsptE/DjPkUPm9yQiDgDp5XZZ2ajdVIQQR/kdm
        uuOw/gkwC3GpWA0OGwMC5WawvnCw+x/9f1DvJHytqJRxKuUEoBpxdiky26xvEZw0iUFe6W
        pvOY9Co0D+AOqYcKPO/Wt9SPcstkNLY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-KH8_8qlgMaamLo-QOr4lBA-1; Fri, 26 Nov 2021 11:29:04 -0500
X-MC-Unique: KH8_8qlgMaamLo-QOr4lBA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AE961017965;
        Fri, 26 Nov 2021 16:29:03 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D5A5260854;
        Fri, 26 Nov 2021 16:28:53 +0000 (UTC)
Date:   Sat, 27 Nov 2021 00:28:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH 1/2] kobject: don't delay to cleanup module kobject
Message-ID: <YaELQGKCQovNqTAp@T590>
References: <20211105063710.4092936-1-ming.lei@redhat.com>
 <20211105063710.4092936-2-ming.lei@redhat.com>
 <YaEGcEoCqVHwGEZH@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaEGcEoCqVHwGEZH@kroah.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 05:08:16PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Nov 05, 2021 at 02:37:09PM +0800, Ming Lei wrote:
> > CONFIG_DEBUG_KOBJECT_RELEASE is used for debugging kobject release/cleanup
> > issue. The module kobject is released after module_exit() returns. If
> > this kobject is delayed too much, and may cause other kobject's
> > cleaned up a bit earlier before freeing module, then real issue is
> > hidden.
> > 
> > So don't delay module kobject's cleanup, meantime module kobject is
> > always cleaned up synchronously, and we needn't module kobject's
> > cleanup.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  lib/kobject.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/lib/kobject.c b/lib/kobject.c
> > index ea53b30cf483..4c0dbe11be3d 100644
> > --- a/lib/kobject.c
> > +++ b/lib/kobject.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/stat.h>
> >  #include <linux/slab.h>
> >  #include <linux/random.h>
> > +#include <linux/module.h>
> >  
> >  /**
> >   * kobject_namespace() - Return @kobj's namespace tag.
> > @@ -727,6 +728,10 @@ static void kobject_release(struct kref *kref)
> >  	struct kobject *kobj = container_of(kref, struct kobject, kref);
> >  #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
> >  	unsigned long delay = HZ + HZ * (get_random_int() & 0x3);
> > +
> > +	if (kobj->ktype == &module_ktype)
> > +		delay = 0;
> 
> No, there should not be anything "special" about module kobjects to get
> this kind of treatment.  They should work like any other kobject and
> clean up properly when needed.

Here setting 0 delay for module kobject is just for making DEBUG_KOBJECT_RELEASE
reliable to detect/report issues. Otherwise if the random delay for module
kobject is bigger than other kobjects, potential use-after-after won't
be exposed.


Thanks,
Ming

