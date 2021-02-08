Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6026F3134DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 15:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhBHOST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 09:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbhBHODT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:03:19 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C954FC06178A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 06:02:38 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id y17so12747891ili.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 06:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yIihDZxPKVTZ1cae8PC+4utdo23XVf26uo8MplI1V+0=;
        b=m1W98MPiWn4KqSymHwJpE0IYeZ4Kk7EKtE/yH6HlXnJnP+InMrRxcG+AHXDkf6K1m4
         ZZFeHbBjc85xHQKYWMRu0QbYyqegM0zJHRWU8yCTos5TTZOSXDY9xxJoGSq8n0pKSXJn
         oXRjWbdlRowm9TB9qftEVBVIvs0l1qfr18Hc4QC8qoYOd6814V728pj6UN6vQDx1pd+W
         mX0MKpocW86nHrSM2q6I1ZNJrMpZ5DMPdsQOs+gFKciAQ4TfPfTYpZrbZ/IVb0pyXXgp
         H1O743tZ6XyH7oqVGMOO+3nTWZ91+LqY6ltl2/E+3y69qobNurfdz+KiQ8S9V2IkY32k
         7B/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIihDZxPKVTZ1cae8PC+4utdo23XVf26uo8MplI1V+0=;
        b=lvwAKGs/+2bvcrszAciiUOTcvkLp4WHgEn+QtKI034rCoJUUhwbEe+h6Y5itRP6iYK
         QJ96YGvP4jFaBpu8iTZ+x/qXYdWRKRWIEPK9ULTgt2Z2TsyWbJXEw/6XhlOsp1d+jfbX
         aRgiqHSjDQgOBZkOhTGZJaPsO7n/HGNu6XN6HpvePbl7RaY/EJB0JOLpU0pX2bbOj800
         0YzS6ufuYmz4Xf3igmLaLPBRt2hCjGTRcMmiyPEjAPZmmJfXsir5K4Lt/jzIwDdrj5+l
         M9A8jcVsu2vwOczDBjxhvKgt+fjQg88yli+eaDebHEC1EV1vh8mffqxvybbvjSKnzTGx
         akjw==
X-Gm-Message-State: AOAM53354Sr3ZobhBbftiy5D2QsBQvyEo23sGcBB/lSdpYE97oSqtefl
        Ay0zgxdiktSjbp3lqxM/42JSGNOImgHALFvgl2c=
X-Google-Smtp-Source: ABdhPJzLjfJQyfk8VbCRnosnrTVY2UPFJFyklm3HOduIZeC19YDcALQpXQJxAX3f0H8THQ+CbOh0I5mdROhUD8nUPfg=
X-Received: by 2002:a05:6e02:1447:: with SMTP id p7mr15814152ilo.93.1612792958315;
 Mon, 08 Feb 2021 06:02:38 -0800 (PST)
MIME-Version: 1.0
References: <20210208101439.55474-1-laoar.shao@gmail.com> <20210208122009.GN308988@casper.infradead.org>
In-Reply-To: <20210208122009.GN308988@casper.infradead.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 8 Feb 2021 22:02:02 +0800
Message-ID: <CALOAHbB+xuDFnaBgQpf+1bf1SOdTkn10Mgtps8Adn7yp3_JFfw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] mm, vsprintf: introduce new format to dump full
 information of page flags
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Miaohe Lin <linmiaohe@huawei.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Joe Perches <joe@perches.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 8:20 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Feb 08, 2021 at 06:14:36PM +0800, Yafang Shao wrote:
> > To avoid breaking some tools which parsing pGp via debugfs or affecting
> > the printf buffer, other new formats are introduced, so the user can choose
> > what and in which order they want, suggested by Andy. These new introduced
> > format as follows,
> >     pGpb: print other information first and then the names of page flags
> >     pGpl: print the names of page flags first and then the other info
>
> This is overengineering things.  We already print in little-endian order,
> and the other information should be tacked onto the end.  Just extend
> %pGp.  Andy's suggestion to add another flag was a bad one.
>

All right. I will do it in the next version.

-- 
Thanks
Yafang
