Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38C93ACD6D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 16:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbhFROYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 10:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbhFROYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:24:11 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453E5C061574;
        Fri, 18 Jun 2021 07:22:02 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f16-20020a05600c1550b02901b00c1be4abso8835854wmg.2;
        Fri, 18 Jun 2021 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/biPioDVeS+IYbxYtzg7Tz6IEPtjr5QXhP/AdQlfO84=;
        b=P4/4h2b8qp4XU9blbA89ELz8vd5WafBNDUFlcZ1rj6cknCBtbZrc20qCrXCo/NAQ+0
         IzaZPkavTJrdzjocPjtmceGDDcolEMj/M7faIc99CL3xJ2dRr4YYi6ogQ2e+YlQw54oQ
         413krdch49fpbem9cgIxN7ox0jAl2jZnuQmVBGp5AoW2CX3wrGSkCg8iola01SIFn/ch
         D5swQzJBZx72+6P4nMYOUmQmVWCTlrFylwfmtWCKGiK3Do/WTPNIIlGHmXOiy0fNKp4R
         9ECjXAHpoNYBRlYjnvans2huDbtNpNkcEC4/VIdWqzKzDeOIDWjiqrgACJhaO98P5riJ
         TLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/biPioDVeS+IYbxYtzg7Tz6IEPtjr5QXhP/AdQlfO84=;
        b=XJ2p83RTVkmVNRMXIa83iH0XqjxfALplr5C4nXspE8PX/imZDXJIGa/82vwhgteygn
         r705NmUy904ebkFY6MsaNnI9cnsDYNkVAPQiy6STl9DwCyhcKZEbPEeWiYipGzLCstPz
         j82gsyDffOoEAWjeGLMVeDi8avzivFxD/56bxiXgQWCpQ3bkI1xOtgNI71AorxwPsI2u
         qRq9sD+qlgOf1OyhGb3CuiqMl/jqmos81RlsEiFWyvMxjWGrlR+iPPrbF7wmbmpIAl1o
         BHU+Qe2WuQecQN/mhKYnwLgg91Qa2LXgLIX+DfWnQupP0PjT0tbqx+ZkBJkcM7GiXPQW
         ButQ==
X-Gm-Message-State: AOAM531A2/5RBUqUOwx5emZlRjCpdTz8tSi06Zib1NMQcPG83rAxRwAk
        7iCXBNFxZSVWrlxHYMntfjvzgxNW4tVX1A==
X-Google-Smtp-Source: ABdhPJyKstre3DomrgnI/Zr73Kb9mawHY+FIwq0XyXEcaToktorCgbIDII2H5TgRhE1qLHB74af1bw==
X-Received: by 2002:a1c:5413:: with SMTP id i19mr12213783wmb.12.1624026120589;
        Fri, 18 Jun 2021 07:22:00 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id x18sm8583826wrw.19.2021.06.18.07.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 07:22:00 -0700 (PDT)
Subject: Re: arm64: dts: mt8195: Add Mediatek SoC MT8195 device nodes
To:     Tinghan Shen <tinghan.shen@mediatek.com>, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, seiya.wang@mediatek.com,
        wenst@google.com, Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20210615173233.26682-1-tinghan.shen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <b1ee64c4-eeb6-a664-ebcd-4a0cc62e2ded@gmail.com>
Date:   Fri, 18 Jun 2021 16:21:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210615173233.26682-1-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tnghan,

It looks like as if you send a whole bunch of device tree files which don't have
any binding description yet.

Can you please filter and only send these patches that actually have a binding
entry? That would make my life much easier.

Apart from that it would be good if you could ask internally to get some advice
how to improve Signed-off-by tags (I spotted at least one patch where yours was
missing) or how to improve commit messages.

Thanks!
Matthias

On 15/06/2021 19:32, Tinghan Shen wrote:
> This series is a collection of device nodes for Mediatek SoC MT8195 and
> depends on patches[1][2][3].
> 
> The dependency list is not complete.
> some dependencies are still under working.
> 
> [1] arm64: dts: Add Mediatek SoC MT8195 and evaluation board dts and Makefile
>     https://patchwork.kernel.org/project/linux-mediatek/patch/20210601075350.31515-2-seiya.wang@mediatek.com/
> 
> [2] dt-bindings: power: Add MT8195 power domains
>     https://patchwork.kernel.org/project/linux-mediatek/patch/20210610023614.5375-3-chun-jie.chen@mediatek.com/
> 
> [3] dt-bindings: pinctrl: mt8195: add pinctrl file and binding document
>     https://patchwork.kernel.org/project/linux-mediatek/patch/20210413055702.27535-2-zhiyong.tao@mediatek.com/
> 
> 
