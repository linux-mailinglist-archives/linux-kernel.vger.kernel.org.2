Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08270353221
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 04:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhDCCnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 22:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231256AbhDCCnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 22:43:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C143D61041
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 02:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617417781;
        bh=aNMELlBUL3U9rUGH+ATD1Xz3WuM8CEMeyY0C6yKRUtA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cuCud8GY0iktgDSRI4xfGJ33gE36wrqpLlpJnRZiDI1ictGBTheAX5cBdZ1IFSqYY
         MhjaitWn43EqYaTVfy8hHCxuSHi7t2phu/vaEybuOLTP8Qnfv00ftT15UmbXxY4XZo
         I0pV2cYS9AOAzEMgeddW4qUCgpUpcJ+DUXXLq5AHhaHgGIALPv1XX7710r8N4YsYNT
         UUgIrWG7AuBSzlS/JmKTks8CqQYRdpNe1hFp0v9f8vFqov8EwW+7iOnGnuexhmDy8/
         NXeVi8QuxUnbl4ie8HfcmV+Kscyx+hEmCAXYqLHToLcSBPUhu3++8eYO6SOWJsy5OW
         Yp7PcoyFPHZmw==
Received: by mail-ej1-f53.google.com with SMTP id hq27so9497926ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 19:43:00 -0700 (PDT)
X-Gm-Message-State: AOAM532SqozzNFWTdxmxZQXtDp8hlgrgoPR6H9yWYYmJSTWn2DKt8uij
        tkQvCu06j6tUsMtbrV6RI4FbNxVhbT3kqA9u/A==
X-Google-Smtp-Source: ABdhPJzRV4BcVclnftx3MZaVEOZmxecuymiOeLqckYtOn66OeMun4ixu6zDGHI8xJMXwUsPxgb/m8Nl6YvcJsOi4ZaA=
X-Received: by 2002:a17:906:9888:: with SMTP id zc8mr17244941ejb.310.1617417779374;
 Fri, 02 Apr 2021 19:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210314233323.23377-1-chunkuang.hu@kernel.org>
In-Reply-To: <20210314233323.23377-1-chunkuang.hu@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 3 Apr 2021 10:42:48 +0800
X-Gmail-Original-Message-ID: <CAAOTY__SvoLJ7aPhuiNLXBd_JhbuzF=bTABG-MHc7bvHuQJi0w@mail.gmail.com>
Message-ID: <CAAOTY__SvoLJ7aPhuiNLXBd_JhbuzF=bTABG-MHc7bvHuQJi0w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Refine mtk-cmdq-mailbox callback mechanism
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jassi:

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

How do you think about this series?

Regards,
Chun-Kuang.

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
