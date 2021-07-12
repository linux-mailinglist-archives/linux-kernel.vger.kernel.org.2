Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65B83C5A38
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237525AbhGLJmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 05:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381969AbhGLJk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 05:40:57 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAC6C0613E8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 02:38:09 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id n14so42082913lfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 02:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fxJCUCjSlgXxGDjLXHj9U/H++hzbmhE6H12woYxnzEo=;
        b=kEXIVazNxdPeQjIQRJkZ34NK8TOWTN8cN3PTg4u6h+qBpMX/8NP2QnXimoDsrD47U1
         Nx9WHbWZ5zUBwObZWK89MK5QKklyaL19EKODkPwj8rr8NhSRf6ZHb7DGRkq9nGOS6W6s
         rlmPcHBaJlpyL6qugKjw7qGyQhPNR06FjEh2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fxJCUCjSlgXxGDjLXHj9U/H++hzbmhE6H12woYxnzEo=;
        b=Df1muPtx7PMlqfD9fTYZzvwkGShUTseS0lHhN+msA9WGyCPCyT04E0YNIqhNGO6YnY
         L7/hL68maKmejxkN2u0En+DCC4yYNmvRyJEEDYJ8h7uNU5MhfNLyc15wNEOug0RisQV3
         rkxRzEWUqrpk/Kz/S1r0OtTvS9c9ylUZIwbxDTezfHWDfseS/NZo5h4xatzi9RD6nedN
         fxuBJIOMHBV8OSC7hpAZ99YM8qBbzcWIVIDURQlU0KxrAuCv3QOahCjfnxtEGiVhd/Rw
         QM6BurWAz4ILa0HvH3EL8rY6EHe1HTw9IyOAmkKhsy8OseJnkLlb+lDq7MM37p+ufYC4
         b0Zw==
X-Gm-Message-State: AOAM531O2phfI1X+qXgqNah4XesmVsrjiCFWHS8mLMGqCVz1NajxlgXI
        Ue2xxsVeHMnAjIauXH8zqh24dYchSNJvF7gWceMlJQ==
X-Google-Smtp-Source: ABdhPJxQC8DmA5HEXaqu0oHdMTjSbon83tv6yVWxtwXNhe/ty5TRr6RQ+xzlTDU/2wgHcAMAinpsKbdHUu82InisZBc=
X-Received: by 2002:a19:858b:: with SMTP id h133mr20580359lfd.656.1626082687405;
 Mon, 12 Jul 2021 02:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com> <20210616224743.5109-3-chun-jie.chen@mediatek.com>
In-Reply-To: <20210616224743.5109-3-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 12 Jul 2021 17:37:56 +0800
Message-ID: <CAGXv+5Hn2YE5yhX61z375vzJufsYyWNBkB07zMUqcPty0YxAaQ@mail.gmail.com>
Subject: Re: [PATCH 02/22] clk: mediatek: Add dt-bindings of MT8195 clocks
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 17, 2021 at 7:02 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 clock dt-bindings, include topckgen, apmixedsys,
> infracfg_ao, pericfg_ao and subsystem clocks.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  include/dt-bindings/clock/mt8195-clk.h | 989 +++++++++++++++++++++++++
>  1 file changed, 989 insertions(+)

This is a really long list. I don't think all of them need to be exposed,
especially the intermediate ones in TOPCKGEN. In such cases the not-to-be-
exposed clock indices could be moved to a header file in the driver directory,
or simply left out.

The Allwinner/sunxi-ng drivers do the former while the Rockchip drivers do
the latter. The Mediatek clock drivers are more similar in structure and
design to the Rockchip ones.


Regards
ChenYu
