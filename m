Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1598E41D80B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350139AbhI3Ksp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350027AbhI3Ksk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:48:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB55C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 03:46:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r18so20164672edv.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 03:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CawvRTZLezIesMVixBblqv+pC8udU0wgrtmbuGU3odA=;
        b=fZlmpfJaVSbAqrKU9fDcE+ZujBeMcTA/xjGynDLFSwSydspSCl7xlidUXZv2On8Q9y
         zrosabo17JSZ3IQANyVjLlxcFCJ6eDk/pOn4OFyzVAJyaNVXyvZnG7Zkd+N6Kil1W+N0
         T45geyZLVBWqSGwHmGjOxKAl8LffAv/wIem+cY6iSuHKnB+d5Hsj+ZbNXo3wql3EC3jg
         Vn2vCBlpEeqETUU2/pKUMoMGsdjKeU6uo/zBr1oIn1HRft8tB4vnt030qmBCc53ZEGJ7
         ltd0ySlYrD1I/tkRlEo2Tib5ocVgplnqirRjz3zHP8NZhwt2AG59ahnS9r7Xns16QGb2
         YrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CawvRTZLezIesMVixBblqv+pC8udU0wgrtmbuGU3odA=;
        b=xTHwEdqHqd0GrhsfxgysVEF8b+KXBKCOGIO28nGja6uKPCTUJjyF6rigbgWYoUq53+
         jnXzIJPKEVYgznixt63WEQ7dOvfgphP6gxFi2ipZVzSCoOq6EAtzIl0da0NOSLcWsWy4
         WY0RElJzDP5GxXo3g0qnAHpgafs79JLqD2TjWNDxBXDEvRbfskqaaWqp5d6KrC+FD8fm
         mfBgRTSu+VL4J7S1GQykb5FdawD+z+iOrm1/0SNz6VT6F1P//IXHFqXv3nCCvcMwJsVS
         ymC90Q8LI/pI5EeiHMzqJGTsRatf14P6LKndB70APnk95LSxc4zs9aR0+V8mDqaK/xi3
         sOLw==
X-Gm-Message-State: AOAM530h+L7ZYyYJM5zKWoFaCNz168KkuVHSxnzD/DLOzY9RiQH79aj8
        wsjC8aOV4LtCPIN13DJbcLOHccgeNzhYy6xRAgtjmzvhfZU=
X-Google-Smtp-Source: ABdhPJzKfOZv0XK+lwsWU8LnQgaOmlK/CXmv9D6a6zXdbzbGgzOaEU9JUHOyEQ4l8+HmXMP0fSVUR8HhKz/Llgcd1eo=
X-Received: by 2002:a17:906:280f:: with SMTP id r15mr5549965ejc.559.1632998815910;
 Thu, 30 Sep 2021 03:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210916222705.13554-1-tklauser@distanz.ch> <20210930103010.2716097-1-antti.kervinen@intel.com>
In-Reply-To: <20210930103010.2716097-1-antti.kervinen@intel.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 30 Sep 2021 23:46:44 +1300
Message-ID: <CAGsJ_4zGVykhHgpxL5HZVsM453NUMBJRE9CfsfayXWV68whHwA@mail.gmail.com>
Subject: Re: [PATCH] cpumask: Omit terminating null byte in cpumap_print_{list,bitmask}_to_buf
To:     Antti Kervinen <antti.kervinen@intel.com>
Cc:     Tobias Klauser <tklauser@distanz.ch>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Yury Norov <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 11:31 PM Antti Kervinen
<antti.kervinen@intel.com> wrote:
>
>
> An original function, bitmap_print_to_pagebuf() in lib/bitmap.c,
> returns the number of printed characters, excluding terminating null.
>

a patch has been in
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=c86a2d9058c5a4a05d20ef89e699b7a6b2c89da6

I guess it is on the way to linus' tree.

> Commit 1fae5629, a cause of this regression, introduced new functions
> to lib/bitmap.c:
>
> - bitmap_print_to_buf()
>   (return value doc missing)
>
> - bitmap_print_bitmask_to_buf()
>   (return value doc not explicit about terminating null, but
>   can be considered misleading)
>
> - bitmap_print_list_to_buf()
>   (the same as above)
>
> Unlike the original function, the return value of new functions
> include the terminating null.
>
> As this behavior is clearly opposite to the original function, and
> functions that print to buffers in general, I would suggest fixing
> this problem by alignign these new functions with the original one:
> excluding the terminating null. And documenting this behavior
> unambiguously.
>
> The suggested change to cpumask_print_{bitmask,list}_to_buf()
> functions decrements possible errors (like -ENOMEM) returned by
> bitmap_print_to_buf(). This must not happen.

Thanks
barry
