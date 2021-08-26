Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313513F8D9C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbhHZSJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhHZSJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:09:42 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7DBC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:08:54 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id j18so4844556ioj.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jy6kuEa6qOgtVcIiHcL8rg+bn6K8NFztM/6FPGA8TH0=;
        b=cOVMuHR/jcS4F7qoAfsqLFcmg6fAf3mJeeBFe3SuigOc873b4njVi0bY+8ShjxHOla
         wEXxYRLn03hQXt7bL0bhzXJ/YWy0n7GCBeTq0P2rKE+9SZTdDphev2LQdCbCv3OQB+Rm
         MOdPQJzIyaQ0sfzXZhP6JjPqS7jB/I68vMLtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jy6kuEa6qOgtVcIiHcL8rg+bn6K8NFztM/6FPGA8TH0=;
        b=hwJwT+hR/TiUufVbnMKa7IqL+8V1E8bX30ZKxqWdtZb6XG0Nz4/cEUmQSQyocQD862
         KBqy8xup/hEgHQ62g+IYpsMUsGOciNM0IvqlbAJd6pKHDpi9qfxLU0TZbKx/Qq1w9mJT
         ay4u0Nu9oP/C2LTveEIwEnZEmmV3JhVnYIf84kqD27uwE+lGoaCJZ4jmKoCR6wgGWrHN
         A7jh2upDnlpUeZiev98qSsfbM62kgnU8pS27PWGAYdTppOHJJaOzpRkOOVs0rieN4mgs
         17T0Af9ywUIoTPgOja4CK1z8jocPeYKgDJ/sBX6qrv1nvelxG7X/LFxo7AYUOu2deDr5
         Rd0g==
X-Gm-Message-State: AOAM530uuQVJM22xe8rhz2HD2otp03kVOss62Sx57Bkn/LM99/hqgJ/Q
        afsg0b00BmxmLo+TAfIgwRnPrjLqvlT6kw==
X-Google-Smtp-Source: ABdhPJwRluAcauq42GsIItavSUdqnuNb2JKR+rx+0V4iNl7wTkj0yXcNjrBCHw2hBml2jWbMJKQjhA==
X-Received: by 2002:a5d:9e49:: with SMTP id i9mr4058232ioi.125.1630001333919;
        Thu, 26 Aug 2021 11:08:53 -0700 (PDT)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id k7sm1847298iok.22.2021.08.26.11.08.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 11:08:53 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id x5so4205968ill.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:08:52 -0700 (PDT)
X-Received: by 2002:a05:6e02:964:: with SMTP id q4mr3649001ilt.229.1630001332199;
 Thu, 26 Aug 2021 11:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210824181140.v2.1.I8ead7431357409f2526e5739ec5bc3ddfd242243@changeid>
In-Reply-To: <20210824181140.v2.1.I8ead7431357409f2526e5739ec5bc3ddfd242243@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 26 Aug 2021 11:08:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UqcHiZxeVte_qYKeBQOqe6C_9TRXDJjesGqz2qWsNiqg@mail.gmail.com>
Message-ID: <CAD=FV=UqcHiZxeVte_qYKeBQOqe6C_9TRXDJjesGqz2qWsNiqg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: parade-ps8640: Reorg the macros
To:     Philip Chen <philipchen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 24, 2021 at 6:12 PM Philip Chen <philipchen@chromium.org> wrote:
>
> Reorg the macros as follows:
> (1) Group the registers on the same page together.
> (2) Group the register and its bit operation together while indenting
> the macros of the bit operation with one space.
>
> Also fix a misnomer for the number of mipi data lanes.
>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---
>
> Changes in v2:
> - Fix the double sign-off lines
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

Pushed to drm-misc-next with Sam's Ack and Stephen's review.

28210a3f5412 drm/bridge: parade-ps8640: Reorg the macros

-Doug
