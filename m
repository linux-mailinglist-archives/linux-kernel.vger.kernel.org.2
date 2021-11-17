Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C9A454E04
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 20:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239627AbhKQTkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 14:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhKQTkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 14:40:10 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978BAC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 11:37:11 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so6611886otl.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 11:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nlKPRUTcJm+bOUCWbAkUY1Qe6bsanAizXJtTl9a9Ch8=;
        b=oCh6mOUdCmKpUE3mzwPRgOo830TBXHM2t5qvaaMsGNG/XjgSdZXCPdY166iX0ccX/X
         DGxiNDQJDeTrfbCcBMe0owj9C/NiBzR9UHv8k6OG1Jne8uIgo/i2K0PwW9QtPQpznIOO
         N88hIazbPsLO6O7LPIxakMuNrN2qsrNLJf8J8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nlKPRUTcJm+bOUCWbAkUY1Qe6bsanAizXJtTl9a9Ch8=;
        b=eMmEw2ZR8bCc+O0RNbbqZia+tvdc69+RzHRd996DgAG/4b4fQuSWb2/HJYs8/2F7u4
         o3OwLBP/CPJRrwSiZhr+e+aByL7IRKIF1JXpMWqx6lqZ7H0E7TH83sHJcPb6hb2S09jv
         LiSqUE0Y/g/jG5eK2HyL+lhLeOAHUF418lv0kWeMGRXVdcRw2yKsziE4d2Mpmm9Sxnzl
         E16rzb+FCAc/B7GJMfl+jkJdQOmmerhTjLB11JHwYTSZVOjr0bPl1+wbkaink29fn32H
         h4Hh5+jJoqiA33qiHQotfBFRl7z/JtCyUT70N870jQpcYaBHCOGyNk+X4Ant1etUY2G1
         kB9A==
X-Gm-Message-State: AOAM530sF8Mxd4R982VwSqIONIKv3YTC44P9n1JBOoZ6a6dE4W+cOiXK
        ToqFoTrWSyR2EARj8QcsAEUBf5Wf5NdAjQ==
X-Google-Smtp-Source: ABdhPJz51B8ttHWKUYp/7aAImLjqgsNSGLmm9zQhRzPi4/rkRImBX5wAe6bfdq6Shu8fWAbCnGm8YA==
X-Received: by 2002:a05:6830:4d:: with SMTP id d13mr16437056otp.45.1637177830368;
        Wed, 17 Nov 2021 11:37:10 -0800 (PST)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id m2sm126534oop.12.2021.11.17.11.37.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 11:37:09 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id h16-20020a9d7990000000b0055c7ae44dd2so6586732otm.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 11:37:08 -0800 (PST)
X-Received: by 2002:a05:6830:20d3:: with SMTP id z19mr15840988otq.3.1637177828401;
 Wed, 17 Nov 2021 11:37:08 -0800 (PST)
MIME-Version: 1.0
References: <20211103234018.4009771-1-briannorris@chromium.org>
 <20211103164002.2.Ie6c485320b35b89fd49e15a73f0a68e3bb49eef9@changeid> <CAKMK7uHGNrgqjQh3DX4gChpNt+xhB_39sVrhdA3BFqnoW-ue2w@mail.gmail.com>
In-Reply-To: <CAKMK7uHGNrgqjQh3DX4gChpNt+xhB_39sVrhdA3BFqnoW-ue2w@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 17 Nov 2021 11:36:56 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPtWsZRTUmrGQKY2Sc-yaeg=e47QpkYWA=KpN5iYGafjQ@mail.gmail.com>
Message-ID: <CA+ASDXPtWsZRTUmrGQKY2Sc-yaeg=e47QpkYWA=KpN5iYGafjQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/self_refresh: Disable self-refresh on input events
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        linux-rockchip@lists.infradead.org,
        "Kristian H . Kristensen" <hoegsberg@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 11:12 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> Can you pls resend with dri-devel on cc? scripts/get_maintainers.pl
> should pick this up, you have all the maintainers but not the list.

Oops, I don't know how that happened. I guess I sometimes have to trim
get_maintainer output, since it likes to hoover up a bunch of
barely-relevant previous committers. I must have been too aggressive.

I'll plan on sending v2 to dri-devel, but let me know (privately if
you'd like) if you'd prefer a pure RESEND of v1.

Brian
