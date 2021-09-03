Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29531400349
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 18:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349993AbhICQ3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 12:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349941AbhICQ3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:29:51 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A507C061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 09:28:51 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id r6so5744236ilt.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 09:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xeg98tsSU3FdTA5hOYvBjUfjJ4oW48qTu6E3gGWZ+1Q=;
        b=EQKZzP6ytA4s8CNgP50sY1pCXZMg1YhJhu090WN2KLkiVo4uZcjQNka9SyU4bcqgbZ
         crvzaLkDEMW0tFiRbTGFva1cUZ1N8Qp4v2CTZv1+kb/sUmvILyrCae8Sao6m2IMie5gQ
         axKI2f6TGSL/Rp1PHrIuRhlysRncAWXNctxA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xeg98tsSU3FdTA5hOYvBjUfjJ4oW48qTu6E3gGWZ+1Q=;
        b=Oo/XQwAystRNRESqIcZHYRU5FdZlepHC+5/XfSG8Cy4gRUFbEf6Nfn97A+Ldfc+fh8
         0yE+CzVPzGl7ckN3LTDqQzXk6l4vwol0aciTSn+qT3PVEmdyYdZUkLcrSPbhKTREsORZ
         gNe+CByxTOjpCFgLD6xYipSzmeIMhmoGIWXRcvVFIBNEk/Du/P94dQL5qz9JYu1ZtVIp
         V8L/2ZlaK9LF6wzs6p4X+2b4cF6WsN/iF08joMFu5fO8WXK8nLHpISZhuj3cj8afA1HE
         3vyURvwd4mLrv401kWOcDl4fZWT8ZFON5++sZlR+95R2/Ab5yj7HntlpKYtIrZJD/vTR
         J+3w==
X-Gm-Message-State: AOAM531E9wPoOzlYInXM8Z6A1OCnmmaRNPkMzJXcMUn4T3lRAEMZUe2L
        QIJEyL08O1TRJMraMN5myqFRtOCCtj3JBA==
X-Google-Smtp-Source: ABdhPJw1OM+i0NgtMroqmcHRiQSNr99rEiEmJbXYH79gjm5QJCUIHbDP5SGqNtM5duwVardMrAeKFA==
X-Received: by 2002:a92:7108:: with SMTP id m8mr3166937ilc.238.1630686530689;
        Fri, 03 Sep 2021 09:28:50 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id u17sm2707519iln.81.2021.09.03.09.28.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 09:28:49 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id h29so5777314ila.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 09:28:48 -0700 (PDT)
X-Received: by 2002:a92:cb52:: with SMTP id f18mr3259436ilq.120.1630686528519;
 Fri, 03 Sep 2021 09:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <1630643340-10373-1-git-send-email-rajpat@codeaurora.org> <1630643340-10373-2-git-send-email-rajpat@codeaurora.org>
In-Reply-To: <1630643340-10373-2-git-send-email-rajpat@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 3 Sep 2021 09:28:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XjjNx5UzgiKvONw+n0waGqgF+g7Qf4su9dvPQRS7uCrw@mail.gmail.com>
Message-ID: <CAD=FV=XjjNx5UzgiKvONw+n0waGqgF+g7Qf4su9dvPQRS7uCrw@mail.gmail.com>
Subject: Re: [PATCH V7 1/7] arm64: dts: sc7280: Add QSPI node
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
        Matthias Kaehlcke <mka@chromium.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 2, 2021 at 9:29 PM Rajesh Patil <rajpat@codeaurora.org> wrote:
>
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -415,6 +415,25 @@
>                 method = "smc";
>         };
>
> +       qspi_opp_table: qspi-opp-table {
> +               compatible = "operating-points-v2";
> +
> +               opp-75000000 {
> +                       opp-hz = /bits/ 64 <75000000>;
> +                       required-opps = <&rpmhpd_opp_low_svs>;
> +               };
> +
> +               opp-150000000 {
> +                       opp-hz = /bits/ 64 <150000000>;
> +                       required-opps = <&rpmhpd_opp_svs>;
> +               };
> +

Any chance you could add a 200 MHz OPP point? It seems plausible that
we might want to run the Quad SPI bus at 50 MHz and this OPP needs to
be 4x that, so 200 MHz. ...or does it magically handle that case by
one of the other OPPs?

> +               opp-300000000 {
> +                       opp-hz = /bits/ 64 <300000000>;
> +                       required-opps = <&rpmhpd_opp_nom>;
> +               };
> +       };
> +
>         soc: soc@0 {
>                 #address-cells = <2>;
>                 #size-cells = <2>;
> @@ -1318,6 +1337,23 @@
>                         };
>                 };
>
> +               qspi: spi@88dc000 {
> +                       compatible = "qcom,qspi-v1";

The above compatible should be:

compatible = "qcom,sdm7280-qspi", "qcom,qspi-v1";

...and you should fix the devicetree bindings to handle that. You
should also fix sc7180.

Technically the "qcom,sdm7280-qspi" isn't really needed to make
anything work today but having it is encouraged so that if we need to
deal with a quirk in the future we can easily do it. Also note that
your current dts will cause a bindings error because the current
bindings _require_ you to have two compatible strings.
