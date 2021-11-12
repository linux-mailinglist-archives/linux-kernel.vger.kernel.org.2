Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B497144EB6A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbhKLQfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbhKLQfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:35:07 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE73C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:32:16 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id k1so9528701ilo.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZQU60Xp18Hdsmtr7VDsvNRYsO9Fr9Pv2XyHmxjj+mM=;
        b=KuCqVetYf798pzMpcifYfYBDXK7mJj8RA51iDj8N5l+Hr6lkTUxdpghhQ5jIk36Mth
         wl4kFkIE3mufICbUYUMyO5l9GhOWg2rrWnFEOtLxzTSdv7cJuUBFXVOo/o8RLBg3Siw8
         LyHz6ZvZjh2sGHFGCifhnNbxYDuwOX6YT1ZVEMevpd7LFwXs1Rmu9k8DS/5n1pBmSMTT
         GjeArjcZePLAIQdrnN+IKo11faF3a5gjiLW7Px3vgI8g53ptQX9AJvBHmsU4ZWDM1zfv
         DQ4Nyq7pXqwd9oFi+UH9P7wsxxQIPhTb4a23Fea4vkvRAKmOI1GxAlJ7R/uy8IamChq4
         Yhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZQU60Xp18Hdsmtr7VDsvNRYsO9Fr9Pv2XyHmxjj+mM=;
        b=ocfCENB31cmV/VcMNpAclRXKThGnH0wSuHARGTCHw+XD2UbiEW0O/YSK/vLtgq7VFi
         VDurRZYgwj52Ct8z6IkgOW34eYNQ0XddvjDuVOcX1DghOZIc0Jqs1Yp0z7t4XSWGVz6b
         YUuePKbxyINjbPa7B/EZszyKnZhgNnjncxcEUyJfpX6Fl1uUfxqAaVXi0UjdoqrPS0JK
         oSU0q9+ISKozyV6Nom/Fa0w+UGbSVGwizOL7CRjn6Mc5B6xapM7en3gcDqJy5C+NS/F6
         tc60Lnh0TeKXDRpHpxgSLb19Eq0+KpDxBRzi6uNqPhynYSzP4dcVO4m4brquhsxtL/T7
         AOvw==
X-Gm-Message-State: AOAM532bBWigfuzY57L8OjiRZL00f5aEvR6UTJpJFS92Wnb/zKHosjY8
        DGWcVYMKaQwFC/+5DlH1Aa/p9ZrNYUrhpsvtWmv/nQ==
X-Google-Smtp-Source: ABdhPJx2vazsN9hiP4Pi5PPRhbKghUbvJI/jrMtOuxA3B6w+bLX6dIBky+qiit4PlBLgRfNrY9wQl1QF0SBSxiEolaQ=
X-Received: by 2002:a05:6e02:144e:: with SMTP id p14mr9934206ilo.180.1636734735453;
 Fri, 12 Nov 2021 08:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20211112084302.2447931-1-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20211112084302.2447931-1-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Fri, 12 Nov 2021 08:32:04 -0800
Message-ID: <CAD=FV=XWdA5kC5VpRPNWzCQDJjmDg5s7bP=sa7yVuqnRcxWf+w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: parade-ps8640: Fix additional suspend/resume
 at bootup
To:     yangcong <yangcong5@huaqin.corp-partner.google.com>
Cc:     swboyd@chromium.org, robert.foss@linaro.org,
        narmstrong@baylibre.com, laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, a.hajda@samsung.com, philipchen@chromium.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 12, 2021 at 12:43 AM yangcong
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Through log and waveform, we can see that there will be additional
> suspend/resume when booting. This timing does not meet the ps8640 spec.
> It seems that the delay of 500ms does not satisfied drm_panel_get_modes.
> I increased it to 900ms and it seems that this problem can be solved.
> To be safe, I'd just round up to a full 1000.

Do be clear: I'm still not convinced that the old 500 ms actually
causes any real problems. I think someone is just measuring with a
scope and upset that they see the device power on and then power off
again. In any case, if we can avoid an extra power cycle at boot then
that seems sane to me. Since this is a tiny change, I'll plan to merge
it some time next week unless someone yells.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
