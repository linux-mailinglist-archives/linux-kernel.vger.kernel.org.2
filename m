Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130233ABE8E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 00:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhFQWNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 18:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhFQWNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 18:13:24 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB06DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 15:11:14 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id s15so5803606edt.13;
        Thu, 17 Jun 2021 15:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zesdvlDOTsfJCYMfxYc1eGdUgx4s/GRB2e4AjzOW/PE=;
        b=c6d/7vzaOUVDMePr0fBGYrzT6WgLmo55vDCeFW1vzWwyGxuLIlhG7gIfj8nzNJV8n4
         l9MRyCfWE8korSmGWWISVxk076slUO70E+qg/fu86m+bLv0AFxxLCtx9MADzS3WVZZ8i
         p5lcuLl2inhxGD5UK+n8/JszeE6MHb0efkxHaYvuLNBVtm1/xczacfrbC3heM9/dN32H
         E2zuS4aG5Q7IdGDhLzDVluLau1J85kuVISp6NXPdI8zHthb2E0Y8KAVe70C6XW7UPbl7
         3TPXjv3Z9RDOZM9idFbHvkrj8av94bUt+JUqqqFEIp+rKTL4Cnnfl+jdfjuQEH+1r8F6
         S6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zesdvlDOTsfJCYMfxYc1eGdUgx4s/GRB2e4AjzOW/PE=;
        b=G8E/GW3lf8d+8PI7Dd4FN3e29wPRdTuRClf0S539iAOOsWQbe0f5MlVmpfiVCsvvVV
         d4x1t5Es1YN13iNqcsdbv/dEthZmA4xuGR+Ckf5ejhW8D+oD1Tj4Q+FM5RPiNjw4JOZu
         pX6NquArh4DuvbItIb330wgLFxfeFcdDqosPCz1gylzj/jUtnCtGfdiCQeCo6bvo8fJL
         RoDHEzS0U71HYXVyui/pcaJST1GzU8F3bGc/FIzVUP4FupVW0MletOIgxwudfxF8leSy
         IPx6qkJKGcrnvcdhjinkGz4oQcx7PbVwhJlP+7MDPqYwbSkIySNo92udUVQ9EH8eA5OH
         nmdw==
X-Gm-Message-State: AOAM533uWRNzbgj1o32GJy0XruVP/rQGxtpi9Omd/Jp0FEWJONjwIh/O
        SkpfpdVkwSil3lVFbbF5iDpKO3KBgCLLTuqFb/I=
X-Google-Smtp-Source: ABdhPJy+s7G8n2muPksCVmlW0yHIS9m4Uk35n+fl3NqiK+lQz3IllqAa/h2ZJAFr1oZZRzDtew4JHXz2WSDJXOYfza0=
X-Received: by 2002:a05:6402:177a:: with SMTP id da26mr724355edb.40.1623967873323;
 Thu, 17 Jun 2021 15:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com>
In-Reply-To: <20210617194154.2397-1-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 18 Jun 2021 00:11:02 +0200
Message-ID: <CAFBinCDVnBApYziHazeS8f2FXHQ-tUS55-g6B22c20OtfYD=xw@mail.gmail.com>
Subject: Re: [RFCv1 0/8] Meson-8b and Meson-gxbb USB phy code re-structure
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     --to=linux-phy@lists.infradead.org,
        --to=linux-arm-kernel@lists.infradead.org,
        --to=linux-amlogic@lists.infradead.org,
        --to=linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Thu, Jun 17, 2021 at 9:42 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> On Odroid C1+ and Odroid C2 USB feature is broken
with "broken" you mean the hotplug and IRQ issues you describe below?
I think that these are not PHY related but rather a problem with the
dwc2 IP/driver

> this code changes are just re-structure the code so that
> proper callback function execute in proper order.
>
> Code changes losely based on phy-meson-gxl-usb2.c
there's a big difference between the Meson8 and GXL drivers:
GXL requires changing some of the PHY registers at runtime based on
the mode (host/peripheral).
The Meson8 PHY however (as far as I can tell from the 3.10 and 3.14
kernels) don't require any runtime changes based on the mode.

> Initially if we connect USB HDD at initial boot it get detected.
> but after that usb hotplug of USB HDD is broken.
> I did not observe and USB debug events messages to trace the root cause.
>
> Another issue I observed is increase of USB interrupts event
> even if there is not much activity on USB ports.
> I tried some clk changes but it did not workout for me.
I suggest reporting this to the dwc2 maintainers and asking for advice
on how to debug these issues.


Best regards,
Martin
