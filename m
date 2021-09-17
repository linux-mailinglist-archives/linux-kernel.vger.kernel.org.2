Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AC541002A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 22:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244011AbhIQUD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 16:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244123AbhIQUDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 16:03:54 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1D9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 13:02:31 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id d18so1308805iof.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 13:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J1UMbMc8OAj14RDhbE254NcvzwuTcA6/D0lnRvB23mQ=;
        b=evClt5J6dFFrQPKBBVCoFxqTJwegs8huDM9pX5uOxtetVMSX/DzJB6dQYczFDSMKuP
         0nvtA2qnccJQsgAPlE1IAc6DZuXXO6oOlYkaa3s9XTabjzfysVl8xz419KIb/N0AqdPz
         ZwbYoP4LB+0abJLIY3j56sLCv7LSkT4qNai7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J1UMbMc8OAj14RDhbE254NcvzwuTcA6/D0lnRvB23mQ=;
        b=c7zznByoSfrJyRV4XcSBOzujEfnnIxg8O7h64l70TlfeFV/GttudWg/VLcJM0lx4Np
         mZa3xxYK/FX3EFHESvfTHHg8OZj1VKzLMOexpUR6pejl6laukoRkaNRD/tijzqeVz4pV
         fQjlnzWrEwIOzJKU6vCgN5kYozl9odzrS19+z1FCEvLSOCVn7a1tO73UsbNv18iv6WlM
         787vEeBVIrK0To2vCrTEHo49BLjEilcO/KfWKHimIskl1VgyklSmPRk7XLAhONwZYSA9
         i5Ci4FpTvMbCQ98WskUShU/kb7ZFtMNGvnChq98pfk+iczVRe2V5DATOrkDg8qQdUMWe
         eYNQ==
X-Gm-Message-State: AOAM533B8IXdIFV5+NARMeY1rTbU86EB8G64dAZwwk6QZ5pBX5wpTtAM
        7xqXUqP6Z5+ZSyYRVQMeHrtNTGmNQY5Gnw==
X-Google-Smtp-Source: ABdhPJzKzdKynZRxRjGuzp/XgktCjPiFbdluYsSOvykrjhwIw87WQ6lJZhYXphxKWsSlxG0HxmOqDg==
X-Received: by 2002:a05:6638:381d:: with SMTP id i29mr10272799jav.29.1631908950588;
        Fri, 17 Sep 2021 13:02:30 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id r11sm4327011ila.17.2021.09.17.13.02.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 13:02:29 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id y18so13715560ioc.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 13:02:27 -0700 (PDT)
X-Received: by 2002:a02:ac01:: with SMTP id a1mr1270459jao.93.1631908947377;
 Fri, 17 Sep 2021 13:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <1631872087-24416-1-git-send-email-rajpat@codeaurora.org> <1631872087-24416-2-git-send-email-rajpat@codeaurora.org>
In-Reply-To: <1631872087-24416-2-git-send-email-rajpat@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Sep 2021 13:02:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X-7-OS0uDFDR+_AksgqLvTVCx0+Z5pbmNCCvqwBrvgBg@mail.gmail.com>
Message-ID: <CAD=FV=X-7-OS0uDFDR+_AksgqLvTVCx0+Z5pbmNCCvqwBrvgBg@mail.gmail.com>
Subject: Re: [PATCH V8 1/8] dt-bindings: spi: Add sc7280 support
To:     Rajesh Patil <rajpat@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        msavaliy@qti.qualcomm.com, satya priya <skakit@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 17, 2021 at 2:49 AM Rajesh Patil <rajpat@codeaurora.org> wrote:
>
> Add compatible for sc7280 SoC.
>
> Signed-off-by: Rajesh Patil <rajpat@codeaurora.org>
> ---
> Changes in V8:
>  - As per Doug's comments, added "qcom,sc7280-qspi" compatible
>
>  Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
> index ef5698f..31711fe 100644
> --- a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
> @@ -21,7 +21,10 @@ allOf:
>  properties:
>    compatible:
>      items:
> -      - const: qcom,sdm845-qspi
> +      - enum:
> +        - qcom,sdm845-qspi
> +        - qcom,sc7280-qspi

Other than the fact that the indentation is wrong (as Rob's bot
found), this looks good to me. Feel free to add my Reviewed-by when
you fix the indentation. In theory you could also be nice and add the
sc7180-qspi at the same time, I think.

-Doug
