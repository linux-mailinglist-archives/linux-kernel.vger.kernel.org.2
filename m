Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CCD3CF194
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 03:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241436AbhGTBC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 21:02:56 -0400
Received: from mo-csw1515.securemx.jp ([210.130.202.154]:39676 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238901AbhGTA7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 20:59:50 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 16K1dnMa020160; Tue, 20 Jul 2021 10:39:50 +0900
X-Iguazu-Qid: 34tr8rsmpL7lZ8fR6E
X-Iguazu-QSIG: v=2; s=0; t=1626745189; q=34tr8rsmpL7lZ8fR6E; m=7jWreV28C33jvpXcV98QWw+Q/3s1CLDKk4R69WmRN5Q=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1512) id 16K1dlUu037777
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 20 Jul 2021 10:39:49 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id C61D21000C4;
        Tue, 20 Jul 2021 10:39:47 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 16K1dl1E012788;
        Tue, 20 Jul 2021 10:39:47 +0900
Date:   Tue, 20 Jul 2021 10:39:43 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] clk: visconti: Add support common clock driver
 and reset driver
X-TSB-HOP: ON
Message-ID: <20210720013943.worr5h3u7tcpfvwy@toshiba.co.jp>
References: <20210624034337.282386-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210624034337.282386-2-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210714192130.GA3000985@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714192130.GA3000985@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your review.

On Wed, Jul 14, 2021 at 01:21:30PM -0600, Rob Herring wrote:
> On Thu, Jun 24, 2021 at 12:43:34PM +0900, Nobuhiro Iwamatsu wrote:
> > This adds support for common interface of the common clock and reset driver
> > for Toshiba Visconti5 and its SoC, TMPV7708. The PIPLLCT provides the PLL,
> > and the PISMU provides clock and reset functionality.
> > Each drivers are provided in this patch.
> > 
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > ---
> >  drivers/clk/Makefile                         |   1 +
> >  drivers/clk/visconti/Makefile                |   5 +
> >  drivers/clk/visconti/clkc-tmpv770x.c         | 246 +++++++++++++
> >  drivers/clk/visconti/clkc.c                  | 220 +++++++++++
> >  drivers/clk/visconti/clkc.h                  |  75 ++++
> >  drivers/clk/visconti/pll-tmpv770x.c          |  96 +++++
> >  drivers/clk/visconti/pll.c                   | 369 +++++++++++++++++++
> >  drivers/clk/visconti/pll.h                   |  63 ++++
> >  drivers/clk/visconti/reset.c                 | 111 ++++++
> >  drivers/clk/visconti/reset.h                 |  35 ++
> 
> >  include/dt-bindings/clock/toshiba,tmpv770x.h | 181 +++++++++
> >  include/dt-bindings/reset/toshiba,tmpv770x.h |  41 +++
> 
> These belong with the binding.

OK, I will include this to DT binding patche from next.

> 
> >  12 files changed, 1443 insertions(+)
> >  create mode 100644 drivers/clk/visconti/Makefile
> >  create mode 100644 drivers/clk/visconti/clkc-tmpv770x.c
> >  create mode 100644 drivers/clk/visconti/clkc.c
> >  create mode 100644 drivers/clk/visconti/clkc.h
> >  create mode 100644 drivers/clk/visconti/pll-tmpv770x.c
> >  create mode 100644 drivers/clk/visconti/pll.c
> >  create mode 100644 drivers/clk/visconti/pll.h
> >  create mode 100644 drivers/clk/visconti/reset.c
> >  create mode 100644 drivers/clk/visconti/reset.h
> >  create mode 100644 include/dt-bindings/clock/toshiba,tmpv770x.h
> >  create mode 100644 include/dt-bindings/reset/toshiba,tmpv770x.h
> 
> > diff --git a/include/dt-bindings/clock/toshiba,tmpv770x.h b/include/dt-bindings/clock/toshiba,tmpv770x.h
> > new file mode 100644
> > index 000000000000..923b47a11730
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/toshiba,tmpv770x.h
> > @@ -0,0 +1,181 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> 
> Dual license DT headers please.

OK, I will update.

Best regards,
  Nobuhiro


