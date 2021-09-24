Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DB4416A50
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 05:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243961AbhIXDKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 23:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhIXDKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 23:10:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89EDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 20:08:44 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id bx4so30655755edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 20:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pqOUF2ID5Z3ZhgcypPTAUuh9KgfVjRAG/Kv6sgvowxc=;
        b=XcpN0OmnZiCmTRLGp6cKERD7HTR89Kj9jpH7/CHRyc9RFZt/YZRSVGdqasbne76v2v
         vSX6EMJiGswIs9cCNO7/M9UNU3c+M6+5GxBupYFV7BbGAyBcfDVJ3kGoknQsh5BMRDfC
         hq2Udpf/5k84jW9VLPeSpZssJSRbJK3Bbr0at69y57bm+SrcMrwZiWPP3ziPw9qWMWxv
         dwIfZyCvdf9Lk9dyx23VrJga56LJQIOMRaEtHzDaaDP8A0spxD5fbuzqWXMG8IfxczV0
         LhPtRN/QwNcIxDR+ZVj6UL1qMBZ39hzfBQxeFFy5VF71j6AK6rYOKPUzucIVVUcyNaBb
         Y4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pqOUF2ID5Z3ZhgcypPTAUuh9KgfVjRAG/Kv6sgvowxc=;
        b=exU82XFYLQRo+WyVjVNHXXVhgCJmBnPNnM3wJ+8fCh9M0dRYNxqCghaeyGKNWkS4cK
         lIQsRruKPRBsZPZtsRj/nUiQ1cP7SIYT6NbobOueg9ceApkVUkXMHAmj976yw5NRWjlx
         IAL5GsB1YJjPBKv7pu2M6eyEYpzZpsJ1DSOEADDZBjpi0Uu8cbCRn1cn9+R0Jg4ailXb
         GesGJIa1c1TIVu2xOxAski0zHICNEia3pUDdyGkBlpnVSJUoXKMMd3FQ4ttYG+BmKdwR
         mkF1DyBag/ROnOyoPXBQW+YYB0lsp2YO7Pdqz0ZGc86gCM8A4jtvr5fnlOhIp4Cbv7RB
         MICw==
X-Gm-Message-State: AOAM533zJ7WbdoFfNOO7+v0GSxOihPJWJ9ylO77+HlSD9KLxXGVrNfBx
        oK2B6MNTFbWok6tLUNgctrMy6dAiGUlrhbAuJGs=
X-Google-Smtp-Source: ABdhPJx3zGsvE6gO3iatsk7hVOkUwkznmn7IZbRaERkL0uPs+CEgt5cfCnYe5G9ewkeD/gXujh+Cwj1SxeIee6C7JzM=
X-Received: by 2002:a17:906:3854:: with SMTP id w20mr8488896ejc.537.1632452923167;
 Thu, 23 Sep 2021 20:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
 <20210922070645.47345-2-rongwei.wang@linux.alibaba.com> <YUsVcEDcQ2vEzjGg@casper.infradead.org>
 <BC145393-93AC-4DF4-9CF4-2FB1C736B70C@linux.alibaba.com> <20210923194343.ca0f29e1c4d361170343a6f2@linux-foundation.org>
In-Reply-To: <20210923194343.ca0f29e1c4d361170343a6f2@linux-foundation.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 23 Sep 2021 20:08:31 -0700
Message-ID: <CAHbLzkrj5FVwuUOea3Y40kJbFipOaw1F-ARK5jrfw8ZNF+=GXw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page cache
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        song@kernel.org, william.kucharski@oracle.com,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 7:43 PM Andrew Morton <akpm@linux-foundation.org> w=
rote:
>
> On Thu, 23 Sep 2021 01:04:54 +0800 Rongwei Wang <rongwei.wang@linux.aliba=
ba.com> wrote:
>
> >
> >
> > > On Sep 22, 2021, at 7:37 PM, Matthew Wilcox <willy@infradead.org> wro=
te:
> > >
> > > On Wed, Sep 22, 2021 at 03:06:44PM +0800, Rongwei Wang wrote:
> > >> Transparent huge page has supported read-only non-shmem files. The f=
ile-
> > >> backed THP is collapsed by khugepaged and truncated when written (fo=
r
> > >> shared libraries).
> > >>
> > >> However, there is race in two possible places.
> > >>
> > >> 1) multiple writers truncate the same page cache concurrently;
> > >> 2) collapse_file rolls back when writer truncates the page cache;
> > >
> > > As I've said before, the bug here is that somehow there is a writable=
 fd
> > > to a file with THPs.  That's what we need to track down and fix.
> > Hi, Matthew
> > I am not sure get your means. We know =E2=80=9Cmm, thp: relax the VM_DE=
NYWRITE constraint on file-backed THPs"
> > Introduced file-backed THPs for DSO. It is possible {very rarely} for D=
SO to be opened in writeable way.
> >
> > ...
> >
> > > https://lore.kernel.org/linux-mm/YUdL3lFLFHzC80Wt@casper.infradead.or=
g/
> > All in all, what you mean is that we should solve this race at the sour=
ce?
>
> Matthew is being pretty clear here: we shouldn't be permitting
> userspace to get a writeable fd for a thp-backed file.

No, he doesn't mean it IIRC. Actually we had the same conversation for
another patch. Quoted below:

" > > Things have already gone wrong before we get to this point.  See
> > do_dentry_open().  You aren't supposed to be able to get a writable fil=
e
> > descriptor on a file which has had huge pages added to the page cache
> > without the filesystem's knowledge.  That's the problem that needs to
> > be fixed.
>
> I don't quite understand your point here. Do you mean do_dentry_open()
> should fail for such cases instead of truncating the page cache?

No, do_dentry_open() should have truncated the page cache when it was
called and found that there were THPs in the cache.  Then khugepaged
should see that someone has the file open for write and decline to create
new THPs.  So it shouldn't be possible to get here with THPs in the cache."

Please see https://lore.kernel.org/linux-mm/YUkCI2I085Sos%2F64@casper.infra=
dead.org/

But actually "mm, thp: relax the VM_DENYWRITE constraint on
file-backed THPs" did so exactly.

>
> Why are we permitting the DSO to be opened writeably?  If there's a
> legitimate case for doing this then presumably "mm, thp: relax the
> VM_DENYWRITE constraint on file-backed THPs: should be fixed or
> reverted.

Unfortunately we can't revert this commit anymore since VM_DENYWRITE
is gone due to commit 8d0920bde5eb ("mm: remove VM_DENYWRITE")

>
> If there is no legitimate use case for returning a writeable fd for a
> thp-backed file then we should fail such an attempt at open().  This
> approach has back-compatibility issues which need to be thought about.
> Perhaps we should permit the open-writeably attempt to appear to
> succeed, but to really return a read-only fd?
>
>
