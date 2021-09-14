Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8C440B8CF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbhINUPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbhINUO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:14:56 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C482EC061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:13:38 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b200so295386iof.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=opbU04o7Av2seByLDm+85tUZqupNHweB2QHyYQl46u0=;
        b=Cg4NzZFqSaeWh4iwIopzkDRdf9YkC4YU7w7K6lGW+bGKsuACZacPGqTiw32dbnvhK9
         xKTisVlvzsBA9DGgELL0LAVERYePLiDfLtDhTF6kMZZh9bTierktXrVkazV0+fd34DWy
         +kSKoNkXw7p2UWJVuUyM2SnhvGt0usal+Z5KY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=opbU04o7Av2seByLDm+85tUZqupNHweB2QHyYQl46u0=;
        b=DgRjTFlbcri4/bD50Uq8WpdW/LC+Ya7m0nZzAeDe8xke37Mgfj1McruLoX9iMpLi1R
         4cFwxWamuBPJgO2Zju1FypLs6LNxbyitg00/W+8Bt6BRb3IO/5f9JIduY1uRHlDlryVh
         X7vZo5N9f4Rr4ej6ByPmi9ObnIgwBq7gWwfeopCYPVQ3gaC7JIfmAnKWx237ulVf9ZVL
         WFEv4BH+fcF5dDr/9Q1ZCAtqB7AiaYLbVswqTQ2AnXYozXE+kDfhdB4gq++BEQMqg34z
         2SRzTl8+MBOURE77ND7PN8/p4rR1Itex3OlGXqOzzO48ZGOcrgAUOD+Vpa4OjEpHhIN0
         Yc5A==
X-Gm-Message-State: AOAM530Bbm3zKgaCQr6IaFIMcfOtVWZJ/eOF+m+CIK+pQQ/7r1oUUUBb
        auwffthj9QS2jDlESL7QIW07/VBVh+2aRw==
X-Google-Smtp-Source: ABdhPJyEOYxjYbsvllKNYe2SiliybtvcaEQCS0JiCeMXTV6uN6dKOrf0fCnp4vPZoPDSaR5FGo/oyw==
X-Received: by 2002:a6b:3e84:: with SMTP id l126mr15567618ioa.151.1631650417728;
        Tue, 14 Sep 2021 13:13:37 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id f3sm7373362iow.3.2021.09.14.13.13.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 13:13:37 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id h20so346925ilj.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:13:36 -0700 (PDT)
X-Received: by 2002:a05:6e02:214e:: with SMTP id d14mr12547218ilv.142.1631650416432;
 Tue, 14 Sep 2021 13:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210909210032.465570-1-dianders@chromium.org>
 <20210909135838.v4.1.I1116e79d34035338a45c1fc7cdd14a097909c8e0@changeid> <CAE-0n53Pp1F5dZRk98WT5+K9jz_XpMkKUvYAs_suZFaOE0K39w@mail.gmail.com>
In-Reply-To: <CAE-0n53Pp1F5dZRk98WT5+K9jz_XpMkKUvYAs_suZFaOE0K39w@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Sep 2021 13:13:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uc77p-BifFvr=GkWVbP=KKb-eHNtvnOKQJ5D86ogi8hA@mail.gmail.com>
Message-ID: <CAD=FV=Uc77p-BifFvr=GkWVbP=KKb-eHNtvnOKQJ5D86ogi8hA@mail.gmail.com>
Subject: Re: [PATCH v4 01/15] dt-bindings: drm/panel-simple-edp: Introduce
 generic eDP panels
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linus W <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 14, 2021 at 12:12 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Douglas Anderson (2021-09-09 14:00:17)
> > diff --git a/Documentation/devicetree/bindings/display/panel/panel-edp.yaml b/Documentation/devicetree/bindings/display/panel/panel-edp.yaml
> > new file mode 100644
> > index 000000000000..6a621376ff86
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/panel-edp.yaml
> > @@ -0,0 +1,188 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/panel/panel-edp.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Probable (via DP AUX / EDID) eDP Panels with simple poweron sequences
>
> Should that be "Probeable" or "Probe-able" or "Detectable"? It's not
> about statistical probabilities right?

Thanks for the catch! Will be fixed in v5.

-Doug
