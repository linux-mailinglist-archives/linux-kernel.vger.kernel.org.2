Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224663E8562
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 23:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbhHJVes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 17:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbhHJVeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:34:44 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06426C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:34:22 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w6so1190598oiv.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=bgpLmyHy//Rdaa2myVwlWVrvOLDfl36DscQjlx6Wvgo=;
        b=MzbxM7E5cFVw9K4JPRmW3EY6dt63hd511MvQfWIKO6m0qOos2mondDT1SaUGSMj7ht
         NcSJ+5X8jXuH9wVdMuQY72+kavtSYJu/hU+yxJfKkFWYi+IdZurvSzVj4LS7P834rcth
         5ly72EwOKQ2hAwWD/V6PLKThnQNH1Lowt9EsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=bgpLmyHy//Rdaa2myVwlWVrvOLDfl36DscQjlx6Wvgo=;
        b=ZatxycuKBcE6IUhlPCBGrsBRDlAScHATJnEImsdR3eYY8BP+Fh6GqtwTbkS4yqcp85
         QLWNeGpltoZSTtlX7Th/MPa/d6cb9ku5qYEgB/9krN8wz5bfxGaih+Q81VXgjXE+rVU4
         kjEDLO9M2GnS2cI7MOwNHDKPhESh+q5IiAN6UrB4+Ybquu4TuVZhqvaBK8jCkkr+USGB
         43/HIJFVj4Nkf01N2ErRssaRx2KFsfFDajQx2fypRLmVljB+1lAA6nHrApzw20/u0iVA
         Co5QGq4TSb9YHgQf7D+oziSeRpD2lqLzAdyhLb3c35m37SW/tE0BX23X2xS7fU2und1F
         GxCg==
X-Gm-Message-State: AOAM532bDQb74cLLmhn8VIo13dkMxJ41ROnIt0l7bipCQB2IO/IfkeHp
        G8hdbUUmClYA0map18/2W/SZOIvXMCYB2Z+NQU5ZFQ==
X-Google-Smtp-Source: ABdhPJwtDSdSAO44q6BeLqlIjD2XgZBA9t3YQSpodb5FKKDjqUdo86V5/S+6qFY8mQ16RmOc1Rkfqd+TR4TcPze1UjY=
X-Received: by 2002:a05:6808:114a:: with SMTP id u10mr7816788oiu.19.1628631261456;
 Tue, 10 Aug 2021 14:34:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Aug 2021 14:34:21 -0700
MIME-Version: 1.0
In-Reply-To: <1628196295-7382-6-git-send-email-khsieh@codeaurora.org>
References: <1628196295-7382-1-git-send-email-khsieh@codeaurora.org> <1628196295-7382-6-git-send-email-khsieh@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 10 Aug 2021 14:34:20 -0700
Message-ID: <CAE-0n525MQTy8rFF1JDZTqDfGpWZoUTFkqA7Svk1CRkuDmioiw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] drm/msm/dp: return correct edid checksum after
 corrupted edid checksum read
To:     Kuogee Hsieh <khsieh@codeaurora.org>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run
Cc:     abhinavk@codeaurora.org, aravindh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-08-05 13:44:54)
> Response with correct edid checksum saved at connector after corrupted edid
> checksum read. This fixes Link Layer CTS cases 4.2.2.3, 4.2.2.6.
>
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
