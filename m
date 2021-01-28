Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A913076F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 14:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhA1NU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 08:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhA1NUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 08:20:20 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776FBC061756
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 05:19:40 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id a1so5160270ilr.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 05:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cow24fgEnd60fVUr2CBX9vdbr4yWWqVuvtzr63SEizA=;
        b=HoFbP+Zib5UOipWa3W23Fi1MoIU070YNaq5BparQIgolVOtb7EhFAyEGoflJKUq27G
         SfV7TY3UAfWePauSGfIZbZMbSzdaOSmk7G31UYfkhh2lrrMHJy8EXGSr08lpe7us5Nmr
         e6+Lqz4a7EdYV8dGPJyk9gf+PffLDcY7qnwJtTRHGB9uy7GjH1O4DNCVS05Gs1Pcdwqr
         FK2iR9acytUeue/auHPno2+MG1E15Oiy8+V5R41n0fOwkwJ0Ib3WzKtYs7uws6CQacNj
         vS1fwm8KAX+CL3YQXVC9b2WzF8u9xNkFgF2FmzlxXa1MTlnbt96k0Ex7EYJWh7BAAchr
         2jPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cow24fgEnd60fVUr2CBX9vdbr4yWWqVuvtzr63SEizA=;
        b=iy/rFeZZRkKoa2+XIcWM1wnNHiv5uxFwi94rbJTcGxhrr1jVrdKfz8yok37PwiZYbE
         MJCeOZEnwl4hiH5ExG7G4t/ZMgrXovW45V5L+lh8cYdoxJSpjsQP5exIOfrHPR7sTF3r
         DM6aaXOR9vFhjLeojLF99MuCNEj0k5otEiIA3Oa36dUwR4U1CvzxC598JW9b8EMuN8/+
         vMhhz4pMVNTePAq1UvFZzwxc3VIYKJXNQsFd9SuZThwccSZ1w0FRi5xhloSR5raxRD86
         Xy79OC9/PRrl69Cpws2pi65yfD1xpIFPm4khhybJw92t4qYJXFQatSnoWwaEaleG5Zlv
         eRlg==
X-Gm-Message-State: AOAM532aCj6PAfZ/xR5UVQjSW/EufyU5lpZbYEBFoSxVMrYOsxcpmRB5
        d4yNJJdOuU+ta+a7Fc6PUOmx7RMNgMU5sVfRVXc=
X-Google-Smtp-Source: ABdhPJx+BDNyxHgnjhZTSAfixwEALTr8y67HbZhhAmj8GRTwYKd4hY/oomdsUZ0le75y3K9j5DpOtWJbuK861L3wl/8=
X-Received: by 2002:a92:5bc2:: with SMTP id c63mr12865497ilg.142.1611839980051;
 Thu, 28 Jan 2021 05:19:40 -0800 (PST)
MIME-Version: 1.0
References: <20210128021947.22877-1-laoar.shao@gmail.com> <YBKqNLL2MVHhRjtU@smile.fi.intel.com>
In-Reply-To: <YBKqNLL2MVHhRjtU@smile.fi.intel.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 28 Jan 2021 21:19:04 +0800
Message-ID: <CALOAHbCrW=MvuN68eVo16Z7EaCMpSWTnAQo3EV4maGBQMtWSYQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] mm, printk: dump full information of page flags in pGp
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 8:12 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jan 28, 2021 at 10:19:44AM +0800, Yafang Shao wrote:
> > Currently the pGp only shows the names of page flags, rather than
> > the full information including section, node, zone, last cpupid and
> > kasan tag. While it is not easy to parse these information manually
> > because there're so many flavors. Let's interpret them in pGp as well.
> >
> > This patchset also includes some code cleanup in mm/slub.c.
> >
> > Below is the example of the output in mm/slub.c.
> > - Before the patchset
> > [ 6155.716018] INFO: Slab 0x000000004027dd4f objects=33 used=3 fp=0x000000008cd1579c flags=0x17ffffc0010200
> >
> > - After the patchset
> > [ 6315.235783] ERR: Slab 0x000000006d1133b9 objects=33 used=3 fp=0x000000006d0779d1 flags=0x17ffffc0010200(Node 0x0,Zone 0x2,Lastcpupid 0x1fffff,slab|head)
>
>
> Please, add a corresponding test cases to test_printf.c. W/o test cases NAK.
>

Sure. Will add the test cases in the next version.


-- 
Thanks
Yafang
