Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757D137A514
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhEKKxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:53:30 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:38649 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbhEKKxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:53:24 -0400
Received: by mail-oi1-f171.google.com with SMTP id z3so17406210oib.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LJ6/iEx981OsThdHsoNHle4saMckTPoLWOXMh4tuyVg=;
        b=l3QQiy4IrhBEfgn6eqEUUN24O9NK0mW65P9gaLYfMRlwBbO9wCL43jFqrH7BOGmn+a
         PoUp/YTK87Zy+/rZ+B7oOciddMr10V6y738X3eEpFpN1ahI+maTEjDcwAru5IQ38cv1y
         ln8gA9z+OrdaFj8XlmtEtrmsN4Yt9a557eyFy5WeXA1jvLgpgphJEsWVWlpEqaLMewf5
         byYImgcOEwYY4x11N0Uce3Mxu3Ezzfh2oYE3VAt4VY/sfz7YGiEwMPOUrtGXgVTBCFna
         PUJzSPLKlfRDuXpuL8vlYQcmkl0vzNqmZFXJrUBim3VTPcpPcVTTR0gxRQO3URh72JjL
         Ixjw==
X-Gm-Message-State: AOAM532ZrwCdl2WbRVKXn8rdnfzqvqReULchn58QnRURtuHnF3cN55/9
        hCl8ksEqywkmP7RLiyuE0YYp2mjlGuosiOAuPcQ=
X-Google-Smtp-Source: ABdhPJwZq8P+r2q3I4vQUuyKzAJKw8MSL1bi+Xg+MXsSXXSqi5MCoC4NztrTDQcz1iZ1sR8OfL6FDUIj4iRIHoC+hM4=
X-Received: by 2002:aca:1815:: with SMTP id h21mr2513827oih.69.1620730336930;
 Tue, 11 May 2021 03:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210508074118.1621729-1-swboyd@chromium.org> <YJlZwYS+oH7W5WjO@phenom.ffwll.local>
 <CAE-0n52S=LFRx93qVyWBpF5PmdCEbWH_+HnN0Do9W45kiJLCbQ@mail.gmail.com>
 <CAKMK7uE_yrXNdEYTf-snNU9dS+=6AKOmUxRuLSHLWBTOtVwpmg@mail.gmail.com> <CAE-0n50d8_OtZTpBGaz0uhj6AO823_kwHg9+SJK6ar=e+rGxFA@mail.gmail.com>
In-Reply-To: <CAE-0n50d8_OtZTpBGaz0uhj6AO823_kwHg9+SJK6ar=e+rGxFA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 May 2021 12:52:06 +0200
Message-ID: <CAJZ5v0h42fTKueFxrB6fpc9YBVNyDsCBryAf_geS-=0+OQQqjg@mail.gmail.com>
Subject: Re: [PATCH] component: Move host device to end of device lists on binding
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 9:08 PM Stephen Boyd <swboyd@chromium.org> wrote:

[cut]

>
> >
> > > I will try it, but then I wonder about things like system wide
> > > suspend/resume too. The drm encoder chain would need to reimplement the
> > > logic for system wide suspend/resume so that any PM ops attached to the
> > > msm device run in the correct order. Right now the bridge PM ops will
> > > run, the i2c bus PM ops will run, and then the msm PM ops will run.
> > > After this change, the msm PM ops will run, the bridge PM ops will run,
> > > and then the i2c bus PM ops will run. It feels like that could be a
> > > problem if we're suspending the DSI encoder while the bridge is still
> > > active.
> >
> > Yup suspend/resume has the exact same problem as shutdown.
>
> I think suspend/resume has the exact opposite problem. At least I think
> the correct order is to suspend the bridge, then the encoder, i.e. DSI,
> like is happening today. It looks like drm_atomic_helper_shutdown()
> operates from the top down when we want bottom up? I admit I have no
> idea what is supposed to happen here.

Why would the system-wide suspend ordering be different from the
shutdown ordering?
