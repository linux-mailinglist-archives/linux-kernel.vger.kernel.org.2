Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF6E421B2E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 02:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhJEAiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 20:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhJEAiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 20:38:14 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50144C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 17:36:25 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id l13so3426059ilo.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 17:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIEfmhHMWRR+UfbfarKixY0VfYOQ7qrc2Yu2ffv5Aws=;
        b=HVKYKpLYZsQ9UTyyVy1Vf68F9k+FOnBn7+9LJBhoCIDGj4DtpqnbiLLEuHoP7URbRu
         yWbC7e48enorTEgwAc9q+sBTCplD/Nk3G42Ixoy6VrM2x9T1VsqUikRntsEX0fSkrzfT
         mapzJmRojmYesEyumCJd5at2lucUUJNvK2HSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIEfmhHMWRR+UfbfarKixY0VfYOQ7qrc2Yu2ffv5Aws=;
        b=JbDiN3ldPOj+zIt9EWhXBGz1S9Vi+3ACVNOOzNl9JD24Gpk1kubwLPfYTWKTTYSOr2
         cvA0HS2mPIGFaCe6FToqqf+xZwG7XAT8iBnWvaPD2WjqwejvjKcXvUiMCf06NVdEPfmc
         rc0PM5o1u+bKkNQ1TGtrry9MdBWzkFw+VCdphUOXuF5YhexX1hxtc0MdbItTgwuhLHVQ
         pH6R3sx11K8PH2H4Cgy0gEJTJsOeeze7RWffrSf2+Xqf4Qa4whaTJaAd1i4wjMNMFRJa
         gvWo3CaXtRbnTeZPiJES6DWN1Jgw2OqotNvmiM0oX1+eodiqDOiFqD9C5LMnAuhUnxJJ
         p01A==
X-Gm-Message-State: AOAM532ey7Ag4pPAbvAfPmESI1q+NVT9OFGL43gf8A1FfpLNKy55pRKx
        HwI2hDXXZbKxF6mOk/CueiQlJzUL/d0zMg==
X-Google-Smtp-Source: ABdhPJxIf27aAKi8ZoEVvHhezElldFpCwLuq16m411qNWGvXL2ily5+nMjXmcKQHFOkq8Aey/ESffQ==
X-Received: by 2002:a05:6e02:1445:: with SMTP id p5mr764748ilo.11.1633394184662;
        Mon, 04 Oct 2021 17:36:24 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id y124sm10154201iof.8.2021.10.04.17.36.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 17:36:23 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id r75so22384023iod.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 17:36:23 -0700 (PDT)
X-Received: by 2002:a02:c7d2:: with SMTP id s18mr175853jao.68.1633394182579;
 Mon, 04 Oct 2021 17:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210726231351.655302-1-bjorn.andersson@linaro.org>
 <CAD=FV=UGtHXD==Yy8CVCOioYGb=2hqGQOoNWftD1Jj7OiEp51g@mail.gmail.com> <YVd3YdfgFVc0Br5T@ripper>
In-Reply-To: <YVd3YdfgFVc0Br5T@ripper>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 4 Oct 2021 17:36:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U=xVLuKOYHbGPTkLjGa8_U+F1ZtEvJt4LGaRuR5SsKFw@mail.gmail.com>
Message-ID: <CAD=FV=U=xVLuKOYHbGPTkLjGa8_U+F1ZtEvJt4LGaRuR5SsKFw@mail.gmail.com>
Subject: Re: [RFC] drm/msm/dp: Allow attaching a drm_panel
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Vara Reddy <varar@codeaurora.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 1, 2021 at 2:00 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Fri 27 Aug 13:52 PDT 2021, Doug Anderson wrote:
>
> > Hi,
> >
> > On Mon, Jul 26, 2021 at 4:15 PM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > >
> > > +static int dp_parser_find_panel(struct dp_parser *parser)
> > > +{
> > > +       struct device_node *np = parser->pdev->dev.of_node;
> > > +       int rc;
> > > +
> > > +       rc = drm_of_find_panel_or_bridge(np, 2, 0, &parser->drm_panel, NULL);
> >
> > Why port 2? Shouldn't this just be port 1 always? The yaml says that
> > port 1 is "Output endpoint of the controller". We should just use port
> > 1 here, right?
> >
>
> Finally got back to this, changed it to 1 and figured out why I left it
> at 2.
>
> drm_of_find_panel_or_bridge() on a DP controller will find the of_graph
> reference to the USB-C controller, scan through the registered panels
> and conclude that the of_node of the USB-C controller isn't a registered
> panel and return -EPROBE_DEFER.

I'm confused, but maybe it would help if I could see something
concrete. Is there a specific board this was happening on?

Under the DP node in the device tree I expect:

ports {
  port@1 {
    reg = <1>;
    edp_out: endpoint {
      remote-endpoint = <&edp_panel_in>;
    };
  };
};

If you have "port@1" pointing to a USB-C controller but this instance
of the DP controller is actually hooked up straight to a panel then
you should simply delete the "port@1" that points to the typeC and
replace it with one that points to a panel, right?

-Doug
