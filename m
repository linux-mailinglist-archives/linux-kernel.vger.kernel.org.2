Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF9841672F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243287AbhIWVM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243269AbhIWVMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:12:54 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C481C061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:11:22 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b15so30580327lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j2kl8h+4ATUGvv+z4Ez87ArKkPHKBbbEw0WTQVzieXs=;
        b=jOWtkKpqc7S5Kn1C3py8QN/jT0FuGCpokXxnWw98ZKH4rLwU57UPGk0+slHElmjqBE
         hGu63FF+1bDgx13Lrhy96S60ckNSOs2CYRLWbx7E0Ir0HBIFBVNIor1IPtUE1xiA9CGo
         VY8YDBkiLa6jJSDmH1ipdcmqxXtZFQKvTC+lm90OwligXVJ4/u1iNV5AILz5sTYOI2op
         ZSM7mmXtSj2JKvGgmsXnfsU1oc+pSmQwuvjdWhuUsp9YIz6EZNZbPfkGCjXUH2GP/aLu
         ZnTFq9D0hvW/u31qafRGq/+yuKcsSW2dw5gOkr+LEZdjPI5SI6AQpx25XKr0XYiqufhP
         qSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j2kl8h+4ATUGvv+z4Ez87ArKkPHKBbbEw0WTQVzieXs=;
        b=iqf6pWMzH8c3dY4Pw6l8B5tlKK/T/aAJFZTFqx71Mu8JCOJVD9tiyovJ0xzjNtRyCx
         cUQlqzpEshuHT8V0t7EJc72dJgXXIz/qGvH3rUyeDdl5K08kkbsbQTFqH/NwX/5eeNuf
         L5Qe7J5KHv09DLF9TTYJ428GEh9ZB4oFXv7UCFUp6EF9gfquF9eqmOy41XdaUnqkZbrf
         OqiG6DagJCpCJzAmhPmlic3xxy3diKnWrja1u772Wp2wxDNR/LiDCPD70PBKAjrl5SGn
         pnLC26C6vjWmVO8ldEczCtw9cFY9q+Li3pGGBbTIKdC8EvK3oNtBo+Zcb1na7WKTlVQo
         toOA==
X-Gm-Message-State: AOAM533kLuLEUxCFRteBaHt5F/2K4KaDOiLggdMtbNF0Y213uBz/LrxQ
        CfvClA5kSME3x1TdLTHELwiUhGsXdbYNjgMfQ+qBiQ==
X-Google-Smtp-Source: ABdhPJy9hTS9GoHoGmMxbglABqy5TnI8Hc6XNBF5d2W/i3muZBAgBEGKdj5ik2uZqliBCGCi/EaM1fHMnx+/0ay0elE=
X-Received: by 2002:ac2:4d03:: with SMTP id r3mr6421581lfi.339.1632431480892;
 Thu, 23 Sep 2021 14:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210923161450.15278-1-konrad.dybcio@somainline.org>
In-Reply-To: <20210923161450.15278-1-konrad.dybcio@somainline.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Sep 2021 23:11:09 +0200
Message-ID: <CACRpkdYugrxY3z08tv=_yBb3+h4RggUSWjEakuM6W=kLsbx=QQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: pinctrl: qcom: Add SM6350 pinctrl bindings
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>,
        Martin Botka <martin.botka@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
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

On Thu, Sep 23, 2021 at 6:15 PM Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:

> Add device tree binding Documentation details for Qualcomm SM6350
> pinctrl driver.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Patch applied for v5.16!

Yours,
Linus Walleij
