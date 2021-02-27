Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA56326ADE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 01:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhB0A4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 19:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhB0A4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 19:56:31 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672CCC061756
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 16:55:51 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id t1so4412847qvj.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 16:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bywHDhST5zNkzuXBnTBeQymmsekGTUrywljUCs2Oamc=;
        b=Rw4YISFFwe+LjUxCjTBgDRr2aGPIpxGGoRRgxoluknggQH5CORuC3Nu4O7iVH0GPD/
         DowbrVCFxvJ6JFLhXi0fTaN6TzQ+MPjZ9qaEHXqnBhZwqFK5BwPNOkqyL7DXXXS6f5t0
         srKF4tP15iLNeLUHkCgJwc3lIc62IHWMIpFhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bywHDhST5zNkzuXBnTBeQymmsekGTUrywljUCs2Oamc=;
        b=ML40y5fZ/zgk+4LGjBLdWBVw0T/8UqdeBjXCBDVeJ3r9Yi9gtrYWfXXw92BTlbegX0
         aNMq+yQ7v/zuuEOaARiq5B2t4c/BulQeuAmOI372g4kogHRtQmodt72MvYxLDlv8eW6A
         jO5oW+riWQIi9k0edrATKy/4S77ZlNz5s47uV8LCCo3rag3cVGebwzvkrKVwnL18o+mp
         K5QAZte+c5l3cxVL5JXp2m4ALmesUvQSGrT1VOo5IDiHMUqnBuvBYeb6LRnILNSkXck+
         9Kv9D8c4Gd+MPT8O31/kRqboRBWU8n08aUeEayirHxkDN8DK3HGI8OTRos4Vu+Di2wMR
         Zc0A==
X-Gm-Message-State: AOAM532NRJrlhZJu/CQO6adQIhhmTM0NNDozIk/yhWr2Ujme1pc5MCmO
        dQj7fq7viiRRDxGHaEIVaoVLZbDQ9DMiqw==
X-Google-Smtp-Source: ABdhPJyIQrzUEnNTFU4cWBjIcCi+aiMNCOQ9B8Lt7DWQUn1dCl9Mgiw2+9BgEReYiGRaTJGYWsoziQ==
X-Received: by 2002:a0c:bdaf:: with SMTP id n47mr2890196qvg.48.1614387350371;
        Fri, 26 Feb 2021 16:55:50 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id e15sm6830155qti.79.2021.02.26.16.55.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 16:55:49 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id n195so10689048ybg.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 16:55:49 -0800 (PST)
X-Received: by 2002:a5b:84f:: with SMTP id v15mr7682859ybq.79.1614387349119;
 Fri, 26 Feb 2021 16:55:49 -0800 (PST)
MIME-Version: 1.0
References: <20210225221310.1939599-1-dianders@chromium.org>
 <20210225141022.13.I3d1f5f8a3bf31e8014229df0d4cfdff20e9cc90f@changeid> <161436510419.1254594.15131518424468767659@swboyd.mtv.corp.google.com>
In-Reply-To: <161436510419.1254594.15131518424468767659@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 26 Feb 2021 16:55:37 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VY3V=8ii+E_Yva3i-HngKwFj9u8W_6pkLe-c2gG0Oz3A@mail.gmail.com>
Message-ID: <CAD=FV=VY3V=8ii+E_Yva3i-HngKwFj9u8W_6pkLe-c2gG0Oz3A@mail.gmail.com>
Subject: Re: [PATCH 13/13] arm64: dts: qcom: Add sc7180-lazor-coachz skus
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 26, 2021 at 10:45 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Douglas Anderson (2021-02-25 14:13:10)
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> > new file mode 100644
> > index 000000000000..5def9953d82b
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> > @@ -0,0 +1,249 @@
> [...]
> > +
> > +/*
> > + * There's no SAR sensor, so i2c5 is re-purposed.  We leave the
> > + * proximity@28 node under i2c5 (from trogdor.dtsi) since it's "disabled"
> > + * and doesn't hurt.
> > + */
> > +i2c_wlc: &i2c5 {
> > +       /* Currently not connected to anything; see b/168652326 */
> > +};
>
> Can we remove this? As far as I know this will always be this way and
> thus doesn't provide anything meaningful to leave this bug comment here
> that doesn't work for people.

Yeah, that sounds good.  We just want to delete this whole comment and the node.

That seems like enough reason to repost the series.  I'll plan to do
it early next week.  Of course, I wouldn't object to any of these
things:
* This patch landing and having the node and I'll do a follow-up patch
to remove it.
* Bjorn removing the comment and node as he applies.

-Doug
