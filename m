Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60B7329F6A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 13:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573935AbhCBD2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239567AbhCAUdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 15:33:50 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34664C061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 12:33:10 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id m11so20229995lji.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 12:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QUAIpvEkTlSXH3WpLcUzPSeK+taFsATzFW6uBRGm5Zo=;
        b=r9I1mk8ry9Qaofll5knF/RLPp3sNzGH6X9W0ow0yHchZVd9TyWunN6es1so1AaorDy
         CH0Q8WNk08fBPnOkQLqgrSjoKyzDHNPvxVo3NwAyGY4UNvEVf1/+qUZH/UXPdp2x6yXt
         HeybVa4BH8vntonQ4wH0E1P7tjcDeXgzPmuhLEPHAqQQjfPZviyYTw8y7OKWVULIVqGy
         XxgP/649J19AVvuWO1KLxpNtZzf6NKQk/LE1CC7Db1z/KeAiC1TueGU4IHyZEwj+j3KO
         UDwThgdYvCi0MHgkRu1Te7lM1p2SEoi9Y/ASM3/aleHCWaEUJtIUFivb80XWdCTRFTcQ
         NBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QUAIpvEkTlSXH3WpLcUzPSeK+taFsATzFW6uBRGm5Zo=;
        b=q67nskulLjs0sKN1OFgzgdsXbLMIa/4srVQzxlwpMzNosIlYxism2+GVODUNhQZfrY
         +ra6bJF6WbmZBQtF4Rh8hkVcd5g9T+uqRUcVzP6htxVDV3sAU55MYsoe+3nR+Nfo6w4U
         XoQqfkIFQ1pM3gTf/7+gye5eLCQS8yNPlnQ4vQxiNVQklRdhHCy5b7e8fYA0+7DDHRfl
         Vh6z9TpJmK+HwQsvOiMwMKpyW5YoIWMgQ2B8Chrfl+EgRepeeh1zRvS+Hmjc4wP+mVIi
         G3hkb659jbud+6qTlID6TN0t/ecWhQkDtdHlPjaLAS5r9s9Tpv1yDakUW7G1eht11oiH
         RHnQ==
X-Gm-Message-State: AOAM532wC8BrTVVBBh62iypVXTKEPKGhql7CzC6wizwJK8lDuS1xw/As
        PRdvdXj+BvlWvYHmFxI5L2CVxr6EvSQtbZ0ePJRKWQ==
X-Google-Smtp-Source: ABdhPJweFvJ+LUXwqlJDYWW1Fn8lDlfe4M+n4J5Dmozp+belyfrpQ2uuwRv/yZDlpNcl3/LYsxhlvZV+EJ9CqZgBu60=
X-Received: by 2002:a2e:8ec6:: with SMTP id e6mr10243435ljl.257.1614630788746;
 Mon, 01 Mar 2021 12:33:08 -0800 (PST)
MIME-Version: 1.0
References: <20201217140933.1133969-1-robert.foss@linaro.org> <CAG3jFyuzjbPsMBOOgc2DBBT92H7FPBNdJLKWHF8+7K10LujMbw@mail.gmail.com>
In-Reply-To: <CAG3jFyuzjbPsMBOOgc2DBBT92H7FPBNdJLKWHF8+7K10LujMbw@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 1 Mar 2021 12:32:57 -0800
Message-ID: <CALAqxLXwvP0-FTSajHnLSc9fDRuQifQQwJKo-71jFVSX4SfRhw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: lt9611: Fix handling of 4k panels
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Anibal Limon <anibal.limon@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Peter Collingbourne <pcc@google.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 1:50 AM Robert Foss <robert.foss@linaro.org> wrote:
> +Sam Ravnborg
>
> I think this patch is ready to get pulled into the drm-misc tree.
>
> On Thu, 17 Dec 2020 at 15:09, Robert Foss <robert.foss@linaro.org> wrote:
> >
> > 4k requires two dsi pipes, so don't report MODE_OK when only a
> > single pipe is configured. But rather report MODE_PANEL to
> > signal that requirements of the panel are not being met.

Hey All, I just wanted to follow up on this patch as it seems like it
missed 5.12 ?

Just wanted to make sure it didn't slip through the cracks.

thanks
-john
