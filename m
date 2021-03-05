Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C45E32E4D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhCEJbe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 Mar 2021 04:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhCEJbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:31:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F28C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 01:31:24 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lI6nq-00072G-Rz; Fri, 05 Mar 2021 10:31:22 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lI6nq-0004fP-Bg; Fri, 05 Mar 2021 10:31:22 +0100
Message-ID: <fc9b38620c9576f5334605128cfb99fa47697aed.camel@pengutronix.de>
Subject: Re: [PATCH] reset: zynqmp: replace spaces with tabs
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org
Date:   Fri, 05 Mar 2021 10:31:22 +0100
In-Reply-To: <b5310ccf-2004-b047-c545-cceca3b1ee64@xilinx.com>
References: <20210304160042.15316-1-p.zabel@pengutronix.de>
         <b5310ccf-2004-b047-c545-cceca3b1ee64@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-03-04 at 17:03 +0100, Michal Simek wrote:
> 
> On 3/4/21 5:00 PM, Philipp Zabel wrote:
> > Fixes checkpatch issues:
> > 
> >   ERROR: code indent should use tabs where possible
> >   #86: FILE: drivers/reset/reset-zynqmp.c:86:
> >   +        .reset_id = 0,$
> > 
> >   WARNING: please, no spaces at the start of a line
> >   #86: FILE: drivers/reset/reset-zynqmp.c:86:
> >   +        .reset_id = 0,$
> > 
> >   ERROR: code indent should use tabs where possible
> >   #87: FILE: drivers/reset/reset-zynqmp.c:87:
> >   +        .num_resets = VERSAL_NR_RESETS,$
> > 
> >   WARNING: please, no spaces at the start of a line
> >   #87: FILE: drivers/reset/reset-zynqmp.c:87:
> >   +        .num_resets = VERSAL_NR_RESETS,$
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> >  drivers/reset/reset-zynqmp.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
> > index ebd433fa09dd..daa425e74c96 100644
> > --- a/drivers/reset/reset-zynqmp.c
> > +++ b/drivers/reset/reset-zynqmp.c
> > @@ -83,8 +83,8 @@ static const struct zynqmp_reset_soc_data zynqmp_reset_data = {
> >  };
> >  
> >  static const struct zynqmp_reset_soc_data versal_reset_data = {
> > -        .reset_id = 0,
> > -        .num_resets = VERSAL_NR_RESETS,
> > +	.reset_id = 0,
> > +	.num_resets = VERSAL_NR_RESETS,
> >  };
> >  
> >  static const struct reset_control_ops zynqmp_reset_ops = {
> > 
> 
> Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thank you, applied to reset/next

regards
Philipp
