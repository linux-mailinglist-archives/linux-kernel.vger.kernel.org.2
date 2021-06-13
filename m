Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46503A5727
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 10:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhFMIqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 04:46:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50770 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229777AbhFMIqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 04:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623573876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FHEEdqa7cqln4XKJYtrL82d5dzyuGs+JlNcccHmAJK4=;
        b=H/NTdufQx/mwn+xt2K7UHpLOdMEj9PlMCx7+5y6X3lXCeCHYUtDm7rK5nlnDnywGEmcuZf
        Zl217XZVip61Lkk1K2rlflliBmbfiT1qi7Z5z6ON5Ooi37wvIkZadO3XyoIsbsuuyppj2i
        aCJBjq/l8WrVdM+5s4JeTDmI7ADMdUU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-nk1NYrweM1WDZWJVQtYJIQ-1; Sun, 13 Jun 2021 04:44:34 -0400
X-MC-Unique: nk1NYrweM1WDZWJVQtYJIQ-1
Received: by mail-wr1-f71.google.com with SMTP id k25-20020a5d52590000b0290114dee5b660so5300392wrc.16
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 01:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=FHEEdqa7cqln4XKJYtrL82d5dzyuGs+JlNcccHmAJK4=;
        b=P9UMek+ufcaLv30D0a0Ipi2sWPDfkVyy9+XcDqzK3cNwVrxBVm7iSaBQzBivW4FTBE
         JLwDKtCenlTbZuoStifWijAjrODwOQVffDy3mI6JnQvdHrIJciK6DDfX38/VfkX6ljze
         +GOZoJ+eNe/MfKOtaff0+eIXSK3xgqnF+fZ1lxaiM7a2QnpHWtXBHzs+IGX62WQXxRiY
         6eJbrLOEw6qFVbO7nAtk7K0mSyVcfmFbon2IHzvZ1QVljFei8rFExaIGCzDEeaHPD9Ef
         NzmqIXeR3Nu5s0buOEuf5pdd+FhNwGmwmBNF6qOeGj2LOX6khte+C+QX90srrsZEDCgS
         hHqQ==
X-Gm-Message-State: AOAM5331UeRMzGcAQWxfOTg1SjMDgzGY3jCleHm5iXnNS2H2XxJetuph
        b6Nqm19R/zOp9YjLSh5zS7uTpBmfY4CZ+4VwVRUeImJoUSAENTc2y2RmFWJcOZ7hAx5zQDas8Kt
        BINesoctdFsDzMllAECtyrebx
X-Received: by 2002:a5d:4689:: with SMTP id u9mr12894324wrq.31.1623573873475;
        Sun, 13 Jun 2021 01:44:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPV5Df5jlQniyi+mEa+LESxC0jsxbRNrsfkQ0E+V2REF6TTCGUK0DwVzr+uD6OmWQlwPAVMQ==
X-Received: by 2002:a5d:4689:: with SMTP id u9mr12894306wrq.31.1623573873233;
        Sun, 13 Jun 2021 01:44:33 -0700 (PDT)
Received: from 0.7.3.c.2.b.0.0.0.3.7.8.9.5.0.2.0.0.0.0.a.d.f.f.0.b.8.0.1.0.0.2.ip6.arpa (0.7.3.c.2.b.0.0.0.3.7.8.9.5.0.2.0.0.0.0.a.d.f.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:ffda:0:2059:8730:b2:c370])
        by smtp.gmail.com with ESMTPSA id k42sm19768540wms.0.2021.06.13.01.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 01:44:32 -0700 (PDT)
Message-ID: <3ae2eac460c27a9f58a1b89b49da710c0c9d43ed.camel@redhat.com>
Subject: Re: [Cluster-devel] [RFC 4/9] gfs2: Fix mmap + page fault deadlocks
 (part 1)
