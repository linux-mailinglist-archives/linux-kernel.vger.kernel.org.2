Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045C2426BBA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 15:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242500AbhJHNfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 09:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhJHNfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 09:35:21 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F2FC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 06:33:26 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id g125so7042383oif.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 06:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WoGewCiLqk1L6y+Pgt2DJrjP+8ghH7hEUaGntIWrC6s=;
        b=pBBPhlBaaQ/+9BTkC8YQaIzxZUjhoP5gpNMQgN77vY9v2h7jlzVCbinDSYFVpy6ndp
         Ws/ti+bseFbbE03/vlU7RLpGr+ZmLeFD+9aZUzyKl5KiA1kwk0kGXLgzHtr8zBWYn8xi
         q4ybMOkh/x97fGCnjftfaUtNefTClMrA9CrF8PLx03L/5AatozRBMZJfDQaaGckjkYph
         j0hLuo22LwIe+w52ooreptbTrMgPdlu/1FLlleiZxaowcIgR9Y3QK1tVQF4VFXn2kiwC
         /CEI1mjKgHU0X1rWDCt2RP121DdUPklm+JYOoNFXNvxwK1LKfV6mI6GyhI2lERLEg2ND
         DhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WoGewCiLqk1L6y+Pgt2DJrjP+8ghH7hEUaGntIWrC6s=;
        b=n4LUtCstf3uUpbwMq97fghFF8RaR38WHslIb6ERkqJ+h46TXWVF4+i8ksBXIgKeVu6
         r5bJP5wb56HkujVyFGfja8Zh3ZeI4YTCID+4jNt2T7DNAM9SZIdMNnhDzjM1BLKr7dU+
         OqPnyQnd0UF50azh6hG81D04paxTGksg7GvD81x2E57aHWCY0jVqA31fIvKuMdV7V41U
         zpE39yiCRg/1Uac7JZEN2IAbyKH4EhOpFtMqgyjT9wljU6LgM38CE/QQwYV22k8YXsfl
         4ba4rlUio8mgIhjgFfQxrw6gFVyTJ+JSyU8zBQbuNYsxzmQ+ENIjkS/6Oawn1jhHeDh7
         sThQ==
X-Gm-Message-State: AOAM530wgwuAPCxu2cxSzJhXfQWRfQfBeWPeYMkLCEIwHVc/SDnuVp44
        x5kuExdCiV5qkJNBU1+p52LpUkrLO05fh8AEpno=
X-Google-Smtp-Source: ABdhPJzqOPRwfbVyLwZGp7MkC4sShrKrhfIK/YsbRKO8AG2yd7R+50aZOrvJPgTLoJY6/jZl+GNohd1/SRi0OGXehm4=
X-Received: by 2002:a05:6808:15:: with SMTP id u21mr16376940oic.129.1633700005586;
 Fri, 08 Oct 2021 06:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211007235310.14626-1-chunkuang.hu@kernel.org>
In-Reply-To: <20211007235310.14626-1-chunkuang.hu@kernel.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 8 Oct 2021 15:33:14 +0200
Message-ID: <CAFqH_51hO2efxbQkkbzNHSk92zOZGeFJBu4Ocijk_cpxFDJ2fw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Revert series "CMDQ refinement of Mediatek DRM driver"
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Kuang,

Thank you to take time to send this, for full series

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Display is now working again.

Thanks,
  Enric


Missatge de Chun-Kuang Hu <chunkuang.hu@kernel.org> del dia dv., 8
d=E2=80=99oct. 2021 a les 1:53:
>
> Commit c1ec54b7b5af
> ("drm/mediatek: Use mailbox rx_callback instead of cmdq_task_cb")
> would cause numerous mtk cmdq mailbox driver warning:
>
> WARNING: CPU: 0 PID: 0 at drivers/mailbox/mtk-cmdq-mailbox.c:198
> cmdq_task_exec_done+0xb8/0xe0
>
> So revert that patch and all the patches depend on that patch.
>
> Chun-Kuang Hu (5):
>   Revert "drm/mediatek: Clear pending flag when cmdq packet is done"
>   Revert "drm/mediatek: Add cmdq_handle in mtk_crtc"
>   Revert "drm/mediatek: Detect CMDQ execution timeout"
>   Revert "drm/mediatek: Remove struct cmdq_client"
>   Revert "drm/mediatek: Use mailbox rx_callback instead of cmdq_task_cb"
>
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 157 ++++--------------------
>  1 file changed, 24 insertions(+), 133 deletions(-)
>
> --
> 2.25.1
>
