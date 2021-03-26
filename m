Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37B234A613
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 12:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhCZLCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 07:02:43 -0400
Received: from foss.arm.com ([217.140.110.172]:55026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhCZLCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 07:02:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF7EE143D;
        Fri, 26 Mar 2021 04:02:37 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A49523F7D7;
        Fri, 26 Mar 2021 04:02:35 -0700 (PDT)
Date:   Fri, 26 Mar 2021 11:02:29 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, sudeep.holla@arm.com,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, thara.gopinath@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v7 18/38] clk: scmi: port driver to the new
 scmi_clk_proto_ops interface
Message-ID: <20210326110229.GB43717@e120937-lin>
References: <20210316124903.35011-1-cristian.marussi@arm.com>
 <20210316124903.35011-19-cristian.marussi@arm.com>
 <161671733901.3012082.11186673559577220910@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161671733901.3012082.11186673559577220910@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 05:08:59PM -0700, Stephen Boyd wrote:
> Sorry didn't notice because linux-clk@vger.kernel.org wasn't Cced
> 
Ah, sorry my bad.

> Quoting Cristian Marussi (2021-03-16 05:48:43)
> > Port driver to the new SCMI Clock interface based on protocol handles
> > and common devm_get_ops().
> > 
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v6 -> v7
> > - fixed Copyright
> > - renamed non-static function to fit scmi_<OBJ>_<ACTION> naming pattern
> > v4 --> v5
> > - using renamed devm_get/put_protocol
> > ---
> >  drivers/clk/clk-scmi.c | 27 +++++++++++++++++----------
> >  1 file changed, 17 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> > index c754dfbb73fd..be4c13d63385 100644
> > --- a/drivers/clk/clk-scmi.c
> > +++ b/drivers/clk/clk-scmi.c
> > @@ -2,7 +2,7 @@
> >  /*
> >   * System Control and Power Interface (SCMI) Protocol based clock driver
> >   *
> > - * Copyright (C) 2018 ARM Ltd.
> > + * Copyright (C) 2018-2021 ARM Ltd.
> >   */
> >  
> >  #include <linux/clk-provider.h>
> > @@ -13,11 +13,13 @@
> >  #include <linux/scmi_protocol.h>
> >  #include <asm/div64.h>
> >  
> > +static const struct scmi_clk_proto_ops *clk_ops;
> 
> Can you call it scmi_proto_clk_ops instead of clk_ops? We already have
> 'struct clk_ops' and this pollutes the global namespace with another
> 'clk_ops'.
> 

Sure I'll do and reply on this thread and CCing linux-clk with the fix.

Thanks

Cristian
> > +
> >  struct scmi_clk {
> >         u32 id;
> >         struct clk_hw hw;
> >         const struct scmi_clock_info *info;
> > -       const struct scmi_handle *handle;
> > +       const struct scmi_protocol_handle *ph;
> >  };
> >  
> >  #define to_scmi_clk(clk) container_of(clk, struct scmi_clk, hw)
