Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741F73496A0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCYQSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhCYQSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:18:11 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F002C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 09:18:10 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id w8so2872983ybt.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 09:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQUSMG2MYvr7z2lGID3UbwL8eVjOA95JzM6A/R4Iu1E=;
        b=IRAPbpwUGbuUSp2HYxkhC7c7pPoKfFtl7jbJslD/5YuRK/PXAtdEHHvefviHJJNJU8
         /GNZ4Jvf/qQ0BFs1R+xzmZfjtVA6o+81OWemBKmiDSNjAWnip31eC5PgkpPyVCB0uwWR
         OBeVkR2CBo6VbKoDIeLGSVzeL9PSH9zXyt/Uxj6OAPQAeJxGnVVv0hTRgBhlWAGkhKgv
         oxHvU/MptLG2T5zdSLxoGRgVCwyjfl7VGTEv2bHv6Nqx9PCqD08DDB14ZIDdxPsoUGxA
         nCxZznnptNnoDeEZwYSwC/yZT0w0BWchvcZpQ8ZhPQqWoQCM9X8XofRfO7wWT+wvnbR9
         AdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQUSMG2MYvr7z2lGID3UbwL8eVjOA95JzM6A/R4Iu1E=;
        b=sEE652MOindJ7DxFoibEUvNbcOxIaYekRj1Hk+6BFR4zssU2TLaNmfrUAMwcYuZMB3
         xsIfAp+BtSJEjuZMWmxDFJTqAGhUWdHnM9LdMbmlzdxDUGaEuSvT8ZTS0b3iXX1plQ+K
         G81Z+zJOiWIwGJ2X2pC6Ocx3sd/myntuQ/lRMJ+AAoTMz8IbZ5zh9vwSWwgfZTl7/L7j
         7muqrTZd3VdX6i0jbDO0dsOZ/dqukAASrJJAJnlCq4uop6terZbqbOwi+THW32ff5uAy
         xOvQsaMbI91tFIUwp5CZmxQYAi9wvvLuO+SlF9qYq+EPtXHya8Rpx0ZcDHuuLnSo3P25
         9S6g==
X-Gm-Message-State: AOAM530ZMAtiD+84CQXHNvSnoPL09Y4txzQKEk0I3OwXtoGG2rgL6YP+
        AuE1RxuGf8143GVd04g9gLkf1DTJoN17/lST3Xy9xA==
X-Google-Smtp-Source: ABdhPJyCI41mEQVSMR5OzYWKNCakBrYDxOD4TjekSAjXtIhStEvQQQrTQE12lRIasP2p34vK39aXj/x47+APczR7xLE=
X-Received: by 2002:a5b:54a:: with SMTP id r10mr12095885ybp.476.1616689089164;
 Thu, 25 Mar 2021 09:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <1616264220-25825-1-git-send-email-sbhanu@codeaurora.org>
 <CAD=FV=WLZCSd6D5VFyD+1KBp5n1qyszER2EVaEMwYjQfPSSDnA@mail.gmail.com> <b77f207b-2d90-3c8b-857f-625bd3867ed1@codeaurora.org>
In-Reply-To: <b77f207b-2d90-3c8b-857f-625bd3867ed1@codeaurora.org>
From:   Doug Anderson <dianders@google.com>
Date:   Thu, 25 Mar 2021 09:17:57 -0700
Message-ID: <CAD=FV=ULXU46C4jbx4nJEOuK4+wZmknoD=mZ_3=c0drfa32N=w@mail.gmail.com>
Subject: Re: [PATCH V2] arm64: dts: qcom: sc7280: Add nodes for eMMC and SD card
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        sartgarg@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>, cang@codeaurora.org,
        pragalla@codeaurora.org, nitirawa@codeaurora.org,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 24, 2021 at 8:59 PM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> >> +                       clocks = <&gcc GCC_SDCC1_APPS_CLK>,
> >> +                                       <&gcc GCC_SDCC1_AHB_CLK>,
> >> +                                       <&rpmhcc RPMH_CXO_CLK>;
> >> +                       clock-names = "core", "iface", "xo";
> > I'm curious: why is the "xo" clock needed here but not for sc7180?
> Actually its needed even for sc7180. We are making use of this clock in
> msm_init_cm_dll()
> The default PoR value is also same as calculated value for
> HS200/HS400/SDR104 modes.
> But just not to rely on default register values we need this entry.

Can you post a patch for sc7180?


> >> +                       bus-width = <4>;
> >> +
> >> +                       no-mmc;
> >> +                       no-sdio;
> > Similar question to above: why exactly would mmc not work? Are you
> > saying that if someone hooked this up to a full sized SD card slot and
> > placed an MMC card into the slot that it wouldn't work? Similar
> > question about SDIO. If someone placed an external SDIO card into your
> > slot, would it not work?
> >
> As mentioned above, its just to optimize SDcard scan time a little.

OK. ...but while the eMMC one can make sense since the eMMC is
soldered down (but in the board dts file, not in the SoC dtsi file) I
think you should just remove these for SD card because:

1. Even if only a uSD slot is exposed it's still _possible_ for
someone to insert a card that uses MMC or SDIO signaling. If nothing
else I have a (probably non-compliant) adapter that plugs into a uSD
slot and provides a full sided SD slot. I could plug an MMC card or
SDIO card in.

2. Presumably the SD card scan time optimization is tiny.


-Doug
