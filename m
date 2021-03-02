Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4848632A96C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835179AbhCBSXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448646AbhCBPdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:33:42 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA27EC0698C4
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:29:06 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id q14so24440338ljp.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LCwQhqE9NkoRHlHwO6Fmc47EHLE3N6sGTOQ1yFKT36o=;
        b=Px3dXxEpwKxyAHKEvzvnYWBM0KZXBnBuCM/BtUAWJBWMLnWk6lOZ8pi0Gz7Met1TId
         aT57pJgcHmsiNh8w/Fq3eWCR56/3/dTM3OifHpMO5WuEGqk9ThWaAaAFK7aP7RkqfRrK
         h4Dsj2Glvvoa+F8dJDS6xLK8jWTOLlRSK4qDLldlVEk5V2CJiXLhzru36Fv0IzGycuGT
         a6T7hbeh0bwTZ+37RxzGJEjbDxhkqE/lJFK6+waZIspLxTjNlvBk9c/mARsveZoa9T8V
         ofwVTxorf7zso/aVER27KBtJ5KZ2goi5SROzfGvlh4JtOyl8yQFLY1nuwRgfZWnrCJe3
         Y4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LCwQhqE9NkoRHlHwO6Fmc47EHLE3N6sGTOQ1yFKT36o=;
        b=eOn3Q0K0zoQNcz3wC3E9AOORmT41iH9nP1anlIHwJeJXVrHhuw+BkBuhFMNhfUAzCo
         bJ6RLsLtDFIPaPnQiuKvgjYjoB69dZlpXPNG7lraKq0CujoRtl3ccb/ydKqsiE7sx7XN
         +byAZS8cuhAeh1MSdHHawY82k1I6gpOwFWfhcmpAO5OCq7zmsJBNArHcSzSOQA64UKBC
         dmYO7SXcXiqWXqurSlCob77WVcowrKXSVxlAMfMBmI5ZXe3x8sCq9aTIPEXY6YbVx3l5
         ksgemNt1a/6UtqjJEy52HmPOwU9tbUYug1mqPckZOfXYh1y8HyaiN/OewYKQiuI9MrVh
         3UMA==
X-Gm-Message-State: AOAM530Hzk3vlCYfy+3MvJtNze8wV3o4t2sEu9SL1iYYl2CUdhgTNjrM
        9lv09QOnkdSGTU1Ar4j0IBAOd+6nJglmvh+XbzPpPg==
X-Google-Smtp-Source: ABdhPJy9mNgWIuNzMd1S+ztjRGu8pwsStRN881pmfjS/D9xzv0ch+hdfcQ/S4mujmCBVqvAyOFCFu5FSAgGrbuXhlEY=
X-Received: by 2002:a2e:864a:: with SMTP id i10mr11926918ljj.467.1614698945418;
 Tue, 02 Mar 2021 07:29:05 -0800 (PST)
MIME-Version: 1.0
References: <20210225164216.21124-1-noltari@gmail.com> <20210225164216.21124-11-noltari@gmail.com>
In-Reply-To: <20210225164216.21124-11-noltari@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 16:28:54 +0100
Message-ID: <CACRpkdbuOJUjvmJ2STzfT+2JHCC9UpGnD4LuBYRFO3BEv=CsiQ@mail.gmail.com>
Subject: Re: [PATCH 10/12] pinctrl: add a pincontrol driver for BCM63268
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 5:42 PM =C3=81lvaro Fern=C3=A1ndez Rojas
<noltari@gmail.com> wrote:

> Add a pincontrol driver for BCM63268. BCM63268 allows muxing GPIOs
> to different functions. Depending on the mux, these are either single
> pin configurations or whole pin groups.
>
> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Same comments as the other drivers :)

Yours,
Linus Walleij
