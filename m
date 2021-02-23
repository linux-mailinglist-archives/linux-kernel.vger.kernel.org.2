Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321C832242D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 03:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhBWCe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 21:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhBWCex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 21:34:53 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8340AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 18:34:13 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id n195so14981720ybg.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 18:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vbEZDn6F+U7fLvG/dV/ekQ+8VtzU/Wmvd2z5pzH+GUE=;
        b=eymbrX2fFRafVOEdU4Pi6I97vLxaXnBfqWsMLS7i5Y7yCOAPpBukdtgjoCJAsIgqPl
         npy1vkN/EA/Ou2XkCoSEb1s6N1VUVuaDz7vNXCiY2KKgms8RE7iVMSfKn1JerMSxuhr4
         fXYmuKeocmTCJkKlL2BtrqdZ91X44alH7svsWDDiAb0K0WP0hSWjylPSwk122Ewy7pBg
         0CB/Vvhgkd6oHjxT74WYKhfgGlrl0beDlrq5UwpamUTyx/9ygXGGZmTHX/jsVhaj9Vvz
         yZkCb57OyJR3IPEbcSFswrtWL9/1HGKCW7LrtTaFlk7oYTO2+MV3qRE5xf6cIpAA5B7r
         UV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vbEZDn6F+U7fLvG/dV/ekQ+8VtzU/Wmvd2z5pzH+GUE=;
        b=FZ5roHfHuBfHD9zoRNhz6T6+k913Eg/4ha8UVe3W/JyExxqlhy4Vo3MUKSrvnddwDv
         MqXtygpDrJNtFQTZyL7OmU75AACzGi0Hdcq9vbO1uelVAoNW9PZWIOBaPig3k2upuEe3
         4ygYa9eXxeN28g9HczNR7zkoQSfqVNdUjtD3E4LGMCeFCQI853m2lJMARHLU4wZKG9nU
         o+RZg/d/xbjcJ46OarFD8tlll78JFcD5RjAAq2ms8A7jjLApsW6ydhvVGVznro/foYJD
         PKgnwTLYVYEobzMXmxFKsn9JMhJJUJwHgxWLslYNpDd9OCNFfzomRIb3Q6h+qUyuh9VJ
         vyfw==
X-Gm-Message-State: AOAM5330D3UwcPy2wdAAW9rqlVThJbhOLigbDWBIvUYIJs4scPPcQ1R5
        MsAJgwzLvC4jPiMs3nsfLRVCokZwbj7XbviNyE2qCQ==
X-Google-Smtp-Source: ABdhPJwvuAF/gcAoXk64cfSwPxsylDcsCtoq2d0FF8wyE7rZopigHoV0zNOJYSQj+DIVrOfQS+sItg3pskcy+TPMMwU=
X-Received: by 2002:a25:b74c:: with SMTP id e12mr40069788ybm.20.1614047652553;
 Mon, 22 Feb 2021 18:34:12 -0800 (PST)
MIME-Version: 1.0
References: <20210205013847.1736929-1-saravanak@google.com>
 <CAOMZO5DRjT4d8gzSZZX4itcOXO_pye-1aq658EX2vQJ5xhEi8A@mail.gmail.com> <CAGETcx9E+dw3HS+DHMhzbrQGcrT6z4kDH=ziS=1=i-7=0rLwgw@mail.gmail.com>
In-Reply-To: <CAGETcx9E+dw3HS+DHMhzbrQGcrT6z4kDH=ziS=1=i-7=0rLwgw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 22 Feb 2021 18:33:36 -0800
Message-ID: <CAGETcx9r5=zZZ445ou3Vd0hWCfb_HH6bHnE_XMTAWwvr7bW=OA@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: imx: avic: Convert to using IRQCHIP_DECLARE
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

On Thu, Feb 4, 2021 at 6:07 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Feb 4, 2021 at 5:54 PM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > Hi Saravana,
> >
> > On Thu, Feb 4, 2021 at 10:39 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > Using IRQCHIP_DECLARE lets fw_devlink know that it should not wait for
> > > these interrupt controllers to be populated as struct devices. Without
> > > this change, fw_devlink=on will make the consumers of these interrupt
> > > controllers wait for the struct device to be added and thereby block the
> > > consumers' probes forever. Converting to IRQCHIP_DECLARE addresses boot
> > > issues on imx25 with fw_devlink=on that were reported by Martin.
> > >
> > > This also removes a lot of boilerplate code.
> > >
> > > Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
> > > Reported-by: Martin Kaiser <martin@kaiser.cx>
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > Tested-by: Martin Kaiser <martin@kaiser.cx>
> >
> > Thanks for the respin:
> >
> > Reviewed-by: Fabio Estevam <festevam@gmail.com>
>
> Thanks for the quick review.
>

Maintainers,

Is this getting picked up for 5.12?

-Saravana
