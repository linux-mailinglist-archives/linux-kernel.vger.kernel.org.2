Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27F33EFE09
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 09:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbhHRHo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 03:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238310AbhHRHo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 03:44:27 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72EBC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 00:43:52 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t9so2720857lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 00:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Pb+i4XV4pD9hHVrCfu2OguYuvXddQz4i1EZeyLXlSA=;
        b=gU6KmWZ2VTtGU6MiqbJsuaCgeM+rsgd3JJa00KF9rgd6K9cenC2G4J0H6wZB5SCAqf
         6Bo7La+IoqM78I2iW9kvnfoDUEdChf27ygxHLn8lkctJjJ2XKY28XcqOepRC3GrG/Iv9
         cU1jo2AKfe+0ty10qvt5sCVfPTdG5UopO0ZaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Pb+i4XV4pD9hHVrCfu2OguYuvXddQz4i1EZeyLXlSA=;
        b=GgaNmDcJNJ2+eSekTEuTgLEWzck+9wAORyJoiozsUT0boU3C1wG+GPO0JK5fMAhUwS
         wKc7pRPqtAhl4QEDd+2E9MCzJx+GD5+beV1CAd2+UOT6QKdWiInlw2x3ai6UhKfXn0w/
         nGdp/K68jUUi8yMco8elmZ0RsYCmbO5Or7EXF3MHdYathuSTaGupiAH1ojm6nIktn2pX
         KfiPyJIDShKamdYIFBKUtXeOxuCtGOAsb56YaeJ8EZbrUvEaD3DdYhgeUFUi/OH1wq1M
         XJF10sm8NRE/JpGFBp3anss7Fayge/1Dxv2E1dc9Hp/6WAGNGKOT6f0i10w/sLOUYnLc
         a/GQ==
X-Gm-Message-State: AOAM532kw6boDC1rj8pVewpo/S463aO00gJmHjmLnXr99aUFT/SGUeyb
        nq4qqHkR44D+3tM9r0BgXughk4LWuoMpHg==
X-Google-Smtp-Source: ABdhPJzY6MRpuYfymRx1P0leG8adSYZLgE64yuhqn9vxGFOixqpIqAtz/+HxAgC8OlU6mk9hnUQXxQ==
X-Received: by 2002:ac2:50c6:: with SMTP id h6mr5380158lfm.343.1629272631199;
        Wed, 18 Aug 2021 00:43:51 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id k16sm496127ljo.37.2021.08.18.00.43.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 00:43:51 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id i28so2760457lfl.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 00:43:50 -0700 (PDT)
X-Received: by 2002:a19:2d4e:: with SMTP id t14mr5421824lft.30.1629272630297;
 Wed, 18 Aug 2021 00:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210802121215.703023-1-eizan@chromium.org> <20210802220943.v6.7.I2049e180dca12e0d1b3178bfc7292dcf9e05ac28@changeid>
 <bf98c5ee749bca755bd46832f858536dbf51a2a4.camel@mediatek.com>
In-Reply-To: <bf98c5ee749bca755bd46832f858536dbf51a2a4.camel@mediatek.com>
From:   Eizan Miyamoto <eizan@chromium.org>
Date:   Wed, 18 Aug 2021 17:43:33 +1000
X-Gmail-Original-Message-ID: <CAOak1e-oyzxbvHimMReQpZCAPyCtAsaGixjwmoa0EzMjqaUxVg@mail.gmail.com>
Message-ID: <CAOak1e-oyzxbvHimMReQpZCAPyCtAsaGixjwmoa0EzMjqaUxVg@mail.gmail.com>
Subject: Re: [PATCH v6 7/9] media: mtk-mdp: use mdp-rdma0 alias to point to
 MDP master
To:     houlong wei <houlong.wei@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <yong.wu@mediatek.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?B?TWluZ2hzaXUgVHNhaSAo6JSh5piO5L+uKQ==?= 
        <minghsiu.tsai@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Houlong,

On Mon, Aug 16, 2021 at 1:00 PM houlong wei <houlong.wei@mediatek.com> wrote:
> Hi Eizan,
>
> "mdp-rdma0" may be not the only one master device node. In fact, there
> are 2 "mdp-rdma" in mt8173. You can see "mdp_rdma1" via below link.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/arm64/boot/dts/mediatek/mt8173.dtsi?h=v5.13.11#n1016
> If we add "mediatek,mt8173-mdp" to "mdp_rdma1" like below, we will have
> one more V4L2 video devie node.
>
>                 mdp_rdma1: rdma@14002000 {
>                         compatible = "mediatek,mt8173-mdp-rdma",
>                                      "mediatek,mt8173-mdp";
>                         ...
>                 }
>
> We should consider the case that there are more than one "MDP_RDMA"
> components.

Would it be okay with you if we added support for multiple MDP master
device nodes in follow-up changes? My rationale is this:
- As far as I can tell, the mediatek integration with V4L2 currently
only handles a single MDP master device node. It's not clear to me the
scope of changes that will be needed to make things work properly with
multiple nodes.
- The patch series makes video decode work (admittedly, in light of
your comments not optimally) upstream, which is better than not
landing these changes at all.

I'd like to say that I'm very open to (and excited about) discussing
further work to support multiple MDP master nodes, perhaps we can
work together on this so I can understand what needs to be done.

Please let me know your thoughts,

Eizan
