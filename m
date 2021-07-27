Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD5A3D6B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 03:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhG0AwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 20:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhG0AwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 20:52:24 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57940C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 18:32:51 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id t66so10926830qkb.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 18:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TWbfeNZmjnTcz2HGOF8VXSmVn2/eSAizVGY/kzYPBqQ=;
        b=ICQPyziFtMqRPneCQJqnIvELj5oraZC5gjp7JnXtqqSCrhUqqycpmcRD6UIh27jsTH
         RsJ1jLUe9bBergXXo0C4CdrNoXiAolVE2py9vyPxYhFr3VknBUnzL5DC9++M/xYcBLIJ
         UEILSLxBMtNFCqJKV2M3Fr4cqUpo5Dhi/Md/B2nLXau0NJ4sZgm0Czs0xL89P2p2byxL
         RPSmHSjDrtWflhW32mp4S5kyOelw371FSDtBIrYcMS/s23E2/yOsAM+asfOzGs7uO7ux
         pcLuiCJIm+T3HY+NiAmEnf9sHuSWEjIobYBSxLtVY5l83Pxl+9308tHglNgcLaiSFnV7
         tA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TWbfeNZmjnTcz2HGOF8VXSmVn2/eSAizVGY/kzYPBqQ=;
        b=HyxHJeHXdFu8EMaHXX+0OOT+xmtg6YcGju5J9x56P2MlUPJYaEU1kizHSk4/xVpask
         y+b1JLrxwI/BzAxHM/K1zi151HrpQqROII5HpfoAOmMQFv0dElsidrcyJyhTcLqvZROO
         bP0BKpbdpUswt7jLNEpzgLwJf0VjdZs0+KcNSpHfX50WkE4WyjkUZoygNS4pviU4X9Tc
         Ns3N/H8Fji0IzAjORuZ36xChLOAE5hscAlFEkqnEB7CbmgGwjL+0nqzoCj6leoBYUb1P
         zxbB4svKLlFjM772/pqIRhSS1SlsQAcaJIsHnhcS0bgbW4yXchShNcYvHHilHbq2ZJR3
         NZng==
X-Gm-Message-State: AOAM5313V7SA1HUYLTSsHD3JTPsZd/NXz0N2rHtY6jMVg5jd0uVp6532
        9Ng3BdyCGocXmsZ40QkcG5wi5hVyUlL+RABemIKomUJOn0I=
X-Google-Smtp-Source: ABdhPJwWb4M3ObQbtdTKza+Ui7yxD25UppTflRevqpTN4WITR9ntWMWldph9L4G8NKESBCChfFqSKYwaK36Od3rGBbY=
X-Received: by 2002:a05:620a:172c:: with SMTP id az44mr4313377qkb.324.1627349570448;
 Mon, 26 Jul 2021 18:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <1626763658-27748-1-git-send-email-huangzhaoyang@gmail.com>
 <YP4PjMnw1OZtARQC@google.com> <YP72sNSOVwgnQzqo@google.com>
In-Reply-To: <YP72sNSOVwgnQzqo@google.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 27 Jul 2021 09:32:24 +0800
Message-ID: <CAGWkznFifWQSMAoz-qD2M_qnZL=qi8XsJPVxet6Cbt_euD4eAg@mail.gmail.com>
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

On Tue, Jul 27, 2021 at 1:53 AM Minchan Kim <minchan@kernel.org> wrote:
>
> On Mon, Jul 26, 2021 at 10:27:40AM +0900, Sergey Senozhatsky wrote:
> > On (21/07/20 14:47), Huangzhaoyang wrote:
> > > It makes the statistic confused when counting pages_store in during writeback.
> > > pages_store should just reflect the swapped pages on ZRAM, while bd_writes be
> > > responsible for writeback things.
> > >
> > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > ---
> > >  drivers/block/zram/zram_drv.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > > index cf8deec..6bdaa9d 100644
> > > --- a/drivers/block/zram/zram_drv.c
> > > +++ b/drivers/block/zram/zram_drv.c
> > > @@ -765,7 +765,6 @@ static ssize_t writeback_store(struct device *dev,
> > >             zram_set_flag(zram, index, ZRAM_WB);
> > >             zram_set_element(zram, index, blk_idx);
> > >             blk_idx = 0;
> > > -           atomic64_inc(&zram->stats.pages_stored);
> >
> > Yeah, I think we don't need it here.
> >
> > Minchan, what do you think?
>
> What pages_stored currently represents is orig_data_size from mm_stat
>
>  ================ =============================================================
>  orig_data_size   uncompressed size of data stored in this disk.
>                   Unit: bytes
>
> Thus, if we don't increase it after zram_free_page, it loses what's
> the original data size which would be important to calculate
> compression ratio along with compr_data_size.
zram_free_page??  What the commit try to fix is pages_stored being
increased incorrectly in writeback_store, which will lead to wrong
statistic on orig size of ZRAM.
