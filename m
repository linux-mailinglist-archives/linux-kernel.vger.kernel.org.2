Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7203C7E92
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 08:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbhGNGgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 02:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbhGNGgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 02:36:15 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AAEC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 23:33:23 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id v26so706668iom.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 23:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fF0A3SNyCoLJ9V4Mf6IFTlcVxCvyAcihWUy7P8dtXJI=;
        b=DN/o78lFqAKsgN5uUZevIfvTthvAaqLUS7o/z4AqRbGBER//DxjodEcfhITop+1Sbi
         5xnPBW4khvCZ9s+B1EueYDKprlSNK7aHd7gD0NOPaVX7FC2k2vU+jDakW2TtboEyTibR
         qoWxRSuHKBrIIysihP1UKdBy4Awi8uwDvRoP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fF0A3SNyCoLJ9V4Mf6IFTlcVxCvyAcihWUy7P8dtXJI=;
        b=eXS3J8YZwSelhIhyHxLHEdl3E/IOYDxP+qQGLCP5GVpwiqQhDK4ak398bmPm/1pnId
         9aJlbLER+G4uppLHbtl90B9PlAQkiJyazH5EYV9Ex1w/FT6HUIdI8rZ5n7guHTx2ymGq
         OrldJuPsIg7j/VJeunnec4g//iS+5cfKBfNLYTfWfLPEjng7VA20VAuciiorSXZED5C+
         zqMGflZ+nMTiah6DCHQ4UUSeuiJkeY+btYeCTY1ssa1p3q8WQhRqjnhBgks8uMwEyBxd
         5u1obhHnJcObJjk4S0IJhY9ljkTVohtwKbQm0whtJBa4aBK6p/65mU72vpSsUh45Yi02
         DFNg==
X-Gm-Message-State: AOAM531DUcBugMvjmabJKh/Ulqh+aHA7ArOIFCxfpMIGb8XIRX+QtjCa
        wXqMnP89g5a6l/PcW813dzfMR3oQyrvnw5NvflG6bw==
X-Google-Smtp-Source: ABdhPJziJytxeQ51ecTdT3CtD4o86bg7Q+pPkL3Gi50sJ3vzYsr9bjOhfcALk+Ji1bGlr/PbCYsHfE4mxG+wawo0Vso=
X-Received: by 2002:a02:cce6:: with SMTP id l6mr7474610jaq.114.1626244402499;
 Tue, 13 Jul 2021 23:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210705053429.4380-1-jason-jh.lin@mediatek.com> <20210705053429.4380-6-jason-jh.lin@mediatek.com>
In-Reply-To: <20210705053429.4380-6-jason-jh.lin@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 14 Jul 2021 14:32:56 +0800
Message-ID: <CAJMQK-g-3-WeLMH57cJBWVt1=i7SuxwGG2Ae253igEEX9oywKA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] mailbox: cmdq: fix GCE can not receive hardward event
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@google.com>, nancy.lin@mediatek.com,
        singo.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 5, 2021 at 1:35 PM jason-jh.lin <jason-jh.lin@mediatek.com> wrote:
>
> For the design of GCE hardware event signal transportation,
> evnet rx will send the event signal to all GCE event merges
> after receiving the event signal from the other hardware.
>
> Because GCE event merges need to response to event rx, their
> clocks must be enabled at that time.
>
> To make sure all the gce clock is enabled while receiving the
> hardware event, each cmdq mailbox should enable or disable
> the others gce clk at the same time.
>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 102 +++++++++++++++++++++++------
>  1 file changed, 83 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index fc67888a677c..44a3cf252fd5 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -19,6 +19,7 @@
>
>  #define CMDQ_OP_CODE_MASK              (0xff << CMDQ_OP_CODE_SHIFT)
>  #define CMDQ_NUM_CMD(t)                        (t->cmd_buf_size / CMDQ_INST_SIZE)
> +#define CMDQ_GCE_NUM_MAX               (2)
>
>  #define CMDQ_CURR_IRQ_STATUS           0x10
>  #define CMDQ_SYNC_TOKEN_UPDATE         0x68
> @@ -73,14 +74,16 @@ struct cmdq {
>         u32                     thread_nr;
>         u32                     irq_mask;
>         struct cmdq_thread      *thread;
> -       struct clk              *clock;
> +       struct clk              *clock[CMDQ_GCE_NUM_MAX];
>         bool                    suspended;
>         u8                      shift_pa;
> +       u32                     gce_num;
>  };
>
>  struct gce_plat {
>         u32 thread_nr;
>         u8 shift;
> +       u32 gce_num;
>  };
>
>  u8 cmdq_get_shift_pa(struct mbox_chan *chan)
> @@ -120,11 +123,15 @@ static void cmdq_init(struct cmdq *cmdq)
>  {
>         int i;
>
> -       WARN_ON(clk_enable(cmdq->clock) < 0);
> +       for (i = 0; i < cmdq->gce_num; i++)
> +               WARN_ON(clk_enable(cmdq->clock[i]) < 0);
> +
You can use clk_bulk_enable instead of looping. Same for clk_bulk_disable.

<snip>
