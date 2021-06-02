Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE05399416
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhFBT6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:58:39 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:46771 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhFBT6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:58:35 -0400
Received: by mail-qt1-f172.google.com with SMTP id m13so2707741qtk.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 12:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t8u4p0mRfsdYCtJTM/K9Y8fUxpv3fGAAMx8yDE7edtM=;
        b=HsQThjsbdcgxS4Sauu7xku8z2h1uwLF/YPWdO1UOAI9HZDGPb7fUQoXB6idd3xfv18
         i7HuJMXCBFL7mA3gPVv3GVJiOuGtYyNhWodZ+KsqW9K8AdbJyCAZnDN9DdTx5pYLelTj
         RF1p+HGUT84HhloeqrFD8xLpnmqkQsw1qdNrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t8u4p0mRfsdYCtJTM/K9Y8fUxpv3fGAAMx8yDE7edtM=;
        b=KN9OEIP1lzYzY5gAjENqG+9Py9Yhx0m2CXAO9obgg15n5IbCevSwqnb9XS1D75Er0l
         Fe1dKuVwAGrrd2DbdOzi4YqmqFRX3NpDW2Tl7KkS1YmjgRHz7RNJj3xFFJyDYs50/+K0
         Vfxfi0tEZ4KZTDrgclvawM10DzZCpM1Hg7h1Nr+HtOA0F7SXmlf9G1xvnR42JHVq0dOK
         mgsx5akML2Rsh8FkJesmw0NOQjIqdw9RKzmIzT09x5yLkYh5rRunl3PIZGgDQDNMHwDi
         WW2naegmqWnTb6g/WD65TCjAd/OvJXxa7kDEYEBaJj7NDtWpl4iIBQD9VJn/v4S5uM1j
         mnRA==
X-Gm-Message-State: AOAM533ud+ets5Jx5vtu6lvlmll1ZlOYk3JvgNjvU1T4OrbOIHsro9hE
        +dljfxlT0+lWbDwAyHxnxIDjy6s+Qm4hqA==
X-Google-Smtp-Source: ABdhPJw9ge0wisKKZhpq+tvdl7yISBYe2kDcwfogd7UvmrAlGQJrCDp51m/kj3a/mMiD7hf0EMT+mA==
X-Received: by 2002:ac8:5b8d:: with SMTP id a13mr10460355qta.114.1622663751314;
        Wed, 02 Jun 2021 12:55:51 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id a23sm507354qkl.6.2021.06.02.12.55.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 12:55:51 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id b13so5501878ybk.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 12:55:51 -0700 (PDT)
X-Received: by 2002:a25:ab4b:: with SMTP id u69mr11929577ybi.276.1622663740165;
 Wed, 02 Jun 2021 12:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210525000159.3384921-1-dianders@chromium.org>
 <20210524165920.v8.4.I79c7ed8815a07d285dd3b38e680e980d1024dbf1@changeid> <20210602181621.GB3692772@robh.at.kernel.org>
In-Reply-To: <20210602181621.GB3692772@robh.at.kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 2 Jun 2021 12:55:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WyXfi-v6zO_v3YDN71OrXsOVkf1W5h5gV4zwJ4_fBzQA@mail.gmail.com>
Message-ID: <CAD=FV=WyXfi-v6zO_v3YDN71OrXsOVkf1W5h5gV4zwJ4_fBzQA@mail.gmail.com>
Subject: Re: [PATCH v8 04/11] dt-bindings: drm/aux-bus: Add an example
To:     Rob Herring <robh@kernel.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linus W <linus.walleij@linaro.org>,
        Lyude Paul <lyude@redhat.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thierry Reding <treding@nvidia.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 2, 2021 at 11:16 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, May 24, 2021 at 05:01:52PM -0700, Douglas Anderson wrote:
> > Now that we have an eDP controller that lists aux-bus, we can safely
> > add an example to the aux-bus bindings.
> >
> > NOTE: this example is just a copy of the one in the 'ti-sn65dsi86'
> > one. It feels useful to have the example in both places simply because
> > it's important to document the interaction between the two bindings in
> > both places.
>
> Don't forget the 3rd copy that exists in some .dts file most likely.
> That's 3 places to fix when we improve or add some schema.
>
> I've generally been trying to de-duplicate examples...

I'm interpreting your response as: please drop ${SUBJECT} patch from
the series and leave the 'dp-aux-bus.yaml' without any example. The
existing example in the bridge chip is sufficient.

-Doug
