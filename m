Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB39351030
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 09:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhDAHhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 03:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbhDAHhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:37:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18422C061788
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 00:37:11 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso567378pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 00:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Aud+dIcxPCJT/CZT/Avgbz5emttFAGl7iLysJkmv9HQ=;
        b=GIu6cSr7gEi7kr1eVD0E/FKPEHv2+ntW/buQZ2B8W7aBHsJypdoxS/0saK/383DCmU
         esv3wPdXsB6Q9hgwBt72cKTfpEqzyGcF+81O5TkRZvBvzaigTBUcTKBSQkXpcsd4tVkg
         UbWcqPKyK4KdqVevgR/Lc1sKz6fn6NfG/t6IQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Aud+dIcxPCJT/CZT/Avgbz5emttFAGl7iLysJkmv9HQ=;
        b=L6sx1Wg+otRurK88spcJI4Agc/Xg+IGURD++JlyrwkMfjQx9uD3Xq38S3OqQyDphyE
         GuDlGcR5SO+Wuc9XMNuXWdz/ULzb/xLGbOolJgjO7UBbnYZHAQcanT3bI+jmjAFMwAya
         TmhWPIgJ8rFLGdNCxLqQZeH9gmA6+VGop+RYs+LGCVPtBTVjVD9jke4yDCOWLGqh0hu/
         skG+X5aFygx+SS6r1ltoxvXoK/nVoLSn8FG5ZwNs/aezgY1wKZfcn3+elLYJqK32m3jJ
         EoZ/9ZB+/oxmA/S9GQIgcpsyXHwMpmc1cd90/vbY0/1YoHPDJdQeAhzBr5tvaJ49iKtg
         3d3g==
X-Gm-Message-State: AOAM532yi5TyWN2RaUOiHJJBFE9QcPa/yY7bYe9ke8CdwRQ+YU/5h9oQ
        p6p6gxQfPs+dyOQ6GfcwxDDJ1w==
X-Google-Smtp-Source: ABdhPJwLCcrVg7CiJnE1FLkm7Zxzfm66PC6qjKPyS9K94ekCn1cm2DTfRkS5WAGVsuUhQUtVPEm//A==
X-Received: by 2002:a17:90a:f298:: with SMTP id fs24mr7717612pjb.57.1617262630639;
        Thu, 01 Apr 2021 00:37:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 15sm4289460pfx.167.2021.04.01.00.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 00:37:10 -0700 (PDT)
Date:   Thu, 1 Apr 2021 00:37:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sysfs: Unconditionally use vmalloc for buffer
Message-ID: <202104010030.42B460AB12@keescook>
References: <20210401022145.2019422-1-keescook@chromium.org>
 <YGVy0WUG1OEFfjhx@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGVy0WUG1OEFfjhx@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 09:14:25AM +0200, Michal Hocko wrote:
> On Wed 31-03-21 19:21:45, Kees Cook wrote:
> > The sysfs interface to seq_file continues to be rather fragile
> > (seq_get_buf() should not be used outside of seq_file), as seen with
> > some recent exploits[1]. Move the seq_file buffer to the vmap area
> > (while retaining the accounting flag), since it has guard pages that
> > will catch and stop linear overflows.
> 
> I thought the previous discussion has led to a conclusion that the
> preferred way is to disallow direct seq_file buffer usage. But this is
> obviously up to sysfs maintainers. I am happy you do not want to spread
> this out to all seq_file users anymore.

Yeah; I still want to remove external seq_get_buf(), but that'll take
time. I'll be doing the work, though, since I still need access to
f_cred for show() access control checks.

> > This seems justified given that
> > sysfs's use of seq_file already uses kvmalloc(), is almost always using
> > a PAGE_SIZE or larger allocation, has normally short-lived allocations,
> > and is not normally on a performance critical path.
> 
> Let me clarify on this, because this is not quite right. kvmalloc vs
> vmalloc (both with GFP_KERNEL) on PAGE_SIZE are two different beasts.
> The first one is almost always going to use kmalloc because the page
> allocator almost never fails those requests.

Yes, good point. I will adjust my changelog.

Thanks!

-Kees

> 
> > Once seq_get_buf() has been removed (and all sysfs callbacks using
> > seq_file directly), this change can also be removed.
> > 
> > [1] https://blog.grimm-co.com/2021/03/new-old-bugs-in-linux-kernel.html
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v3:
> > - Limit to only sysfs (instead of all of seq_file).
> > v2: https://lore.kernel.org/lkml/20210315174851.622228-1-keescook@chromium.org/
> > v1: https://lore.kernel.org/lkml/20210312205558.2947488-1-keescook@chromium.org/
> > ---
> >  fs/sysfs/file.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> > index 9aefa7779b29..70e7a450e5d1 100644
> > --- a/fs/sysfs/file.c
> > +++ b/fs/sysfs/file.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/mm.h>
> > +#include <linux/vmalloc.h>
> >  
> >  #include "sysfs.h"
> >  
> > @@ -32,6 +33,25 @@ static const struct sysfs_ops *sysfs_file_ops(struct kernfs_node *kn)
> >  	return kobj->ktype ? kobj->ktype->sysfs_ops : NULL;
> >  }
> >  
> > +/*
> > + * To be proactively defensive against sysfs show() handlers that do not
> > + * correctly stay within their PAGE_SIZE buffer, use the vmap area to gain
> > + * the trailing guard page which will stop linear buffer overflows.
> > + */
> > +static void *sysfs_kf_seq_start(struct seq_file *sf, loff_t *ppos)
> > +{
> > +	struct kernfs_open_file *of = sf->private;
> > +	struct kernfs_node *kn = of->kn;
> > +
> > +	WARN_ON_ONCE(sf->buf);
> > +	sf->buf = __vmalloc(kn->attr.size, GFP_KERNEL_ACCOUNT);
> > +	if (!sf->buf)
> > +		return ERR_PTR(-ENOMEM);
> > +	sf->size = kn->attr.size;
> > +
> > +	return NULL + !*ppos;
> > +}
> > +
> >  /*
> >   * Reads on sysfs are handled through seq_file, which takes care of hairy
> >   * details like buffering and seeking.  The following function pipes
> > @@ -206,14 +226,17 @@ static const struct kernfs_ops sysfs_file_kfops_empty = {
> >  };
> >  
> >  static const struct kernfs_ops sysfs_file_kfops_ro = {
> > +	.seq_start	= sysfs_kf_seq_start,
> >  	.seq_show	= sysfs_kf_seq_show,
> >  };
> >  
> >  static const struct kernfs_ops sysfs_file_kfops_wo = {
> > +	.seq_start	= sysfs_kf_seq_start,
> >  	.write		= sysfs_kf_write,
> >  };
> >  
> >  static const struct kernfs_ops sysfs_file_kfops_rw = {
> > +	.seq_start	= sysfs_kf_seq_start,
> >  	.seq_show	= sysfs_kf_seq_show,
> >  	.write		= sysfs_kf_write,
> >  };
> > -- 
> > 2.25.1
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Kees Cook
