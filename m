Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC63531127B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhBESqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:46:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233089AbhBEPEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:04:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23F1264EBB;
        Fri,  5 Feb 2021 16:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612542918;
        bh=IFsoR33cfLR/NdsmSDvU1b96AKsLDHBLu6xFlw273pg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KZxh+APv+35iGZRKPPFRQTJ/hGBEgBXyyL709ntUmNkBZA0K/e7U6qxFt6OyDwGQV
         o5y+9Az7Xav+3WoePuF3+yQEQ4wdLNX+1UkW7eLJ2P22gtD+b7Y7Q9bBXPByAz8Cr2
         fGFFU3Bg6uIfHKxq4V9iHWzqbA5rEFGrMjSBLxt7859Chpr+ZP03c/A0zERKiJa5FE
         7vFCgdIfO0NznmeJaKivQmVZ4C8Nkif/nrYunM0siFx86qYFBE53La+zLoY63pMUrV
         Ge9xRqRSC9tbrwgbb3oR36Gy2LOW90il1O4gtyqY6ul8B08CdHE4ytOMgf1rmaKOhs
         welBiSbNSmYxw==
Received: by mail-wr1-f44.google.com with SMTP id a1so8371347wrq.6;
        Fri, 05 Feb 2021 08:35:18 -0800 (PST)
X-Gm-Message-State: AOAM531CAnDptnHE4QcsPMmEwy3NIOmR4EeM5IV/oSpFdVJ73Lyy7Bp6
        tiuLrr4Ol+baFDTW7/4Km9WOdYfq4T2EFXlXXQ==
X-Google-Smtp-Source: ABdhPJxHaO6IYPbyxfqRFCa2tsAhyIgQYiwjsqx933EYqGvODP9OdFZKkygaQFKEuVKnf1Lb6O8Kcb8tXYF+CWHULSc=
X-Received: by 2002:a5d:524a:: with SMTP id k10mr5993484wrc.394.1612542916550;
 Fri, 05 Feb 2021 08:35:16 -0800 (PST)
MIME-Version: 1.0
References: <20210205071833.2707243-1-hsinyi@chromium.org> <20210205071833.2707243-2-hsinyi@chromium.org>
In-Reply-To: <20210205071833.2707243-2-hsinyi@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 6 Feb 2021 00:35:05 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9CJQ9dF4D04Kp6SwVX4zoJ5HZJKD5aKbko3Qqiy0xEPw@mail.gmail.com>
Message-ID: <CAAOTY_9CJQ9dF4D04Kp6SwVX4zoJ5HZJKD5aKbko3Qqiy0xEPw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-binding: gce: add gce header file for mt8192
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-Yi:

