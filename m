Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633B9452850
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 04:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239495AbhKPDRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 22:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbhKPDQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 22:16:48 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840D5C04A430
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:44:26 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id bk14so38311416oib.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=PaQ00ZGEy4Uu84RCOZUTfeFZWA/YaY1Ww6m8YLQkvhs=;
        b=W2VWXeSJ7wyysKLzDpvFz3g4Id+6kYVmETNy7ILgaFccZ0N8OZhsm0Q+E5PEBV9stG
         tTm2eidYTQXb9mwOs5kOYnf+CLNeGHi4OziOUAHeDMh+r66riOTbQ76CaCPh+btspJCX
         rt+DT5fyUGDvywAuuNIHdD6mIWWlFgscl1FyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=PaQ00ZGEy4Uu84RCOZUTfeFZWA/YaY1Ww6m8YLQkvhs=;
        b=5v2z6ZIsNTEPeCKboRKD7l3Yw7B6JdQDgy0XQrm62RaNxYfL4EjSEIrtVE7nPijX9a
         tWxyR/k+/sz09GjJ90nSmP/ujfL70ZnnGJfL2gcy8uNADMxgRtK6it3xBJmbpQXYhxrp
         a0Du60GYJ2rc2jHKmwMjVUc0UUAViWdwcjhQKafepPHfB9g8gpx360Rn6GECTnlSrlDh
         R9L1DXc2bCVxUeyH69NgjJcUWHC0z6d2CCE3G87ARZMPEkCcP8s5UkOn7uoJ0PCGMJKS
         a3BugeMR9ivwJJu1bCed8RD4r7hTyOZ8Naf3pcSMsiIBF7FaNH+a6xzCFmSMywAFmG0v
         tO2w==
X-Gm-Message-State: AOAM5331PzaeOJm+dXwalUQ8ZfFUA91cvg2U0VY9oX5n9Rdlz8hqd59+
        CBebt6QSQnZNE04X+uNyAFGHlXAsni1lq/wnlcWxIQ==
X-Google-Smtp-Source: ABdhPJxCjyQFH++dUTHe2DWuuQH++OcFJWe93JshD2AnAevt+Mu3F1DFIzPwztSodo1vFR26oriYaUigBSgSRnqGH88=
X-Received: by 2002:a54:4506:: with SMTP id l6mr49058489oil.32.1637019866000;
 Mon, 15 Nov 2021 15:44:26 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Nov 2021 15:44:25 -0800
MIME-Version: 1.0
In-Reply-To: <20211112084302.2447931-1-yangcong5@huaqin.corp-partner.google.com>
References: <20211112084302.2447931-1-yangcong5@huaqin.corp-partner.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 15 Nov 2021 15:44:25 -0800
Message-ID: <CAE-0n53zMYmm2DxmptUWNzXvLQb+4bY1mDby1G78Jf1Hjdbadw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: parade-ps8640: Fix additional suspend/resume
 at bootup
To:     Laurent.pinchart@ideasonboard.com, a.hajda@samsung.com,
        airlied@linux.ie, daniel@ffwll.ch, dianders@google.com,
        jernej.skrabec@gmail.com, jonas@kwiboo.se, narmstrong@baylibre.com,
        philipchen@chromium.org, robert.foss@linaro.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting yangcong (2021-11-12 00:43:02)
> Through log and waveform, we can see that there will be additional
> suspend/resume when booting. This timing does not meet the ps8640 spec.
> It seems that the delay of 500ms does not satisfied drm_panel_get_modes.
> I increased it to 900ms and it seems that this problem can be solved.
> To be safe, I'd just round up to a full 1000.
>
> Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
