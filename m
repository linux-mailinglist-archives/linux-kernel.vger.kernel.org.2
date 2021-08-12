Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310F43E9B82
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 02:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhHLANr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 20:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232704AbhHLANq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 20:13:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A9CE610A7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 00:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628727202;
        bh=SvqZXrT6raLFkVVxSV1Rme6HepTUUscOCyV5xTdrWSw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B6KSggAEUigQ5ARvSFSmuLugF8pCl74OazxBj93wNoETjxYTmQjhtadx5Dr7K0VNR
         Ydechf2VxRHirK2RzLK5oJoTMzEKPX+afgHXXaNQGaraSNd/3TyKPA9ftTP0+0vbI5
         W0IITElFrQwFhplnriCy6VOXAaaJgFIhUU7ia/Q02VWxlOOYO8nzsZuWH34a7y2NlS
         XqkJ79J35xvvE7pzcnLyjmugFMEWymrq5g+cZNJBDEM/jx40ofqZ5IvWghL6YBMaa6
         76n/rxGGaUGOCypVNNbej8QynIFtZmPqNwv1JuR7JlRcSUEgwyCMgt7g48BokrRsyy
         cGtZJnDHEWTWg==
Received: by mail-ed1-f54.google.com with SMTP id g21so6609631edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 17:13:22 -0700 (PDT)
X-Gm-Message-State: AOAM530bjASuTYLn2ENhQ+kz+RkyDc3GdGwPo1DkfNWWo5ymdkF0xLGy
        hqKiY0BMD6dyDTXfhoZwG4JLJDQ3LErZI2NACQ==
X-Google-Smtp-Source: ABdhPJyQ8kt15E+5zz4pGcu5BjWx3XvQp7ecCpdQWAw9XtUggxnZaJHQrXUdbE/deXKJx/q6khdVJ2sSNurzzj/izb8=
X-Received: by 2002:a50:9fc2:: with SMTP id c60mr1984780edf.49.1628727200855;
 Wed, 11 Aug 2021 17:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210808234733.14782-1-chunkuang.hu@kernel.org>
In-Reply-To: <20210808234733.14782-1-chunkuang.hu@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 12 Aug 2021 08:13:09 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9LstZegE_Gyibov5tLo5eEqiPfoAcnyj_uoS=8xLLhnA@mail.gmail.com>
Message-ID: <CAAOTY_9LstZegE_Gyibov5tLo5eEqiPfoAcnyj_uoS=8xLLhnA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] CMDQ refinement of Mediatek DRM driver
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2021=E5=B9=B48=E6=9C=889=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=887:47=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> These refinements include using standard mailbox callback interface,
> timeout detection, and a fixed cmdq_handle.

For this series, applied to mediatek-drm-next [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Changes in v2:
> 1. Define mtk_drm_cmdq_pkt_create() and mtk_drm_cmdq_pkt_destroy()
>    when CONFIG_MTK_CMDQ is reachable.
>
> Chun-Kuang Hu (4):
>   drm/mediatek: Use mailbox rx_callback instead of cmdq_task_cb
>   drm/mediatek: Remove struct cmdq_client
>   drm/mediatek: Detect CMDQ execution timeout
>   drm/mediatek: Add cmdq_handle in mtk_crtc
>
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 110 ++++++++++++++++++++----
>  1 file changed, 91 insertions(+), 19 deletions(-)
>
> --
> 2.25.1
>
