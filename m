Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CE53E9216
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhHKNDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhHKNDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:03:04 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898B2C0613D5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 06:02:40 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id x7so4425499ljn.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 06:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oqknCsbFpsHTcdIkxTiepqaukGt+0UkYz6s7BEcJxW0=;
        b=zETW/RQQHABCPBWuPA21hB380a9P/ufFTxArOH3AaD1VokQTofGE/ANxcRxgoNULmQ
         ipqIJsQMqFLEoW9XU4E3x506DWqChTc44adnhPxP7z+Y8EoXBeqiDdzKLrbAAvHfiinn
         VprQ+jUDCJOBSqYmiykbr+ZwlS8aSuce7cgTxZr+h5hgdVPUjPcuU/iECulFJQU4u6F4
         2yq8GatDqLQXM8e/5sW10Y2eJBsggfyKjvwZMsJc8E8sJ0Dn4MHjpU8HSJZPbFnWjQfr
         YUwBb39mM6Pt78gMM6jhMRTwlS9X5riSOFdusr/5lzS/0ga2yejBkbKMHT7r+VEG96eH
         581Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oqknCsbFpsHTcdIkxTiepqaukGt+0UkYz6s7BEcJxW0=;
        b=Npv4CgeYfum/X8+f/LJcfHdIeDg/OrZwkRXjpYguUoAKx8LPbW2HrSX9FmLUMf0cxw
         1n9j6Z7AWLJG838LDa9/lTnULCvav4quP45+RfMMV7kAIPCwPELxN70V/c/XtEtPqrUr
         BZcW4ZVaTCpoy/9nyntQj7xuDW6aK10vRJR4bDTdvQzDxGOOkAKWdiEVE2RCaeDC6mAN
         z8W7/R9maWc/4LDcery7XIlNIzNVufwvUde8q3zCOTjvHwGZKTPE17L97QVAc59MRC7o
         YTe3Vml7+fh4AMTHEjXjIViwl7DBxk4CsuqG4VStZABdYseAxdrz1RqfUntF01Yqk/1g
         HehA==
X-Gm-Message-State: AOAM530F8EbOhDzHMHHbXA/EAg/y2xFZlhIIR76ilukZYYIw/zMV9mCQ
        awdoLpLSZK/10C+dOnz82xJMPB+zIVqGPhWL+f8UFQ==
X-Google-Smtp-Source: ABdhPJy/Dd1dNZKjIqWmvk3JaALAdtf1mDPqUYu8w58dq7IJd2Vi8KCQzgqnXLjDFA87tT2tRnXVOB9p0MHdi165UhQ=
X-Received: by 2002:a2e:b819:: with SMTP id u25mr22997754ljo.438.1628686957962;
 Wed, 11 Aug 2021 06:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210805222625.40236-1-konrad.dybcio@somainline.org>
In-Reply-To: <20210805222625.40236-1-konrad.dybcio@somainline.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Aug 2021 15:02:26 +0200
Message-ID: <CACRpkdYkoETS02DZWyXR_CzR_m4H=E6NyBa==8vH6A5+My2KYA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom-pmic-gpio: Add pm8019 support
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>,
        Martin Botka <martin.botka@somainline.org>,
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

On Fri, Aug 6, 2021 at 12:26 AM Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:

> Add compatible string for pm8019 pmic GPIO support to the
> Qualcomm PMIC GPIO binding.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Sadly I just merged a patch converting this file to YAML.

Please respin this on top of the "devel" branch in the pinctrl
tree:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel

Yours,
Linus Walleij
