Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C2F3F8FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 22:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243534AbhHZUhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 16:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243505AbhHZUhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 16:37:06 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E55C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 13:36:18 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id s16so4600125ilo.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 13:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=of32+HsVJg8BjIpFCQkLFrsfUsAQLmJI9fq1/gQoEQc=;
        b=VZbC9LJdjvm7jBIyQ99wpnFBXRhf/RtavRPrmiWlpnBkMX5G2PEaCCDA0eZpnirKCK
         rYivpqDHjpUeYYuxVPPrkWyKbtMNCAR8T0WpQhagK1uWeMtJX+uXPlYF2ZPbRa0A29zC
         YImvafN9RqYP7O0dVpcGpMgKLCwbxPpZnMZ8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=of32+HsVJg8BjIpFCQkLFrsfUsAQLmJI9fq1/gQoEQc=;
        b=IHGfIycUjcT2CHFCwulwdxvX5wL3VXV5INT+d8UwyuLWNnJRE+0mZMwDUHvA8KYzu5
         +A+9MMy7eY7zhBbnbVTh8N1G8Z/6+6K5tG/eHY3Kix0uVBBV0COx442adN3i9a/4zWK5
         /aOAa6sIMnmMEnu0iOOrPoII8n2x0OUk/OIUTVrzcRK3Q7RcU1uZHrW+GTVSHwGRJAac
         W17/+6R6uavUo6cM8tPSu+89v4JhBBuLAnQF85ZfnZ4jaaAJCaZMGrQyWC+dXIQ8edEE
         OHnLjS3khOoEq/7waVdSDVc3WuhdtmX+mmJA5bx9tVej0PWbyFsRhztz76TXlEhgZVC7
         cguQ==
X-Gm-Message-State: AOAM532ZZwJI3Y1SgtOHZfxwIYGlSwji50k6xk8rfPYtxRoYrtOuj++v
        adfHzQuYX0yrMhR3wqjF542f6FHLGCbcKQ==
X-Google-Smtp-Source: ABdhPJwqiSfj1+pJhIpBVPca4w9NQuRNjpSYai+8oE1IxwwyL7+bEcpMknzmBhmTHWyjk5kTvlbGhA==
X-Received: by 2002:a92:6a05:: with SMTP id f5mr3994268ilc.140.1630010177914;
        Thu, 26 Aug 2021 13:36:17 -0700 (PDT)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id b2sm2170495ioe.23.2021.08.26.13.36.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 13:36:17 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id v16so4576979ilo.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 13:36:16 -0700 (PDT)
X-Received: by 2002:a92:d304:: with SMTP id x4mr4140800ila.82.1630010176526;
 Thu, 26 Aug 2021 13:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210726231351.655302-1-bjorn.andersson@linaro.org> <CAE-0n50HohAKisSSsNijcxgZGHdBgt=sQbLE3b7C87wPkLJ0cw@mail.gmail.com>
In-Reply-To: <CAE-0n50HohAKisSSsNijcxgZGHdBgt=sQbLE3b7C87wPkLJ0cw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 26 Aug 2021 13:36:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VnkJqJnGHawyqNS5+p6miWd44zR7FPXZWgLk5vo9fOYQ@mail.gmail.com>
Message-ID: <CAD=FV=VnkJqJnGHawyqNS5+p6miWd44zR7FPXZWgLk5vo9fOYQ@mail.gmail.com>
Subject: Re: [RFC] drm/msm/dp: Allow attaching a drm_panel
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Vara Reddy <varar@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 25, 2021 at 6:31 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Bjorn Andersson (2021-07-26 16:13:51)
> > eDP panels might need some power sequencing and backlight management,
> > so make it possible to associate a drm_panel with a DP instance and
> > prepare and enable the panel accordingly.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >
> > This solves my immediate problem on my 8cx laptops, of indirectly controlling
> > the backlight during DPMS. But my panel is powered when I boot it and as such I
> > get the hpd interrupt and I don't actually have to deal with a power on
> > sequence - so I'm posting this as an RFC, hoping to get some input on these
> > other aspects.
> >
> > If this is acceptable I'd be happy to write up an accompanying DT binding
> > change that marks port 2 of the DP controller's of_graph as a reference to the
> > attached panel.
>
> dianders@ mentioned creating a connector (and maybe a bridge) for the DP
> connector (not eDP)[1]. I'm not sure that's directly related, but I
> think with the aux bus code the panel isn't managed in the encoder
> driver. Instead the encoder sees a bridge and tries to power it up and
> then query things over the aux bus? It's all a little too fuzzy to me
> right now so I could be spewing nonsense but I think we want to take
> this bridge route if possible.
>
> -Stephen
>
> [1] https://lore.kernel.org/r/CAD=FV=Xd9fizYdxfXYOkpJ_1fZcHp3-ROJ7k4iPg0g0RQ_+A3Q@mail.gmail.com/

The idea of modeling the connector as a bridge is something that makes
sense to me, but it probably makes sense to tackle that separately. We
don't need to block on it.

The whole DP AUX bus can also be tackled separately after the fact. It
really doesn't change things very much--we still have to find/attach
the panel. It just makes the panel probe in a slightly different way
and as a side effect gives the panel access to the DP AUX bus.

-Doug
