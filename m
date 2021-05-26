Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE59390E5C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 04:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhEZCkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 22:40:02 -0400
Received: from smtprelay0022.hostedemail.com ([216.40.44.22]:33004 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231843AbhEZCkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 22:40:01 -0400
Received: from omf09.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 8A5E6A2D0;
        Wed, 26 May 2021 02:38:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id F39FD1E04D5;
        Wed, 26 May 2021 02:38:28 +0000 (UTC)
Message-ID: <c017049e2abc746eec80deb0768744d5b94cd3e1.camel@perches.com>
Subject: Re: [PATCH 3/3] slub: Actually use 'message' in restore_bytes()
From:   Joe Perches <joe@perches.com>
To:     Stephen Boyd <swboyd@chromium.org>,
        David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Date:   Tue, 25 May 2021 19:38:27 -0700
In-Reply-To: <CAE-0n50NAaWNdFbsUGw==u+=X+4ZxDA=Qf_YesxXLVsyU8e8YA@mail.gmail.com>
References: <20210520013539.3733631-1-swboyd@chromium.org>
         <20210520013539.3733631-4-swboyd@chromium.org>
         <f4da67db-a53b-a710-947d-474be7aad07@google.com>
         <858b8d14673a200c3c2162fb7a9bf891ecd2a2d9.camel@perches.com>
         <CAE-0n50NAaWNdFbsUGw==u+=X+4ZxDA=Qf_YesxXLVsyU8e8YA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.89
X-Stat-Signature: apm3jtknofu18oxwznwijb89fja8hhrq
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: F39FD1E04D5
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19tJgMR7ep1kGpvtE7bmjdOvSYV0/RJpvI=
X-HE-Tag: 1621996708-919670
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-05-25 at 22:32 -0400, Stephen Boyd wrote:
> Quoting Joe Perches (2021-05-25 00:37:45)
> > On Sun, 2021-05-23 at 22:12 -0700, David Rientjes wrote:
> > > On Wed, 19 May 2021, Stephen Boyd wrote:
> > > 
> > > > The message argument isn't used here. Let's pass the string to the
> > > > printk message so that the developer can figure out what's happening,
> > > > instead of guessing that a redzone is being restored, etc.
> > > > 
> > > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > 
> > > Acked-by: David Rientjes <rientjes@google.com>
> > 
> > Ideally, the slab_fix function would be marked with __printf and the
> > format here would not use \n as that's emitted by the slab_fix.
> 
> Thanks. I can make this into a proper patch and author it from you. Can
> you provide a signed-off-by? The restore_bytes() hunk is slightly
> different but I can fix that up.

If you want...

Signed-off-by: Joe Perches <joe@perches.com>

> 
> > ---
> >  mm/slub.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index ee51857d8e9bc..46f9b043089b6 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -702,6 +702,7 @@ static void slab_bug(struct kmem_cache *s, char *fmt, ...)
> >         va_end(args);
> >  }
> > 
> > +__printf(2, 3)
> >  static void slab_fix(struct kmem_cache *s, char *fmt, ...)
> >  {
> >         struct va_format vaf;
> > @@ -816,7 +817,8 @@ static void init_object(struct kmem_cache *s, void *object, u8 val)
> >  static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
> >                                                 void *from, void *to)
> >  {
> > -       slab_fix(s, "Restoring %s 0x%px-0x%px=0x%x\n", message, from, to - 1, data);
> > +       slab_fix(s, "Restoring %s 0x%px-0x%px=0x%x",
> > +                message, from, to - 1, data);
> >         memset(from, data, to - from);
> >  }
> > 
> > @@ -1069,13 +1071,13 @@ static int on_freelist(struct kmem_cache *s, struct page *page, void *search)
> >                 slab_err(s, page, "Wrong number of objects. Found %d but should be %d",
> >                          page->objects, max_objects);
> >                 page->objects = max_objects;
> > -               slab_fix(s, "Number of objects adjusted.");
> > +               slab_fix(s, "Number of objects adjusted");
> >         }
> >         if (page->inuse != page->objects - nr) {
> >                 slab_err(s, page, "Wrong object count. Counter is %d but counted were %d",
> >                          page->inuse, page->objects - nr);
> >                 page->inuse = page->objects - nr;
> > -               slab_fix(s, "Object count adjusted.");
> > +               slab_fix(s, "Object count adjusted");
> >         }
> >         return search == NULL;
> >  }
> > 
> > 


