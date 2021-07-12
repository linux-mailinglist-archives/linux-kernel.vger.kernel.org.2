Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A323C5ECA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 17:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbhGLPG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 11:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbhGLPG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 11:06:57 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD92DC0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 08:04:08 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id r17so3166796qtp.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 08:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=isd/llWwr/Y0cL0WxQwwfUZGS9+zFVVnxXEoNVeoRKQ=;
        b=JTqNDAZEgzekdEwusOKFc/BA38hvqh2Q/Y0osda98t33A9XhabVx51fuWMSUG2X2k8
         PUGz839O2kQ17hLlv8qrvpsoe7ZeNnGZVrAq9ZhuzGIU+esN4VCDCF1WiRU2r5Y8eeX9
         waoFggrUUaK1Yrpp6/HAPHxdJAyUhC4iVEqJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=isd/llWwr/Y0cL0WxQwwfUZGS9+zFVVnxXEoNVeoRKQ=;
        b=a2ildmyUgppjah7MYX0xuOT8PXwsD2ux73Y3X9eXAeeMqM3eWBq12JEUjzOk8iWMEs
         YAJbWe15/p4QHHZRRtl5/MEuoqBe/AiqoBQy/Zu+ziDy2vLJGk+idP1qJfA8/BGDICy0
         s+gIVpDzD5aQLQL6xqABlNOQKg+FHHAhrEhEWz5vsWlU6vYv3REDZKXZx+Uvqsb/FrD6
         TIK7eJx3fBl8G1b8/Tjj42PjSdEMghLGgCd4c8tfWHRuLe3alZ2jmm3Gtpwmcppvu2kJ
         Wj3lwZwvzsPHgphs83uYOAEgFxjcfnYBA3Gj0cViXa0saziw43t6FKvGOtmBGVgipZH0
         3HpQ==
X-Gm-Message-State: AOAM531nDQvW4C2p3xB47Fo3eqRnvUktPfkLSEsg04d4Rj5a6BUto0hl
        Ee+H1m4pmRzue2w0TcIZS45u0OVMzPOnZA==
X-Google-Smtp-Source: ABdhPJycY4+mXlLN7jPP4IGGj51VwRqYzov5s7tYn/xG1XCoI3EPxfnPuH1JPDRZjbx0i7OEwt2zZQ==
X-Received: by 2002:a05:622a:1646:: with SMTP id y6mr10106366qtj.146.1626102247935;
        Mon, 12 Jul 2021 08:04:07 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id 197sm1332931qkn.64.2021.07.12.08.04.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 08:04:07 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id o139so29409250ybg.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 08:04:06 -0700 (PDT)
X-Received: by 2002:a25:cc52:: with SMTP id l79mr63888238ybf.476.1626102245460;
 Mon, 12 Jul 2021 08:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <1624726268-14869-1-git-send-email-rajeevny@codeaurora.org>
 <1624726268-14869-2-git-send-email-rajeevny@codeaurora.org>
 <7f8562df-7e1f-dcfb-1c58-f1edd9dcc606@suse.de> <CAD=FV=V8CaKObbQTCsX2GrP=O8aJUaWLZY3zgBMRATtSn6Be4g@mail.gmail.com>
In-Reply-To: <CAD=FV=V8CaKObbQTCsX2GrP=O8aJUaWLZY3zgBMRATtSn6Be4g@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 12 Jul 2021 08:03:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wij=nih9c1Dxmh=3UFXsOvdbTHBqwXxsUa+rQfpuf4Wg@mail.gmail.com>
Message-ID: <CAD=FV=Wij=nih9c1Dxmh=3UFXsOvdbTHBqwXxsUa+rQfpuf4Wg@mail.gmail.com>
Subject: Re: [v8 1/6] drm/panel: add basic DP AUX backlight support
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Rajeev Nandan <rajeevny@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@gmail.com>, Lyude Paul <lyude@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rob Herring <robh@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 12, 2021 at 6:39 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Jul 12, 2021 at 2:41 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >
> > > +     ret = drm_dp_dpcd_read(aux, DP_EDP_DPCD_REV, edp_dpcd,
> > > +                            EDP_DISPLAY_CTL_CAP_SIZE);
> >
> > This creates a cyclic dependency between drm_kms_helper-ko and drm.ko.
> > drm_panel.c is in the latter, while drm_dp_dpcd_read() in
> > drm_dp_helper.c is in the former. Please fix.
>
> Yeah, this was reported Friday and I posted a patch to try to fix it:
>
> https://lore.kernel.org/lkml/20210709152909.1.I23eb4cc5a680341e7b3e791632a635566fa5806a@changeid/
>
> I see Rajeev had some feedback on it. Once I've dug out of my weekend
> email hole I'll take a look at plan to post a v2 ASAP.

Breadcrumbs: v2 of the fix is at:

https://lore.kernel.org/lkml/20210712075933.v2.1.I23eb4cc5a680341e7b3e791632a635566fa5806a@changeid/

I'm hoping this looks OK so we can get this resolved before it trips
too many people up.

-Doug