Hsin-Yi Wang <hsinyi@chromium.org> =E6=96=BC 2021=E5=B9=B42=E6=9C=885=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:19=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
>
> Add documentation for the mt8192 gce.
>
> Add gce header file defined the gce hardware event,
> subsys number and constant for mt8192.
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  .../devicetree/bindings/mailbox/mtk-gce.txt   |   7 +-
>  include/dt-bindings/gce/mt8192-gce.h          | 419 ++++++++++++++++++
>  2 files changed, 423 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/gce/mt8192-gce.h
>
> diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Docu=
mentation/devicetree/bindings/mailbox/mtk-gce.txt
> index 7771ecaac5868..ac4245050d17d 100644
> --- a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> +++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> @@ -9,8 +9,8 @@ CMDQ driver uses mailbox framework for communication. Ple=
ase refer to
>  mailbox.txt for generic information about mailbox device-tree bindings.
>
>  Required properties:
> -- compatible: can be "mediatek,mt8173-gce", "mediatek,mt8183-gce" or
> -  "mediatek,mt6779-gce".
> +- compatible: can be "mediatek,mt8173-gce", "mediatek,mt8183-gce",
> +  "mediatek,mt8192-gce" or "mediatek,mt6779-gce".
>  - reg: Address range of the GCE unit
>  - interrupts: The interrupt signal from the GCE block
>  - clock: Clocks according to the common clock binding
> @@ -36,7 +36,8 @@ Optional properties for a client device:
>    size: the total size of register address that GCE can access.
>
>  Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h',
> -'dt-binding/gce/mt8183-gce.h' or 'dt-bindings/gce/mt6779-gce.h'. Such as
> +'dt-binding/gce/mt8183-gce.h', 'dt-binding/gce/mt8192-gce.h' or
> +'dt-bindings/gce/mt6779-gce.h'. Such as
>  sub-system ids, thread priority, event ids.
>
>  Example:
> diff --git a/include/dt-bindings/gce/mt8192-gce.h b/include/dt-bindings/g=
ce/mt8192-gce.h
> new file mode 100644
> index 0000000000000..062754416bfda
> --- /dev/null
> +++ b/include/dt-bindings/gce/mt8192-gce.h
> @@ -0,0 +1,419 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2020 MediaTek Inc.
> + * Author: Yongqiang Niu <yongqiang.niu@mediatek.com>
> + */
> +
> +#ifndef _DT_BINDINGS_GCE_MT8192_H
> +#define _DT_BINDINGS_GCE_MT8192_H
> +
> +/* assign timeout 0 also means default */
> +#define CMDQ_NO_TIMEOUT                0xffffffff
> +#define CMDQ_TIMEOUT_DEFAULT   1000
> +
> +/* GCE thread priority */
> +#define CMDQ_THR_PRIO_LOWEST   0
> +#define CMDQ_THR_PRIO_1                1
> +#define CMDQ_THR_PRIO_2                2
> +#define CMDQ_THR_PRIO_3                3
> +#define CMDQ_THR_PRIO_4                4
> +#define CMDQ_THR_PRIO_5                5
> +#define CMDQ_THR_PRIO_6                6
> +#define CMDQ_THR_PRIO_HIGHEST  7
> +
> +/* CPR count in 32bit register */
> +#define GCE_CPR_COUNT          1312
> +
> +/* GCE subsys table */
> +#define SUBSYS_1300XXXX                0
> +#define SUBSYS_1400XXXX                1
> +#define SUBSYS_1401XXXX                2
> +#define SUBSYS_1402XXXX                3
> +#define SUBSYS_1502XXXX                4
> +#define SUBSYS_1880XXXX                5
> +#define SUBSYS_1881XXXX                6
> +#define SUBSYS_1882XXXX                7
> +#define SUBSYS_1883XXXX                8
> +#define SUBSYS_1884XXXX                9
> +#define SUBSYS_1000XXXX                10
> +#define SUBSYS_1001XXXX                11
> +#define SUBSYS_1002XXXX                12
> +#define SUBSYS_1003XXXX                13
> +#define SUBSYS_1004XXXX                14
> +#define SUBSYS_1005XXXX                15
> +#define SUBSYS_1020XXXX                16
> +#define SUBSYS_1028XXXX                17
> +#define SUBSYS_1700XXXX                18
> +#define SUBSYS_1701XXXX                19
> +#define SUBSYS_1702XXXX                20
> +#define SUBSYS_1703XXXX                21
> +#define SUBSYS_1800XXXX                22
> +#define SUBSYS_1801XXXX                23
> +#define SUBSYS_1802XXXX                24
> +#define SUBSYS_1804XXXX                25
> +#define SUBSYS_1805XXXX                26
> +#define SUBSYS_1808XXXX                27
> +#define SUBSYS_180aXXXX                28
> +#define SUBSYS_180bXXXX                29
> +#define SUBSYS_NO_SUPPORT      99

Why define no support?

