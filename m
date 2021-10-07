Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA2D425D00
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 22:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240916AbhJGUNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 16:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbhJGUNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 16:13:35 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6813AC061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 13:11:41 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id c26-20020a056830349a00b0054d96d25c1eso8913648otu.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 13:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=RQk4fZ8zAs/6aRjZB+mzOwZtqbl00fU4slehYKDsrqc=;
        b=IHhVwmWPbTvQi99ZO+D11B1elyHaSTPHfBa98vxfDPsiU7ydHtTDkbfrw+5UWn2CIL
         jQWGqK/pKPW/1iSVBTjlVxyLFQftacDlm45yTJ9znDdg0rSnqXGMOUPUD0Vmhi3yxtxK
         BIPcL3MhLZC72XE6J3d8bsGziRr3hllyrkc1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=RQk4fZ8zAs/6aRjZB+mzOwZtqbl00fU4slehYKDsrqc=;
        b=riwTscfzct0SJOCGVjU9X1d7GXUloA2STLJosO13OwZeYXcFgYUz+qiJ0GjktO+yBH
         xqLnfiUi4q/b9p9GFdxjcbyfjj6eri5v57g4gc/MkGY+xxGPABngRBO4XPlxwNm1e/c4
         5ecHGQMjwT/Bt6iVHGRdGRUccaYmDfMyYAlXDF7tvwBUC93sEpWWodnjQzjkQ2ut9NTr
         5+9HjWfpuIGGaMV6a4YwU3Qj3qXoLvADvnsmf+ENcB+ufSA2CFeqVRqI9/V8A0EnSsqH
         rdxvpQ0a83K+1Z7qX4y7zU+5ya07sV0Qs0JpQgBlgPbJH1AsYHwQUL5h7gNyelZx1v1O
         jv2Q==
X-Gm-Message-State: AOAM532LULNrlV42ddWGApZRSh7htN/NtVuiAUmXnvhoHP14xfeQUTAM
        f+mj8qRFc77iOCCeB+OSJFGr+DPHsZTyJnG5deqCGA==
X-Google-Smtp-Source: ABdhPJw6F0cMIR3gHGSKrivUlJvz9nMPEORHTG5UDv1ab+eSfl1wmDgSWj65PdXu+FyfAhZ1Zixs1O4RRYobdhRF36Q=
X-Received: by 2002:a9d:12f4:: with SMTP id g107mr1438053otg.77.1633637500801;
 Thu, 07 Oct 2021 13:11:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 Oct 2021 16:11:40 -0400
MIME-Version: 1.0
In-Reply-To: <CAE-0n50YqKr1nKy-4WaxsfuwPiJ5kZcf46t-U_4i-TpfXzOX1g@mail.gmail.com>
References: <20211006193819.2654854-1-swboyd@chromium.org> <20211006193819.2654854-3-swboyd@chromium.org>
 <CAGETcx9T59dHXodt9MW=tTV_hYhtNOZzYFT=35D--VN7WJ0GqQ@mail.gmail.com> <CAE-0n50YqKr1nKy-4WaxsfuwPiJ5kZcf46t-U_4i-TpfXzOX1g@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 7 Oct 2021 16:11:40 -0400
Message-ID: <CAE-0n532XYgT=dTTCyLcwikvxgUyGi=TcybDh=v3wQTNb=wqyw@mail.gmail.com>
Subject: Re: [PATCH v2 02/34] component: Introduce the aggregate bus_type
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2021-10-07 11:40:07)
> Quoting Saravana Kannan (2021-10-06 20:07:11)
> > On Wed, Oct 6, 2021 at 12:38 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > diff --git a/drivers/base/component.c b/drivers/base/component.c
> > > index 0a41bbe14981..d99e99cabb99 100644
> > > --- a/drivers/base/component.c
> > > +++ b/drivers/base/component.c
> [...]
> > > +                       continue;
> > > +
> > > +               /* Matches put in component_del() */
> > > +               get_device(&adev->dev);
> > > +               c->link = device_link_add(&adev->dev, c->dev,
> > > +                                         DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
> >
> > Remove the STATELESS flag and you'll get a bunch of other stuff done for free:
>
> I tried that and it didn't work for me. The aggregate device never
> probed and I was left with no display. Let me see if I can reproduce it
> with logging to provide more details.

This patch fixes it (whitespace damaged sorry).

----8<----
diff --git a/drivers/base/component.c b/drivers/base/component.c
index 65042c9f8a42..43cac9ed70b7 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -202,7 +202,7 @@ static int find_components(struct aggregate_device *adev)
 		/* Matches put in component_del() */
 		get_device(&adev->dev);
 		c->link = device_link_add(&adev->dev, c->dev,
-					  DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
+					  DL_FLAG_PM_RUNTIME);
 		c->adev = adev;
 	}

@@ -749,7 +749,9 @@ static int __component_add(struct device *dev,
const struct component_ops *ops,
 	mutex_unlock(&component_mutex);

 	/* Try to bind */
-	return bus_rescan_devices(&aggregate_bus_type);
+	bus_rescan_devices(&aggregate_bus_type);
+
+	return 0;
 }

 /**


The important part is ignoring the return value of bus_rescan_devices().
It's a cycle problem. The last component is probing and calling
component_add() in its probe function. The call to component_add() is
trying to probe the aggregate device now that all components are added.
But when it tries to probe the aggregate device it sees that a supplier,
which is this component calling compnent_add(), hasn't been probed yet,
so it returns -EPROBE_DEFER. That is passed up to the component and it
defers probe.

I don't think the component device cares at all about the aggregate
device being able to probe or not. We should be able to ignore the
return value of bus_rescan_devices() in component_add(). I'll add a
comment to the code here so it's more obvious.
