Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90DF39C3C0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 01:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhFDXOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 19:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhFDXOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 19:14:07 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D32C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 16:12:12 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id l17so4122400qtq.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 16:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vXmDc2pLbpX9lgKwc2VxPAgHsvXZdqTU2+0uHS8Qm20=;
        b=Q6hzRsvkNOq2IfRMhqfR5Q6fFPfTbJEeWjktfJe4ZqJlNs/8W4nzSxfmscedh4TRYY
         R2vFGv+LhNOQoUiKRLnC5K/7WFJzqWvRgJ+lZRYkL9+EN2R4ETo5oXfZJWWUlCEq9Hni
         ob8YX8UBR5vckySVcQH/IIZIikAnt7KgBgCg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vXmDc2pLbpX9lgKwc2VxPAgHsvXZdqTU2+0uHS8Qm20=;
        b=q2BErjrIG+eUEJ9NJ2Ll18FD0wKRtXNrHRACZwRUp9dTYXI2PxVaDlOa5Y32qWPbaR
         Vv+t38LBP8mSyxNr20fnzgu8dtPC9MV59EA9RxvBcnMPSrozFQ7pvy4UuWsMm3bqJEAl
         +Oa63Jg3b+L5zQzOHN0vdjeuMOgk00C3OBX136e/e+ApUWAB3gEXGqC51H6MvLqgLD4M
         tHaSNlypKGAXpROcONmLagQsDHl9lJ6xco+vDqqdfQ1Qg12ib025dknxCZek2bZwxqCG
         MbyW4xgB48u/lUpY4h45jH5Fr+UpzTWoqVY4x1abC5XcRl+LF/iD9SV5pzEzGB0BpyjA
         YFNg==
X-Gm-Message-State: AOAM533QLRqA8t8tY4AjHb79CubVVjuHU/VybOQnL5CHXMBxhHnpim3F
        x9mtqjusG4hIPhpWykEJmKn3X9MLPLXLbA==
X-Google-Smtp-Source: ABdhPJy166hPfYa+Pb2nDJFHx54xClQA65/h+53bW4My86QGA7HOjYrkVjypY+V9kJcLkyzC5yZrRA==
X-Received: by 2002:ac8:6b92:: with SMTP id z18mr6836310qts.26.1622848331339;
        Fri, 04 Jun 2021 16:12:11 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id c7sm4324299qtd.25.2021.06.04.16.12.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 16:12:10 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id y2so15833573ybq.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 16:12:10 -0700 (PDT)
X-Received: by 2002:a25:8082:: with SMTP id n2mr8366030ybk.79.1622848329667;
 Fri, 04 Jun 2021 16:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210603081215.v2.1.Id4510e9e4baaa3f6c9fdd5cdf4d8606e63c262e3@changeid>
In-Reply-To: <20210603081215.v2.1.Id4510e9e4baaa3f6c9fdd5cdf4d8606e63c262e3@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 4 Jun 2021 16:11:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V9tczBEnT6zZq1UA=E1x8jyBoiEAt6yJv5R7j-mpOczg@mail.gmail.com>
Message-ID: <CAD=FV=V9tczBEnT6zZq1UA=E1x8jyBoiEAt6yJv5R7j-mpOczg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: pm6150: Add thermal zone for PMIC
 on-die temperature
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 3, 2021 at 8:12 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Add a thermal zone for the pm6150 on-die temperature. The system should
> try to shut down orderly when the temperature reaches the critical trip
> point at 115=C2=B0C, otherwise the PMIC will perform a HW power off at 14=
5=C2=B0C.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
> Changes in v2:
> - remove 'pm6150-' prefix from critical trip point
> - updated commit message
>
>  arch/arm64/boot/dts/qcom/pm6150.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