From:   Steven Whitehouse <swhiteho@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel <cluster-devel@redhat.com>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Date:   Sun, 13 Jun 2021 09:44:31 +0100
In-Reply-To: <YMUokdiLMIpr8ee/@zeniv-ca.linux.org.uk>
References: <20210531170123.243771-1-agruenba@redhat.com>
         <20210531170123.243771-5-agruenba@redhat.com>
         <CAHk-=wiB9gvUsebmiOaRXzYVUxJDUt1SozGtRyxR_MDR=Nv7YQ@mail.gmail.com>
         <CAHc6FU4n_F9sPjP7getGRKLpB-KsZt_qhHctqwY5pJrxGxLr2w@mail.gmail.com>
         <YMOOZsBzg/6SKSzT@zeniv-ca.linux.org.uk>
         <YMUhpI/ZIuxvKCt8@zeniv-ca.linux.org.uk>
         <YMUokdiLMIpr8ee/@zeniv-ca.linux.org.uk>
Organization: Red Hat UK Ltd
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2021-06-12 at 21:35 +0000, Al Viro wrote:
> On Sat, Jun 12, 2021 at 09:05:40PM +0000, Al Viro wrote:
> 
> > Is the above an accurate description of the mainline situation
> > there?
> > In particular, normal read doesn't seem to bother with locks at
> > all.
> > What exactly are those cluster locks for in O_DIRECT read?
> 
> BTW, assuming the lack of contention, how costly is
> dropping/regaining
> such cluster lock?
> 

The answer is that it depends...

The locking modes for glocks for inodes look like this:

==========      ==========   ==============   ==========   ==============
Glock mode      Cache data   Cache Metadata   Dirty Data   Dirty Metadata
==========      ==========   ==============   ==========   ==============
    UN             No              No             No            No
    SH             Yes             Yes            No            No
    DF             No              Yes            No            No
    EX             Yes             Yes            Yes           Yes
==========      ==========   ==============   ==========   ==============

The above is a copy & paste from Documentation/filesystems/gfs2-
glocks.rst. If you think of these locks as cache control, then it makes
a lot more sense.

The DF (deferred) mode is there only for DIO. It is a shared lock mode
that is incompatible with the normal SH mode. That is because it is ok
to cache data pages under SH but not under DF. That the only other
difference between the two shared modes. DF is used for both read and
write under DIO meaning that it is possible for multiple nodes to read
& write the same file at the same time with DIO, leaving any
synchronisation to the application layer. As soon as one performs an
operation which alters the metadata tree (truncate, extend, hole
filling) then we drop back to the normal EX mode, so DF is only used
for preallocated files.

Your original question though was about the cost of locking, and there
is a wide variation according to circumstances. The glock layer caches
the results of the DLM requests and will continue to hold glocks gained
from remote nodes until either memory pressure or requests to drop the
lock from another node is received.

When no other nodes are interested in a lock, all such cluster lock
activity is local. There is a cost to it though, and if (for example)
you tried to take and drop the cluster lock on every page, that would
definitely be noticeable. There are probably optimisations that could
be done on what is quite a complex code path, but in general thats what
we've discovered from testing. The introduction of ->readpages() vs the
old ->readpage() made a measurable difference and likewise on the write
side, iomap has also show performance increases due to the reduction in
locking on multi-page writes.

If there is another node that has an interest in a lock, then it can
get very expensive in terms of latency to regain a lock. To drop the
lock to a lower mode may involve I/O (from EX mode) and journal
flush(es) and to get the lock back again involves I/O to other nodes
and then a wait while they finish what they are doing. To avoid
starvation there is a "minimum hold time" so that when a node gains a
glock, it is allowed to retain it, in the absence of local requests,
for a short period. The idea being that if a large number of glock
requests are being made on a node, each for a short time, we allow
several of those to complete before we do the expensive glock release
to another node.

See Documentation/filesystems/gfs2-glocks.rst for a longer explanation
and locking order/rules between different lock types,

Steve.


