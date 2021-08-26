Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017BF3F8CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 19:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243200AbhHZRW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 13:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243135AbhHZRW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 13:22:56 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1C5C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 10:22:08 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id g8so4054716ilc.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qKQjjsM4J8O5CgSWAuv+6gyXK0hCVd/AxIuqKbifVi8=;
        b=c5DyMLynQk1gn4WXQI278terFJZS6NE0EbIEyUor/Df3RXEATH9/MTDp2/GBb+5mPd
         Cq1tHPUfEhEuzDPPiFJPCHKQlf10zJxJ8h68Nq3ZH4yMP837kdjazwLbnbPymm7UH629
         yNB3j6kxRc7fWi+9sdt9TmGchIiCjY81a9kEE/puyORvKpHae0aSEORdzQH8MrPP5sX4
         DKHTC8exfKX1zbTSqdain05CO2fSIYxjZLcJpTGZSUFi6HUbPOD818vVvNqdFfL23gR5
         6tmJPrJlnZXKYj7oOXjDwniYn/FUdIYpC9iioYnzIwW+OOUsC+j/8HtK09Eu3q/HL3mq
         31mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qKQjjsM4J8O5CgSWAuv+6gyXK0hCVd/AxIuqKbifVi8=;
        b=pQn/oFSjZlCbQqf1MDv7gRlt/kEsQn0BiW2EOxb8oDdARTwxqTMh+I6E17TaASaayy
         5wZ2PvCGeZSSVYg1Nd4UQrAPZgXV+CaT31f/+1HOY//b/TOYcr7ItjokbjlZr5qockV5
         /iWAKoa1Yrm+iylO6z9HiWGkjS6N2ytBkuvdvGxQgnvFTSt3uRjJYx7ICO8/yZAb+7dL
         gYTpNUNJ0DbRMrQOc3N0jh6OqPmgA7dYHUCV/nBHyfItfbJhaPtCZse3UVpEGGsYkup+
         Gh06UCi4S+8Y1OFhSAPkC/mHIdcS+H3MVXOnXvmfo/+QFEuD+Ii/lebXaaZ9yq6rUziM
         la3Q==
X-Gm-Message-State: AOAM530C+UMHaX3LtzNPetLoSOGXGnot0WE24j8rSMnVn2osbRPca+PR
        x3xyQ5TJUxDaltjsOUqfCVE8qgIXDbS72dsYn8m/qg==
X-Google-Smtp-Source: ABdhPJzEP6d3k2PmiDaAY6pcR6U/TWQ8ba7bFfwnlUzENowhcCUx9XWHwgdsT9momgcLgJkyDpiLoam3ywnLdyU69E8=
X-Received: by 2002:a05:6e02:168d:: with SMTP id f13mr3602680ila.12.1629998527624;
 Thu, 26 Aug 2021 10:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210826110311.613396-1-yangcong5@huaqin.corp-partner.google.com> <20210826110311.613396-2-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20210826110311.613396-2-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Thu, 26 Aug 2021 10:21:54 -0700
Message-ID: <CAD=FV=WSQBpGTxYKur03VoR1=UN6MekbSxT_sOy7udxWXDG95g@mail.gmail.com>
Subject: Re: [v3 1/2] drm/panel: support for BOE tv1110c9m-ll3 wuxga dsi video
 mode panel
To:     yangcong <yangcong5@huaqin.corp-partner.google.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 26, 2021 at 4:03 AM yangcong
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Add driver for BOE tv110c9m-ll3 panel is a 10.95" 1200x2000 panel.
>
> Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/Kconfig              |   10 +
>  drivers/gpu/drm/panel/Makefile             |    1 +
>  drivers/gpu/drm/panel/panel-boe-tv110c9m.c | 1303 ++++++++++++++++++++
>  3 files changed, 1314 insertions(+)

Breadcrumbs: discussion continues in the cover letter of the earlier patchset:

https://lore.kernel.org/r/CAD=FV=UFDRG9TJis28Wtsz9RVhp3Xk35stpLyY5ExLx3=8yxPQ@mail.gmail.com

Quick summary: discussion is leaning toward just supporting these new
panels with the existing `panel-boe-tv101wum-nl6.c` driver.

-Doug
