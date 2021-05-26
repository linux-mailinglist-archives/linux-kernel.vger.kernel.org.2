Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E244391078
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhEZGOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:14:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232831AbhEZGOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:14:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD7B6613C9
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622009599;
        bh=WxE/nYoBUew8cawmtyFnT6QVxlwzsMB2VH8N97o6ILU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W3wmXVbSCTKRrh02KjzmgFG4xDxdQvFsQ8BRhOvsYhx4YIhnQzhtBrtSCZ6rmupLX
         2hPltBRfEJfTXVN096eCrGrYOSHihBuiGhQ/kEHPNNInc3nZuzbRAZK2hgMiY6YSFm
         UjiH8J/vaygafiK9n7NKBcBiad5SLElkFFvBB7QXXAYmGvoYnLyAh0bDI1qp63qYrb
         LkvPvJJZu+Rh7/luN4lc35naRJZii4R1NmJge+7D9LG1Z+VGFO6bUjGMAP/oVqt8V7
         ict6/b1lko3IvMadDgXR4yYGvjPCGzHYTtIAyGOGfaElKOHBror8bpvb1wqHwbwv6C
         Wz3xx2rv5Pa7A==
Received: by mail-ej1-f52.google.com with SMTP id b9so528515ejc.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 23:13:19 -0700 (PDT)
X-Gm-Message-State: AOAM531FyEdRxGh62L3W5/zmSohZXdqhi8r3B0wDyZsQBQm1xvvW2ndk
        sTz9xMNxPhIVoz6UbFDLYGPRRCmVCizJ2olbog==
X-Google-Smtp-Source: ABdhPJyLkSEaneCrl0B8Uo6KH8eSMCLLi627Il/INpXPMrNKeFajtofiTGol2XS5McwtUI0QbMI+UZjmQsFpzFQne2Q=
X-Received: by 2002:a17:906:b0cb:: with SMTP id bk11mr32693838ejb.310.1622009598186;
 Tue, 25 May 2021 23:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210314233323.23377-1-chunkuang.hu@kernel.org>
In-Reply-To: <20210314233323.23377-1-chunkuang.hu@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 26 May 2021 14:13:09 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9fksAnZc2pqmbHtBiPQgQhX9iX0349K8T9zCG8mH3ZSQ@mail.gmail.com>
Message-ID: <CAAOTY_9fksAnZc2pqmbHtBiPQgQhX9iX0349K8T9zCG8mH3ZSQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Refine mtk-cmdq-mailbox callback mechanism
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Yongqiang.

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2021=E5=B9=B43=E6=9C=8815=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=887:33=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> mtk-cmdq-mailbox use proprietary callback mechanism and proprietary
> error number, but these could be replaced by standard callback
> mechanism and standard error number. In addition, use cmdq_pkt as
> callback data to prevent redundnat assignment.
>
> Because client driver still use proprietary mechanism, so keep
> proprietary mechanism until client driver use the standard one.
>
> Chun-Kuang Hu (3):
>   mailbox: mtk-cmdq: Remove cmdq_cb_status
>   mailbox: mtk-cmdq: Use mailbox rx_callback
>   mailbox: mtk-cmdq: Add struct cmdq_pkt in struct cmdq_cb_data
>
>  drivers/mailbox/mtk-cmdq-mailbox.c       | 24 +++++++++++++++---------
>  include/linux/mailbox/mtk-cmdq-mailbox.h |  8 ++------
>  2 files changed, 17 insertions(+), 15 deletions(-)
>
> --
> 2.17.1
>
