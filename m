Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE20834062A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhCRMyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231349AbhCRMyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:54:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6295D64F53;
        Thu, 18 Mar 2021 12:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616072055;
        bh=PIgoILQ+JXQLKgHb4EX46KzQNin7qaWoZQINVA9rRg8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VM8uQb8n/g+eow1038PB3oZRgVelzhtSYvgJI8MQqo1iAMnUhxdMgv106lxMicZ1Q
         cEAz8GE+D+1MmgYU+plwG6FP9I1LGuLZBWA6CEhW3dbbYLaL+q/xba7NWBVVUXSnhO
         /EnXkZ+kYh1MrYkVXEVondrGhlT3o7Eg2SjZbg0ZQjlWl/GVtr0vXj6uftVzTNGSt6
         qYJbtg8C4gKegkvBnPQhxWhDqpUfM+IZNlKtGDPAEx/+yOv8Vg1tp0WIfJ4d0AC7M4
         ZBcGj0GbqKApy92ULDA3xumziIdyp4F0rlKYef9yfmSAbVzXB+12xRTzXfzk8ac02K
         MmK6yxy0yFa3Q==
Received: by mail-wr1-f45.google.com with SMTP id b9so5419756wrt.8;
        Thu, 18 Mar 2021 05:54:15 -0700 (PDT)
X-Gm-Message-State: AOAM532xLCaQIB1htnOvuLS75QFnkNZM0ihX85NMJzLjxZh5nQJ6KJrq
        FICwswnlYkvaZlGyUSsKvx13Nwq7gpEJFsrVlA==
X-Google-Smtp-Source: ABdhPJwLERCk/N5J3yNu9yr15qTSlb8M38k26qtsk7H27iH5P5Ntdy0rj4/mqmw1+bjPHgvQ7F5zwKMruCOCx4m9TeY=
X-Received: by 2002:adf:e84f:: with SMTP id d15mr9572196wrn.394.1616072054006;
 Thu, 18 Mar 2021 05:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <1616046056-29068-1-git-send-email-rex-bc.chen@mediatek.com>
In-Reply-To: <1616046056-29068-1-git-send-email-rex-bc.chen@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 18 Mar 2021 20:54:02 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-V7=ooGE1DhAjQR4MrsCmwocARYqUkB_aoJNbVK8Hdyg@mail.gmail.com>
Message-ID: <CAAOTY_-V7=ooGE1DhAjQR4MrsCmwocARYqUkB_aoJNbVK8Hdyg@mail.gmail.com>
Subject: Re: [v5,0/2] Add check for max clock rate in mode_valid
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rex:


For this series, applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

Rex-BC Chen <rex-bc.chen@mediatek.com> =E6=96=BC 2021=E5=B9=B43=E6=9C=8818=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=881:41=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Changes in v5:
>   fix build error
>
> Changes in v4:
>   add Author and add patch description
>
> Rex-BC Chen (2):
>   drm/mediatek: mtk_dpi: Add check for max clock rate in mode_valid
>   drm/mediatek: mtk_dpi: Add dpi config for mt8192
>
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> --
> 2.18.0
>
