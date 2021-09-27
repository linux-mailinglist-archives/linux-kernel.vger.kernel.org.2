Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2168C4199C4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbhI0Q6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbhI0Q6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:58:00 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBF9C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:56:21 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id c20so17274591qtb.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LxG4HPV4FXiyd9Nx3Il3K8msxXap3JQb5VLOGuZR7VY=;
        b=lg1n7FUxcNqWTq5zo6ikpYbbg1qh5zQzLTJ8zwUneGdbsMi0M8mPV5zE8+Xcnd4HAQ
         gP4NyCqJ20CSOR+CPqKX/7qhd/sNzEYzCKw4BD4XJoCDHPDw+ma36rX2v5+8bAAdsQXE
         1U8inMUrBNXMZLxmcTjggGzHf9MKW1SPst+Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LxG4HPV4FXiyd9Nx3Il3K8msxXap3JQb5VLOGuZR7VY=;
        b=NqaeWBUaygMpgoT9Fa9BijqsOXAdRl647FoBjaIum1G8qFs2SaQHo3eerPNOhYvepg
         oq4Ub31bwrWxLL14GK+PF/iyaEPBEHazxVW8Mgdo6yV/ia7mYq6C/mpFZuFFfCklxE+S
         bDpqAQQGOa/B9wYbnvDtbloMU3A9UENAF5m3BLbbl22HlkpXRA0St+LdFpABXUTxvyqd
         2RAcFJ24Q5dfpNbH0xfqnGwxYDNOSn8QMudRaRWTYEvEDw0RtWZ3MXsG8bdczANwamTc
         UcRUWWMnWSGZoRFGLNlFGLVBe4wExJbi4PCu4uf73P21My+ctQw2Ljmp4WZNeg7dQ03z
         C6cA==
X-Gm-Message-State: AOAM533CVAQCH6S1F1YMFk0k3ujVkPZsYPonEUFA5WM4U9NEqk/kgIqJ
        oMdFh5+bqHRihbfSRCTkHSjkkYqrLjJLvu+Da6sXlg==
X-Google-Smtp-Source: ABdhPJxks+ildD0Q8dRhHE4wWhlya4id4tdrl9iWX9N3kBCiqQIO9AuMcdOLdKpmnSNIRpILzZVNT9+rwNTdRNHeUGM=
X-Received: by 2002:ac8:1c6:: with SMTP id b6mr855002qtg.221.1632761781171;
 Mon, 27 Sep 2021 09:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210901083215.25984-1-yunfei.dong@mediatek.com>
In-Reply-To: <20210901083215.25984-1-yunfei.dong@mediatek.com>
From:   Steve Cho <stevecho@chromium.org>
Date:   Mon, 27 Sep 2021 09:56:10 -0700
Message-ID: <CAC-pXoNT8AFA2j1DiD9M_uGb92fVcukTGDKVURaGjwpPstcwqQ@mail.gmail.com>
Subject: Re: [PATCH v6, 00/15] Using component framework to support multi
 hardware decode
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunfei,

> This patch dependents on : "media: mtk-vcodec: support for MT8183 decoder"[1] and
> "Mediatek MT8192 clock support"[2].
>
> 1: Multi hardware decode is based on stateless decoder, MT8183 is the first time
> to add stateless decoder. Otherwise it will cause conflict. This patch will be
> accepted in 5.15[1].
Just a few basic questions. What kind of "conflict" are you expecting here?
Are you referring to kernel "5.15" here?
Probably not. If yes, then that sounds strange to me considering our
current kernel uprev plans and current kernel used for MT8183.

> 2: The definition of decoder clocks are in mt8192-clk.h, this patch already in clk tree[2].
>
> [1]https://patchwork.linuxtv.org/project/linux-media/list/?series=5826
This link seems to be no longer available.

> [2]https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/?h=clk-next&id=f35f1a23e0e12e3173e9e9dedbc150d139027189
