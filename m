Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA49441F04
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 18:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhKARMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 13:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbhKARMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 13:12:42 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CEFC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 10:10:08 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id h2so19133638ili.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 10:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ipBE8NX/wVY+ROYSuRyteYW9jHXTysDyorv6dPtGYZA=;
        b=j80Lqh6xiJcsysn7NipdlN7PT8nZlBuhjJxm9fAPEq/nQRDBmvW7X546Fn3VlkJVDm
         XRzD6pS8QFiuK9VPsH/jGtwjdE3VG9wKT4FQMk2QV4yTmnfMz19cM33ow2Re5WL2hgO3
         mcr0FbkxvPOGeiIEDGdlKj8bEonkho30alFoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipBE8NX/wVY+ROYSuRyteYW9jHXTysDyorv6dPtGYZA=;
        b=y2JGevDYu2Ds/rNxS21z4+wkasYTsf5w6VgOf8HrJ0ngr6MfmoWVwfAhnStp1AqEtW
         5kfFvWp0ADVv44XgFoADQUKvavroLDcG5h8gdzx3Lgwo/6HFZyy1OuDhDd54xnA6g/ep
         5amALcG5Jv9izOw07WqdhpF4X1BILGHUyxKbTUW35DrrOuEI+NkTgh75TlHFBdExDn3P
         SKNS4HSpw91djh19aGUWl5BrpkVhkQRhOJWSk+xFkzPp/zb58CFQHu3EzCHDpKVfdAOO
         4Siynd6AyT3L0kERMUSaK4mDeudKv+ffwn0mLv0J+wO2WrkuXWYiJzryZ6QEc1Lx3lDu
         xc3Q==
X-Gm-Message-State: AOAM530CMDurTyC9Q+7zkcju21cIug6MGzCSNSL3jTfVj096NiG/YN5E
        FZ3kNUEn47HGmmgezKbpFKjplyxfGAs3+g==
X-Google-Smtp-Source: ABdhPJytYvqCX4/XRf4bTBpLqodx3CYdZtaEn42Jw8LTwOqHtrS+HxT3plhkrXeBZ05xtWF1El0i0A==
X-Received: by 2002:a05:6e02:1bc8:: with SMTP id x8mr19884615ilv.201.1635786608106;
        Mon, 01 Nov 2021 10:10:08 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id w2sm8147469iou.0.2021.11.01.10.10.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 10:10:07 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id s14so1864772ilv.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 10:10:07 -0700 (PDT)
X-Received: by 2002:a05:6e02:2189:: with SMTP id j9mr5015590ila.120.1635786607120;
 Mon, 01 Nov 2021 10:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211029152647.v3.1.Ie17e51ad3eb91d72826ce651ca2786534a360210@changeid>
 <20211029152647.v3.2.If23c83a786fc4d318a1986f43803f22b4b1d82cd@changeid>
In-Reply-To: <20211029152647.v3.2.If23c83a786fc4d318a1986f43803f22b4b1d82cd@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 1 Nov 2021 10:09:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xic56vn1n5jT9J=RU6qPTR3cpJ-kqGav08SrEu-8RZzg@mail.gmail.com>
Message-ID: <CAD=FV=Xic56vn1n5jT9J=RU6qPTR3cpJ-kqGav08SrEu-8RZzg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] arm64: dts: sc7180: Specify "data-lanes" for DSI
 host output
To:     Philip Chen <philipchen@chromium.org>
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

Hi,

On Fri, Oct 29, 2021 at 3:27 PM Philip Chen <philipchen@chromium.org> wrote:
>
> MSM DSI host driver actually parses "data-lanes" in DT and compare
> it with the number of DSI lanes the bridge driver sets for
> mipi_dsi_device. So we need to always specify "data-lanes" for the
> DSI host output. As of now, "data-lanes" is added to ti-sn65dsi86 dts
> fragment, but missing in parade-ps8640 dts fragment, which requires
> a fixup.
>
> Since we'll do 4-lane DSI regardless of which bridge chip is used,
> instead of adding "data-lanes" to parade-ps8640 dts fragment, let's
> just move "data-lanes" from the bridge dts to sc7180-trogdor.dtsi.
>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---
>
> (no changes since v1)
>
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi | 1 -
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi              | 4 ++++
>  2 files changed, 4 insertions(+), 1 deletion(-)

I think it's fine to take this change even if we also decide to fix
the driver as well.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
