Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98857397765
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbhFAQCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFAQBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:01:55 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F77EC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 09:00:14 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id h19-20020a9d6f930000b02903c0c4560e99so1361633otq.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 09:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+EQc3xvG4vj4snpRMCUapfXHF8CpIpQCf2oacLZFBAk=;
        b=JeHyn8OpcfFeowio6lacRBlt7uKlEBVT0atacKuoMyyheIZe6HEZu8oJ/iBrO1DO1F
         OVCJhIf0AfES6MFJ+irIKqRLXlp/XbXYltlH4VO+ibPgl0QVSc6s78aPUXbuBvv8yocD
         afVNLPjC4HLPkk/Cd2qCIZFkpoGavJXHJcKUGfSV+NA/WryXTERG3dvjf/jL/PB9luFx
         98P38atSF+M/EjlnURCenI5RexCscTp24Gmkj7x8EuJmpnOTNKs8tAHj4TWY2bQiLmHO
         Bd34DwXpJQG3Rs2VW+ed0CMqgWICwIarye8SitaTgBtoCXoyOGcrt951KGkSrXriw2Dx
         IihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+EQc3xvG4vj4snpRMCUapfXHF8CpIpQCf2oacLZFBAk=;
        b=QliPQFb9EHzi/+FOTyhTv4Zizv8yINRV0QXN3dsr6O2jSD2G2BDwsDfchg4sW7wK0n
         3+GBMDssUS4SkVOr4V6Gb+Q+nMMWi7+ULzAFnxnzOm1aUH+UrGkr/1WoT43Qu7l0ZY7B
         AgsVElD5BpLdXJGgEUcZW97k1y33Lvjk5OVbKx/mHcITEwzffyQmVZkghS/GTjn91i3e
         oYziprR4YhylIP+RwUftpyfHmXWRTtzes41/mYuvNPliAC3Z99TLF958+QoXX/2uLHgL
         w2hP2cH4bwgt/V9tUT3vJLZ76KsllhapnWSM9dzCGW1nD0q0SHEFjLruqywtES9FWPMa
         WacA==
X-Gm-Message-State: AOAM532RgmWgArtTGgANdkztKfRhqZ5k9Wzjyl7yAOu5meNFO8+Xcuvd
        yNpysXPpFzJi2YBonodA1BDxxw==
X-Google-Smtp-Source: ABdhPJwPbmwjUcUd/RkviTbfJMWI6W/96DM7lu5hzupA0RL0pKF638/dfu5fK+yefZmIG0F5nNmpqw==
X-Received: by 2002:a05:6830:a:: with SMTP id c10mr23699912otp.114.1622563213374;
        Tue, 01 Jun 2021 09:00:13 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a71sm3508262oib.20.2021.06.01.09.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 09:00:12 -0700 (PDT)
Date:   Tue, 1 Jun 2021 11:00:10 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, ohad@wizery.com,
        o.rempel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] remoteproc: imx_rproc: correct firmware reload
Message-ID: <YLZZinrEMaYHgsEe@yoga>
References: <20210601102939.16139-1-peng.fan@oss.nxp.com>
 <20210601153139.GB1759269@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601153139.GB1759269@xps15>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01 Jun 10:31 CDT 2021, Mathieu Poirier wrote:

> On Tue, Jun 01, 2021 at 06:29:39PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > ENABLE_M4 should be set to 1 when loading code to TCM, otherwise
> > you will not able to replace the firmware after you stop m4.
> > 
> > Besides ENABLE_M4, we still need set SW_M4C_RST, because this bit
> > will be automatically set with SW_M4C_NON_SCLR_RST set.
> > 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> > 
> > V1:
> >  Although this is an fix, but it is not critical, patch is based on
> >  https://patchwork.kernel.org/project/linux-remoteproc/cover/1620274123-1461-1-git-send-email-peng.fan@oss.nxp.com/
> > 
> >  drivers/remoteproc/imx_rproc.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> > index cd2ca96a30e5..ce2ce42bee91 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -33,7 +33,8 @@
> >  
> >  #define IMX7D_M4_START			(IMX7D_ENABLE_M4 | IMX7D_SW_M4P_RST \
> >  					 | IMX7D_SW_M4C_RST)
> > -#define IMX7D_M4_STOP			(IMX7D_ENABLE_M4 | IMX7D_SW_M4C_NON_SCLR_RST)
> > +#define IMX7D_M4_STOP			(IMX7D_ENABLE_M4 | IMX7D_SW_M4C_RST | \
> > +					 IMX7D_SW_M4C_NON_SCLR_RST)
> >  
> >  /* Address: 0x020D8000 */
> >  #define IMX6SX_SRC_SCR			0x00
> > @@ -44,7 +45,8 @@
> >  
> >  #define IMX6SX_M4_START			(IMX6SX_ENABLE_M4 | IMX6SX_SW_M4P_RST \
> >  					 | IMX6SX_SW_M4C_RST)
> > -#define IMX6SX_M4_STOP			(IMX6SX_ENABLE_M4 | IMX6SX_SW_M4C_NON_SCLR_RST)
> > +#define IMX6SX_M4_STOP			(IMX6SX_ENABLE_M4 | IMX6SX_SW_M4C_RST | \
> > +					 IMX6SX_SW_M4C_NON_SCLR_RST)
> >  #define IMX6SX_M4_RST_MASK		(IMX6SX_ENABLE_M4 | IMX6SX_SW_M4P_RST \
> >  					 | IMX6SX_SW_M4C_NON_SCLR_RST \
> >  					 | IMX6SX_SW_M4C_RST)
> > @@ -691,7 +693,7 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
> >  		return ret;
> >  	}
> >  
> > -	if (!(val & dcfg->src_stop))
> > +	if ((val & dcfg->src_mask) != dcfg->src_stop)
> >  		priv->rproc->state = RPROC_DETACHED;
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Bjorn hasn't picked up this set yet so it is best to send a v7 of [1] with this
> change merged in it.
> 

Sorry I had missed that [1] was fully reviewed, so I figured I'll just
apply the series and squash this in. But afaict this patch isn't a fix
to any of the patches in [1].

More so, this patch doesn't apply on top of either v5.13-rc1, linux-next
or [1] - because neither IMX7D_M4_STOP nor IMX6SX_M4_STOP has
IMX6SX_ENABLE_M4 included.


Peng, I've applied [1] now, please let me know what to do about this
patch.

Regards,
Bjorn

> Thanks,
> Mathieu 
> 
> [1]. https://patchwork.kernel.org/project/linux-remoteproc/cover/1620274123-1461-1-git-send-email-peng.fan@oss.nxp.com/
> 
> >  
> >  	return 0;
> > -- 
> > 2.30.0
> > 
