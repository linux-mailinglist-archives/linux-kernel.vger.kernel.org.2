Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557643A22EC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 05:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhFJDnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 23:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhFJDnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 23:43:14 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BC5C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 20:41:02 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ei4so2812254pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 20:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94pKNGw6aDmClK5qtz94uwCrVTPu2QawOX0eEueaQtw=;
        b=hgdu2EGMeJKw7Zqbcjnq4JgrvciYatqrsvp/Hq38+r3dbFHb3YEZhBI4aQP80VcU84
         XTI2zxdzIwKN0fntEi2P4wfCt1Sjc2W6QvJ2Ge6+EzN69HFwWHdVZa7c5odI7eC4fmbY
         fXfkc4SQl0zDWr1xTXh6Mrc+hVLODwK88TSjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94pKNGw6aDmClK5qtz94uwCrVTPu2QawOX0eEueaQtw=;
        b=gSf4MIZlPS9PQo23iyfgSsYjEONbU3BZmffYsUDIFVCJ3sGSSTGNi91Acd1TmlcTTn
         3HElcSGyGL4D0GqH7fTdM4ZzkSPcR8sKY/H3GREt6DJVdsOGjjTbo8JA706/dXf5rar3
         D2ZANnAX0+T1DPDuoEBI/nvJeY1d8LzEnEIYGwM2sIPmKkfUJJ/b9FfdJ6qhos+L31sF
         c/E1PNh0OZFKwdfWFLkLfL9cCI8EjtklswX9YrgFtEqEEQ5zSHCjjE8ZKm6Z9CkPepNq
         yOicP+q13Bm0Gz/lTBlAUJVhQh2biE+pS+yWMOYYS/hAmv4MYFvaoP+9e5ODKLkvTOFL
         9Jiw==
X-Gm-Message-State: AOAM532B5ZXPlBO95dXn0b8wwTfkypcmU4CBRPCohlgOf/DiQRplfa+Z
        DKnA8u1KyTSmvVgrC/rqrHXVCOxeCg/nRc4UDNi5Sw==
X-Google-Smtp-Source: ABdhPJxfhXQZP1C7d97G/hx7Snn+K2LH9xusJE2FA5qGXcVH1gpUQP62dNOS5MgnxVxXRcpVPneWdOueRi+vrJScXkw=
X-Received: by 2002:a17:902:fe83:b029:106:2e:97b6 with SMTP id
 x3-20020a170902fe83b0290106002e97b6mr2950199plm.49.1623296462349; Wed, 09 Jun
 2021 20:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210507021127.54717-1-chunfeng.yun@mediatek.com> <20210507021127.54717-4-chunfeng.yun@mediatek.com>
In-Reply-To: <20210507021127.54717-4-chunfeng.yun@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Thu, 10 Jun 2021 11:40:50 +0800
Message-ID: <CAATdQgAmms=x=go7TBy9WRTGT05rtc82pBH4NxYdM5d-ohN5MA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] usb: xhci-mtk: use first-fit for LS/FS
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 7, 2021 at 10:11 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> Use first-fit instead of best-fit for LS/FS devices under TT,
> we found that best-fit will consume more bandwidth for some
> cases.
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-and-Tested-by: Ikjoon Jang <ikjn@chromium.org>

> ---
> v3: no changes
> ---
>  drivers/usb/host/xhci-mtk-sch.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
> index 9fb75085e40f..c07411d9b16f 100644
> --- a/drivers/usb/host/xhci-mtk-sch.c
> +++ b/drivers/usb/host/xhci-mtk-sch.c
> @@ -634,6 +634,11 @@ static int check_sch_bw(struct mu3h_sch_bw_info *sch_bw,
>                         min_bw = worst_bw;
>                         min_index = offset;
>                 }
> +
> +               /* use first-fit for LS/FS */
> +               if (sch_ep->sch_tt && min_index >= 0)
> +                       break;
> +
>                 if (min_bw == 0)
>                         break;
>         }
> --
> 2.18.0
>
