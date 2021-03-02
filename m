Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0555632A978
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244029AbhCBS0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575709AbhCBPe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:34:57 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAADC0698C5
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:30:26 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id h4so24258492ljl.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W834NQ1vAh6LWdXU80aAvj1G8P2ffq4WwVKe01ihhOs=;
        b=gKyg1Muwq2lNtJ5GXY+ygyJPb/wwpaaAi1kBGRe7mFZmw8B8tViDhbynkysd4lYarJ
         RnUJwn+JNLRcoX2ZYOJQuYMcmTFTmrV9vKERejJTkso//LWx0ulfjhBrT2wygnU5sDA6
         hyzYxssPd9sN3sCntg5mSL47i7uY5gAMqhbxROdUrtN8i27FYVZk+1QtDJ/cSnv/3mE2
         d82H/xfJJXjX4PXAGc4q8my3bF/LseKJNkuG/knSItT5dXHE420CrWGxLWaqgwBy+xfl
         tlIENx5fwOJ3pgfoDAJXaqnVXblnxySTj9Dqep3d4zUXwJmNb8UOccIT9G594r3i9t42
         F9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W834NQ1vAh6LWdXU80aAvj1G8P2ffq4WwVKe01ihhOs=;
        b=HagZcQt9FLySkiBWQ1qPBdvua6DFIkrN6a95aW0IC/gmAkZDMWuL4l/wAj8TubOrgf
         e7Gu+wzjGxHe9TwzQrOPmXiwsiynm/SSlCAD6MLExlLdKd0X1hXxyIbvqskwEbGylem8
         xS4Fl4AxnJnGQgLltbaEYUSOcAQCQnzSeiNooef1rSHv7aI7k+Xbgatr02YZaXQl+XB3
         7LUjfVKWOSTGtXoIxzuMoZHfVEp8qL6g9zJmSKSEPunw4ZjBRAyDfQ5lKp/N9xGWECZY
         1ksUUzPj56wX5T1k/eRdwDqFLy1r8ochBP1gTTzZte5pb/LUtC/3f3HkY2tg0yTYm29n
         j7rQ==
X-Gm-Message-State: AOAM532lm4ZB8+4MbRddz7TK6GXYRf/9Ss9RzXuioBxQcps+Twx9ahsy
        C5Jvv4vKbukBAy8rctgPiKNPgtzny7/p85cTEIF/ow==
X-Google-Smtp-Source: ABdhPJybFFwipXyQWZHYVEaekG+qg6cTGcIeBxjc1+hy1oZItqJ7bLzKK82xiAtjTPHwPwKPsZRGK6FA4Brq8Mg7bXk=
X-Received: by 2002:a2e:700a:: with SMTP id l10mr12496829ljc.368.1614699023063;
 Tue, 02 Mar 2021 07:30:23 -0800 (PST)
MIME-Version: 1.0
References: <20210225164216.21124-1-noltari@gmail.com> <20210225164216.21124-13-noltari@gmail.com>
In-Reply-To: <20210225164216.21124-13-noltari@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 16:30:12 +0100
Message-ID: <CACRpkdamVjNOua1ZVriPnhb6GDerpchMFepqekx_NP40_KH9Ew@mail.gmail.com>
Subject: Re: [PATCH 12/12] pinctrl: add a pincontrol driver for BCM6318
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

> Add a pincontrol driver for BCM6318. BCM6318 allows muxing most GPIOs
> to different functions. BCM6318 is similar to BCM6328 with the addition
> of a pad register, and the GPIO meaning of the mux register changes
> based on the GPIO number.
>
> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Same comments as the other drivers.

Looking forward to the next iteration of these drivers!

Yours,
Linus Walleij
