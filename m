Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078283A22D5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 05:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhFJDfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 23:35:39 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:38756 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhFJDfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 23:35:38 -0400
Received: by mail-pf1-f182.google.com with SMTP id z26so442938pfj.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 20:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xUW1QYivvyjjAgnt50OixHHdXR+qpa5RaoXkpg+0Z1M=;
        b=Ckk34yOiLznSSdYmHluvlvw2OSugkHIAcSI40L06ddrl1WVeu9lXyJKAySZr7I/6lx
         L836XZ32h5BAbCgwQE46EsuxXnQxKGyeSqwD00a0X8Jl9oP+RTO3Mi8P+NnpJGUSpbSN
         7UB4hKaHAkMX/VHG9tiyztZzgqJ5TWFOxM0D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xUW1QYivvyjjAgnt50OixHHdXR+qpa5RaoXkpg+0Z1M=;
        b=ORXG4VI70u8WMQZ0Fuq776THLkd/ckT1Brj4H/rEFx/i/qgKtS0ASy07h6w+wWJxNj
         Qw2OJ/bSItQbAiWZenTuH4Aqug6mnSj4r1XJIYpwC+f2My7gGmBzDwIe7H/SDDiIT7zS
         S4e6YmRM5Y//D+4xJHMXOeeegI94P9Gg8fDIZl/jkiVSkhTxgolnhnaIqU4NGdyAq28x
         QlzbiEHuC9dqvOqUdJuSKSysS/wnyB786k46qjg0upAC72jFsrV463ioK3w5F2yjnHSk
         fQVMDe1LjgUvwGxoVizdbKiLcUwZMNn5KdtmvE/7eoctOzpZmOczr2UAwQfwTZBwdTtN
         UTig==
X-Gm-Message-State: AOAM530HNt/hwYFTzwRt4+liH9aqe4/qRdY6H3YOZP8VXgxL5hKEy3iJ
        k8ZwAFXzx1AvpEANHIthuvQLYHiZZ7GI3Nu2AhotUQ==
X-Google-Smtp-Source: ABdhPJwe3SJDAt53Ax1wi7DIEJ7gvGIkAxJ9U/9K0Mhis4k/681JzWIKUxqMMmr9kGyLMHjJbzCsDbc5afgxvWOYbpg=
X-Received: by 2002:a63:5d19:: with SMTP id r25mr2802205pgb.317.1623295948478;
 Wed, 09 Jun 2021 20:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210507021127.54717-1-chunfeng.yun@mediatek.com> <20210507021127.54717-2-chunfeng.yun@mediatek.com>
In-Reply-To: <20210507021127.54717-2-chunfeng.yun@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Thu, 10 Jun 2021 11:32:17 +0800
Message-ID: <CAATdQgAr=wwbuJ=0nKKmO6Rb7qcW2BobFAb30DUsMA2s6EOxhA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] usb: xhci-mtk: remove unnecessary setting of has_ippc
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
> Due to @has_ippc's default value is 0, no need set it again if fail
> to get ippc base address
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-and-Tested-by: Ikjoon Jang <ikjn@chromium.org>

> ---
> v3: new patch suggested by Greg
>     fix typo suggested by Sergei
> ---
>  drivers/usb/host/xhci-mtk.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> index b2058b3bc834..2548976bcf05 100644
> --- a/drivers/usb/host/xhci-mtk.c
> +++ b/drivers/usb/host/xhci-mtk.c
> @@ -495,8 +495,6 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>                         goto put_usb2_hcd;
>                 }
>                 mtk->has_ippc = true;
> -       } else {
> -               mtk->has_ippc = false;
>         }
>
>         device_init_wakeup(dev, true);
> --
> 2.18.0
>
