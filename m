Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560EF3931C7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbhE0PIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbhE0PHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:07:21 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B78C06138F
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:45 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id f30so621213lfj.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rahXOe6QHY33QTQOxWdfULKSVMeqoD1SZ9MMzCB7Epk=;
        b=QgemFEUFUuuSklvkxKN/r2wK+fwxRrcB+1NIfYRwdBQcZxI+ThqfRKz3T9kBMN3R84
         XQ+FR2t5sTM3Bo3nw8Mq/B9Bl06bJiX1lmproov3AVCqCpmoa4SUEznu4j82fsW39cK9
         SXS5pvi+uCrSz565Boqa8z4D4+IFkE1Ard90fIVnjkJXWXMGkmzN8yGGQB1ljvscOwOE
         s0b7aZNWFN3Iw+dv47/0gAyF+MH85d80s6T6SnhhY22pdVp+H6FXig7MG3SJNoqep6rG
         ApOLAJevQ+ttOj2YfVZFKgK8IRfVfJmwGx+/mPZ/WTc8uULCQKMzSdbVGXJo01wTJQo/
         MPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rahXOe6QHY33QTQOxWdfULKSVMeqoD1SZ9MMzCB7Epk=;
        b=MWAkj/tFCztcytLlFAQ2CXuyLwlYpU5vKL1bD7w9C2DhbFbX7lsn63NyOy+1pVWDVe
         GpPfMLYWDvMna8RWX7iH18jCcSZ5Oso/dFcvaE/Kc+efjrfXy8OVYihZUHHYBH5igDHk
         6vsRVUYapk4Gzrh1XXzbZsr16/9pxp5qfoCoxwhesMyr5gmAc0qi0khADfYO9lcNp4I3
         3UFdKcRqyCqt2gCYw8ypH/4EnHoTHsK2GyYT6KVL0fSdeU1wXFvP09ixTyEE68fV1ppq
         gX86bGlKApyfQkJ/JPYfdIh37QhXJXSPC0i0OdB2KlDYGcDYT+3eajVvcJoXmeQrG8jw
         PsLA==
X-Gm-Message-State: AOAM53081e5JDyr/nwH9rMHuJ1wKo5cBx1ABsTYXQxyCa0bTXJpA1CXu
        paD/XEWdV/5OqhTdNN26zCeQGzDg/eblrFujdIRExg==
X-Google-Smtp-Source: ABdhPJzBYi57GIctgtdTsVpbJbwy9MS4FOpEElMLUm+fWapmXHzjAEojgsu6AlyvT1IQTvqNVOXBcraYmzlssDGr3Xk=
X-Received: by 2002:ac2:47e6:: with SMTP id b6mr2601491lfp.649.1622127943635;
 Thu, 27 May 2021 08:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210524193012.592210-1-martin.botka@somainline.org>
In-Reply-To: <20210524193012.592210-1-martin.botka@somainline.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 May 2021 17:05:32 +0200
Message-ID: <CACRpkdbPvxN2-VTm+n-j6JiWZnraCviZ2JDFe=A7Z=z93-seVQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: pinctrl: qcom: sm6125: Document
 SM6125 pinctrl driver
To:     Martin Botka <martin.botka@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

overall this looks good but the bot warned because of this:

On Mon, May 24, 2021 at 9:30 PM Martin Botka
<martin.botka@somainline.org> wrote:
>
> Document the newly added SM6125 pinctrl driver
>
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
(...)
> +properties:
> +  compatible:
> +    const: qcom,sm6125-tlmm
(...)
> +        #include <dt-bindings/interrupt-controller/arm-gic.h>
> +        pinctrl@500000 {
> +                compatible = "qcom,sm6125-pinctrl";

So it seems like you didn't run the checks?

Yours,
Linus Walleij
