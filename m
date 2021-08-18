Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7063EFE35
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 09:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238825AbhHRHvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 03:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237962AbhHRHve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 03:51:34 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4D1C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 00:50:59 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t9so2757610lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 00:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iel16lsj6RMRR46Er5XdYCOwg9LzHhn4KhXWnbYd6I8=;
        b=Z6UL4g1ShVuS90FHgfgXoDI0ewpCEgBdf/rZjBW7xBbfy2iaS+ch/kpFLuCG76wgsg
         XjzJywFmHZyLb/7h1BhV8W++8I6HRHNqOXU1z09Ff1N1nsKiRPXfUPFbtuK5EegZ3NNL
         qUHLFEliYdrejtMHhNSu19/d3oLe737Y9Z0JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iel16lsj6RMRR46Er5XdYCOwg9LzHhn4KhXWnbYd6I8=;
        b=MDcygW4u6mcSA3mSEy78GsodD+XPscwzUZg1qkEiju1ZRCujM5qB89d1ikNnwcHXNq
         bWFM05hS8WYWwE+T8CwIglqTexzxlvl2XEtP2/mdYoS3JMzC9zq5W2Gaj+3H2BoLRG7j
         TOjHHoyHldQu3gkoJ5TvelkcPILflQIBjUDydPyYND6mD9DmgNIn3rXrdnL7qj2dJWHp
         6MOY4kv5+tRQTid4EnBtX9jcsbkY2UtSGmKi19ymjBYFhOM95r4B1lAVZHztmqF3dBci
         f64bt5VWnriHzpk5Kt//p4KDEC0yQjmzXR4AoSthBtBIATTUqhAlDpAzbUeFx2ltxflh
         ikBg==
X-Gm-Message-State: AOAM532AaLOoheegMI151nwnXDZI2GvYY9gJHec0nQBGK6JEznt2yDHx
        64ntZD7fmBwsP9r0z1JuhoW3XORwDku15g==
X-Google-Smtp-Source: ABdhPJzq6mYjIF5Q9vwpDwLR2pDGg23QhS1tIX0AbmL77XDoYUi/yi/ldnTsuAFK3dNZaHllNcdwyg==
X-Received: by 2002:a05:6512:b8e:: with SMTP id b14mr5755494lfv.449.1629273058130;
        Wed, 18 Aug 2021 00:50:58 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id b19sm419051lff.121.2021.08.18.00.50.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 00:50:57 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id n6so3410610ljp.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 00:50:57 -0700 (PDT)
X-Received: by 2002:a2e:b0e8:: with SMTP id h8mr6695165ljl.189.1629273056836;
 Wed, 18 Aug 2021 00:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210802121215.703023-1-eizan@chromium.org> <20210802220943.v6.7.I2049e180dca12e0d1b3178bfc7292dcf9e05ac28@changeid>
 <bf98c5ee749bca755bd46832f858536dbf51a2a4.camel@mediatek.com> <9f23beea197495d017a548ef483584714a3673f9.camel@mediatek.com>
In-Reply-To: <9f23beea197495d017a548ef483584714a3673f9.camel@mediatek.com>
From:   Eizan Miyamoto <eizan@chromium.org>
Date:   Wed, 18 Aug 2021 17:50:39 +1000
X-Gmail-Original-Message-ID: <CAOak1e924x8E+kM2WJ3oGPxxt_R=b79BtbxPAdENamvjVamnEw@mail.gmail.com>
Message-ID: <CAOak1e924x8E+kM2WJ3oGPxxt_R=b79BtbxPAdENamvjVamnEw@mail.gmail.com>
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

Thank you for your review on this series, it is much appreciated.

On Mon, Aug 16, 2021 at 2:53 PM houlong wei <houlong.wei@mediatek.com> wrote:
> Is your removing "mediatek,vpu" necessary for this series "Refactor MTK
> MDP driver into core/components" ?

Removing it is not strictly necessary for the series to function, I
will re-upload the series and omit the following changes:
- [PATCH v6 8/9] dts: mtk-mdp: remove mediatek,vpu property from
primary MDP device
- [PATCH v6 9/9] dt-bindings: mediatek: remove vpu requirement from mtk-mdp

Do please let me know if you meant something different.

Thanks,

Eizan




>
> In some MediaTek projects (not upstream yet), the device-tree node name
> "vpu" may be changed to something like "vpu0", "vpu1" or other name,
> which depends on the implementation of "mtk-vpu" driver. We can specify
> the different phandle to "mediatek,vpu" in .dtsi file. If we use
> of_find_node_by_name() to get the vpu_node, we have to modify the name
> string in different project.
> If the answer of my previous questions is "No", I prefer to slow down
> the modification of removing "mediatek,vpu".
>
> Sorry for late reply.
>
> Regards,
> Houlong
