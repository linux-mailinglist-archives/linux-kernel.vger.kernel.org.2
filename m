Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A9A3BE620
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 12:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhGGKIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 06:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGGKIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 06:08:11 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EDCC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 03:05:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t15so2352806wry.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 03:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/mQjTUejd8tKQk4eMfEXIf/oxOvq8b1A8Sr0VU0Mh/Q=;
        b=ObJEC61b1E5vsl9TsWe5s3mQlBCBlqjY5MqGVbzt7B2QPfhj78AWN3wmGMV+5wxjQK
         Frvg3Ab6P0epviGe5PrQP++qIC+CuyFTsVrG2wwRp+bJkDVfJhfIRJpJHSo2csJjL0zg
         cnBr1e20lFwGxJQ30wA6h/9+nXuQkAKHq83mATuybkkZlZCdnQboz1RBa+kJPpe/M7D/
         3Df5/tSEzCapSVRX8XM/+buF0BDKTKNUF8diFi816hcDI/aT0Rdabs63tV7DdbY+1Vs7
         tS687FLdxxMlf1aDERj2I7e6cVHX3YhOZYZM58JsDokLMTeO20PkuyWWhy8TvCIsTp8Q
         9bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/mQjTUejd8tKQk4eMfEXIf/oxOvq8b1A8Sr0VU0Mh/Q=;
        b=bbGc8MJFSsRjLrdO01g4/j0VvH2mzHTc4MPG3IFN/lkyUY+CkEkrWrbaD+XStCOJtK
         I4YtHjDWOcQ9ebSGTQkb5Nwhfl0BwYZMGb9Ou+aBx1uCSBiaK8T3oVl7TnUT6g/dL4WC
         WgSNP1RlOGAcR52GK2LK/JtNweuDqLMqVfS5lw4Kun8ZZAM7EdGYNbZW/l5BHJ5Q2ray
         0YI0tav9Z5hwAh/rDFJhTiKdjvHGnaP9fLQ1BFVx0RDvpAiHMYjLtxzqgu+hseQYGbFT
         LttNNStwZ6IQt9E0q/dThjiVwPIvFwyElt0p870SYmr7+D2+kALy161AFR8PRW7ogMce
         EgHQ==
X-Gm-Message-State: AOAM530qySLFZlORc0iinisP9287XbQLfefu0RprahAuGDWrtudewb1M
        t3X7BLWnUEiSEqp4Y+8CZVjbIPHNwBQs+9kLOAQTgQ==
X-Google-Smtp-Source: ABdhPJyoGU+U7VV9amLbAiDK7jQ7puXvDjYhvDYuqDNFRAxvGTw+HyKSC3cBjBZ2Ffwer6j7Uf+9hDRVBN3QEya3cqs=
X-Received: by 2002:a5d:548a:: with SMTP id h10mr26540467wrv.273.1625652330348;
 Wed, 07 Jul 2021 03:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210707095112.1469670-1-maxime@cerno.tech>
In-Reply-To: <20210707095112.1469670-1-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Wed, 7 Jul 2021 11:05:12 +0100
Message-ID: <CAPY8ntD-fi1Zm5eDQd4JR9qOcwfQukkEbMQvYaOgdhOHcQMUDw@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/vc4: hdmi: Interrupt fixes
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Maxime Ripard <mripard@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Wed, 7 Jul 2021 at 10:51, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> Those are three fixes for race conditions we currently have in the vc4 HDMI
> driver with regard to the interrupts handling.
>
> The first two are fixing an issue where the handler will be removed by devm
> after the resources it uses have been free'd already.
>
> The last one is there to deal with an interrupt coming in the window between
> the end of the driver's bind and the  DRM device registration.
>
> Let me know what you think,
> Maxime

For the series
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> Maxime Ripard (3):
>   drm/vc4: hdmi: Drop devm interrupt handler for CEC interrupts
>   drm/vc4: hdmi: Drop devm interrupt handler for hotplug interrupts
>   drm/vc4: hdmi: Only call into DRM framework if registered
>
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 92 +++++++++++++++++++++++-----------
>  1 file changed, 62 insertions(+), 30 deletions(-)
>
> --
> 2.31.1
>
