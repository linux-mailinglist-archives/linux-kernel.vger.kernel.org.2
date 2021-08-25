Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50ED3F7B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 19:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbhHYROs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 13:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbhHYROq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 13:14:46 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4861C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 10:14:00 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso50702212otp.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 10:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=F18YLP2mtr+5HyJ/pmcAHG9a7g1G49mcq+SFUPInr7Q=;
        b=GfAwrm1lDeGg47ZdOF90kEgL7lc1T1Xrt4BgosVgjjBvk/VdcSbyJKyI5oaJIWxjzH
         SG89ZXuStu2PYhQXYa0A9TZ7H+NV0zToeFDKtTUHR0V0yonmsYfnyYX593ISM3fC3fL6
         KVVZOaaq8fTrLL66oNflyXRAyrOr4hDKzidhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=F18YLP2mtr+5HyJ/pmcAHG9a7g1G49mcq+SFUPInr7Q=;
        b=TMdXY3I7UvsNs9AR5ZuJ8D1R5iYJb1qaH84G5ZzKVf0dQknSIPdhP5iM++lVgiuxSf
         OYfWdP9G2dNcaYYv4ETpEKTQ86188UYbUsg5aobsY4arp4hDHrvXY+RVJi4hVHj8A5iN
         ptA22ndND2PDZ/nVUrmmz5KTcFblIIJxNCXEHolUrV2UTiSGHbcBUGIbKcIOQUQOQKRs
         tjmtBA3Beg8TDtJ2auy/9T6ClraFxv/NAdSeiEpa7lefYTSEfCjqW9DU1UKskhJIRFmf
         cTCQz7jQHzU4PGihf47DCmB740ExpTiUWH/9RF4xzZMwKYc9linKLBSgakAhIdztQ8uG
         GKNw==
X-Gm-Message-State: AOAM530K0xh4Kl3yziY2cff6w9wxf1JvyUo4ej3jL0Sp9KiacckIv62r
        xDqTSPxl7uFNAVSQ+XlL9WmyS1ZGSNpY+P6zY2Lq2z2A2S0=
X-Google-Smtp-Source: ABdhPJyKV38cjFSmdW5cvFWhgMhKBwixXeiMVBDXQOWKiGrBfDaTkcrAnUwkuBu1F2nr5lC3n/mVQw1jxQJE67fJ8Xg=
X-Received: by 2002:a05:6830:2b24:: with SMTP id l36mr21330863otv.25.1629911640034;
 Wed, 25 Aug 2021 10:14:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Aug 2021 17:13:59 +0000
MIME-Version: 1.0
In-Reply-To: <20210824181140.v2.1.I8ead7431357409f2526e5739ec5bc3ddfd242243@changeid>
References: <20210824181140.v2.1.I8ead7431357409f2526e5739ec5bc3ddfd242243@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 25 Aug 2021 17:13:59 +0000
Message-ID: <CAE-0n50Yd3J_g=tuSHZvxqVCRH8Cj_-VKy1cx5N=LNXwbh8wng@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: parade-ps8640: Reorg the macros
To:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>
Cc:     dianders@chromium.org, Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philip Chen (2021-08-24 18:11:55)
> Reorg the macros as follows:
> (1) Group the registers on the same page together.
> (2) Group the register and its bit operation together while indenting
> the macros of the bit operation with one space.
>
> Also fix a misnomer for the number of mipi data lanes.
>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
