Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429ED3D6E45
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 07:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbhG0Fpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 01:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbhG0Fpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 01:45:31 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7311C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 22:45:31 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 184so11317444qkh.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 22:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9UhfJ72ShgnVBe6T+2w7tb78zjNRACqScNORwxlEWgg=;
        b=fkws12MgMNA+B3+r7nq36hbFE5RF0C4ZmJCZbaAgFxh0fS4rkFoZdYHfPhQ+nFu8wc
         yp4ibHcbvb845j63tKPbs46ee5FrBknOxFOHGX/GiOJ1Yl0jAcq225ZFhNUGWvGZPilM
         EhtaCHZML7yVjbcUybrBytytCSJgdGSGB99sYO4WChkdX66I8VWGnRZsfpu03F17cmCU
         CBH2MEiTnVL/N88r1F5cf+YCOQb7If18NjanbZwNDrhO08JTAbJfkVq13LvE1Ym7JHy+
         70SX2aFc/J7fY21I6OkSnwmZh5uWciqvEq1sDsjw42W/2ZLerTAlRWJ5qTH64AaJ8MfM
         Nsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9UhfJ72ShgnVBe6T+2w7tb78zjNRACqScNORwxlEWgg=;
        b=Sg19lxwxYJ2jb/zqLheAy4q4oN14YscgxAqIJYSFVtdUV1iRe/VM1exdCPdJCxJo9m
         ylJQpHXfLsU9gJB5bdADoLP+hHiEcghmnV3iM5UeA76OkvRTWqClqCwnVBRmKGzv7RbV
         ilWIkhn7yymk4oS4dXRtl5klK8uNnlvsxWeB+r6v99lndyP3mlSPe0pX3F9AzPJRDgVJ
         FSoXO+X8/ylptmP661QC88dfKoP0dikAdb6EX7vHhzYTxw1ySeQS3yiXmncuHSNovVJM
         QGdc9r0M110HERd0yVelLLhLZxaf2IXjlbyiRP5OWS+/roe+8zrXNvhO12aryYJKIiWK
         m3yg==
X-Gm-Message-State: AOAM533KeeeCa8j1EEUaU9TvrY+MIUbbZZ0voVb0UT19baieGYv6G+AC
        QJtWzLj7fDAtpOtaAswI0S36nJWZ8M3EHQ3hyNo=
X-Google-Smtp-Source: ABdhPJxUV5CjpXrNTe0ZzNz+2ksAKEtWJaxs8OKEIBYu1Jdn1Z4K7taHur5OwWROvtkutLbb14RhEbE5arYW6Ax6hvg=
X-Received: by 2002:a37:ad12:: with SMTP id f18mr20807807qkm.105.1627364730956;
 Mon, 26 Jul 2021 22:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <1626763658-27748-1-git-send-email-huangzhaoyang@gmail.com>
 <YP4PjMnw1OZtARQC@google.com> <YP72sNSOVwgnQzqo@google.com> <CAGWkznFifWQSMAoz-qD2M_qnZL=qi8XsJPVxet6Cbt_euD4eAg@mail.gmail.com>
In-Reply-To: <CAGWkznFifWQSMAoz-qD2M_qnZL=qi8XsJPVxet6Cbt_euD4eAg@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 27 Jul 2021 13:45:04 +0800
Message-ID: <CAGWkznGt9hWGM4KF-0WX4noe=piB4==T4cVuSETDGAsn7Xgi=Q@mail.gmail.com>
Subject: Re: [PATCH] driver: zram: fix wrong counting on pages_store
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 9:32 AM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> On Tue, Jul 27, 2021 at 1:53 AM Minchan Kim <minchan@kernel.org> wrote:
> >
> > On Mon, Jul 26, 2021 at 10:27:40AM +0900, Sergey Senozhatsky wrote:
> > > On (21/07/20 14:47), Huangzhaoyang wrote:
> > > > It makes the statistic confused when counting pages_store in during writeback.
> > > > pages_store should just reflect the swapped pages on ZRAM, while bd_writes be
> > > > responsible for writeback things.
> > > >
> > > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > ---
> > > >  drivers/block/zram/zram_drv.c | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > > > index cf8deec..6bdaa9d 100644
> > > > --- a/drivers/block/zram/zram_drv.c
> > > > +++ b/drivers/block/zram/zram_drv.c
> > > > @@ -765,7 +765,6 @@ static ssize_t writeback_store(struct device *dev,
> > > >             zram_set_flag(zram, index, ZRAM_WB);
> > > >             zram_set_element(zram, index, blk_idx);
> > > >             blk_idx = 0;
> > > > -           atomic64_inc(&zram->stats.pages_stored);
> > >
> > > Yeah, I think we don't need it here.
> > >
> > > Minchan, what do you think?
> >
> > What pages_stored currently represents is orig_data_size from mm_stat
> >
> >  ================ =============================================================
> >  orig_data_size   uncompressed size of data stored in this disk.
> >                   Unit: bytes
> >
> > Thus, if we don't increase it after zram_free_page, it loses what's
> > the original data size which would be important to calculate
> > compression ratio along with compr_data_size.
> zram_free_page??  What the commit try to fix is pages_stored being
> increased incorrectly in writeback_store, which will lead to wrong
> statistic on orig size of ZRAM.
OK, if I understand right, I think what you mean is the page count
corresponding to SWAP should be still available even if it is written
back to the backing dev.So we need to increase page_stored again after
zram_free_page free it.
