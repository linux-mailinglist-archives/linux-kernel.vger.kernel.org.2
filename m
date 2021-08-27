Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3D33FA0E7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 22:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhH0UxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 16:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhH0UxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 16:53:14 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F999C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 13:52:24 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id v2so8228987ilg.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 13:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aXHt+zBvV2P2yRdRsCvTblJhainZty6Jg0vDCbYmK8M=;
        b=FV8wBmGYU5sDobyYYnQpOECTKrYkK8EB7/GlKxGqyLstGxzDaWlP7jlTT05tsDEu9N
         m3ODA5TwhdedwETDFIuIUoqNe6jBe53IH7JlysQzvDipyp3WcCIgWyE2nSumqs3jqm+E
         Zr7wV9fgaErAPWv/uxHyXK5/YaePil/2i1r98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXHt+zBvV2P2yRdRsCvTblJhainZty6Jg0vDCbYmK8M=;
        b=pdaYR0UnVLf4HdXek5SrjQBpqFGdMSgrD0+vNb1ns7YsqG5UzHzqSTHraF9cO3Cybm
         I/wOsMBpuX/gof+bJWYUA6KxmNB9vv6NpL4WRJtr1Wznh7nGsYi0zo0km+s8BAsdiZhB
         ctPyOdYJ75vdWwD58q3s/6dyki5Pmep7ykXe0Llyzq6e+JBbIZZ/EJPMNeNoawFsLx6d
         sgVtkUAr49UcVOI8XYGxsnH35xLLlyQxauPqcvt2fI4Mt1fd6Vz6yv60Q/88XoMx6TH4
         X7TvASOdkARP1H4TC1ay8NMx1Eb0wzeBkNv+Zakd40++B8b6ylVvO7NRhORndlUdmopv
         5c7A==
X-Gm-Message-State: AOAM530JWtDaoFqb1rmSXWj5r+8qOcGg21g9ZsBBerXO4vvU3jmnxTGF
        QrpxL5dSYVsLRDafrGEwwFmP10N7gDFbNw==
X-Google-Smtp-Source: ABdhPJwSDYNqt1lA4q7nsQUyGqiH6hnu/s4NgsGw1dzgqwmFeoUe70LJJapOnU7aDB4UfI8sdYgEkA==
X-Received: by 2002:a92:cace:: with SMTP id m14mr8009056ilq.146.1630097544251;
        Fri, 27 Aug 2021 13:52:24 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id c8sm3966240ilk.64.2021.08.27.13.52.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 13:52:23 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id l10so8264008ilh.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 13:52:23 -0700 (PDT)
X-Received: by 2002:a92:a008:: with SMTP id e8mr7587200ili.187.1630097542564;
 Fri, 27 Aug 2021 13:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210726231351.655302-1-bjorn.andersson@linaro.org>
In-Reply-To: <20210726231351.655302-1-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 27 Aug 2021 13:52:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UGtHXD==Yy8CVCOioYGb=2hqGQOoNWftD1Jj7OiEp51g@mail.gmail.com>
Message-ID: <CAD=FV=UGtHXD==Yy8CVCOioYGb=2hqGQOoNWftD1Jj7OiEp51g@mail.gmail.com>
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

On Mon, Jul 26, 2021 at 4:15 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> +static int dp_parser_find_panel(struct dp_parser *parser)
> +{
> +       struct device_node *np = parser->pdev->dev.of_node;
> +       int rc;
> +
> +       rc = drm_of_find_panel_or_bridge(np, 2, 0, &parser->drm_panel, NULL);

Why port 2? Shouldn't this just be port 1 always? The yaml says that
port 1 is "Output endpoint of the controller". We should just use port
1 here, right?

-Doug
