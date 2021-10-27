Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC72943CC69
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242622AbhJ0Okj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242616AbhJ0Okh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:40:37 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8828FC061767
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 07:38:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id lx5-20020a17090b4b0500b001a262880e99so2224811pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 07:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=619X0KptUed08s0CUBhf/N/JswW0tMPE0BHSDIcOX4Y=;
        b=VwUW9DxGBSkeRgyMzwMqoMCIN9AgwTpLSDg6/KPh+kDvDc76Jrx/wL/eO0gBa4ZpUX
         K0T4FkjE7dVSToBvaN//CHtRYgzB2bUgT/EVG94UxRfxbTBp727tSp88UIjnm8/rxxyq
         g1hKFq/miAgkJZ/NUoCLqVNWadua4TUfxhZKN4Z4+pt+o8KIPBzjvSGsW7HMqkD+2+D7
         3K3mUV5UdUr3krH7L+J+LOvG/kSzhReVRBqR/HNtFRQcr4nEo2uuGLq6O3LFykgA2xht
         MtlLMOL07lOLrRMNnOpHEPA+ft36FjoTkvHGH7kKelhyyATSqxgFzqRWFRyazw6WgIvE
         rHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=619X0KptUed08s0CUBhf/N/JswW0tMPE0BHSDIcOX4Y=;
        b=4dT7GM/W4/MXSDBRrCcefFiD/uYCflrpltLNaL15sv/cCliVgD8xNx5p7Ew6mcp7LG
         mmYe+JuwX6OfC0zGsAMM5wIEOWzXfA5JMRPt4CIS+e0b8kIqfaOHQtlMHL/PSjyNiVkZ
         hysRRUHR8/pVp9HWryQ5aqA3P6BG+EFVHH8b5csXrpRV7eneIqYhZYrTVzKVmLbP3MbS
         BLfr50sl8G4VE8B7wkksA9+COs+VAlF9XZPZ2QL2klRqOGWSNGazBr2+ZEyOYVym+1z7
         VtdvTT8QldTuYqkxp15Y87vX1YsGZeM0S6kRVaP0I8UqklsxS8nG1QHVyRVbnYrJRPeg
         0c0w==
X-Gm-Message-State: AOAM532gLrnHnbnYaNX0XCwJernkOymJRyky/RQ7Nxz1La8OkRsZYWbr
        uySYU95kgiVUMzhc/WGW2ZP0Mbo3Ye+0n+nGhLqlqw==
X-Google-Smtp-Source: ABdhPJx2YdwH/KlEpTrc402ZLzsDivRtCZrcToQPCLTj03ywUTQjxzPidpH1dlmQr/eooVdnXa2HBTRcECMeVOq2ZB0=
X-Received: by 2002:a17:902:edc2:b0:141:6a3f:e676 with SMTP id
 q2-20020a170902edc200b001416a3fe676mr3176904plk.24.1635345491987; Wed, 27 Oct
 2021 07:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211025170925.3096444-1-bjorn.andersson@linaro.org>
 <20211025170925.3096444-2-bjorn.andersson@linaro.org> <CAG3jFysN4pFqTrF8tGTVapCzysPkvO=MpYosAJnErY-AW7BqgQ@mail.gmail.com>
 <YXlc+7BzbADe/p4A@ripper>
In-Reply-To: <YXlc+7BzbADe/p4A@ripper>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 27 Oct 2021 16:38:00 +0200
Message-ID: <CAG3jFyuUHd0Ra7zWx6byZUiZkJFVgtPkX6-a2RSqN6aGsyST+A@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] drm/bridge: ti-sn65dsi86: Use regmap_bulk_write API
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "Uwe Kleine-K?nig" <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 at 16:04, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Wed 27 Oct 01:29 PDT 2021, Robert Foss wrote:
>
> > Hey Bjorn,
> >
> > On Mon, 25 Oct 2021 at 19:07, Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > >
> > > The multi-register u16 write operation can use regmap_bulk_write()
> > > instead of two separate regmap_write() calls.
> > >
> > > It's uncertain if this has any effect on the actual updates of the
> > > underlying registers, but this at least gives the hardware the
> > > opportunity and saves us one transation on the bus.
> > >
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >
> > Did you miss including Dougs R-B from v6? As far as I can tell nothing
> > else changed between v6 & v7.
> >
>
> Yes, I missed adding Doug's R-b from v6. I also missed fixing the
> spelling of transaction (transation) in the commit message.
>
> Would you be willing to correct these two items as you apply the
> patches?

Can do.
