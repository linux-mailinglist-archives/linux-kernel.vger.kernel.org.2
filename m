Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F54F43A4A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 22:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbhJYU2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 16:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbhJYU2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:28:06 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6821C04CCA2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:17:01 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id t4so17226379oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=sFv6oulnfVWm3KV24cqy4zkMNUKjR06XXY8InDqsw00=;
        b=QDiai+q8Lqf5LMBLx2DhWGQnvq0RMrH2tHpBEgbx3rXXJU1etaPCLUki3NvMOiiWf8
         t/1GJIn2IejrRZjvkeRoV8LAE3d9Ps01FqQmrkk6U7FEf8+OVU2HXp50V9ve+WZ9Tyf1
         1JunLoHzZAAYHRpEGHajeJ3/3EhrykIaRZuIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=sFv6oulnfVWm3KV24cqy4zkMNUKjR06XXY8InDqsw00=;
        b=DmQgbpHsBjV5+OaLNijVBCDvAyx+V5ijC0+vkW01tA8M9YHnz9U1S/hMXLZiOGG+jV
         45GJF300qxlCJ3UWcvyd0hBx14J0P8WbpxhVSxrnmjjlzHX56C2HL+IXSWwDbQGHL3YY
         aEIbTlyrBoznGWJebVAWsVJppKn7AKRn4nfI9amCE2piwW5khwp0ChLTKtqWfJBateID
         W2WKNUKH4GsUmgf1W5qOWmczq83oTqNVA8+1c0sbUYHQu0UOiX/g9XDlCy+JCgWInEeh
         GXqFzuh5Vo3zx/h6DiGui6WZNAOHNr4k28EVDtpA8X+ALMJAy3DRMVVJOk2f5s8ng4ri
         /wMg==
X-Gm-Message-State: AOAM530Gyr5M454oR/Wv5tlwq9LJeATW87XkccCPciBgHtkikOexaB+r
        hjH8Vv8g3g0RHVbkHVI8JCULu5N9ITpbWjj+8kmYtA==
X-Google-Smtp-Source: ABdhPJwhdypNNNtSLateKcvC+lx++2bCS+2MH4BP5EkkJROEF59u9EHq9c5I6//07zar4ce5AtumC4etyH/4t4KQ/Xc=
X-Received: by 2002:a05:6808:1d9:: with SMTP id x25mr12912230oic.64.1635193021348;
 Mon, 25 Oct 2021 13:17:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 Oct 2021 13:17:00 -0700
MIME-Version: 1.0
In-Reply-To: <YXcBK7zqny0s4gd4@ripper>
References: <1635152851-23660-1-git-send-email-quic_c_sanm@quicinc.com>
 <1635152851-23660-2-git-send-email-quic_c_sanm@quicinc.com> <YXcBK7zqny0s4gd4@ripper>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 25 Oct 2021 13:17:00 -0700
Message-ID: <CAE-0n51k8TycXjEkH7rHYo0j7cYbKJOnOn1keVhx2yyTcBNnvg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: usb: qcom,dwc3: Add multi-pd bindings
 for dwc3 qcom
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-10-25 12:10:35)
> On Mon 25 Oct 02:07 PDT 2021, Sandeep Maheswaram wrote:
>
> > Add multi pd bindings to set performance state for cx domain
> > to maintain minimum corner voltage for USB clocks.
> >
> > Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > ---
> > v2:
> > Make cx domain mandatory.
> >
> >  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > index 2bdaba0..fd595a8 100644
> > --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > @@ -42,7 +42,13 @@ properties:
> >
> >    power-domains:
> >      description: specifies a phandle to PM domain provider node
> > -    maxItems: 1
> > +    minItems: 2
> > +    items:
> > +      - description: cx power domain
> > +      - description: USB gdsc power domain
> > +
> > +  required-opps:
> > +    description: specifies the performance state to power domain
>
> I'm still worried about the fact that we can't just rely on the USB GDSC
> being a subdomin of CX in order to just "turn on" CX.
>
> Afaict accepting this path forward means that for any device that sits
> in a GDSC power domain we will have to replicate this series for the
> related driver.
>

I suspect the problem is that it's not just "turn on" but wanting to
turn it on and then set the performance state to some value based on the
clk frequency. Maybe the simplest version of that could be supported
somehow by having dev_pm_opp_set_rate() figure out that the 'level'
applies to the parent power domain instead of the child one? Or we may
need to make another part of the OPP binding to indicate the
relationship between the power domain and the OPP and the parent of the
power domain.
