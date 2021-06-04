Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4039F39C30A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhFDV45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:56:57 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:34533 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDV44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:56:56 -0400
Received: by mail-ot1-f47.google.com with SMTP id v27-20020a056830091bb02903cd67d40070so7412960ott.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 14:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=3DYU5t9nuzfAYYmhd6HSphs3gWfN50+sEv5DeMPpACI=;
        b=D5ZewtXrnc2df+El9ZmfGqxur9CwKbv7QtTt11dEm496Zbj/vpTj51UtzaxzEAXBr6
         L/eHi2e9aQCgj07t/dd+/GotaJPivYRZhFgcCJu2sGoi+af6wI6H/qjcliSmLtHLr3MF
         rkfGTjIHp7q8uBfn3aCI/FAuKpt6Yx53rawIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=3DYU5t9nuzfAYYmhd6HSphs3gWfN50+sEv5DeMPpACI=;
        b=VK/Xr6VTgutf6twZD/G9PLOtKgg2/nudvwQDp5AVWmHNfE8P7dvRH+QYGY3ll8OMbt
         1yEfUb5arEsPeUoTIGKhVFMp47j388b29/tDjpy2Gf63Mb3YfIrMOUYMU+nkE/bfn9/P
         11t0gDFH3lmiOf2cCyBs9Y9Yql7/g/gnCAmqWOMGHXJYFnaVzJVHoxfhPrPSgt0YV58X
         t6mQvpEqPJOQTZrsi68D7LCm7excbMYUqCLy9Ny/3o5g9vyGaiYaAmS6nw0EOSo5tdi0
         bCp+UEbafx1ueJXilOkTkWDfQUi589uMK68sf+qn7DNEqZiXFftMuUYQWRBsY36numFj
         e0uw==
X-Gm-Message-State: AOAM532QVaXboVqpKlyhEDybHuO9knDE+VqJiiHiWf1M5kD+PebKC7By
        zWz/obPvvva9iMDlzjJDMIUV6QZxW+sWIwgJyP+oLQ==
X-Google-Smtp-Source: ABdhPJzIN2HfxqmojBCJq27yYqlMih2sw4bfo6I3KvfxVP/kroq1o9U9zXFAQ7Q5SdEXUbDSz1CAhW5dVGm8SShsQzY=
X-Received: by 2002:a05:6830:3154:: with SMTP id c20mr5439195ots.233.1622843635345;
 Fri, 04 Jun 2021 14:53:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Jun 2021 21:53:54 +0000
MIME-Version: 1.0
In-Reply-To: <YLhCGC/qgP6ESNl7@yoga>
References: <1621596371-26482-1-git-send-email-mkshah@codeaurora.org>
 <1621596371-26482-4-git-send-email-mkshah@codeaurora.org> <CAE-0n53ySKwDwzRYFYjnQnqVAujVrkik2U-PeCuS61xQU-hbWA@mail.gmail.com>
 <YLUjbwFSJOSWS0IV@builder.lan> <CAE-0n53hdd1tEmYwTL0CNi=S6CUxRhWnkJz-KoTj2UnedNKXmg@mail.gmail.com>
 <YLhCGC/qgP6ESNl7@yoga>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 4 Jun 2021 21:53:54 +0000
Message-ID: <CAE-0n511_GHcyPDSeDaf5QSqVQqyHOqxJCGaSWNr=x9uotegLg@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] arm64: dts: qcom: sc7180: Enable SoC sleep stats
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Maulik Shah <mkshah@codeaurora.org>, evgreen@chromium.org,
        mka@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        dianders@chromium.org, linux@roeck-us.net, rnayak@codeaurora.org,
        lsrao@codeaurora.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-06-02 19:44:40)
> On Wed 02 Jun 19:26 CDT 2021, Stephen Boyd wrote:
>
> > Quoting Bjorn Andersson (2021-05-31 10:57:03)
> > > On Wed 26 May 18:30 CDT 2021, Stephen Boyd wrote:
> > >
> > > > Quoting Maulik Shah (2021-05-21 04:26:09)
> > > > > @@ -3223,6 +3223,11 @@
> > > > >                         #power-domain-cells = <1>;
> > > > >                 };
> > > > >
> > > > > +               rpmh-sleep-stats@c3f0000 {
> > > > > +                       compatible = "qcom,rpmh-sleep-stats";
> > > > > +                       reg = <0 0x0c3f0000 0 0x400>;
> > > > > +               };
> > > > > +
> > > >
> > > > Does this need to be in DT? Can the sc7180-aoss-qmp driver use the
> > > > aux-bus and stick the sleep stats device on there?
> > > >
> > >
> > > The AOSS memory space has N chunks of "message ram", one is used for the
> > > QMP protocol (presumably the APSS specific one), a different one is used
> > > for the sleep stats.
> > >
> > > I presume we could have come up with a binding for the entire AOSS/AOP
> > > and then describe (either implicit or explicitly) the QMP and
> > > debug-stats under that.
> > >
> > > But we'd also have to come up with the same container-device for the RPM
> > > case.
> >
> > Because the rpm node doesn't include this region of memory today? I
> > still fail to see why we're changing the existing binding and adding a
> > DT node for this new region that is basically a debug feature.
>
> We're not changing the binding, the memory region for the "AOSS QMP"
> thing was never larger than 0x400.
>
> 0x100000 is the size of all the AOSS "msg_ram" regions. We don't have
> this whole thing described in a binding and we don't have an
> implementation for the whole thing.
>
> If we're going for that we'd need to extend the binding to indicate
> which of the msg_ram regions are used for APSS QMP and for debug stats
> on particular platform (either by compatible, explicit properties or as
> some subnodes).

Fair enough. At the least, can we change the name of the node then to
'sram' or 'ram'? The 'rpmh-sleep-stats' node name is nonsense.

>
>
> That said, as I looked into my other objection, for the RPM
> (non-hardened) case it seems that we're actually describing the RPM
> region. So there it would make sense to describe it as such in DT - but
> we don't have any other code (that I'm aware of) that would implement
> the "qcom,<platform>-rpm".
>

I only half parsed this part. Are you saying that because we don't have
a driver for qcom,<platform>-rpm we shouldn't keep it all within the rpm
node?
