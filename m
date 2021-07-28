Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95803D8FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237283AbhG1NyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236952AbhG1Nww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:52:52 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950A2C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 06:52:41 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l11-20020a7bc34b0000b029021f84fcaf75so4388836wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 06:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kuD2/cMi9v63nZZZmSBG2IaupOS/1XWwnneUf9M1k9o=;
        b=qcRqP641xG0vB+UDYiik9LQYbPUpon4cK820eR4sCWfADHA+T9YgUCydz8yzF5Z8gN
         9ZQUEAhytwB5ZTNRpwtUWvuzeTq7kDMKRLGiRBEVaGKgpBgaJMzQzHdYwsT+ei/fzUXD
         tnEDngdpt/iMmL9N+uLOZBHGyiUIgar1ziPC1yNKhdps+wgFOmNmB2Bv2w4E8HKZTvBf
         72i9hM0HTF4pHTf0pEs99WWodCZCQ9/x9snGUz247KYbrsT1v4M7LCB4quydvu6HYkrl
         oK5ypCS8Fy3yBcHA54M1L3MZ+MlQ2d4dGvvShgn5bgsDF8hmQrtKCtyrAcYa18gE4f8n
         mkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kuD2/cMi9v63nZZZmSBG2IaupOS/1XWwnneUf9M1k9o=;
        b=dVKwNJ2MtDeseoVR5rHOtZY8zNJ9pigjsGbya6vAL3GQFnkRChMEa1GJiQNVHG2hHY
         4m3GFfzTVefyvgqRGFp0SjMtfQM90aFAs/wJSRaBCnOqZIoQeFzVdhJpd77Yci1uDB5V
         i/Ll/FsWKfJNGZtnPPCs9DWSvtw8ik5+roaNp7o+1p+l4TiawEudilauip+T9HaBa9yL
         3Rr0+vnWYoSVRpOjnsrHBrx5gw4mfVLzH3DMuF7Ha6yjO6S+gaoMk5nLHI/9zL1duHwQ
         pVe1lcud0rBeM5Ky66WJAOLXuuLXfxX7hcQzNj3pUXa+15mkQ+qEyHXmEx7bWVDZJ810
         CvWQ==
X-Gm-Message-State: AOAM532eJYcJA/fxvKdoxOYKC1v6R0qTD7y6NB5gbc6HkrQjlwyd3MZo
        bPmoCS1wUQEAoHwBe0Lh/3o/WnHJf0N87z0rdsqMYQ==
X-Google-Smtp-Source: ABdhPJyZ4wRTiW93BgBlBxE6MvcGFi57mJyOUsPHwaGo/ilO2tap+IJYgnG0mQS5pIEyDpoLfvQwlnfJlQMVP7gRGQs=
X-Received: by 2002:a05:600c:354e:: with SMTP id i14mr27642677wmq.96.1627480360236;
 Wed, 28 Jul 2021 06:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210707092257.1465109-1-maxime@cerno.tech>
In-Reply-To: <20210707092257.1465109-1-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Wed, 28 Jul 2021 14:52:24 +0100
Message-ID: <CAPY8ntDXZ7ExjKvBMFjd5d3RTfrGCe2TYiXfmjF4bmE+WMFssQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] drm/vc4: hdmi: Fix CEC access while disabled
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Emma Anholt <emma@anholt.net>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        LKML <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Wed, 7 Jul 2021 at 10:23, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> This series aims at fixing a complete and silent hang when one tries to use CEC
> while the display output is off.
>
> This can be tested with:
>
> echo off > /sys/class/drm/card0-HDMI-A-1/status
> cec-ctl --tuner -p 1.0.0.0
> cec-compliance
>
> This series addresses it by making sure the HDMI controller is powered up as
> soon as the CEC device is opened by the userspace.
>
> Let me know what you think,
> Maxime
>
> Changes from v1:
>   - More fixes
>   - Added a big warning if we try to access a register while the device is
>     disabled.
>   - Fixed the pre_crtc_configure error path
>
> Maxime Ripard (5):
>   drm/vc4: hdmi: Make sure the controller is powered up during bind
>   drm/vc4: hdmi: Rework the pre_crtc_configure error handling
>   drm/vc4: hdmi: Split the CEC disable / enable functions in two
>   drm/vc4: hdmi: Make sure the device is powered with CEC
>   drm/vc4: hdmi: Warn if we access the controller while disabled

Comment made on patch 1.

Patches 2-5:
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

  Dave

>
>  drivers/gpu/drm/vc4/vc4_hdmi.c      | 123 +++++++++++++++++++---------
>  drivers/gpu/drm/vc4/vc4_hdmi_regs.h |   6 ++
>  2 files changed, 89 insertions(+), 40 deletions(-)
>
> --
> 2.31.1
>
