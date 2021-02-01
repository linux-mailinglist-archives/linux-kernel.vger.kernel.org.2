Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF1130A91F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhBANyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhBANyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:54:10 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F281C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 05:53:30 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id p15so14879368ilq.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 05:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BeSu4xYQl+/zC1Ai3KoLiW3Kk/6+Mg+BlRaAWIf/mIo=;
        b=TKw0vFNs9522C1dd7Jccv26cVLax4gf7b5Pdi9MpFL5+U7BJd20VZZ4haBWYlmAk5R
         6cPy4h+s0Bcj8kfLANlSYZEm92KeKHt6aV0W7TcpPXjVc4lya9EYECMQiamUMJOe011w
         26IPjwmr+AwnbhvgJOysJCzrjIPYpvmiQfcj/mrEbIzd6kofGn9uImj58ERdKQW1ZnSc
         oi+voxs82uSkbAnq+yyUWAPUD4TdP5oS2IZVcP7WVgeBysn2Ouq8rhXyWEjMAC0jvVbh
         JNkQO+v9rdoOcV6IIumpPk060NsCkuYoUMPCukUzi5wohtCJdBxp0KaDzr1HQV1unwQA
         bMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BeSu4xYQl+/zC1Ai3KoLiW3Kk/6+Mg+BlRaAWIf/mIo=;
        b=BcGe5A32OnLOln1IZEr9I3OW+VsQ4MbUMiOAVKkAjNMrjiofhR7kmTfIygvq/xCggS
         Hk/vgfIo/lKA0ctd6M7R/rPzv/04RHd/Z1hQrxfOZ+4bn8sDZCWARuCUXGLUrGHoUP/i
         6JpmPcmXnfGdNY4lZnmfJoPoWZZKG54fExwxEgf6M/2zAeuQDZulExiblgDPYlnRnRuZ
         2vgiDBG9dv5kz7Ywnjnx5JHk5dyibJXMI3nTVXUg9kUe99+e1rzOqX3Z4GaD6dFEYpZ0
         PZ8ynMPwhgaovBzitoDi9W4zBOiYQ4GmNYlqW3J+4LISEUck0ofJNdXGdcO8C5K1kIdg
         NnUQ==
X-Gm-Message-State: AOAM531m9CTrOs1UNFI+s5yeJYHVGYxqgDMjl2HFG2ioIEXQq0fY+vGK
        cMdR60s6iuNex6kGTEj6HFwWEQAS89hg50zE5BM=
X-Google-Smtp-Source: ABdhPJzXZ3YRSg+mtqXMCWCd7XfgB1X0ZqLiJkwKk0K4HjNAvNXZF87LEaKwmQDir/YWK6mGH91lams5hI2efWtmFUs=
X-Received: by 2002:a05:6e02:b:: with SMTP id h11mr12729742ilr.168.1612187609633;
 Mon, 01 Feb 2021 05:53:29 -0800 (PST)
MIME-Version: 1.0
References: <20210201115610.87808-1-laoar.shao@gmail.com> <20210201115610.87808-4-laoar.shao@gmail.com>
 <66784ea1-29c7-6bed-ca7f-cd3e7ea9155b@redhat.com> <YBgDW6dbdT7AvCXE@smile.fi.intel.com>
In-Reply-To: <YBgDW6dbdT7AvCXE@smile.fi.intel.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 1 Feb 2021 21:52:53 +0800
Message-ID: <CALOAHbAeU53py1yi7Dd-vrP6fJO1OMJXM4bVo0O3jc9iAY5UTA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] vsprintf: dump full information of page flags in pGp
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 9:34 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 01, 2021 at 02:23:33PM +0100, David Hildenbrand wrote:
> > On 01.02.21 12:56, Yafang Shao wrote:
> > > Currently the pGp only shows the names of page flags, rather than
> > > the full information including section, node, zone, last cpupid and
> > > kasan tag. While it is not easy to parse these information manually
> > > because there're so many flavors. Let's interpret them in pGp as well.
> > >
> > > - Before the patch,
> > > [ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)
> > >
> > > - After the patch,
> > > [ 6871.296131] Slab 0x00000000c0e19a37 objects=33 used=3 fp=0x00000000c4902159 flags=0x17ffffc0010200(Node 0,Zone 2,Lastcpupid 0x1fffff,slab|head)
> >
> > For debugging purposes, it might be helpful to have the actual zone name
> > (and to know if the value is sane). You could obtain it (without other
> > modifications) via
> >
> > const char zname = "Invalid";
> >
> > if (zone < MAX_NR_ZONES)
> >       zname = first_online_pgdat()->node_zones[zone].name;
> >
> >
> > Similarly, it might also be helpful to indicate if a node is
> > online/offline/invalid/.
> >
> > const char nstate = "Invalid";
> >
> > if (node_online(nid))
> >       nstate = "Online";
> > else if (node_possible(nid))
> >       nstate = "Offline";
> >
> >
> > Printing that in addition to the raw value could be helpful. Just some
> > thoughts.
>
> printf() buffer is not a black hole, esp. when you get it messed with critical
> messages (Oops). I suggest to reduce a burden as much as possible. If you wish
> to get this, make it caller-configurable, i.e. adding another letter to the
> specifier.
>

I think David's suggestion will help us to identify issues.

You mean that we should use another one like "%pGpd" - means pGp debug
- to implement it ?

-- 
Thanks
Yafang
