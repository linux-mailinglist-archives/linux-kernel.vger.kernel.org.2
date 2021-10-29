Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8463243F75F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 08:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhJ2Glr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 02:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhJ2Gl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 02:41:28 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E21EC061767
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 23:39:00 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id o4so11979953oia.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 23:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=KV7XOEXb1RIfBt4WHiGPrT2FFPH43MntF1OOVLSp5Go=;
        b=LrhtdRayKEjccI2+9x3/+JijppVNU7TeHrgJ6xNsYtw2/psP28cRXcIaCr0EVDoNd4
         2YNcbu9zT6JTNx1UrzPtNmOhWraQ7N7m5V1ehAg3oAplLDPFiYWfVojhmSJBlMNslaaW
         f6+iLI3v0kQKXOadDYlpfLO/bOZk8GFdKG+ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=KV7XOEXb1RIfBt4WHiGPrT2FFPH43MntF1OOVLSp5Go=;
        b=wrzANfHqCqoL1vwTcqtimolBI466/EkdYaSnt2DQAkO2Gbr5NDFavxCsSmKBh3sOlc
         4l6Q+G9oxmDYitM0kZBQUZJWPQ5nJ1ugTm32JG7yPHKzXG2HzCaDZZQbSkNX4Kk9Z1Vj
         tShx0kSpdhqnmMOlmZLsz3eeE/NhxMDcHo3I5++8hyKkYRFSzWwbHptY0laDPe/NoxPR
         ANo9TcYzXGOIUQ1UquRQRucw5uRLw/gxLiME8mS5Yq0tqEIj6frhw40DNsnabbzDDH5p
         3QGXZjI9btwhd11perF3dSQxLkXQu2I8SRJSN2DZjCQPh6AdnAh6fProWGXsxmayF5mW
         CY/Q==
X-Gm-Message-State: AOAM531SheRYYqwpx7TobMqmh6R0+LyHEHFWanX00469qJ0kdpAqO2Of
        05P9Hed2lGNAb8EyKg8DTMSUvRXlMRGG/iCARdMeMnIBjcA=
X-Google-Smtp-Source: ABdhPJxQXyxkgAXORFmXL5dl+M9QXG5g9npSoDDd9GA9g7yu5BIliAVvrA3Mp8wuWTPuqhQbVxXEYENB8Kff6Two/I4=
X-Received: by 2002:a05:6808:2128:: with SMTP id r40mr4885842oiw.164.1635489539883;
 Thu, 28 Oct 2021 23:38:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 Oct 2021 23:38:59 -0700
MIME-Version: 1.0
In-Reply-To: <20211028174015.v2.3.If7aaa8e36f1269acae5488035bd62ce543756bf8@changeid>
References: <20211028174015.v2.1.Ie17e51ad3eb91d72826ce651ca2786534a360210@changeid>
 <20211028174015.v2.3.If7aaa8e36f1269acae5488035bd62ce543756bf8@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 28 Oct 2021 23:38:59 -0700
Message-ID: <CAE-0n51qNoFtDNxbCQgxKDQfZ1_jmDChV=-+LHfQR4F7Kjss0Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: sc7180: Support Homestar rev4
To:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>
Cc:     dianders@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philip Chen (2021-10-28 17:41:17)
> Support Homestar rev4 board where Parade ps8640 is added as the
> second source edp bridge.
>
> Support different edp bridge chips in different board revisions,
> now we move the #incldue line of the edp bridge dts fragment (e.g.
> sc7180-trogdor-ti-sn65dsi86.dtsi) from "sc7180-trogdor-homestar.dtsi"
> to per-board-rev dts files.
>
> Since the edp bridge dts fragment overrides 'dsi0_out', which is
> defined in "sc7180.dtsi", move the #incldue line of "sc7180.dtsi" from
> "sc7180-trogdor-homestar.dtsi" to per-board-rev dts files too, before
> the #include line of the edp bridge dts fragment.
>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
