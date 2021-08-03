Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306B83DE68E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 08:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbhHCGFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 02:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbhHCGFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 02:05:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EDBC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 23:05:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so2345062pja.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 23:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=51/WH4H+3K8+t696XglQpyQZW1lNoES93JPrqYKsZxg=;
        b=G/fRC/zb3uF4kvM88E14wVxtUeT1gTTqB5861RuWAB1JZ4mQfVqvH+6iwK0b0Y//ou
         q6rUewplkkZCvg5FeMxUAWu+KI6j0006uvaZVtak3ITzYmvONdH5ZlYnIbu1hNfQm0mh
         HrfWotlfyYJTEIlsN6nEn7mcxuL9Up7SORWW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=51/WH4H+3K8+t696XglQpyQZW1lNoES93JPrqYKsZxg=;
        b=NSW/E9MCY6ZBReTJF0CIDvXguAiyNP4XQBjpvxeNXg3u8odRB0kuUjuSAVJ/g5G9QD
         dCUawVk6+1t0cphk8NsbFbpHaBZP77I3tW1OcmPFOwfCuA+IjxrMn5USFs0T9kP3AWJg
         E9sOmrb/ezpAxBaTMP2YfOGTOYsGijS2ztqCIDUl0hv3vrkpTwCNnkFA70ayyEInPDUb
         DJeheP01J3bKb53lwybqP3484gAJOh2m3FSoE7E7rh6rxhv8T6SR5tOLSq9Vigkweqrr
         FjoJPiHI5G7qb/quKjFDPIgkCczZ8FqNo9w39GceDNZiv8e8bY4iyKpCiAv7fO+DBJjj
         QZxg==
X-Gm-Message-State: AOAM531SyYgbLymi+Y0cjPTu4E5r2V3MVItdTdT5bkEkbE7a8vfyCPqv
        SHePdOEdPJ5g/QTYB8vvdVsVhPcd/DxFCWm7iV1PMA==
X-Google-Smtp-Source: ABdhPJy1HSMVKjdSljKukA9eioaRaXtN/w+0zAqgpjTq1m0pUhY96LCQ34rv0gbfZIf1jp6S9+Pn+bscR1D75OqUKWQ=
X-Received: by 2002:a17:902:b788:b029:12c:2888:9589 with SMTP id
 e8-20020a170902b788b029012c28889589mr17410188pls.60.1627970728797; Mon, 02
 Aug 2021 23:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <1627635002-24521-1-git-send-email-chunfeng.yun@mediatek.com> <1627635002-24521-8-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1627635002-24521-8-git-send-email-chunfeng.yun@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Tue, 3 Aug 2021 14:05:18 +0800
Message-ID: <CAATdQgDWkohpzgr=z+uzro4m9Bd=v88DNnJ-M88-5-0annhH_w@mail.gmail.com>
Subject: Re: [PATCH 08/11] usb: xhci-mtk: update fs bus bandwidth by bw_budget_table
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunfeng,

On Fri, Jul 30, 2021 at 4:51 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> Use @bw_budget_table[] to update fs bus bandwidth due to
> not all microframes consume @bw_cost_per_microframe, see
> setup_sch_info().
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/host/xhci-mtk-sch.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
> index 0bb1a6295d64..10c0f0f6461f 100644
> --- a/drivers/usb/host/xhci-mtk-sch.c
> +++ b/drivers/usb/host/xhci-mtk-sch.c
> @@ -458,8 +458,8 @@ static int check_fs_bus_bw(struct mu3h_sch_ep_info *sch_ep, int offset)
>                  * Compared with hs bus, no matter what ep type,
>                  * the hub will always delay one uframe to send data
>                  */
> -               for (j = 0; j < sch_ep->cs_count; j++) {
> -                       tmp = tt->fs_bus_bw[base + j] + sch_ep->bw_cost_per_microframe;
> +               for (j = 0; j < sch_ep->num_budget_microframes; j++) {
> +                       tmp = tt->fs_bus_bw[base + j] + sch_ep->bw_budget_table[j];
>                         if (tmp > FS_PAYLOAD_MAX)
>                                 return -ESCH_BW_OVERFLOW;
>                 }
> @@ -534,21 +534,18 @@ static void update_sch_tt(struct mu3h_sch_ep_info *sch_ep, bool used)
>  {
>         struct mu3h_sch_tt *tt = sch_ep->sch_tt;
>         u32 base, num_esit;
> -       int bw_updated;
>         int i, j;
>
>         num_esit = XHCI_MTK_MAX_ESIT / sch_ep->esit;
>
> -       if (used)
> -               bw_updated = sch_ep->bw_cost_per_microframe;
> -       else
> -               bw_updated = -sch_ep->bw_cost_per_microframe;
> -
>         for (i = 0; i < num_esit; i++) {
>                 base = sch_ep->offset + i * sch_ep->esit;
>
> -               for (j = 0; j < sch_ep->cs_count; j++)
> -                       tt->fs_bus_bw[base + j] += bw_updated;
> +               for (j = 0; j < sch_ep->num_budget_microframes; j++)
> +                       if (used)
> +                               tt->fs_bus_bw[base + j] += sch_ep->bw_budget_table[j];
> +                       else
> +                               tt->fs_bus_bw[base + j] -= sch_ep->bw_budget_table[j];

I agree that xhci-mtk-sch still has more rooms for tt periodic bandwidth
but I think this approach could trigger a problem.

for example, if there are two endpoints scheduled in the same u-frame index,
* ep1out  = iso 192bytes bw_budget_table[] = { 188, 188, 0, ...} --> y0
* ep2in = int 64bytes, bw_budget_table[] = { 0, 0, 64, ... }  --> y0

(If this is possible allocation from this patch),
I guess xhci-mtk could have some problems on internal scheduling?

>         }
>
>         if (used)

> --
> 2.18.0
>
