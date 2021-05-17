Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A62A382466
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 08:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhEQGem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 02:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbhEQGek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 02:34:40 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB1CC061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 23:33:24 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id b13so5680087ybk.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 23:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=A36YmdWL+EYTeLs3ounPSrRDBQL+KBGOVJE7xzmOlzQ=;
        b=E8Um+FvJWWPq/Vju3q8Z9x0tc9ESbtATca5EokIKGipjzKIF45qLUO53SY7FP2CEd0
         6gI5PstYVTNETiOWugslJDcFoIt6OG3KO3OQurN3H9gprQ3alCJa1FaEhcSDthGPW80d
         6Pdqxs6iRsD1V0ELvSYOUEz9M0ImWvE71RwAMl6iaYRio7SGsMuZUpvh9mamulmnLLZ8
         Z75BQSXfliACpx5ALUHawhuK6JE0/SLBhovMut0b6ahhx9zDRV5QjpE1adbaTmefzdZ4
         RNCgh7eEdIc7dPgasocw/h3R0CHf9ffGwfT1eRYlBUA03GQFKmbeLzPWHBkHi+NST6Cu
         BAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=A36YmdWL+EYTeLs3ounPSrRDBQL+KBGOVJE7xzmOlzQ=;
        b=YOd06c5qSIS1kT3GLKGCnHwlSI4t+k+GDXpy3Y8SSigKU81P0rZXYJcyGdQ44u1Um9
         vB/yiLV6aLv9i+cJ1p7jxqZhQ8ufi0PhqORkKZMXCHd/lDjvL5QTLXVxu8FG00250Lwf
         +Z1XJLFt5KrOf3/J6t0nQirZa7mKrsr/5gjKieomgo32I+a96h3iVZcN0DmjMjAeWRTc
         f2MFVeKxtd+Q8V3AiLJ+xjB+FDWbFfODldQLtOUsZAmNda7gY2jTkEzIb9h/81PV2KPr
         MSpoG/Hi6v6DKWCDluc8b3/3WK07ANyuJXi8Ystze4UrPH0hfv5CvVERImunG60C0XQp
         T57w==
X-Gm-Message-State: AOAM5339O8RnSHz15o4hp/xrLad981Y52+meemkflWs07S5H4vzX3zm7
        tGd+RVsXo8o2DEjtj2TWmJaR847SNU9TTVlVyMBcag==
X-Google-Smtp-Source: ABdhPJzZjzAHF8QEVwH6VzWcLF633GRECtLRgXgmILGdUs6Nnt2o99yB5eE+20hfwrFGxUClgONU+RUDNU8eWJVGemo=
X-Received: by 2002:a25:3f47:: with SMTP id m68mr22624211yba.228.1621233203274;
 Sun, 16 May 2021 23:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210516170539.2yxe43qwezonuo3r@core>
In-Reply-To: <20210516170539.2yxe43qwezonuo3r@core>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sun, 16 May 2021 23:32:47 -0700
Message-ID: <CAGETcx93RxfsXG51zeaUK+UyKdEDgivqkmS85mcMPp0H42X5ZQ@mail.gmail.com>
Subject: Re: fw_devlink=on and sunxi HDMI
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
        Saravana Kannan <saravanak@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, andre.przywara@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2021 at 10:05 AM Ond=C5=99ej Jirman <megi@xff.cz> wrote:
>
> Hello,
>
> Linux 5.13-rc1 again has fw_devlink=3Don enabled by default. I've found t=
hat this
> breaks probing display pipeline and HDMI output on sunxi boards, because =
of
> fwnode_link between hdmi and hdmi-phy nodes.
>
> HDMI device probe keeps being avoided with these repeated messages in dme=
sg:
>
>   platform 1ee0000.hdmi: probe deferral - supplier 1ef0000.hdmi-phy not r=
eady
>
> Both nodes have their own compatible, but are implemented by a single
> struct device.
>
> This looks like a kind of situation that's expected to break fw_devlink
> expectations by my reading of the the e-mails about trying the fw_devlink=
=3Don
> during 5.12 cycle.
>
> Is this supposed to be solved by implementing the PHY node as it's own
> device or by breaking the fwnode_link between the hdmi phy and hdmi nodes=
?
> Seems like second solution would be quicker now that rc1 is out.

Seems like sun8i_hdmi_phy_probe() already does 95% of the work to make
the PHY a separate driver. Why not just finish it up by really making
it a separate driver? I'd really prefer doing that because this seems
unnecessarily messed up. The phy will have a struct device created for
it already. You are just not probing it.

Thanks,
Saravana

>
> Where would be a good place to break that fwnode_link in code?
>
> Or can the fw_devlink code be made aware of this situation, where two fwn=
odes
> are implemented by the same Linux device, somehow?
>
> Relevant references:
>
> https://elixir.bootlin.com/linux/v5.13-rc1/source/drivers/gpu/drm/sun4i/s=
un8i_hdmi_phy.c#L600
> https://elixir.bootlin.com/linux/v5.13-rc1/source/drivers/gpu/drm/sun4i/s=
un8i_dw_hdmi.c#L212
> https://elixir.bootlin.com/linux/v5.13-rc1/source/arch/arm64/boot/dts/all=
winner/sun50i-a64.dtsi#L1176
>
> kind regards,
>         o.
