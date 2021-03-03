Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC7032C446
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388649AbhCDAMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390295AbhCCWCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 17:02:21 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D035C0613DC;
        Wed,  3 Mar 2021 14:01:41 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id a17so30734738ljq.2;
        Wed, 03 Mar 2021 14:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j07ek4Zt9ZdE7LS3OsZtxsaFuQttw0xxqtZtfHiifAQ=;
        b=NBvJ3Sw+FEHPVCJrhr1ERPVezGdGEH25D1eFIMyn2u6ovdDB2Uhig5ww00vZ9LDMK5
         6T1JFGVP73hxC9XHSnFHHBC/H4WweEF5RMyyPRx5qQWXwQp6vufOvTBFpJ+erbgZFr0W
         XL6G8EsGz4nEO2OjEW5nmggrck3PYNj8AshFnccieYet3IFFWnycjgyEFYY/QyXJUyig
         Vf21SazyDaxGuHK/QFZwxFwW07m/d94CPmPUNYB+fzF/OSkIzp5RJgEvD9dvBFx+coif
         4tAwtLq6xMR63iJ+tm4NhniTqZHz3/vmp3hD4EgkSSlAcKvzfNyrW0m7LgBCnSsIQwkW
         iLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j07ek4Zt9ZdE7LS3OsZtxsaFuQttw0xxqtZtfHiifAQ=;
        b=uYNM05JcusPuMGSPT/sd3Q0p5MB7KACTD84BsXmSk3M6Y6Dw/np5M6Lk+qLCqXBOqQ
         f5x4oFU2wcTiY/WDTsChrTazL5OFMYxssDe9ZRMWGb22wODW+zLkymOfJPkKVE14K4tG
         Io2W5vAdrbI9vvFUIckXbXqL8H0zqs91T4jRejnD5zHRkyDXh+DkzReicmKL2smKPBqr
         4uwNCCeZzeI87IBq3qzGhk+CrqxyWvC0Am4SK4Ml+6ulAH1zRbD6NZQGOnPIXj+MGoFz
         1dflNKkemUaCMqdK8iaCTDcyqLHJeCHfc47ZZ3teCq3topT6v6FFKu/NbKwR1qyBHoYp
         zzGg==
X-Gm-Message-State: AOAM530VU5AT34DiAx0wy875EKNaji/w58i/QlKz2I9ZfLKqitW1W98Q
        MOH2Lj52fz1iYsAMJGmhJed2+Olu8Z6uqWiOGGC/ZsIZ+Ts=
X-Google-Smtp-Source: ABdhPJwWq1M7hocWIy98G8weo/IGzkmjbUuAECHqyucj33Ofrlv1wUGjzGKT8jSpMWV4YXI00uo1+dX+dy9IsNMkgec=
X-Received: by 2002:a2e:9a4e:: with SMTP id k14mr573726ljj.116.1614808899734;
 Wed, 03 Mar 2021 14:01:39 -0800 (PST)
MIME-Version: 1.0
References: <20210303211002.17650-1-heiko.thiery@gmail.com> <20210303211002.17650-3-heiko.thiery@gmail.com>
In-Reply-To: <20210303211002.17650-3-heiko.thiery@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 3 Mar 2021 19:01:27 -0300
Message-ID: <CAOMZO5DbWrN-VuUmjwj1DGFwXFPOdqJ-PmU9DAd+0xbO2MaBag@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: fsl: add support for Kontron
 pitx-imx8m board
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Wed, Mar 3, 2021 at 6:11 PM Heiko Thiery <heiko.thiery@gmail.com> wrote:
>
> The Kontron pitx-imx8m board is based on an i.MX8MQ soc.
>
> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Michael Walle <michael@walle.cc>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
