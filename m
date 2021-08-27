Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B9E3F9A72
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 15:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245209AbhH0NsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 09:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhH0NsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 09:48:12 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D39C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 06:47:24 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id a15so8559559iot.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 06:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y0kIZxdG2WP5UVtm2i0XaO2Bfut6JUxDjhvFbpFOnGo=;
        b=JSu97EaVGMjtQz6hYY6AI5sMmCkndzrTwaujZd7EI+5ltUCYPaLKhEwB6jjgRrI3nk
         WYGpWj6vaCJwjq22DPQhtUxZIPZsPb/0sKt2rkpMP3/BcGUclalMiFrrEngizO7bL/Y+
         dPmWWvxlWCo1jjdczL8iZ2pkyJ+v4ADBp/DrG8KuCWcwPLqb26T0U4Izc7gTkOgEIX3R
         uSPDzIfCjJYAu12vYp0qbjo+/6h83kwd+qh7JzWGUT3zaBIiA74oG496p6Fa6p6soDOh
         s3/di0YPKPA1p9YUw62YWB3e2kxA9zyLOqgph3O5V4yn5cVibzkC2rjwOC5qOcG0R7ru
         OM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y0kIZxdG2WP5UVtm2i0XaO2Bfut6JUxDjhvFbpFOnGo=;
        b=uXutVfHTdtQSXt7+EXdq2lWWLt+4ktxTUhBPoPmmvmg/tnb3SSpQs//yUXPWw82p7B
         T6PiYgvU5Wn7CD6JyP4c5BQrVwBn115SI5DmQyeSpzOiahsYJKgpknO+N11XLpliI6Nc
         10F6KDz5Tc4GHmpj/WIX3EHeS9dSCxrWn0XhdmJ8AV1O+ekrJmlgvqYv4bvG8YyuGYSe
         WjmM+ceFTCGFY3JZqx4GBrBsGDlURYU23a4w8mQ461ul6/VHL6GZD1lR769Z9ftt1Upl
         vE3KcsTAgf9RWHepUllwhZKPlLfXYm/507vS6gII3ex5eHGV+Jgp2Yytv4pU+jsporBU
         Jptg==
X-Gm-Message-State: AOAM5324M/7mCIjQvwh9OufVLJOscp+vAsZzFtwYOP2rmrv/wn0VgWq6
        Oq34MJzCA7sIvF5+QXlEr3CkaTu1BFzl0MGCG94ybA==
X-Google-Smtp-Source: ABdhPJwoMBLlwC9Y3OiKT1MJ/TLJ1htrXZ0Gsq6A+zo5pCGOJKT4X2C+tgqr5zx1l20TXTxPTu1Rb6sQWSkFhJaNluY=
X-Received: by 2002:a5d:8acf:: with SMTP id e15mr7489552iot.184.1630072043205;
 Fri, 27 Aug 2021 06:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <YSPAseE6WD8dDRuz@ravnborg.org> <20210824014124.1080798-1-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=UFDRG9TJis28Wtsz9RVhp3Xk35stpLyY5ExLx3=8yxPQ@mail.gmail.com>
In-Reply-To: <CAD=FV=UFDRG9TJis28Wtsz9RVhp3Xk35stpLyY5ExLx3=8yxPQ@mail.gmail.com>
From:   Doug Anderson <dianders@google.com>
Date:   Fri, 27 Aug 2021 06:47:10 -0700
Message-ID: <CAD=FV=WEid=JgsXEPWpEfNivJ3DK_hnFxxNf_HDiOpuTozAjHA@mail.gmail.com>
Subject: Re: [v2 0/2] Add driver for BOE tv110c9m-ll3 panel
To:     yangcong <yangcong5@huaqin.corp-partner.google.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 26, 2021 at 10:17 AM Doug Anderson <dianders@google.com> wrote:
>
> Hi,
>
> On Mon, Aug 23, 2021 at 6:41 PM yangcong
> <yangcong5@huaqin.corp-partner.google.com> wrote:
> >
> > Hi Sam,
> >   This driver support boe tv1110c9m-ll3 and inx hj110iz-01a panel.The IC chip is used NT36523, which is a new IC.
> >
> > 1: panel-boe-tv101wum-nl6.c driver cannot meet the timing requirements of the current two panel.
> >
> > 2: The screen cannot be work in HS mode, panel-boe-tv101wum-nl6.c will switch to HS mode when boe_panel_enter_sleep_mode.
> >
> > static int boe_panel_enter_sleep_mode(struct boe_panel *boe)
> > {
> >         struct mipi_dsi_device *dsi = boe->dsi;
> >         int ret;
> >
> >         dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> >         ...
> >         ...
> > }
>
> It's really up to Sam how he wants to proceed here, but certainly you
> could support things with the existing driver even if there are
> differences. In general you can add more things to the `struct
> panel_desc` in the driver and then make them different for your panel.
> Look, for instance, at `discharge_on_disable`. Not all panels
> supported by this driver do that, so you could support your "cannot
> work in HS mode" in a similar way.
>
> For the timings, you could also add another bit to the `struct
> panel_desc` to select a different delay for your panel or (if it's
> just a small delay) you could just increase it across the board. I
> guess you need a 10 ms delay instead of a 5 ms delay in probe? I'd
> just make it 10 ms across the board and call it done. Similarly looks
> like something needs .5 ms => 1 ms. Again, this is likely fine across
> the board for all panels.
>
> Unless Sam comes back and says "no, wait, keep it two drivers!" then
> I'd suggest that you post a new version that works as Sam suggests. In
> the worst case if having it combined into one driver looks too ugly
> then we can always go back to a split driver.

Breadcrumbs: it looks like yangcong has attempted this in the
confusingly numbered v3 of his other patch series. See:

https://lore.kernel.org/r/20210827082407.101053-4-yangcong5@huaqin.corp-partner.google.com

-Doug
