Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE1A3A22CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 05:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhFJDdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 23:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFJDdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 23:33:41 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0130C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 20:31:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id u126so428409pfu.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 20:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7oIVo7Xzbw9TVkKcvpifrqSvzyU32kz1bTpH+C80Wns=;
        b=S6u4QNuWHqphKFRnJIadQXQdMQsCC7NxnhI9qTnr6ftqvS7l4znkBCbGb2pMZJiMIR
         rQaw+QzRZnzNuzyZjx6/9d47myK85kBWR1swpwXRCheQQ0Y13A6Ynh4zIYub4GWLGUpe
         2QTve5fmuvSwsQR2MdT86gN7Rg6pbFM8m6KMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7oIVo7Xzbw9TVkKcvpifrqSvzyU32kz1bTpH+C80Wns=;
        b=PAOAd+n+VsxrSu5gxlQP0iTaO0n4+ujhMds0rAJlAZhS02Nu+gKQEStsn72qg78YxW
         Q5mD1HROILrdufzHzb90sjScqDUaUqMGNcQdtighaLkituxGnL7w4T1UuQinoupxDhPB
         TGV9q11wFqx2LuiVYMrQMlC92nApy0Cxa7aUd3V1cOBodYAI9BS7xH3KRri+UPuefkmG
         mBWmhfXawi/Hk3pCcxUCwQIQBI1AeuA8R3xCHCjJBbw7G/rTODPO9ikyOVSIlfR4rXXP
         ByewYy3SoPLX9I12Nj7fGfcyr6/qnmNwt+UaUQLOYIIBw8/9OtawbOdEuGY7f5uqNerU
         Vq9g==
X-Gm-Message-State: AOAM533RRtJ7JLmijI9N8Nnf4DWB8OmI7ek44ju3FjhyQ/fGSgp6hzle
        Su3BD9oBUmIxOOQ7mAnzMHyZGO9TLTSFYPMrLS9cOQ==
X-Google-Smtp-Source: ABdhPJxFOr3K6ngAtBXDCOFBaf1TZc1JxsWX46LnWiU7oVYxdsIbn1LDXznYMFDG2KjGXlDY+RA8/uwdzZBwoByfIRk=
X-Received: by 2002:a63:234f:: with SMTP id u15mr2906536pgm.257.1623295897282;
 Wed, 09 Jun 2021 20:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210507021127.54717-1-chunfeng.yun@mediatek.com>
In-Reply-To: <20210507021127.54717-1-chunfeng.yun@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Thu, 10 Jun 2021 11:31:25 +0800
Message-ID: <CAATdQgD+e6FSFfOvmuib14f1-O6w6znH5agf3gP774Qd6udCUw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] usb: xhci-mtk: use bitfield instead of bool
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
> Use bitfield instead of bool in struct
>
> Refer to coding-style.rst 17) Using bool:
> "If a structure has many true/false values, consider consolidating
> them into a bitfield with 1 bit members, or using an appropriate
> fixed width type, such as u8."
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-and-Tested-by: Ikjoon Jang <ikjn@chromium.org>

> ---
> v3: split @has_ippc out into anather patch suggested by Greg
> v2: add more changelog suggested by Greg
> ---
>  drivers/usb/host/xhci-mtk.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
> index cd3a37bb73e6..94a59b3d178f 100644
> --- a/drivers/usb/host/xhci-mtk.h
> +++ b/drivers/usb/host/xhci-mtk.h
> @@ -138,17 +138,17 @@ struct xhci_hcd_mtk {
>         struct mu3h_sch_bw_info *sch_array;
>         struct list_head bw_ep_chk_list;
>         struct mu3c_ippc_regs __iomem *ippc_regs;
> -       bool has_ippc;
>         int num_u2_ports;
>         int num_u3_ports;
>         int u3p_dis_msk;
>         struct regulator *vusb33;
>         struct regulator *vbus;
>         struct clk_bulk_data clks[BULK_CLKS_NUM];
> -       bool lpm_support;
> -       bool u2_lpm_disable;
> +       unsigned int has_ippc:1;
> +       unsigned int lpm_support:1;
> +       unsigned int u2_lpm_disable:1;
>         /* usb remote wakeup */
> -       bool uwk_en;
> +       unsigned int uwk_en:1;
>         struct regmap *uwk;
>         u32 uwk_reg_base;
>         u32 uwk_vers;
> --
> 2.18.0
>
