Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E6043867A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 05:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhJXD4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 23:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhJXD4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 23:56:40 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09691C061767
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 20:54:20 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id y207so10546836oia.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 20:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RSVUv8wCLMR5NbP2KKxEFrNw99dgjbVZVt1xAWb2Dxo=;
        b=v7OcfIHbtTAqRffqGtqasqZdL3UmgRTpq/uaheUKyEz0T12NzQAsvzGbd4La/vjYYT
         3pOD9gwJBlGkc8MPo45/eDPvKhoQG+5FYCdrHGlRexr4Sn68W1AouG+2Se+H02lwukMB
         QDb7ei+Vs6B6HZp9AtweSc61UXdBAYl6JaJX9ph/Q7tKmsrzWUjC/Gm+VdY7R/t3e4sp
         Now5vxNES/4poJKY919L0zXdgx9IGAU0wadt3cKTs1Uu4xmJ02oC3BeEMYcnS1Q6Hoqx
         VQBhcQvUz3PDhlsWshr8QYPSn4x0KE+RtieKATaoymphpxcXK8Ap/DPQ7EToZpE7OhGn
         dyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RSVUv8wCLMR5NbP2KKxEFrNw99dgjbVZVt1xAWb2Dxo=;
        b=e/pQsGuPCS+Aansu8Rd5QIj4lNm44L+nUrIN+U9eSEro7VxmLldms+nPKTw/mdr429
         Z0Yoc5JkjD7KW5F3vSI9sP7fnDINcH9Xd5Eso877gc9iddUJYrcnPiKj6JdTCfdBGOB3
         SIICzlGkF/ImGsw6Ty48nuqMEzS7YvX/ebO9qzaYLNTYNk0m6+IW5WDhiA3PgL5loBeU
         kPSfciA/+A+d02Ttly7BTAO4x25cmiRADue+cyfyubx6BSCS+SfxjpLPSpQmeHbOatkl
         z2jR0S2FRTyO09rI0WJ0yYArS8ZzQWIhrKAs2ZnLtatrRBETZdsYOWImF++i0kaSk5MV
         0BwA==
X-Gm-Message-State: AOAM531OdmBPEshVeCPCRMmODniyCwi1/IfhjAOWK6r7eOVk0M5A9D8i
        RbQpmtX/QWcqJC3SaEp4gogpGA==
X-Google-Smtp-Source: ABdhPJztJiPTxtqDIWCiiZprKlfavD1GL89TgP/adgnPe7RRnQBmZoQZUNIsvCU6e0NF1TpOrN5C3g==
X-Received: by 2002:a54:4f8f:: with SMTP id g15mr6518394oiy.169.1635047659265;
        Sat, 23 Oct 2021 20:54:19 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id o2sm2650333otl.34.2021.10.23.20.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 20:54:18 -0700 (PDT)
Date:   Sat, 23 Oct 2021 22:54:16 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     satya priya <skakit@codeaurora.org>, Vinod Koul <vkoul@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: pmk8350: Make RTC disabled by default;
 enable on sc7280-idp
Message-ID: <YXTY6BdmKBa+jPeN@builder.lan>
References: <20210929153553.1.Ib44c2ac967833d7a3f51452d44d15b7b8d23c1f0@changeid>
 <86b0d847ddf06c1b445f3dbac9c771a9@codeaurora.org>
 <CAD=FV=WnMnEckHdu0DG3U8MnyjwQ42aybFxq35nWSLG=vs=LGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WnMnEckHdu0DG3U8MnyjwQ42aybFxq35nWSLG=vs=LGA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18 Oct 16:45 CDT 2021, Doug Anderson wrote:

> Bjorn,
> 
> On Wed, Sep 29, 2021 at 9:00 PM <skakit@codeaurora.org> wrote:
> >
> > On 2021-09-30 04:08, Douglas Anderson wrote:
> > > The RTC on the pmk8350 is not useful on all boards. Some boards may
> > > not provide backup power to the PMIC but might have another RTC on the
> > > board that does have backup power. In this case it's better to not use
> > > the RTC on the PMIC.
> > >
> > > At the moment, the only boards that includes this PMIC are sc7280-idp
> > > and sc7280-idp2. On sc7280-idp I'm not aware of any other RTCs, but
> > > sc7280-idp2 has a Chrome OS EC on it and this is intended to provide
> > > the RTC for the AP.
> > >
> > > Let's do what we normally do for hardware that's not used by all
> > > boards and set it to a default status of "disabled" and then enable it
> > > on the boards that need it.
> > >
> > > NOTE: for sc7280-idp it's _possible_ we might also want to add
> > > `allow-set-time;`. That could be the subject of a future patch if it
> > > is indeed true.
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> >
> > Reviewed-by: Satya Priya <skakit@codeaurora.org>
> 
> If you're still accepting patches for 5.16, it'd be keen if you'd
> consider taking this one. Thanks!
> 

I've picked the patch and hope to get it included in v5.16.

I do however not understand why the commit message so clearly defines
that the only device including pmk8350 is the sc7280 idp when the
sm8350-mtp.dts contains the following line:

#include "pmk8350.dtsi"


Perhaps I'm missing something obvious, but I took the liberty of also
enabling the RTC in the SM8350 MTP.

Regards,
Bjorn
