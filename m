Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9336A3E40DC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 09:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhHIHdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 03:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbhHIHdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 03:33:04 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C8CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 00:32:43 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so935408pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 00:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVCCSnIXYykkg2R7yVA5Ld91gUKOn2zITwPVLJyBQvQ=;
        b=JJ0xgqBnD9h/5UXKJJkdIH5qjmoVw6ZhAxv2ayd+S0yB+m/LShHqM8AynrVtiYUuPD
         alwnu+6AGSPiAaPuawgIIconPh0TGQkupInxxbQwuXXiLrMagcGMZJzAZPpnexiGg+6Q
         yKPYKw7FJTDbtEkvB2KSnDDzvYmbkM/E5jEWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVCCSnIXYykkg2R7yVA5Ld91gUKOn2zITwPVLJyBQvQ=;
        b=tL5KPgUULJ7yrIrv2W/oRZTrffps+o6H0YSUVtb/CYrx7Tf3hNqIWehahi7usu0CwL
         FIA0WdOSFkMC94zxjTe0PlUpONg3og9OMlFzHRwVLmdV0ri8k1d5VYZSqAItxizm4qKq
         KaGNdxH9gZhVYYigkaxN4N0N3wD6kN8KEld4Ml+buInO9FMlbCjIef9BZjblBGTG2n0J
         pzA4dueKjeLswaWKoNW7kO1OhI7eccnoXPQ22UivrVlxKyvaUnpvIkLxpUNz4GZGlDE+
         Z94GaMHQ2Dhg0NNxSX1OBpdkeLTsYcTvnzQhSztOmXOoExL+kOYY6wk10HC+u5hwGUAW
         NGNA==
X-Gm-Message-State: AOAM531JyDESn8sBQu+sFa7rVli99U6cxdJZB6BuEXP6QfY7sMgJVMnB
        WebC9yUMpRzKBUU7EL20vlSrxxtJ67pMrx3Q+SC0IQ==
X-Google-Smtp-Source: ABdhPJzPT1GiwQpBd6U/85ILPMLMrLPdsU7/6fuodJb9JGdW/fcRu0XqgpdJcPoOgwhC12HFQLmJTOHVjKPOQOD+oQ8=
X-Received: by 2002:a17:90b:102:: with SMTP id p2mr150614pjz.126.1628494362683;
 Mon, 09 Aug 2021 00:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <1627635002-24521-1-git-send-email-chunfeng.yun@mediatek.com> <1627635002-24521-9-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1627635002-24521-9-git-send-email-chunfeng.yun@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Mon, 9 Aug 2021 15:32:31 +0800
Message-ID: <CAATdQgA4qwKb=Uee1pUj-Fk8G31zA40OD7o49W1YLUhZh7BHWA@mail.gmail.com>
Subject: Re: [PATCH 09/11] usb: xhci-mtk: check boundary before check tt
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

On Fri, Jul 30, 2021 at 4:50 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> check_sch_tt() will access fs_bus_bw[] array, check boundary
> firstly to avoid out-of-bounds issue.
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/host/xhci-mtk-sch.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
> index 10c0f0f6461f..c2f13d69c607 100644
> --- a/drivers/usb/host/xhci-mtk-sch.c
> +++ b/drivers/usb/host/xhci-mtk-sch.c
> @@ -600,13 +600,14 @@ static int check_sch_bw(struct mu3h_sch_bw_info *sch_bw,
>          * and find a microframe where its worst bandwidth is minimum.
>          */
>         for (offset = 0; offset < sch_ep->esit; offset++) {
> -               ret = check_sch_tt(sch_ep, offset);
> -               if (ret)
> -                       continue;
>
>                 if ((offset + sch_ep->num_budget_microframes) > esit_boundary)
>                         break;

Instead of dropping it,
I'm wondering if it should be checked against (offset & 63) == 0 when it's 64?

>
> +               ret = check_sch_tt(sch_ep, offset);
> +               if (ret)
> +                       continue;
> +
>                 worst_bw = get_max_bw(sch_bw, sch_ep, offset);
>                 if (worst_bw > bw_boundary)
>                         continue;
> --
> 2.18.0
>
