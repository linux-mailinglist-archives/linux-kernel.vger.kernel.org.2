Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F6431B7F7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 12:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhBOL0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 06:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhBOL03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 06:26:29 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE9CC061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 03:25:49 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id m144so5987298qke.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 03:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V5p/Ptpd8Lzv5tKkYHxJzAd/BlFt3ePQF/VhO0/xQ9g=;
        b=XmjNHDNIuHF1fDcddYwkbuTllthAII7JSKOm/beY3HBLxAKdzSsi3l5Q835js8OMK2
         HOR1GMNG08PkRKVk7WtQaMwJjgDkjLG8X9BWtcGBJar/AzjDknMicSc2rLeO6fznCycZ
         P+AjBlz7/i7XZR/xYwn14nBCfEIoWAW549gVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5p/Ptpd8Lzv5tKkYHxJzAd/BlFt3ePQF/VhO0/xQ9g=;
        b=jSrcFNaBxSwIH/8tSbjbh/zBwSScB1K+o8PUV0ZkB1UBwVm43RcEuWvilrGxBlL1UC
         PXeHP0ScTB61lSogtBrN2rE9tvxirolbJqcXXiZCfSKi0Tgp7zNfgqkGdSM44WdvDWmi
         2n4nCsB3DVTl+SHqCeymUbQSK2rPOe4okxjm3nQymIX18shio8gDQbJcIMcYD30sPEuh
         GHBBDBZ30axcOZXFFsEMqBnB9r6rAxAbajoy+/KYHMwksDjX2Bshizz1SnnUWSHjAcDP
         +E0ZRPC50oEJw8L8h8076Yqm6LWkViF5Ha97br2iS4jWB0vPB/8xCtUS1pTNfeEQmDXM
         RtPw==
X-Gm-Message-State: AOAM531gytuW+ThjmByTM8SggFNEKGg3Ql59YZRTm+9EoWfO+D1xUKK5
        c1ZEf7HFFHGCOapdQFxYkmDnKAZIBYWXhvKrIeHf/A==
X-Google-Smtp-Source: ABdhPJxZm8ADvBSIVcrG9NDd4A2KXUR9+do9fxfPHlIi8CcMPRNY15cK/Vy9v+E/aC/pTUGVGQRBQQAN9JbJefmfiBI=
X-Received: by 2002:a37:bcc6:: with SMTP id m189mr14108089qkf.88.1613388348069;
 Mon, 15 Feb 2021 03:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20210214174453.104616-1-jagan@amarulasolutions.com> <8330126a-b2f4-5991-a2fa-37776cb412d0@baylibre.com>
In-Reply-To: <8330126a-b2f4-5991-a2fa-37776cb412d0@baylibre.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 15 Feb 2021 16:55:36 +0530
Message-ID: <CAMty3ZAgKPXpkiWuG3cGFs4sZPd182hBNaTbveL9USLj8o=ZxQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: bridge: Add bindings for SN65DSI83/84/85
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 2:32 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi,
>
> On 14/02/2021 18:44, Jagan Teki wrote:
> > SN65DSI83/84/85 devices are MIPI DSI to LVDS based bridge
> > controller IC's from Texas Instruments.
> >
> > SN65DSI83 - Single Channel DSI to Single-link LVDS bridge
> > SN65DSI84 - Single Channel DSI to Dual-link LVDS bridge
> > SN65DSI85 - Dual Channel DSI to Dual-link LVDS bridge
> >
> > Right now the bridge driver is supporting Channel A with single
> > link, so dt-bindings documented according to it.
>
> Shouldn't it describe Dual-link LVDS already for SN65DSI84/85 and Dual Channel DSI for SN65DSI85 even if not implemented in the driver ?

Patch documented only Single link LVDS as it only supported by driver.
Single link LVDS with Channel A configuration is common across all 3
variant chips. I have SN65DSI84 with Single link LVDS which is routed
in Channel A. Idea is to go with Single link and add double link later
and document the same.

Jagan.
