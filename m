Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE21454B64
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 17:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbhKQQxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 11:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbhKQQxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 11:53:47 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2C8C061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 08:50:48 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id s14so3425415ilv.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 08:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jLYkMtFnDmV7z5mlviZaA8HEm3Bspty3ASVJh0ASF+0=;
        b=a3S9Zdzy3vVzknJ2+MHEl7tGolYPQfJtco92MsePu1QameG4aar+6NG8EaO27mYF5Z
         ZmXJl913QfJWkppAjJFBObbxLFbQcPWz03bylfP1u6elDT7gvVP06/iicHQBbHg3OrKv
         BT3bDdw9OgsRnmKwfL9qUvicbYLejYZH/f6RQRlWfo9ke4vnkpeyY8iAj+oJf9Bv/rgv
         SmmRrxajfQ+l2ylCDENTpMOKpMg6IYevTI/DoAA3OL5vZs4BRjHfSCpKgxooL1LvwBx5
         KS7xc5YiqBBxkPGILVUw2uysiZcrNYzDkx3pPMRdWviyGmbh5iLnLTb3hgwxHA/dYtoi
         B+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jLYkMtFnDmV7z5mlviZaA8HEm3Bspty3ASVJh0ASF+0=;
        b=xD4Fa6V3JHMQDlfC0OtOyLy0SHMIBtY+YWpFLTQlKmXxjTmLbYHKcF3T+JIqc4d0Px
         zKpHBcTZXnRSwlVhLk6+WkwNRoO3l+5l4DQhhQ2ZPDTaFey529KPE7y4h38DWrYw4CzX
         m66RK3ePfygYgFoICzSJU2K+ZFo2Ks/TuZRuaId3o8Xr/KlE6thTjt0vyMJjGalq+9oL
         2ZWhYop59z0N3+NOkKATPEaUfcJtujLNP0+2n9tteQR6FU8XQXpGMVWlV8HG10C5hdTN
         jiEkuJMyL4L87QguBVO+0ZL5HrXpzdFdK1vtKNnV84vP7/pgzOQBmmWQTuxVtGKQsGea
         hWsw==
X-Gm-Message-State: AOAM533tMcE90TOBi3G0fHv68jI3D4EFUXw7VzM+OOLqPY6AQdtPjDIq
        UVgvJjq897OhFOahAUiSzW8QeYwXprgbSRrgnq/45Q==
X-Google-Smtp-Source: ABdhPJyHO2KLqbPMiL7hCboUwfUWjOcp+fzSzCmfoiGYW7MY2QXlhJC/3FBFB/CsoleOuaxPymfWFzGOKO4POP7mF+8=
X-Received: by 2002:a05:6e02:144e:: with SMTP id p14mr11313033ilo.180.1637167847569;
 Wed, 17 Nov 2021 08:50:47 -0800 (PST)
MIME-Version: 1.0
References: <20211112084302.2447931-1-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=XWdA5kC5VpRPNWzCQDJjmDg5s7bP=sa7yVuqnRcxWf+w@mail.gmail.com>
In-Reply-To: <CAD=FV=XWdA5kC5VpRPNWzCQDJjmDg5s7bP=sa7yVuqnRcxWf+w@mail.gmail.com>
From:   Doug Anderson <dianders@google.com>
Date:   Wed, 17 Nov 2021 08:50:36 -0800
Message-ID: <CAD=FV=XirCUp3t8sM_zXwZJ_x5-zbXzLQCdHHyor=5q2jr8ZrA@mail.gmail.com>
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

On Fri, Nov 12, 2021 at 8:32 AM Doug Anderson <dianders@google.com> wrote:
>
> Hi,
>
> On Fri, Nov 12, 2021 at 12:43 AM yangcong
> <yangcong5@huaqin.corp-partner.google.com> wrote:
> >
> > Through log and waveform, we can see that there will be additional
> > suspend/resume when booting. This timing does not meet the ps8640 spec.
> > It seems that the delay of 500ms does not satisfied drm_panel_get_modes.
> > I increased it to 900ms and it seems that this problem can be solved.
> > To be safe, I'd just round up to a full 1000.
>
> Do be clear: I'm still not convinced that the old 500 ms actually
> causes any real problems. I think someone is just measuring with a
> scope and upset that they see the device power on and then power off
> again. In any case, if we can avoid an extra power cycle at boot then
> that seems sane to me. Since this is a tiny change, I'll plan to merge
> it some time next week unless someone yells.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

aa70a0996b0e drm/bridge: parade-ps8640: Fix additional suspend/resume at bootup
