Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEAA30643A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344561AbhA0TgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344416AbhA0Tch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:32:37 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39363C06178A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:31:42 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id q8so4273100lfm.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJB6pzhcxR6RIOhk+W4vBLAOQOY6A+IbRkTJX3GrSIA=;
        b=Nex7m0nPT6ikFYD0UDxgXryCJyYTx+pRUl8n/I+/+QgVAzM5sX/Iufo8IZe70BES4A
         PxumGwRUK+eKwrok3peAydYv34EWMMQMd6k8vlFvyDIPohc+dGl9OdT0wXxeuKjCUlu3
         DoAjRpEayelexJA+o2u5g1eysr8elGHigTn34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJB6pzhcxR6RIOhk+W4vBLAOQOY6A+IbRkTJX3GrSIA=;
        b=YqLZvuS+ULKgkCAPEvx/VS5sXg9H2FdH1wWGR/SB61sx7LjH4sluX+NlT1SpP2fGOx
         /3yvJX9zK4PPUvt165WFcYbVsK9TLmRVV8PY1NtnUcll9QX9jUuOffnQahnRhtoFJ19j
         Qb9gLnnML2vxBwr76fFwn6inS4r3VvPNYh4LtA6XYDgfElBvi4ZGnSI/Ao22f9kwOJEb
         Z1T0lewdl+os1EkfVbncjfN/kyzklQFk10qDp0HZiYMkQZvGFHwRp+jeDj0VsPs9NKnG
         eg+pj4BBv/ov8NCa714xBW4huAHxiZi7WC/FvrjzgEf+Yyyn08fdRuy/J295s9FMlsVp
         2Y9A==
X-Gm-Message-State: AOAM530xYa0/sVgeek//arPkQuGuYLj1hxyFMENzq3zgYCmbgu062cKu
        9HgZDv0uSBHbItiSiv7vGWf9ZyTjLvl14w==
X-Google-Smtp-Source: ABdhPJy3502Ce/s5BWfgvJMq1wuTpiP0ynnK6u/dnx4occGpmgAE5XL3qP44RKj6h8CyeC8hIg5LEg==
X-Received: by 2002:a19:8cc:: with SMTP id 195mr5504013lfi.504.1611775900168;
        Wed, 27 Jan 2021 11:31:40 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id e4sm869487ljo.121.2021.01.27.11.31.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 11:31:38 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id b2so4330782lfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:31:38 -0800 (PST)
X-Received: by 2002:ac2:420a:: with SMTP id y10mr5554909lfh.377.1611775897778;
 Wed, 27 Jan 2021 11:31:37 -0800 (PST)
MIME-Version: 1.0
References: <000000000000672eda05b9e291ff@google.com>
In-Reply-To: <000000000000672eda05b9e291ff@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Jan 2021 11:31:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=whCX0Ab=Z2N-zuKVv7BdBZAUGgP0jQqCg+OJjHmtaOkTA@mail.gmail.com>
Message-ID: <CAHk-=whCX0Ab=Z2N-zuKVv7BdBZAUGgP0jQqCg+OJjHmtaOkTA@mail.gmail.com>
Subject: Re: KASAN: invalid-free in p9_client_create (2)
To:     syzbot <syzbot+d0bd96b4696c1ef67991@syzkaller.appspotmail.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        David Miller <davem@davemloft.net>, ericvh@gmail.com,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lucho@ionkov.net, Netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        v9fs-developer@lists.sourceforge.net, wanghai38@huawei.com,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Participants list changed - syzbot thought this was networking and
p9, but it really looks entirely like a slub internal bug. I left the
innocent people on the list just to let them know they are innocent ]

On Wed, Jan 27, 2021 at 6:27 AM syzbot
<syzbot+d0bd96b4696c1ef67991@syzkaller.appspotmail.com> wrote:
>
> The issue was bisected to:
>
> commit dde3c6b72a16c2db826f54b2d49bdea26c3534a2
> Author: Wang Hai <wanghai38@huawei.com>
> Date:   Wed Jun 3 22:56:21 2020 +0000
>
>     mm/slub: fix a memory leak in sysfs_slab_add()
>
> BUG: KASAN: double-free or invalid-free in slab_free mm/slub.c:3142 [inline]
> BUG: KASAN: double-free or invalid-free in kmem_cache_free+0x82/0x350 mm/slub.c:3158

The p9 part of this bug report seems to be a red herring.

The problem looks like it's simply the kmem_cache failure case, ie:

 - mm/slab_common.c: create_cache(): if the __kmem_cache_create()
fails, it does:

        out_free_cache:
                kmem_cache_free(kmem_cache, s);

 - but __kmem_cache_create() - at least for slub() - will have done

        sysfs_slab_add(s) .. fails ..
            -> kobject_del(&s->kobj); .. which frees s ...

so the networking and p9 are fine, and the only reason p9 shows up in
the trace is that apparently it causes that failure in
kobject_init_and_add() for whatever reason, and that then exposes the
problem.

So the added kobject_put() really looks buggy in this situation, and
the memory leak that that commit dde3c6b72a16 ("mm/slub: fix a memory
leak in sysfs_slab_add()") fixes is now a double free.

And no, I don't think you can just remove the kmem_cache_free() in
create_cache(), because _other_ error cases of __kmem_cache_create()
do not free this.

Wang Hai - comments? I'm inclined to revert that commit for now unless
somebody can come up with a proper fix..

              Linus
