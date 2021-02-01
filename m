Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BDE30AA2E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbhBAOrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbhBAOp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:45:57 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F88EC0613ED
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 06:45:17 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id q5so15753092ilc.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 06:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4D16KIn4mdPhfH6zQNKK7p0fTmhOo1v0cmsmsfFxGA=;
        b=ug+16pnxrHl306VQCEZxGDt73DrCGl7Zi3egCSW52HPzvQ/Edp9CyOFir9ng16GLUm
         Yyhrt3Z13jo1fBi6m+vJiQ9GJ6h4bbFEvTw+RdSCZEPgXBTIeTki/oJ7DbbJSqEOI3SM
         Za5k4fAaBsVrzR3jmWK5zflFA3IF7LZ9ijBB++Wp+AcvobpOId8znN9+/3Xjz9qG0xZU
         aPAM+USuXjkHZAl2peQIwb6cpUGApEebiM6kCBobWsBBXhwcWHYYdZbveDX8KlDSA7RM
         DPqGBt+MZMwFBGGbjeMn4mbaSkm61rMebEK/VRw2aHWEZDILkLzr8XJpjhAMCZnae98E
         WoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4D16KIn4mdPhfH6zQNKK7p0fTmhOo1v0cmsmsfFxGA=;
        b=bMk42kLEyYNLjf3+KYFpOyx7DazBowp3M70R97X6C8RtjB5folc4HMYGWTbenGwN43
         XVUQpdFa1RBKw0EKi70hkuAdEi5mjV2kVWOI9xDOwFWhD7BI7NVPzBDFVWI5gvAzsTvC
         /4Xh885ZhZs7Ns/UM+WJ4FKnS38oei05vzqpAw/aNd8fEdfPigtRjb4w6IJ1ux87XK1d
         l8a6xUYcAEryiBbZkmaHp2gVmuozgoL5XwqObOtQEVrUH/B3Wi9MNapCEwnBvl9VYmq3
         vuLdYsGzG+sEhCiUOeJASAj4/M4PebC3AX9v78g7M9rPt4X5wakJ4gBIPd2jwFC8udZH
         zJ4w==
X-Gm-Message-State: AOAM532afK3vlEPpHsrm3RQKESOV1DNDRDgohYECSUdGSOtx18JjWwZs
        8CE0XNEPxbSt8WcJhnXQ5H96JxHAkoyAjxr7G/w=
X-Google-Smtp-Source: ABdhPJzi7UA8le4Q9njnbQvMd8GQ/IaIjSSCpNOKHw4aAjJVWKUJXO5L9Xg7MA54CfrfIjTfnOyWrHZ9jkJpXGKc4do=
X-Received: by 2002:a92:d3c7:: with SMTP id c7mr12632482ilh.137.1612190716727;
 Mon, 01 Feb 2021 06:45:16 -0800 (PST)
MIME-Version: 1.0
References: <20210201115610.87808-1-laoar.shao@gmail.com> <20210201115610.87808-4-laoar.shao@gmail.com>
 <20210201141505.GR308988@casper.infradead.org>
In-Reply-To: <20210201141505.GR308988@casper.infradead.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 1 Feb 2021 22:44:41 +0800
Message-ID: <CALOAHbBzRLYF2Z--OTuO41UEwvcJsYMzuGVdrrqbnCD9U-Ja0A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] vsprintf: dump full information of page flags in pGp
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
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

On Mon, Feb 1, 2021 at 10:15 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Feb 01, 2021 at 07:56:10PM +0800, Yafang Shao wrote:
> > - Before the patch,
> > [ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)
> >
> > - After the patch,
> > [ 6871.296131] Slab 0x00000000c0e19a37 objects=33 used=3 fp=0x00000000c4902159 flags=0x17ffffc0010200(Node 0,Zone 2,Lastcpupid 0x1fffff,slab|head)
>
> I would suggest it will be easier to parse as:
>
> flags=0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
>
> That should alleviate the concerns about debugfs format change -- we've
> never guaranteed that flag names won't change, and they now look enough
> like flags that parsers shouldn't fall over them.

Good suggestion!
I will do it as you suggested in the next version.

-- 
Thanks
Yafang
