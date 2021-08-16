Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06123EDF76
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 23:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhHPVqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 17:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhHPVqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 17:46:53 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46436C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 14:46:21 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b7so15861112iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 14:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5MQaecMruMo90D+KAt7ofTuU0ZRK6FZBpAa7KmNoEuE=;
        b=BwZyjwUDzVNN1nePIhaSHaIy6fkGy8qZIefmUKq7c3URK6ED0dVpkUuJe3mE1kTeDE
         Ocwhh1VNn03xPFmqlYI+xe+7HjgL1TZLWTrf1JuU+vSUZrCGp2r1fXhoH8IMEnX6Mv/2
         pQGCdi3xIz735nPLv18zQqZWgQMNkRxVjmatU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5MQaecMruMo90D+KAt7ofTuU0ZRK6FZBpAa7KmNoEuE=;
        b=MHQuWlQ1Oc4I40rdGuR9LxWZLb9f17+eCDKQSoHQHUJL4xuZ886aOEz/4Bc+tAUscs
         QkUkUzxFbjJp90cecjxjPyj3oAjM+TFCDDtH5V5BiOEhVvF+G15BahHeHW71q0vJeHzo
         i6Kc80bWK7fiAqrbak7qUoFuFp6Ehj7l40/fStpQ32XLJnbN6V5i7+l50uhA0uCiyMeE
         NH83Uvm58m16hSieKnJs6R6ydKcw1E7w/C/KkaYJ1Qf4NKPxRuBNY4zou6L/O/mmq+rV
         hY9rD6RO5ED9Dvf/9yYdJHE/c8Mp5ydJtPb/XzxwnjpRUaJlJknxFeOc6Oj3a6K8IypS
         geSA==
X-Gm-Message-State: AOAM533l7BBYzf1nCTLU/9cgs0aY0lu2RLrsGI7tKByV2oNO8i/fmUAF
        p2sRbv/fBFmJp6bbAj8akwQQ4zavS0Qdig==
X-Google-Smtp-Source: ABdhPJx4pcNkmOkzcPEqoP2gOwX+j428xRv2oHFL8QPv85MKbaYXCFXe5PMGIeVIiTQ/+d8trnzdQg==
X-Received: by 2002:a02:2348:: with SMTP id u69mr642280jau.141.1629150380272;
        Mon, 16 Aug 2021 14:46:20 -0700 (PDT)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id j9sm65532iow.31.2021.08.16.14.46.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 14:46:19 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id u7so20054370ilk.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 14:46:19 -0700 (PDT)
X-Received: by 2002:a92:cf4a:: with SMTP id c10mr46909ilr.269.1629150378895;
 Mon, 16 Aug 2021 14:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210811224141.1110495-1-swboyd@chromium.org> <CAD=FV=XKrSfinnZjPPstY0jDX4cP7adAKtCcKFOo5q2=DH+d7w@mail.gmail.com>
In-Reply-To: <CAD=FV=XKrSfinnZjPPstY0jDX4cP7adAKtCcKFOo5q2=DH+d7w@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 16 Aug 2021 14:46:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WAso9gLe3+nG6N2cnOwTqQb7CDvHa1EzvF7mVhchqruw@mail.gmail.com>
Message-ID: <CAD=FV=WAso9gLe3+nG6N2cnOwTqQb7CDvHa1EzvF7mVhchqruw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7180-trogdor: Fix lpass dai link
 for HDMI
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Srinivasa Rao Mandadapu <srivasam@qti.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

On Wed, Aug 11, 2021 at 3:45 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Aug 11, 2021 at 3:41 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > This should be the dai for display port. Without this set properly we
> > fail to get audio routed through external displays on trogdor. It looks
> > like we picked up v4[1] of this patch when there was a v7[2]. The v7
> > patch still had the wrong sound-dai but at least we can fix all this up
> > and audio works.
> >
> > Cc: Srinivasa Rao Mandadapu <srivasam@qti.qualcomm.com>
> > Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Fixes: b22d313e1772 ("arm64: dts: qcom: sc7180-trogdor: Add lpass dai link for HDMI")
> > Link: https://lore.kernel.org/r/20210721080549.28822-3-srivasam@qti.qualcomm.com [1]
> > Link: https://lore.kernel.org/r/20210726120910.20335-3-srivasam@codeaurora.org [2]
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >
> > Changes from v1:
> >  - Drop sound-dai-cells
> >  - Replace hdmi-primary with hdmi
> >
> >  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
>
> I'm no audio expert, but this matches v7 except for the bugfix setting
> the ID for the `sound-dai` to be LPASS_DP_RX instead of 2, which
> matches downstream.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Since this is a "Fix" and it's my understanding that Fixes can be
landed / pull requests sent for them anytime (regardless of the fact
that it's currently -rc6) maybe it could still land without waiting
for the merge window to start and end?

-Doug
