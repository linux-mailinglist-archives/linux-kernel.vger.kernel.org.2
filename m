Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5515430DCA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 04:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbhJRCSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 22:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbhJRCSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 22:18:09 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21873C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 19:15:59 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s136so11235782pgs.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 19:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=i+wLhpixPoyOpckI8HRAvFPHKMx2lqvriuIvfx/+fps=;
        b=pox9pxe0ZHP23awv/t6xhYokmtWPhfDwd6LEWnAQkTzwXYAdOeYvPWnL43q3QtT95l
         xhYmPe8qCvmed3KYngpKkegppqpIIsHFDnguHoojdkTRzYa99v5TdTS49L3V2HdY00n7
         cnV3FDBguH+FzLxi2QLk1i7zc5wP1lHqAcaNy+ERHvTIPDOsklxXASqSOnl9om/GTndN
         0qs/9Z25HFkcXBzUOMMbbMcBKAkCP3CrWjx1YY4SEf6AlJR5/8RY8eZtFLnaWCt8zSYR
         4KjQwzNYfidcnRnXI3BZ0h+0NSgjVJUMj6WDGfPJGKwd4Kfy0+6t2DiKix7K4K1y/oZK
         33Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=i+wLhpixPoyOpckI8HRAvFPHKMx2lqvriuIvfx/+fps=;
        b=gYkd2m9amIyLEzZpBVA17u6Kr8s7veTv+aqtmq/3LKWtoAM/vGPsa9DHM7x8K9vtzK
         XBUPzmpHr/ukxR3aZKWdS/hveFmERFx+/IWtI/rkPslERbngkzHnhcHCT9+B7YqmHGah
         HlsxRkimfGmxEccAihXuklrbUnm2tpXUI06NZye+H/jNaLE+RuHvbcUPp9xkbnyPGpv4
         MQinC2u/BHS8MY2QZGP0gLYvYDuIU0zuPGXKgSrYTne2v76FP4TujZLFCQ2FhemItIKK
         RqKfnmiYg51EhbzeaFMPon0ExH4R6QXzdB5edc0OeZvXelRcpIsJnxV1JIE0nEfB+B54
         Xcug==
X-Gm-Message-State: AOAM530AQF/zBzG/Fmscpx22/XEoVbC/V09S5dx6aNZxgfLOMmekj1um
        IRhJj2TxzGlOmwCJbURr3SImO6qLCPZZJrEw
X-Google-Smtp-Source: ABdhPJzB2dc32dSOondd6EGAXBDmMcqVsB5HjS9NFCXssR7aTr+QUFmhzaWcb1ERDK1z/vjfQl/bWA==
X-Received: by 2002:a63:954a:: with SMTP id t10mr14425342pgn.89.1634523357225;
        Sun, 17 Oct 2021 19:15:57 -0700 (PDT)
Received: from [172.18.2.138] ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id x184sm11173379pfc.44.2021.10.17.19.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 19:15:56 -0700 (PDT)
Subject: Re: [PATCH] mm: backing-dev: use kfree_rcu() instead of
 synchronize_rcu_expedited()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     hch@infradead.org, akpm@linux-foundation.org, sunhao.th@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mikulas Patocka <mpatocka@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
References: <20211014082433.30733-1-qiang.zhang1211@gmail.com>
 <YWgTZjDtZik/9l4J@casper.infradead.org>
 <CALm+0cUt7iD5zex4-hRv=i1wPd66tz3JYGHz8P8ZFTZcyOCD1A@mail.gmail.com>
 <d697d61e-27a2-a25c-3ae1-e41457d08705@gmail.com>
 <YWl1rDO6gCFJE4hp@casper.infradead.org>
From:   Zqiang <qiang.zhang1211@gmail.com>
Message-ID: <2357d7fe-0679-768e-7319-2f141860af2e@gmail.com>
Date:   Mon, 18 Oct 2021 10:15:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YWl1rDO6gCFJE4hp@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/10/15 下午8:35, Matthew Wilcox wrote:
> On Fri, Oct 15, 2021 at 01:06:02PM +0800, Zqiang wrote:
>> On 2021/10/15 上午10:57, Qiang Zhang wrote:
>>>
>>> Matthew Wilcox <willy@infradead.org <mailto:willy@infradead.org>>
>>> 于2021年10月14日周四 下午7:26写道：
>>>
>>>      On Thu, Oct 14, 2021 at 04:24:33PM +0800, Zqiang wrote:
>>>      > The bdi_remove_from_list() is called in RCU softirq, however the
>>>      > synchronize_rcu_expedited() will produce sleep action, use
>>>      kfree_rcu()
>>>      > instead of it.
>>>      >
>>>      > Reported-by: Hao Sun <sunhao.th@gmail.com
>>>      <mailto:sunhao.th@gmail.com>>
>>>      > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com
>>>      <mailto:qiang.zhang1211@gmail.com>>
>>>      > ---
>>>      >  include/linux/backing-dev-defs.h | 1 +
>>>      >  mm/backing-dev.c                 | 4 +---
>>>      >  2 files changed, 2 insertions(+), 3 deletions(-)
>>>      >
>>>      > diff --git a/include/linux/backing-dev-defs.h
>>>      b/include/linux/backing-dev-defs.h
>>>      > index 33207004cfde..35a093384518 100644
>>>      > --- a/include/linux/backing-dev-defs.h
>>>      > +++ b/include/linux/backing-dev-defs.h
>>>      > @@ -202,6 +202,7 @@ struct backing_dev_info {
>>>      >  #ifdef CONFIG_DEBUG_FS
>>>      >       struct dentry *debug_dir;
>>>      >  #endif
>>>      > +     struct rcu_head rcu;
>>>      >  };
>>>
>>>      >Instead of growing struct backing_dev_info, it seems to me this
>>>      rcu_head
>>>      >could be placed in a union with rb_node, since it will have been
>>>      removed
>>>      >from the bdi_tree by this point and the tree is never walked under
>>>      >RCU protection?
>>>
>>>
>>> Thanks for your advice, I find this bdi_tree is traversed under the
>>> protection of a spin lock, not under the protection of RCU.
>>> I find this modification does not avoid the problem described in patch,
>>> the flush_delayed_work() may be called in release_bdi()
>>> The same will cause problems.
>>> may be  we can replace queue_rcu_work() of call_rcu(&inode->i_rcu,
>>> i_callback) or do you have any better suggestions?
> What?  All I was suggesting was:
>
> +++ b/include/linux/backing-dev-defs.h
> @@ -168,7 +168,10 @@ struct bdi_writeback {
>   
>   struct backing_dev_info {
>          u64 id;
> -       struct rb_node rb_node; /* keyed by ->id */
> +       union {
> +               struct rb_node rb_node; /* keyed by ->id */
> +               struct rcu_head rcu;
> +       };
>          struct list_head bdi_list;
>          unsigned long ra_pages; /* max readahead in PAGE_SIZE units */
>          unsigned long io_pages; /* max allowed IO size */
>
>
> Christoph, independent of the inode lifetime problem, this actually seems
> like a good approach to take.  I don't see why we should synchronize_rcu()
> here?  Adding Jens (original introducer of the synchronize_rcu()), Mikulas
> (converted it to use _expedited) and Tejun (worked around a problem when
> using _expedited).

Sorry，this my mistake.   this problem and the inode lifetime cycle are 
two different problems

Can this modification which use kfree_rcu() instead of synchronize_rcu() 
be accepted?


Thanks

Zqiang


