Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3833732A91E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580693AbhCBSMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382685AbhCBPas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:30:48 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063FBC061224
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:26:09 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id v5so31839960lft.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zg8WKu5dAJAroGIZE1OueymB/BXbUruFVL/8wlwBQVI=;
        b=HJBMbkl+8OdyK/6CJHV8JgUVKM5FptKC4GYsxcM4cEz0V12kU0hbfgjF7u/w9ixTH4
         Nz+4bZHfQO7+pI6+ZqAammwT8wiLIDH2+AdjGOGvw325DRm1EBN5x+7sNmOdgYDwJdOn
         GBQ67XfsZ+D8v5z8hgivjD+JurEojEqcB1UH54uXNuwgHbhGv0u6q8J0N7reIGwC2u9h
         d5FAY52m3wCYfSO2QS+/aPPS+JpPmQQwpXAxU9raSVtlkJRDmqqP57aHWmKnCFiLdQ1U
         Az1c5sDJ8gWAKtwBOf/OcqDd8uVcaiuuKfe5ebZhIWgYsPtvhsiNePbTrn4satROBSny
         JMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zg8WKu5dAJAroGIZE1OueymB/BXbUruFVL/8wlwBQVI=;
        b=p3qxq7fjlJxiyMq2gl4iNUS6ZLsfT/TWa2wrzjUzEniLKqnyNHj7cGOFfZ2bFfKrBm
         gdnYnmO9cdM6ierrtkh0IMQl6FfynWJF/q2KuRTLjlb42q9QnH/lPQeDF12G0ji9JgL+
         DmKHn/nji3dH/Y0dzWrfJgPabhgJYB8k1cMdZAFAA4LXSwgwxSFRTTxLQIQvLcLv3aiD
         mb80VUkzK82OCaD+sUEpUv6pItixihW28NosAn3TYTsgVgJY8urYCHtAUOJIEhtWBnpC
         TmeW3UZd4EpcHl37HwBw1VWn9l6OBrZFRTqL7Om3EguXjgj0rTzzmIGcrdcdpGzIHgub
         gD7w==
X-Gm-Message-State: AOAM533oT8knEFMn9llST4xPkLac2HhBA66Q3FJ9YsXHJ38cWqK2h8vB
        n3CSBJka+L1vCp+jfD6k88s+D+MorUyvzHhg3wIXIaOANS8qZQ==
X-Google-Smtp-Source: ABdhPJx6BROtKQDuW6LN/cJaUZXd62YlmBkeog+nHHu4iz00KLoYlRwWOEUbd/g+lL42oB+ZLq7UznLEmep0PmUbbIY=
X-Received: by 2002:ac2:5d21:: with SMTP id i1mr12077181lfb.649.1614698767566;
 Tue, 02 Mar 2021 07:26:07 -0800 (PST)
MIME-Version: 1.0
References: <20210225164216.21124-1-noltari@gmail.com> <20210225164216.21124-5-noltari@gmail.com>
In-Reply-To: <20210225164216.21124-5-noltari@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 16:25:56 +0100
Message-ID: <CACRpkdbzqXU-iMKeSe-2sRM+h7CJ0_xYf65w6rmHMaOZsCYNkg@mail.gmail.com>
Subject: Re: [PATCH 04/12] pinctrl: add a pincontrol driver for BCM6358
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

> Add a pincotrol driver for BCM6358. BCM6358 allow overlaying different
> functions onto the GPIO pins. It does not support configuring individual
> pins but only whole groups. These groups may overlap, and still require
> the directions to be set correctly in the GPIO register. In addition the
> functions register controls other, not directly mux related functions.
>
> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

All of my review comments on the first driver in the series goes
for this one as well, so copy/paste all my comments from there :D

The good thing is once you get it right in one driver you will get it
right in all of them.

Consider bringing all common code together in a main driver
shared by all these pin controllers as per the pattern of other
pin controllers (se qcom for example).

Yours,
Linus Walleij
