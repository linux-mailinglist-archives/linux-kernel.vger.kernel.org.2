Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AB0376BD6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 23:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhEGVdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 17:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhEGVdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 17:33:24 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED1AC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 14:32:22 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id o27so9990423qkj.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 14:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8fK7eHKUxmepqVXRuH1Me+N6pEGrLKxF0Gw1bBJBEhM=;
        b=azyvyBbnB2N43FTbvrcjr+9F6cdhdryHKabro99427Dv96ts5IO815JB0iUXTr+ExI
         07gW+3w12L5iHMy4slmAEbPI048w1An/TnsrjGxk6eFmt/rjGx3mXxeVzi1VJ4+1kT+v
         sJ60cc7kyGi+lUUBgFQ16Y2GNGCbjC0TRQjBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8fK7eHKUxmepqVXRuH1Me+N6pEGrLKxF0Gw1bBJBEhM=;
        b=DNzdTJlXZBXUBSrrq3tNBQyTkVM6d2YDsvCBJrt07VjZ5OQsTdqgtpIe6Wjl4kjrxw
         WVJOlUDGJtQpV0/tmmCLIJW4MGodn31lB/R8sIU4py74crrK3N9LLmyIIaftjTxjqVbF
         jCAKnfSql6O0MM0FUPC/VT30KaUHvOXZSK6xQWEA/RloUtTO5b6yvpIXj0EXgU2uWFck
         fhGgSgcI85S4PmuOZGeGmE3x9SL+wH70kf/ReuCENBjp25MBejQqSb8KFmKYLG4U3ugZ
         PQH/CET15rAfeplQzieuZ8LPeY0hpPuz0Wz+i+289bavFipS3S/V+xLltqqdwcfE8Kkm
         iOig==
X-Gm-Message-State: AOAM530tYGpl4hrD/rbTpgPCKGQSZdoUb1oTrcH8r6EaDr1cm045IGMB
        ilChrSj+PFw+XNI7hXM23wiUUFH5skUFXQ==
X-Google-Smtp-Source: ABdhPJxgMwjO9UclW9N1HIQAuC5b8FcNNvF9yxgKVI1XSSgDNrXVhexrPbFGhKehNyC47+uefofIDw==
X-Received: by 2002:a37:6606:: with SMTP id a6mr8169809qkc.444.1620423141421;
        Fri, 07 May 2021 14:32:21 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id m124sm5872267qkc.70.2021.05.07.14.32.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 14:32:19 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id v188so13728097ybe.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 14:32:19 -0700 (PDT)
X-Received: by 2002:a25:d70e:: with SMTP id o14mr15904531ybg.79.1620423139099;
 Fri, 07 May 2021 14:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201102181144.3469197-1-swboyd@chromium.org> <20201102181144.3469197-4-swboyd@chromium.org>
 <YFKc23MwUQAosCs8@pendragon.ideasonboard.com> <161646947526.2972785.6883720652669260316@swboyd.mtv.corp.google.com>
 <CAD=FV=U+-spmAxFeDNxhCuB6O=gUvO_==ozg-OGn=2vkUWgL4Q@mail.gmail.com> <YFpG+hK7W+4bpp0A@pendragon.ideasonboard.com>
In-Reply-To: <YFpG+hK7W+4bpp0A@pendragon.ideasonboard.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 7 May 2021 14:32:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WfrZz4PsDcEeLkvsFa6p9LOo1G-3e00NzoVLZ713xNpg@mail.gmail.com>
Message-ID: <CAD=FV=WfrZz4PsDcEeLkvsFa6p9LOo1G-3e00NzoVLZ713xNpg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] drm/bridge: ti-sn65dsi86: Read EDID blob over DDC
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 23, 2021 at 12:53 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Doug,
>
> On Tue, Mar 23, 2021 at 12:07:27PM -0700, Doug Anderson wrote:
> > On Mon, Mar 22, 2021 at 8:17 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Laurent Pinchart (2021-03-17 17:20:43)
> > > > Hi Stephen,
> > > >
> > > > Reviving a bit of an old thread, for a question.
> > > >
> > > > On Mon, Nov 02, 2020 at 10:11:43AM -0800, Stephen Boyd wrote:
> > > > > @@ -265,6 +267,23 @@ connector_to_ti_sn_bridge(struct drm_connector *connector)
> > > > >  static int ti_sn_bridge_connector_get_modes(struct drm_connector *connector)
> > > > >  {
> > > > >       struct ti_sn_bridge *pdata = connector_to_ti_sn_bridge(connector);
> > > > > +     struct edid *edid = pdata->edid;
> > > > > +     int num, ret;
> > > > > +
> > > > > +     if (!edid) {
> > > > > +             pm_runtime_get_sync(pdata->dev);
> > > > > +             edid = pdata->edid = drm_get_edid(connector, &pdata->aux.ddc);
> > > > > +             pm_runtime_put(pdata->dev);
> > > >
> > > > Is there any specific reason to use the indirect access method, compared
> > > > to the direct method that translates access to an I2C ancillary address
> > > > to an I2C-over-AUX transaction (see page 20 of SLLSEH2B) ? The direct
> > > > method seems it would be more efficient.
> > >
> > > No I don't think it matters. I was just using the existing support code
> > > that Sean wrote instead of digging into the details. Maybe Sean ran into
> > > something earlier and abandoned that approach?
> >
> > From reading the docs, it sounds as if there _could_ be a reason to
> > use the indirect method. Specifically if the i2c host that the bridge
> > is on doesn't support clock stretching then the direct method wouldn't
> > work according to the docs. Is that something that we'd have to
> > reasonably worry about?
>
> I'm not sure. I'm going through BSP code that uses the direct method,
> and I was wondering if it was just an implementation detail. Once I get
> the display working on this board, I'll try to find time to compare the
> two methods, to see if there's a significatant performance improvement
> from the direct method. If there isn't, I won't bother.

To follow-up here:

We'd actually been using the "direct" method in the BIOS (coreboot)
and just found a problem. We're now switching coreboot to the
"indirect" mode. Specifically we found that, at least on one panel,
the last byte of the extension block (which should have been a CRC)
was coming back as 0 when using the "direct" mode. See:

https://review.coreboot.org/c/coreboot/+/52959

In addition I was thinking about how to use "direct" mode (ignoring
the above problem) and realized that handling the power sequencing at
the right time would be hard. Maybe not a problem for you since your
bridge is always powered, but I wouldn't know how to model this in
general. Specifically if you want to talk over the i2c bus to the
panel you've got to power the bridge but I don't think the bridge gets
called in the normal code paths.

-Doug
