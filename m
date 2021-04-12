Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F0835C9D9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 17:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242821AbhDLP36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 11:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240372AbhDLP3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 11:29:55 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5BDC061574;
        Mon, 12 Apr 2021 08:29:36 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y2so6560650plg.5;
        Mon, 12 Apr 2021 08:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AC9X+1/OhI3zv50JSM+L1kZ63zcScSi3KwtHVFoeDOw=;
        b=Tz5vMcW2J8n8llIRRxrQEz1Uz4jGuraPfFMjgZhJWfIuHZeZjdN5wwsXeIKHeei3HN
         jl7dgwnU90QfctY/oLsUfelxm7ZQVd4lmn5Ky3n+eAa9YrsaFOeo7mASNKc7KaNoBK0O
         CEL3i+WunqLR+KfhQhlmZv6sBfn94Kj+xj4+96sSKInzAHw1SyLRwu4bpukdQ9V9NKmJ
         XRgy27ylt+yK5lDRJCTP1Tfs1wrLFGZtuQ/pdYmDZXqAgZ4EsJfPQ6r32cCEeUu6os7t
         KWAwMWr4A0DNPqjsacjKXQgQ/vbqSw3HQtrWloZH5hO6sKd7i4QMUuKeFb6p/wrQuYIL
         +2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AC9X+1/OhI3zv50JSM+L1kZ63zcScSi3KwtHVFoeDOw=;
        b=SHQmhcixVziDe9KbFJjGpDxPlKnbcaaLbx5Ofo6Hvi64Vymc8lPEuazH+6V0m+dkDZ
         wIjvQoC4xGTCCYLggX4gfk6UDKd5jsp5sAivP7lmSqH2zLiB6UEhPw3sof0xdpr/iRsc
         irNFBADHu6zYnJHquwrrI3HEzHfKCagRK4IBUzdx8yqLLqbFdII7XsZ3ElRtHuQX/FcS
         +roXf4xO+zQO6f2EzoePnTWBO0yCdQ88+WginP8kEq2OJbigdLp3m7l2sjOQC5x6u2qp
         ws/mkcIeVagfzynZOpqvws9ZMjTy/7nfkEMV7I8dxo/IR+uUNtZI61fSwSiLUJIZUlT0
         LoEA==
X-Gm-Message-State: AOAM5312dNZFx7DZReZ11ypWlbQ9p22NNVD6V7w0i1lljx0I0yaL25An
        jLZ1PNk+M6y+OorZR5zZKyaXt6t0enTrfQDe8rA=
X-Google-Smtp-Source: ABdhPJyhWxFPHubJiQzEWlBZGAcD5U+iSEhomsoE4VkHQdHlcHgEjMjOuHIPkqW6eOaFi+abQ8fizEazhnbBJm7PSIg=
X-Received: by 2002:a17:902:bf92:b029:e6:bc0:25ac with SMTP id
 v18-20020a170902bf92b02900e60bc025acmr27750319pls.49.1618241376112; Mon, 12
 Apr 2021 08:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <1618226325-31927-1-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1618226325-31927-1-git-send-email-yongqiang.niu@mediatek.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 12 Apr 2021 10:29:25 -0500
Message-ID: <CABb+yY1b9wD0hoBx=aYzpLcF-=EEG4QTrV68sZj8+rtf5J1aJQ@mail.gmail.com>
Subject: Re: [PATCH v2, 0/5] Revert "mailbox: mediatek: remove implementation
 related to atomic_exec"
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 6:18 AM Yongqiang Niu
<yongqiang.niu@mediatek.com> wrote:
>
> This series base linux 5.12-rc2
> these patches will cause home ui flick when cursor moved,
> there is no fix solution yet, revert these patches first.
>
> change since v1:
> add mtk-gce.txt and dts modification
>
> Yongqiang Niu (5):
>   Revert "drm/mediatek: Make sure previous message done or be aborted
>     before send"
>   Revert "mailbox: mediatek: remove implementation related to
>     atomic_exec"
>   Revert "dt-bindings: mailbox: mtk-gce: fix incorrect mbox-cells value"
>   Revert "arm64: dts: mediatek: mt8183: fix gce incorrect mbox-cells
>     value"
>   arm64: dts: mediatek: mt8183: add gce information for mmsys
>
>  .../devicetree/bindings/mailbox/mtk-gce.txt        |  2 +-
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi           |  5 +-
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  1 -
>  drivers/mailbox/mtk-cmdq-mailbox.c                 | 80 +++++++++++++++++++---
>  4 files changed, 76 insertions(+), 12 deletions(-)
>
Please break the patchsets (this and the other 3) into mailbox only
and platform specific ones.
Also, it would help if there are some acked/reviewed by some mtk folks
especially when reverting patches.

thanks
