Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8886539E443
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 18:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFGQpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 12:45:40 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:40495 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhFGQpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 12:45:39 -0400
Received: by mail-pl1-f182.google.com with SMTP id e7so9012186plj.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 09:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6LJVcLhVjhkAw1O0ADZV9uBmqzs8gtp6gROk+FpQxN0=;
        b=BsXDcOhaOqC+9pNSvmWG7NLH9D2JCTu9xKmWclo70To9JORVgI3IRh3CFruIYaHXEd
         uENBWL/3uZsq3pBQMKAeEaDs6a3xmvIlzprvviZfSI0P/GU1RziwzkrsJDl47eccAn5m
         Xdh7j+sbiKD6pXEZGoCeSPeL3t4WM26FTMWwSk+j//JMRWl51MgIVDuDCpw17JsjgsVt
         k7j9c2I+yrMiJIfC5OMK0sEvYyPY9VjAMgB2fGHF722cL5hciYW4Wzrh8RWSpKQJEcRS
         RkecEOeCHlEUGW85NxTybywjT+dXAl3Y7TP7Ew2tvo1wbd7QwEf2bfTi/vdXm4bDD1ET
         b0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6LJVcLhVjhkAw1O0ADZV9uBmqzs8gtp6gROk+FpQxN0=;
        b=bfURZXrArZ5weTTVunjP/f/lrTBxBlCWQ7lFHe/66etmygPZzmbQs0ib5yZApWZKJq
         dzW19b6OgLFsgdPyDMjZOd6VV5uQQB3aebYDGwdAxSr4aXcWf1QaCpdPYI39BoGdsE/h
         5eJqu9DwJxfeTc2rw+MEbRX885LzYrcge27ztWoa3JcgA6vBojCMhWM+4+BsmHcsnHIj
         JrUC9DaiOCBds2zodv2EEpXxF6xLgnfEAsmzaMQGBBSGVHDZGC7FiE8QLkZOuV68Rdqt
         gRqiwju+7Z2lT1HSC4RDZyyrEM5iLVru51lvo2IwgZhScadnhyQV9S5lsAtn3Y5TSHyD
         gYYg==
X-Gm-Message-State: AOAM531z1A1ZACuuLs/oYXpulAgOKHF/+hxSVGkOMsLpUbUJZzs9ylhB
        yrQkRAM/oknL+mJAiSKEJYj3l1twjBwqzfVVOzk=
X-Google-Smtp-Source: ABdhPJzY+MgFl6O9pMtvBaJ17X44WNQ+WNRuUyTvaEL5ItcLJ/cUXy5lZR9Ne7a+vbUyowT49j9uieKfv9GaY69Og08=
X-Received: by 2002:a17:902:b190:b029:105:cb55:3a7a with SMTP id
 s16-20020a170902b190b0290105cb553a7amr15115512plr.17.1623084168224; Mon, 07
 Jun 2021 09:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <1622996045-25826-1-git-send-email-faiyazm@codeaurora.org>
 <CAHp75VdM0aziN4zHaf6=z6D0Nb=+GTbjV1pdTpRZ=yxGDZRkhw@mail.gmail.com> <d5c16162-91af-40ba-66dc-02ac5a6a48ef@codeaurora.org>
In-Reply-To: <d5c16162-91af-40ba-66dc-02ac5a6a48ef@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 7 Jun 2021 19:42:32 +0300
Message-ID: <CAHp75VeCLyOSExxLGSaTzR3OgE+_PGe4FxraCK8T3sn6yS6-uQ@mail.gmail.com>
Subject: Re: [PATCH v10] mm: slub: move sysfs slab alloc/free interfaces to debugfs
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <greg@kroah.com>, glittao@gmail.com,
        vinmenon@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 4:55 PM Faiyaz Mohammed <faiyazm@codeaurora.org> wrote:
> On 6/7/2021 2:01 AM, Andy Shevchenko wrote:
> > On Sun, Jun 6, 2021 at 7:16 PM Faiyaz Mohammed <faiyazm@codeaurora.org> wrote:

...

> >> +               if (num_online_cpus() > 1 &&
> >> +                               !cpumask_empty(to_cpumask(l->cpus)))
> >
> > One line?
> >
> I have split the line because it is crossing the 80 columns. In this
> case it's okay to cross 80 columns?

For how many characters? If it's 3 or 4 or so, it's fine to have it on
one line. Use common sense here.

...

> >> +       debugfs_remove_recursive(debugfs_lookup(s->name,
> >> +                                       slab_debugfs_root));
> >
> > One line?
> >
> Same here!

Same here.

-- 
With Best Regards,
Andy Shevchenko
