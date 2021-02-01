Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5039E30A054
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 03:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhBACX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 21:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbhBACXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 21:23:54 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562C3C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 18:23:14 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id e67so15385673ybc.12
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 18:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fua1CWTNS6dyGkCaeEtFLQj2u0XBlL9yhgRw9aRvSQg=;
        b=VV+MW7QZin0ZkeHfhFirPxDxKRFES1Q+InNKtDkhMJ5oTcVs1WGoUWOYO7ijjvWZUr
         IZxiMuGvnCVylBE67dD9DOXLxZ8Pm7sD8TQlPFkaB41h7yULymbm0U4WU4DAYoQE19BE
         iqqGKeH1aXblWSzJMTLPVmXH6pG3pweCgH+xX4WvHcMpL3kN066hmAlGdgSyzOVrDEXN
         1+t7dJ2+AEK2zot+jfurl7Yj8tBT37wikL5Ny1gUOrFA8T4GH9Kw+NVFPhcwqDt3oQMX
         H4RjtRuEYPy6hnkDaOuH50EJRms+MzJ/+DbhrOs3teVb4Sas7nzXRljM07RjfAvgQFv+
         MUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fua1CWTNS6dyGkCaeEtFLQj2u0XBlL9yhgRw9aRvSQg=;
        b=fCZBsn7T+5hFyIOB/IgRXlXshLtdumHLXgs8iHFwAC/pQ80rM4UjfbcVJD3AVrRn/I
         ZEdaGNJhfmdzLugHDNsWNuQJCX9kghJdR5iiUEKww+A16bymmuIfWBpL+lP5k1Ajv/CM
         ejvGylvE78Z8zjiOWah8G4mNYwDfiatDAxPFUXMz7QheIicnpw6uoU4DCOqE5zz/nzNk
         1RnmSoFVGC4XKfFDnxCZExOXGqjrmNUN+RGUvwlgXHnG1Xs5eh6qhuTW2yzFGrqyUO+C
         sI9h0lEP6ZFAUh9TtDKh94UKXD6lTFGbz3HGjg11NeRp4wEYLoCoQClZ93R7pltiyPXF
         OxEA==
X-Gm-Message-State: AOAM53143gnf1YvqlrL/Zi0drc2vhvIFj3zVaWc2qvu2hityk+yGSof+
        yEMS3+Y8sIG1r3B1n3llvjRFzClEnT13WHHDJDFYOw==
X-Google-Smtp-Source: ABdhPJySEZbZNuBEk1/U8sYOHMal+Vhabn5vggXyJpL0kmc8Ta3T185iO5mJvaGD7epPHAB7F/6OgyMFzvgMU4/7l2g=
X-Received: by 2002:a05:6902:1025:: with SMTP id x5mr21478758ybt.96.1612146193253;
 Sun, 31 Jan 2021 18:23:13 -0800 (PST)
MIME-Version: 1.0
References: <20210131205654.3379661-1-saravanak@google.com> <CAOMZO5AZgk0N8sN9=bGcWTcnju75TPVxQX3FbLpF=n-=JA-7-w@mail.gmail.com>
In-Reply-To: <CAOMZO5AZgk0N8sN9=bGcWTcnju75TPVxQX3FbLpF=n-=JA-7-w@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sun, 31 Jan 2021 18:22:37 -0800
Message-ID: <CAGETcx9YsjPtiBxJEybY5UTWNu-9e=FrYPVd1ORF9hz0M04w5Q@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: imx: avic: Convert to using IRQCHIP_DECLARE
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>,
        Android Kernel Team <kernel-team@android.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 5:26 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Saravana,
>
> On Sun, Jan 31, 2021 at 5:56 PM Saravana Kannan <saravanak@google.com> wrote:
>
> > +static int __init imx_avic_init(struct device_node *node,
> > +                              struct device_node *parent)
> > +{
> > +       void __iomem *avic_base;
> > +
> > +       avic_base = of_iomap(node, 0);
> > +       BUG_ON(!avic_base);
> > +       mxc_init_irq(avic_base);
> > +       return 0;
> > +}
> > +
> > +IRQCHIP_DECLARE(imx_avic, "fsl,imx31-avic", imx_avic_init);
>
> Shouldn't the compatible be "fsl,avic" instead?

Fabio,

Ah yes. I had that too. I deleted the wrong one in the last minute
before sending it out. Thanks for catching it.

I'll wait to see if there are any other review comments before I send out v2.

Martin,

Please make this fix before you test it.

-Saravana
