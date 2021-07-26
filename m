Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E199C3D660F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 19:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhGZRN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 13:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhGZRN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 13:13:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1328C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 10:53:55 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so107538pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 10:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h551Z0GDw+QKnY0IISUO3Eg8hP3kvvDKHptPjd9LN9I=;
        b=fWhWiXsyr1VpmQTI5/0t3NGN3Wqziwotm+OJGybva+1IJlvdAORtRhAS8U9i1y7R2e
         zFc1fXA40hh2jlNTEEDVz1yPvPFLqzQ8fTRy9XUj2m5n5q0NrmReeN0EvwQupif6gDV/
         tfVQxz6+AOKHHjtfKiAnVNHaSdBM41ZbC4p69u92ocBTXO8FJUdLpMKKRTib0iwmyOyT
         RHuPdRMLDEymk4n+KRwraTUlz3r1+N9FZlGLqh/gSs3Pa0s+nLi6hUddoExNoS6/qqKU
         hOygVU4rO1b+2l9sD1EvGhD6As4JIZOJXJ0HVg5PWJqQdRZC0D8/o3h6o99dFdh211W9
         mhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=h551Z0GDw+QKnY0IISUO3Eg8hP3kvvDKHptPjd9LN9I=;
        b=uaXPdoBvKw3RgZpyYzrA8WCdwmbCApgg7lxea4IATiG9pnVhcaVOuDWkRYDupOkg/n
         g+R+4fSLf2q1LoPDdNBxEBo9jgeHHbl0vZdqmbzVvpn4uAxUQ2FD1e5YL/1kFKkOS57n
         KlQPzXnY1G5P0Sf+x40OPUHJUEUjjRx5nE2lY2uN6wt10VurAPn9PGFhhKCj9vPqmrs3
         i3d4q377puJr+kZ7u0ZUk8M7YzhB7bkqa4+WJ5HeSn2voS/LA+mEFXOYWnG9li87N6vs
         LSd5ksNteWWZC7qWJhvdBei4kASu/zqCB1WoxnA0A0Y3cYR328kR01cRYikMc8SLuKb2
         N73w==
X-Gm-Message-State: AOAM530Lr+CM4DlkoIpaHyH5W56l9RTcud/utWCyofL15YvFQ2sP0HhZ
        87foD95MHFZF3ocE01FpGOk=
X-Google-Smtp-Source: ABdhPJxdxAcP5SZ0Ov7TOLPHf8HHaLlrWJrUaiOjGjeXkIKgvSAwVUPHFPsXj+6s1wAQPQs29gpMKQ==
X-Received: by 2002:a17:90a:5d8a:: with SMTP id t10mr206536pji.6.1627322035352;
        Mon, 26 Jul 2021 10:53:55 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:7dec:c98b:4b9:d5b9])
        by smtp.gmail.com with ESMTPSA id gg10sm142884pjb.20.2021.07.26.10.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 10:53:54 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 26 Jul 2021 10:53:52 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Huangzhaoyang <huangzhaoyang@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Nitin Gupta <ngupta@vflare.org>
Subject: Re: [PATCH] driver: zram: fix wrong counting on pages_store
Message-ID: <YP72sNSOVwgnQzqo@google.com>
References: <1626763658-27748-1-git-send-email-huangzhaoyang@gmail.com>
 <YP4PjMnw1OZtARQC@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP4PjMnw1OZtARQC@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 10:27:40AM +0900, Sergey Senozhatsky wrote:
> On (21/07/20 14:47), Huangzhaoyang wrote:
> > It makes the statistic confused when counting pages_store in during writeback.
> > pages_store should just reflect the swapped pages on ZRAM, while bd_writes be
> > responsible for writeback things.
> > 
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  drivers/block/zram/zram_drv.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index cf8deec..6bdaa9d 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -765,7 +765,6 @@ static ssize_t writeback_store(struct device *dev,
> >  		zram_set_flag(zram, index, ZRAM_WB);
> >  		zram_set_element(zram, index, blk_idx);
> >  		blk_idx = 0;
> > -		atomic64_inc(&zram->stats.pages_stored);
> 
> Yeah, I think we don't need it here.
> 
> Minchan, what do you think?

What pages_stored currently represents is orig_data_size from mm_stat

 ================ =============================================================
 orig_data_size   uncompressed size of data stored in this disk.
                  Unit: bytes

Thus, if we don't increase it after zram_free_page, it loses what's
the original data size which would be important to calculate
compression ratio along with compr_data_size.