> +
> +/* GCE General Purpose Register (GPR) support
> + * Leave note for scenario usage here
> + */
> +/* GCE: write mask */
> +#define GCE_GPR_R00            0x00
> +#define GCE_GPR_R01            0x01
> +/* MDP: P1: JPEG dest */
> +#define GCE_GPR_R02            0x02
> +#define GCE_GPR_R03            0x03
> +/* MDP: PQ color */
> +#define GCE_GPR_R04            0x04
> +/* MDP: 2D sharpness */
> +#define GCE_GPR_R05            0x05
> +/* DISP: poll esd */
> +#define GCE_GPR_R06            0x06
> +#define GCE_GPR_R07            0x07
> +/* MDP: P4: 2D sharpness dst */
> +#define GCE_GPR_R08            0x08
> +#define GCE_GPR_R09            0x09
> +/* VCU: poll with timeout for GPR timer */
> +#define GCE_GPR_R10            0x0A
> +#define GCE_GPR_R11            0x0B
> +/* CMDQ: debug */
> +#define GCE_GPR_R12            0x0C
> +#define GCE_GPR_R13            0x0D
> +/* CMDQ: P7: debug */
> +#define GCE_GPR_R14            0x0E
> +#define GCE_GPR_R15            0x0F
> +

If there are 1024 general registers, you would have 1024 definition here?

[snip]

> +#define CMDQ_EVENT_OUT_EVENT_0                         898

If the sw token is from 512 to 1023, is this sw token?

> +
> +/* CMDQ sw tokens
> + * Following definitions are gce sw token which may use by clients
> + * event operation API.
> + * Note that token 512 to 639 may set secure
> + */
> +
> +/* end of hw event and begin of sw token */
> +#define CMDQ_MAX_HW_EVENT                              512
> +
> +/* Config thread notify trigger thread */
> +#define CMDQ_SYNC_TOKEN_CONFIG_DIRTY                   640
> +/* Trigger thread notify config thread */
> +#define CMDQ_SYNC_TOKEN_STREAM_EOF                     641
> +/* Block Trigger thread until the ESD check finishes. */
> +#define CMDQ_SYNC_TOKEN_ESD_EOF                                642
> +#define CMDQ_SYNC_TOKEN_STREAM_BLOCK                   643
> +/* check CABC setup finish */
> +#define CMDQ_SYNC_TOKEN_CABC_EOF                       644
> +
> +/* Notify normal CMDQ there are some secure task done
> + * MUST NOT CHANGE, this token sync with secure world
> + */
> +#define CMDQ_SYNC_SECURE_THR_EOF                       647
> +
> +/* CMDQ use sw token */
> +#define CMDQ_SYNC_TOKEN_USER_0                         649
> +#define CMDQ_SYNC_TOKEN_USER_1                         650
> +#define CMDQ_SYNC_TOKEN_POLL_MONITOR                   651
> +
> +/* ISP sw token */
> +#define CMDQ_SYNC_TOKEN_MSS                            665
> +#define CMDQ_SYNC_TOKEN_MSF                            666
> +
> +/* DISP sw token */
> +#define CMDQ_SYNC_TOKEN_SODI                           671

sw token is an event which is trigger by software. Each driver could
choose some sw token to use. But I think each sw token could be used
by any driver. So this definition is a software definition and it
should be placed in driver.

> +
> +/* GPR access tokens (for HW register backup)
> + * There are 15 32-bit GPR, 3 GPR form a set
> + * (64-bit for address, 32-bit for value)
> + * MUST NOT CHANGE, these tokens sync with MDP
> + */
> +#define CMDQ_SYNC_TOKEN_GPR_SET_0                      700
> +#define CMDQ_SYNC_TOKEN_GPR_SET_1                      701
> +#define CMDQ_SYNC_TOKEN_GPR_SET_2                      702
> +#define CMDQ_SYNC_TOKEN_GPR_SET_3                      703
> +#define CMDQ_SYNC_TOKEN_GPR_SET_4                      704

This looks like software definition.

> +
> +/* Resource lock event to control resource in GCE thread */
> +#define CMDQ_SYNC_RESOURCE_WROT0                       710
> +#define CMDQ_SYNC_RESOURCE_WROT1                       711

This looks like software definition.

Regards,
Chun-Kuang.

> +
> +#define CMDQ_EVENT_MAX                                 0x3FF
> +/* CMDQ sw tokens END */
> +
> +#endif
> --
> 2.30.0.365.g02bc693789-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
