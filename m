Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760C242FBAC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 21:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242387AbhJOTGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 15:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbhJOTGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 15:06:35 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3781C061762
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 12:04:28 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id q189so25075180ybq.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 12:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bgY2omHnre5+OPH/CJvDp8gAqE7sB0quUsr7gMFbHSg=;
        b=UUqrHd2Q604474wG7qEa98/EjkxA5vCNm01glKJRUM7mycR7JXIgQ/W69Y7+Xa9e6J
         9MADq90IGUCvBnDx6D4S7iuQFOIPsvz9DM6GLExmtqBgboTwxx7ifgmMGbI231VPzxSj
         /vSwLBIeBr59GFNYBHTLJLf4ojSZyWehpzs8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bgY2omHnre5+OPH/CJvDp8gAqE7sB0quUsr7gMFbHSg=;
        b=Ez6l6nC2KrVpAk8qwmFRVx3Tz8hlTA6zkBQX12BeFLGq0uvcYxXBPYXOmnr9d9BLxu
         FNHK/GXJMdEkrSn8VTNmmoM0EO5HRx1PGqDz8JXBgFBWnfZpTLPhuxrk2XFz5qiU6G8s
         uvcND5F30kVyRj4cR+av5dlxwoSRtRHqMOaO00EWoTHMngrNnixzX2ocagrMeyruu17l
         +FGFeWBIFLrVp1QJbAzgHZP+Lt2sBfdePfmzYvgZh0E89gasTEN7en2v2lGVkx4Y1G8P
         ZjEJRxOfwRnJu3oJwW9yRqIS5B6BJhwEJeEbjZ73zcMTrIjnqjtAf3buYTBej/UJpVhO
         SWYQ==
X-Gm-Message-State: AOAM533HonA34UZGhGlqYcHpA/WE1CSXRUTgyXtCtn1ZgyV4Bd6JEwqM
        +8ocEbLDD3RNZcOWpECTzN8+Z6rIlYn/p67KECNOMQ==
X-Google-Smtp-Source: ABdhPJz2ne2UsI4ZgxozIXcbqoVsbchRM4hvYQ2yQYBZBs9eA/D+MfJ1zJ/9hsDKbaZruStaxaTRoSNhgUrqXTFQwv0=
X-Received: by 2002:a25:7c07:: with SMTP id x7mr14980388ybc.217.1634324668227;
 Fri, 15 Oct 2021 12:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211008113839.v3.1.Ibada67e75d2982157e64164f1d11715d46cdc42c@changeid>
 <20211008113839.v3.2.I187502fa747bc01a1c624ccf20d985fdffe9c320@changeid> <CAD=FV=XsTb00Ax=AgrpAYurruiwZOVKZrYkphFfLLueSAio=rg@mail.gmail.com>
In-Reply-To: <CAD=FV=XsTb00Ax=AgrpAYurruiwZOVKZrYkphFfLLueSAio=rg@mail.gmail.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Fri, 15 Oct 2021 12:04:17 -0700
Message-ID: <CA+cxXhnhZ7kaDav1ykhM65ha5khCAEqvyymY8dCsRWLqnf0Lnw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: sc7180: Support Parade ps8640 edp bridge
To:     Doug Anderson <dianders@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Could you please take a look at this patch series?

On Fri, Oct 8, 2021 at 4:15 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Oct 8, 2021 at 11:39 AM Philip Chen <philipchen@chromium.org> wrote:
> >
> > Add a dts fragment file to support the sc7180 boards with the second
> > source edp bridge, Parade ps8640.
> >
> > Signed-off-by: Philip Chen <philipchen@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Set gpio32 active high
> > - Rename edp-bridge to bridge to align with ti-sn65 dts
> > - Remove the unused label 'aux_bus'
> >
> > Changes in v2:
> > - Add the definition of edp_brij_i2c and some other properties to
> >   ps8640 dts, making it match ti-sn65dsi86 dts better
> >
> >  .../qcom/sc7180-trogdor-parade-ps8640.dtsi    | 109 ++++++++++++++++++
> >  1 file changed, 109 insertions(+)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> I think these two are good to go as long as Bjorn doesn't mind having
> this dtsi file in the tree with no users yet. It looks nearly certain
> that some trogdor devices will ship with it.
>
> -Doug
