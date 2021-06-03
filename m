Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3D139ABDC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 22:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhFCUfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 16:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFCUfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 16:35:07 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639F1C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 13:33:22 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id g12so3863835qvx.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 13:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CWdL8xo0vHpWIgIBdECu+RNiDuRV629s7OGWjc46l1Q=;
        b=n6a/oJMr+5W2Mhz4wGcI8n6C0FC8XTzSB7bxg187Zmsnm//6MWq6vCPwEl+T/+TZHT
         EyA1fF4K1YQ73atxpYKYtS8RIeL0WKUB7CLjXPNYYz0AqHQAyCAysYSfzoXWit/v9R04
         td8OfK6skei2EiDN76u0iJqFG+XzJGVsUNvvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CWdL8xo0vHpWIgIBdECu+RNiDuRV629s7OGWjc46l1Q=;
        b=PaWlFfAvtPdWhImGImVbTSl6t1XP2l8wrPcvyt5xYKEnkGD/ERGUElRSA7nWDEmTgl
         b3QakleAZjdgcEPE2ki3bCZ41v7tY4JgYcTUMxFbxmGeq7Zcf+uJphfWHu7TculYs+Bm
         ToBjpKNsgXGZCzKMOcs8MRZWoXL9uNl3CyiWU3OQokh/WGEI2DtmLpjzANt8E43GjlWN
         FrhZMIsmTYq56MOetrARBqvoof4x7tLNAbK3N5lVK3UVESkePDLIl2pQ1qxu9Z5++HQQ
         MJvN7CHrFv0nuoRhtoZGne9/lmxdx90GdfIVqcznt3Dyr1Ui4yV406WmDQdskh57+6gd
         zRug==
X-Gm-Message-State: AOAM531Pg1iNQaE7oBT46gMQyIdfnz4yz6UcMTMpEqDdWh31qHgA+NtB
        ZbrGFRmNO8XCqKBei/qIxj/Im+aFlNXEZw==
X-Google-Smtp-Source: ABdhPJxCUe/MD839rTL6h86yyaJOO+OBLmfoFYg93FBhLYVrxRzTGuOtwSCpNuqpzoBPcYyPKVjWWw==
X-Received: by 2002:ad4:5bc7:: with SMTP id t7mr1161180qvt.30.1622752401412;
        Thu, 03 Jun 2021 13:33:21 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id d18sm2166661qty.67.2021.06.03.13.33.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 13:33:20 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id x6so10594944ybl.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 13:33:20 -0700 (PDT)
X-Received: by 2002:a25:80d4:: with SMTP id c20mr424281ybm.345.1622752399765;
 Thu, 03 Jun 2021 13:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210602191338.1995827-1-sujitka@chromium.org> <20210602121313.v3.2.I52f30ddfe62041b7e6c3c362f0ad8f695ac28224@changeid>
In-Reply-To: <20210602121313.v3.2.I52f30ddfe62041b7e6c3c362f0ad8f695ac28224@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Jun 2021 13:33:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WzgvkT-F-LoDHJXsRamHH2g0GVUzoU4Qe8wAc4Y_L2Dg@mail.gmail.com>
Message-ID: <CAD=FV=WzgvkT-F-LoDHJXsRamHH2g0GVUzoU4Qe8wAc4Y_L2Dg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sc7180: SD-card GPIO pin set
 bias-pull up
To:     Sujit Kautkar <sujitka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 2, 2021 at 12:14 PM Sujit Kautkar <sujitka@chromium.org> wrote:
>
> Some SC7180 based board do not have external pull-up for cd-gpio.

nit: s/board/boards

Presumably Bjorn could fix this when he applies the patch. I wouldn't
re-post just for this fix unless Bjorn asks you to.


> Set this pin to internal pull-up for sleep config to avoid frequent
> regulator toggle events.
>
> Signed-off-by: Sujit Kautkar <sujitka@chromium.org>
> ---
>
> Changes in v3:
> - remove 'trogdor' from commit message
> - move reference patch from commit message
>
> Changes in v2:
> - added pull-up for IDP
>
> This change is with reference to Qualcomm's DT change posted at:
> https://patchwork.kernel.org/patch/11675347/
>
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts      | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

FYI: I had my Reviewed-by tag on v2. While you did make changes
between v2 and v3, in this case I don't think the changes were
significant enough to warrant removing my Reviewed-by tag and I would
have been happy if you'd kept it.

In general, if you ever have questions about whether you should keep
someone's reviewed tag, it never hurts to mention your logic "after
the cut" (I think you use patman so this would be "Commit-notes:").
For instance, you could say this if you removed Reviewed-by tags:

I totally recombobulated the frobnication logic in v3 and removed
previous Reviewed-by tags. Hopefully reviewers can re-add if they
still think the patch is good.

...or, you could say this if you kept them but you weren't totally
sure it was OK:

Even though every single line in the v3 patch changed from v2, it's
only because I fixed a stoopid spelling Mistake. Thus, I kept previous
Reviewed-by tags. Please yell if you object. Who knew that the only
acceptable spelling of the English word "stupid" in kerneldoc comments
was written as "stoopid". Live and learn.

:-)

In any case, here's my Reviewed-by tag again. I also agree that
Bjorn's comments made sense and were good to fix...

Reviewed-by: Douglas Anderson <dianders@chromium.org>
