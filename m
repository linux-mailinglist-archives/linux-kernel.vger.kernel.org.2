Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8FA349CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 00:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhCYXYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 19:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhCYXXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 19:23:43 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B1DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 16:23:32 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r17so3402254pgi.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 16:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ijr1ZSBfSqBVSit26sWNJ1txc4UM8Ok1brAP81EWSGg=;
        b=L9riEB6bXi4sLwSTz0Hfb2D/nTHnjEw/Plled2mNXivO60pjRz/Rk3+jJ9kHmGLsiq
         HjLwTqkG3Kx6ll7+xnDWFx863Ho+18pnjrlNEZ29EhNxk1gIU/3TmXqRN28ibpjtj6nV
         j5AAos5wA0KYx5SUw0SnLhx9INtLQbGkVooqPvmWy3G8v5OOBIPy+Tv1YhqxmQhUFzzI
         0hXHwBwru3NGCopgMa/gxIhVvkPhDZYieGAsVzzBqxoJ223RdzKFcsVEsk/syJaKDUqi
         cvBZi/RlVvjcgmPLHytOuscS63LkJRTnf8+Ii/eeBdLVGlR05b9mhX6kIyu4nOf+fzT6
         4qNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ijr1ZSBfSqBVSit26sWNJ1txc4UM8Ok1brAP81EWSGg=;
        b=p6GhHyZwHmMrU12pK4MRHxfGSHmIfk68WDJ4tC7J2n2BU3YI3sTLDBSr0d/B9/RA8E
         0pkYgfESqJlc6R9otbYunsimLJKcSsS7CRqBbKbMR3xZ/GGiJhyuTXeNU/AV2TybVtBf
         lBDhifQHH10voXRM0OE/xCsBQiLWHfH+b0Z7q5GnWvy+honmjZK1YzCsVHTwNdUXUwyF
         +DRH/z4OGrsHj1fD7MkVHaSkdvP6KrpykUmmw/Q777aK93dzFlfYqP5JWzzNwYvCq3HS
         FvsdGTwVq3WYLYWqydELZQ0DMwmeQjI2poJugLpktS+EB59wtNaJ0hTfJsMjIk7noBYZ
         Yjdg==
X-Gm-Message-State: AOAM533yIlho5wdyVhqo1KGIHI2rXzU16uh7lUCq1qeOatP6Sq1oqOtT
        RfIlWnnyJq8J9o0tUW8buKad8A==
X-Google-Smtp-Source: ABdhPJz4FFWwY+l3EGeAUHcIXlcxJ1BQLJh67cAiVkNe8DvXqnYxzvrsrUML5+gYdDq0soHLhGo1BA==
X-Received: by 2002:a17:903:31d7:b029:e7:1dfd:4213 with SMTP id v23-20020a17090331d7b02900e71dfd4213mr877305ple.26.1616714611908;
        Thu, 25 Mar 2021 16:23:31 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c72sm6901303pfb.165.2021.03.25.16.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 16:23:31 -0700 (PDT)
Date:   Thu, 25 Mar 2021 17:23:28 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        o.rempel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] remoteproc: imx_rproc: enlarge IMX7D_RPROC_MEM_MAX
Message-ID: <20210325232328.GC1982573@xps15>
References: <20210319104708.7754-1-peng.fan@oss.nxp.com>
 <20210325230042.GB1982573@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325230042.GB1982573@xps15>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 05:00:42PM -0600, Mathieu Poirier wrote:
> Hi Peng,
> 
> On Fri, Mar 19, 2021 at 06:47:07PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > 8 is not enough when we need more, so enlarge IMX7D_RPROC_MEM_MAX to 32,
> > and also rename it to IMX_RPROC_MEM_MAX which make more sense.
> > 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/imx_rproc.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> > index 6d3207ccbaef..24275429a7cc 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -48,7 +48,7 @@
> >  					 | IMX6SX_SW_M4C_NON_SCLR_RST \
> >  					 | IMX6SX_SW_M4C_RST)
> >  
> > -#define IMX7D_RPROC_MEM_MAX		8
> > +#define IMX_RPROC_MEM_MAX		32
> 
> The size of structure imx_rproc_att_imx7d and imx_rproc_att_imx6sx have
> not changed nor has there been an addition of new imx_rproc_att that would
> justify the change.
> 
> It seems to me you are working on something internally and this patch is in
> preparation for that.  If that is the case then please resubmit this patch with
> the rest of the code.

Reviewing the other patch in this set [1], I understand why the extension is
needed.  Without a cover letter I assume the patches were not related.  Next
time please add one so that I know exactly what is going on.  Adding a line in
the changelog that explains why it is needed, i.e for the resource table, would
also be helpful.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

[1]. remoteproc: imx_rproc: support remote cores booted before Linux Kernel

> 
> Thanks,
> Mathieu 
> 
> >  
> >  /**
> >   * struct imx_rproc_mem - slim internal memory structure
> > @@ -88,7 +88,7 @@ struct imx_rproc {
> >  	struct regmap			*regmap;
> >  	struct rproc			*rproc;
> >  	const struct imx_rproc_dcfg	*dcfg;
> > -	struct imx_rproc_mem		mem[IMX7D_RPROC_MEM_MAX];
> > +	struct imx_rproc_mem		mem[IMX_RPROC_MEM_MAX];
> >  	struct clk			*clk;
> >  	struct mbox_client		cl;
> >  	struct mbox_chan		*tx_ch;
> > @@ -272,7 +272,7 @@ static void *imx_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *i
> >  	if (imx_rproc_da_to_sys(priv, da, len, &sys))
> >  		return NULL;
> >  
> > -	for (i = 0; i < IMX7D_RPROC_MEM_MAX; i++) {
> > +	for (i = 0; i < IMX_RPROC_MEM_MAX; i++) {
> >  		if (sys >= priv->mem[i].sys_addr && sys + len <
> >  		    priv->mem[i].sys_addr +  priv->mem[i].size) {
> >  			unsigned int offset = sys - priv->mem[i].sys_addr;
> > @@ -425,7 +425,7 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
> >  		if (!(att->flags & ATT_OWN))
> >  			continue;
> >  
> > -		if (b >= IMX7D_RPROC_MEM_MAX)
> > +		if (b >= IMX_RPROC_MEM_MAX)
> >  			break;
> >  
> >  		priv->mem[b].cpu_addr = devm_ioremap(&pdev->dev,
> > @@ -459,7 +459,7 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
> >  			return err;
> >  		}
> >  
> > -		if (b >= IMX7D_RPROC_MEM_MAX)
> > +		if (b >= IMX_RPROC_MEM_MAX)
> >  			break;
> >  
> >  		/* Not use resource version, because we might share region */
> > -- 
> > 2.30.0
> > 
