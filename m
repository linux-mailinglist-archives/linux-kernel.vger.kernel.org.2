Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E35B35051A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 18:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhCaQuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 12:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhCaQuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 12:50:16 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA434C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 09:50:15 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id l12-20020a9d6a8c0000b0290238e0f9f0d8so19559949otq.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 09:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VO+UUFNdki+F7xgaS2mK6aIBg7EST205oZYqbmljPz0=;
        b=hJ5Ug+Pyr8mj+ETexnOPGtlGqIF72PVbEoX6nARIHgLbRfNVoOsorpNYDzXcrvjHZ0
         HWDL2DOKo3VlO7/+6109vHwy15UC6IiiknGKCjWPkF1RwpL6wyPoFUsQo5DDz/fHwhLp
         r/Ur43R+d5yVjMN6SXQZRnBeyt4M9Z/8sgRk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VO+UUFNdki+F7xgaS2mK6aIBg7EST205oZYqbmljPz0=;
        b=jx9gjV4G80ur55uUAdJHi+9/D+Wz9MXAzygm6RyKNYJEwzzRiN0EGM+J6WCn22bFOr
         vKg9VTXnRxN1QTVr/haltdobQdDNidysG63buyBaxpDPicLlhv6Ryo5QrX8umssAUT3O
         sjlMQA4w10EvQEGjH8pgh2jwWMPn3iwB5ZIeZn8/+ijrPBLKk2JqwFkWJ+/LKsFoZB5x
         A7E0ajDtbR6uq2zPZTOXhN3VfH2TATFp2exvSZ3b6WVwEB2F4vAg0dgvSyq+dZdD2hR4
         1P3fFK+P3ytryNC73O5uxrcQ4NprV9FBSgH+xUExqnYxR7RD/lwePYd570x8wFqvPqln
         MLpA==
X-Gm-Message-State: AOAM530Lxd6HDpcEUAcD5ok8WOnNC9epeD+aduWcp/T/kiSFotKVM2tM
        bUK9dH/oBRYpU50AAhRcNWcLRNfSZnS84w==
X-Google-Smtp-Source: ABdhPJxkDNfI0rOS+IQRKgr6phc//r0uHztrcuwbRe3gYicI2voXyRhuv4dRsMUZiJsUy24zw0E1Zg==
X-Received: by 2002:a9d:2f45:: with SMTP id h63mr3300989otb.372.1617209415183;
        Wed, 31 Mar 2021 09:50:15 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id g84sm525692oia.45.2021.03.31.09.50.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 09:50:15 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so19585913otn.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 09:50:15 -0700 (PDT)
X-Received: by 2002:a25:8712:: with SMTP id a18mr162712ybl.79.1617208996943;
 Wed, 31 Mar 2021 09:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210330025345.3980086-1-dianders@chromium.org>
 <CGME20210330025417eucas1p29eca41bbcfc2550902cee87fd44b98e4@eucas1p2.samsung.com>
 <20210329195255.v2.5.I1a9275ffbde1d33ad7a3af819f5fbc0941b7ee02@changeid> <00fc2110-d30a-d8f2-b22b-a5c73b54127d@samsung.com>
In-Reply-To: <00fc2110-d30a-d8f2-b22b-a5c73b54127d@samsung.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 31 Mar 2021 09:43:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V9uMpPbXxoNd2DpvtX=nEb1RFdbZ5bV8ZGhNpOVMJtOg@mail.gmail.com>
Message-ID: <CAD=FV=V9uMpPbXxoNd2DpvtX=nEb1RFdbZ5bV8ZGhNpOVMJtOg@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] drm/bridge: ti-sn65dsi86: Move MIPI detach() /
 unregister() to detach()
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 31, 2021 at 2:53 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
>
> W dniu 30.03.2021 o 04:53, Douglas Anderson pisze:
> > The register() / attach() for MIPI happen in the bridge's
> > attach(). That means that the inverse belongs in the bridge's
> > detach().
>
>
> As I commented in previous patch, it would be better to fix mipi/bridge
> registration order in host and this driver.
>
> Have you considered this?

Fair enough. How about I drop this patch at the moment? My series
already has enough stuff in it right now and I don't believe anything
in the series depends on this patch.

-Doug
