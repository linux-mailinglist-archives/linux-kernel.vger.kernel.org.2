Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A56418FC5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 09:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhI0HTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 03:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbhI0HTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 03:19:10 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595B5C061570
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 00:17:33 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t10so73036826lfd.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 00:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tuPT9UMjnSF9/x2VxZzbMJbiT3SxCc7RjnbYKdMUOXk=;
        b=NpIOiC9JGVYQ+YGJXTh0LGscT4eTT3N3WB0MpB+nmp0e3RAkiFa2U+CmaWuVoqhtFB
         F4roQ/o1rqwAxesyKp5TXE9xgLRngmIpg3EjrhOt/gtJUwL3ikK+DfcjscR5NvdsGYnR
         5pO8pRUAAMSth27MjzOIJQ1hl4F0G9pW3gxD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tuPT9UMjnSF9/x2VxZzbMJbiT3SxCc7RjnbYKdMUOXk=;
        b=Uvn5F5tsFp05uJU0d+uDx/s374lEvt7gFLtDYGEtIdzj/pLSmqZ+laEUUCbbwZJCID
         m0BLDXpVH2E8yTrz9XgCXH6oR1rMTtp6UlWOa06R0H7N+EiL3TMVRTC88ZdyP82Sq02S
         3tfJlJpsaIfUmPLAZLdDtwSAZPgjb8c7E7gciie4bxz6tRqi1gFG0/wncJq9G1tNALe7
         7IxTiGSbsRAC4Q1DsCutFhxmLSyo8ny/Ce8KPbUKwTbNEIDXhBsqFZhb/mtLTL1WY+hf
         fuD0xzBPOIZ/b34ouJ8IZARarpvhBM2Equn6kh5m3r399fBddQwpToOMOR/Kwk2DF6Vg
         23PQ==
X-Gm-Message-State: AOAM532UP3Z+DNCPaB2DWEArQO8WrYHcrMIjgA7ZEWDlJAVdQ5dieDbz
        BdmUrYVrCp4FXQ+K4p2vjHoVwF9dKUN3+oeUMdrFR3CI5Qc=
X-Google-Smtp-Source: ABdhPJw4lCvDI5qxWeg9+Zx4oGNCCIFt2BJqNldnjQXhKLPJfzJPOcHS8LHpQntsfImx7DzCXz9/tkEB43a7uAvl+iE=
X-Received: by 2002:a19:c3d3:: with SMTP id t202mr23208923lff.678.1632727050548;
 Mon, 27 Sep 2021 00:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210924162321.1.Ic2904d37f30013a7f3d8476203ad3733c186827e@changeid>
 <20210924162321.2.Ie8ceefb51ab6065a1151869b6fcda41a467d4d2c@changeid>
In-Reply-To: <20210924162321.2.Ie8ceefb51ab6065a1151869b6fcda41a467d4d2c@changeid>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 27 Sep 2021 15:17:19 +0800
Message-ID: <CAGXv+5GVpm2PeKkHxnn4gd_WE_Pyoij1RjYiJbAMnyze6RT5oQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/rockchip: dsi: Fix unbalanced clock on probe error
To:     Brian Norris <briannorris@chromium.org>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Thomas Hebb <tommyhebb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2021 at 7:24 AM Brian Norris <briannorris@chromium.org> wrote:
>
> Our probe() function never enabled this clock, so we shouldn't disable
> it if we fail to probe the bridge.
>
> Noted by inspection.
>
> Fixes: 2d4f7bdafd70 ("drm/rockchip: dsi: migrate to use dw-mipi-dsi bridge driver")
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
