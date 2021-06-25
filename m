Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46353B4004
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 11:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhFYJIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 05:08:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231273AbhFYJIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:08:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F42B61429;
        Fri, 25 Jun 2021 09:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624611960;
        bh=JRVtn2LF05O4zsE0yUfn3O6+raSRPmcoBZK9SlvE3Ek=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PI8vE6yPun5p4JI5lqgqmoj6wFcIKcxACiN0n0/ZqHEgn94A8GTyrSmQiOucWmEem
         wagx0jY9FU0oNSkLNbPC59J3f7u8E3D6Jia9fiaWsFS2oe3ZnPGQDWo1KHjjl5qvlc
         QHTnZT1TqLP06ybaXUpfI1KcDzW3NwX3ceo4GnpypoPjF56tWZ9m+yXl1xNcSgePpE
         psFHRxRdPMIWawB6OsvISLD5D3L2lTSKPAeO2gsKU/D+S22vIwwjmyOMe90lsAqKVw
         pc+sL92BFmuOOpfHsfYX4YZQF9Xx7jx0T5fEw10EXx2yD5eeqX19DPiszNhtvyWdKm
         OS90IuLCsK5mQ==
Received: by mail-ed1-f42.google.com with SMTP id r7so12379523edv.12;
        Fri, 25 Jun 2021 02:06:00 -0700 (PDT)
X-Gm-Message-State: AOAM531SwGPG7A9l+hRM1hcHWOeK5IZcnOgA85fZohrP85beCj2sELbq
        FqXQ0JfOM/jmlw3EK/A30NjErcV4riiqbpbFKA==
X-Google-Smtp-Source: ABdhPJxab4jkrfzwFP+D7IPG+I+O5aPJXlWlmFnx/IiQeIs3tugbHdgiEvdUB5GE3e2v6Hzy6jf90PdaVKtT5o0Hc94=
X-Received: by 2002:a05:6402:4cf:: with SMTP id n15mr13597628edw.162.1624611958809;
 Fri, 25 Jun 2021 02:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <YNHg5NuJILrrBIZ/@mwanda>
In-Reply-To: <YNHg5NuJILrrBIZ/@mwanda>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 25 Jun 2021 17:05:48 +0800
X-Gmail-Original-Message-ID: <CAAOTY__qnvFX4NB0G878S_J-mug4sTfynAukLGSD1xoMHKGdqA@mail.gmail.com>
Message-ID: <CAAOTY__qnvFX4NB0G878S_J-mug4sTfynAukLGSD1xoMHKGdqA@mail.gmail.com>
Subject: Re: [PATCH] mailbox: mtk-cmdq: Fix uninitialized variable in cmdq_mbox_flush()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dan:

Dan Carpenter <dan.carpenter@oracle.com> =E6=96=BC 2021=E5=B9=B46=E6=9C=882=
2=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=889:09=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> The "cb" pointer needs to be initialized before can assign
> "data.data =3D cb->data;".

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Fixes: 4a3cb0303984 ("mailbox: mtk-cmdq: Use mailbox rx_callback")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmd=
q-mailbox.c
> index 301e65b9527a..67a42b514429 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -455,10 +455,10 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, =
unsigned long timeout)
>
>         list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
>                                  list_entry) {
> +               cb =3D &task->pkt->async_cb;
>                 data.sta =3D -ECONNABORTED;
>                 data.data =3D cb->data;
>                 data.pkt =3D task->pkt;
> -               cb =3D &task->pkt->async_cb;
>                 if (cb->cb)
>                         cb->cb(data);
>
> --
> 2.30.2
>
