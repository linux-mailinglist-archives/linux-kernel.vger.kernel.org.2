Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE2243A614
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 23:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhJYVoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 17:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbhJYVoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 17:44:09 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2ECC061767
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:41:46 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so16906013ott.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FGNc9Tx8g5/v6KFaaId5VnO2l2Gb29zLqsK+20u4jlQ=;
        b=cJ3SgI091BISPRXBiE8q+NoMzCMMO7TE3mUjnVUSZyyTM/2HdEVTjjMyq1UXYuMO/I
         9qbPtU9k5GfpLfM8F5+H9jcEfr/yhky4VTwQKbUFixO2j+WJbmYLLbSskU78vG9M67gX
         fEvF1LXQw9Avk5tv4b51z16nbHxwj5vIdMelwpLPvEfeK4GaaQHo9EdS/1qo7r/rwV2s
         FPDNv8jCkgsJnDCsSVlF2pUZ+2Eged6qJeAVqKkpDWh5KjAgHW0qvj7PcQd2taipNnoZ
         9qMAgV881ohcmD70JM1ccV+heo10pUPygClUkcx53B4MuxQl5H8u/jc/gnMlmfXu4YcC
         C8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FGNc9Tx8g5/v6KFaaId5VnO2l2Gb29zLqsK+20u4jlQ=;
        b=Ef+R4ZILIqwJMBHrSgjgTGMxdHv1gNIMwMN0llQOMJ+o0LGXvjQLeobFGo8QYnk3UR
         PuPqClS5fQ+3ciVxTTGXDKyozGsNGTev6xQLVPY+3Y537PxT/1p7LjdnEDIz0tt+u+WN
         pctvgkXuWi4vWAnZVjYN0hWXJp/huXM/hWE1RnvRadi9EPYAPBYJe8HmTV0vXUFUgnXE
         2QJqQuC1WPyxd9i/T+ql8cL0fIuOuvpY4BaC4dO8Xn+Iyr2rZsVhbzGNuaY9U4upOm9b
         Xw1D2+/S4jQ9IbIhCEWAb/qN016aqYauiAgtvpoaUVe6RmLwhlvDQjXFpcdK/2ZKXqMk
         BITQ==
X-Gm-Message-State: AOAM531vjhLNpeDlKyCofwx8AB+bZv/Huabkc+hWxRSTBqoE7sM1DelM
        UbMUvjh05Nq1oKp4yT7khvj4OQ==
X-Google-Smtp-Source: ABdhPJyLPL3Eu2q0jA6zGLKMIGyDySUIKVBTEKYYpx+QwwdzIq5OVLXZHPgZxZS1/B9VT/HVaxe4Ng==
X-Received: by 2002:a9d:704d:: with SMTP id x13mr15188704otj.4.1635198105567;
        Mon, 25 Oct 2021 14:41:45 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id s20sm4306440oiw.17.2021.10.25.14.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:41:45 -0700 (PDT)
Date:   Mon, 25 Oct 2021 14:43:23 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com
Subject: Re: [PATCH v2 1/3] dt-bindings: usb: qcom,dwc3: Add multi-pd
 bindings for dwc3 qcom
Message-ID: <YXck+xCJQBRGqTCw@ripper>
References: <1635152851-23660-1-git-send-email-quic_c_sanm@quicinc.com>
 <1635152851-23660-2-git-send-email-quic_c_sanm@quicinc.com>
 <YXcBK7zqny0s4gd4@ripper>
 <CAE-0n51k8TycXjEkH7rHYo0j7cYbKJOnOn1keVhx2yyTcBNnvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n51k8TycXjEkH7rHYo0j7cYbKJOnOn1keVhx2yyTcBNnvg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25 Oct 13:17 PDT 2021, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2021-10-25 12:10:35)
> > On Mon 25 Oct 02:07 PDT 2021, Sandeep Maheswaram wrote:
> >
> > > Add multi pd bindings to set performance state for cx domain
> > > to maintain minimum corner voltage for USB clocks.
> > >
> > > Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > > ---
> > > v2:
> > > Make cx domain mandatory.
> > >
> > >  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > > index 2bdaba0..fd595a8 100644
> > > --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > > @@ -42,7 +42,13 @@ properties:
> > >
> > >    power-domains:
> > >      description: specifies a phandle to PM domain provider node
> > > -    maxItems: 1
> > > +    minItems: 2
> > > +    items:
> > > +      - description: cx power domain
> > > +      - description: USB gdsc power domain
> > > +
> > > +  required-opps:
> > > +    description: specifies the performance state to power domain
> >
> > I'm still worried about the fact that we can't just rely on the USB GDSC
> > being a subdomin of CX in order to just "turn on" CX.
> >
> > Afaict accepting this path forward means that for any device that sits
> > in a GDSC power domain we will have to replicate this series for the
> > related driver.
> >
> 
> I suspect the problem is that it's not just "turn on" but wanting to
> turn it on and then set the performance state to some value based on the
> clk frequency.

I don't see an opp-table involved, just the required-opps for the
purpose of turning CX on a little bit more. Perhaps I'm missing
something here though.

> Maybe the simplest version of that could be supported
> somehow by having dev_pm_opp_set_rate() figure out that the 'level'
> applies to the parent power domain instead of the child one?

Having the performance_state request cascade up through the GDSC sounds
like a nice solution; I've not looked at the code to see if this is
feasible though.

> Or we may need to make another part of the OPP binding to indicate the
> relationship between the power domain and the OPP and the parent of
> the power domain.

I suspect this would be useful if a power-domain provider needs to
translate a performance_state into a different supply-performance_state.
Not sure if we have such case currently; these examples are all an
adjustable power-domain with "gating" subdomains.


PS. I think we have the same problem in the display subsystem, the
sub-blocks are powered by MDSS_GDSC, which is a subdomain of MMCX. We
trust the parent mdss node to keep the GDSC powered and specify MMCX as
the power-domain for the children, so that we can affect their levels by
respective opp-table.

Regards,
Bjorn
