Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD9430A608
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbhBAK72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbhBAK7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:59:17 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8C5C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 02:58:35 -0800 (PST)
Received: from pd956d63d.dip0.t-ipconnect.de ([217.86.214.61] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <postmaster@kaiser.cx>)
        id 1l6WuX-0000TN-Ap; Mon, 01 Feb 2021 11:58:25 +0100
Received: from martin by martin-debian-2.paytec.ch with local (Exim 4.92)
        (envelope-from <martin@martin-debian-2.paytec.ch>)
        id 1l6WuV-0002RC-JK; Mon, 01 Feb 2021 11:58:23 +0100
Date:   Mon, 1 Feb 2021 11:58:23 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Android Kernel Team <kernel-team@android.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] ARM: imx: avic: Convert to using IRQCHIP_DECLARE
Message-ID: <20210201105823.GB1467@martin-debian-1.paytec.ch>
References: <20210131205654.3379661-1-saravanak@google.com>
 <CAOMZO5AZgk0N8sN9=bGcWTcnju75TPVxQX3FbLpF=n-=JA-7-w@mail.gmail.com>
 <CAGETcx9YsjPtiBxJEybY5UTWNu-9e=FrYPVd1ORF9hz0M04w5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx9YsjPtiBxJEybY5UTWNu-9e=FrYPVd1ORF9hz0M04w5Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: "Martin Kaiser,,," <martin@martin-debian-2.paytec.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Saravana Kannan (saravanak@google.com):

> On Sun, Jan 31, 2021 at 5:26 PM Fabio Estevam <festevam@gmail.com> wrote:

> > Hi Saravana,

> > On Sun, Jan 31, 2021 at 5:56 PM Saravana Kannan <saravanak@google.com> wrote:

> > > +static int __init imx_avic_init(struct device_node *node,
> > > +                              struct device_node *parent)
> > > +{
> > > +       void __iomem *avic_base;
> > > +
> > > +       avic_base = of_iomap(node, 0);
> > > +       BUG_ON(!avic_base);
> > > +       mxc_init_irq(avic_base);
> > > +       return 0;
> > > +}
> > > +
> > > +IRQCHIP_DECLARE(imx_avic, "fsl,imx31-avic", imx_avic_init);

> > Shouldn't the compatible be "fsl,avic" instead?

> Fabio,

> Ah yes. I had that too. I deleted the wrong one in the last minute
> before sending it out. Thanks for catching it.

> I'll wait to see if there are any other review comments before I send out v2.

> Martin,

> Please make this fix before you test it.

> -Saravana

with fsl,avic

Tested-by: Martin Kaiser <martin@kaiser.cx>
