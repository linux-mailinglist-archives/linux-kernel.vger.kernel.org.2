Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CB141D3CF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 09:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348456AbhI3HCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 03:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbhI3HCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 03:02:34 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7BAC06161C;
        Thu, 30 Sep 2021 00:00:52 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so6058339otb.10;
        Thu, 30 Sep 2021 00:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ue6uNPnLLdl7jKDUxvPsPxqXMJIv3DpHCbjBPHb+V6E=;
        b=XalgEcT5QsfkjgOWM+i22TOdnTp9NNx9Fvrc5aCHWIEn163QTmmLjPToqPsmoDAJ21
         ne0f0Mu2dMhCrid6VICN7O8aD3gymPvbNeSK1HJNu3MlfWSvxVN8hZOlvC0ovLls1RU4
         2ARRLjTEOit9maXcJVMDDyY3eHr9RL0jN9LNrVDl+4wrF9Y7jjRNqEzvEm5LJV+jp8aN
         XMsNSyWJwtk2jp2tacZeJkCgKGj2VgNLV22MkJnpq8eqyrHz5by2GAiJB7pHlLUqs2mh
         2TAbkICBraqOUtSibZiHg9njNTbizCoD6O27P7MDFWge0HWGXk2hqOqYcM52h/xUyaah
         ZAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ue6uNPnLLdl7jKDUxvPsPxqXMJIv3DpHCbjBPHb+V6E=;
        b=QUKTBs5XBml0zQkUVSUVnIUcpjGeXQ/zc03hEW2gE+oqfiTO+i/2EG+050Qc70i0Jz
         D4WgL2KBrTJePPmMGQ9A1wCtxPNnX/iVXBDUKrulII/9yMOtF0/2ea21HPPx6V7w9T4D
         5jJxWMjsrMZdZI3Fa5NUxTNr+ez065a7li/qlqtqYTRUPPI48wzjjZu/lSATes1B+Std
         kEwJHqXMVBFJwj/n5BwwQtCKv3Rbj9E7UdH/benSv8AIQ/vvtH+HwzZ+gQQ+3DB7/jxA
         UVax0i9fxLi497kurF2am/k0FfqKPn1W0Tnxh2qHW6JpZcYiK6yVG4e+8EQtsZZTcWSJ
         CoVQ==
X-Gm-Message-State: AOAM531SXbs7PBI7VDAL0tgqUftRgbn3aRZKCEJFUd+FdWnwz+q+eDsR
        uip/Hh9/aecyp93MMFfUr6YeUgv4IH7+XmQeBJ8=
X-Google-Smtp-Source: ABdhPJy3XkRsegSss9Hy+paR7Fpx8O2PdcXw9Xl5jXPSzeYvrSlpIJ8rmYtlF0sh6lW9S9hQLSPN1YrmuBQO9ou2QsQ=
X-Received: by 2002:a9d:173:: with SMTP id 106mr4021216otu.150.1632985251729;
 Thu, 30 Sep 2021 00:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210929070807.4488-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20210929070807.4488-1-jason-jh.lin@mediatek.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 30 Sep 2021 09:00:39 +0200
Message-ID: <CAFqH_53KkXEB__cMiQ6d_vKu1jy71XyaNRfoULmMOpSsfQdQAg@mail.gmail.com>
Subject: Re: [PATCH] mailbox: Remove WARN_ON for async_cb.cb in cmdq_exec_done
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "Nancy.Lin" <nancy.lin@mediatek.com>, singo.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

Thank you for your patch.

Missatge de jason-jh.lin <jason-jh.lin@mediatek.com> del dia dc., 29
de set. 2021 a les 9:08:
>
> Because mtk_drm_crtc_update_config is not using cmdq_pkt_flush_async,
> it won't have pkt->async_cb.cb anymore.
>
> So remove the WARN_ON check of pkt->async_cb.cb at cmdq_exec_done.
>
> Fixes: 1b6b0ce2240e ("mailbox: mtk-cmdq: Use mailbox rx_callback")
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>

As expected this removes the annoying "false" warning on the Mediatek
devices I tested.

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
  Enric


> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 64175a893312..c591dab9d5a4 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -195,7 +195,6 @@ static void cmdq_task_exec_done(struct cmdq_task *task, int sta)
>         struct cmdq_task_cb *cb = &task->pkt->async_cb;
>         struct cmdq_cb_data data;
>
> -       WARN_ON(cb->cb == (cmdq_async_flush_cb)NULL);
>         data.sta = sta;
>         data.data = cb->data;
>         data.pkt = task->pkt;
> --
> 2.18.0
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
