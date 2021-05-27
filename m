Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DC7392FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbhE0Nge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbhE0Ngb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:36:31 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43999C061574;
        Thu, 27 May 2021 06:34:57 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id z12so227278ejw.0;
        Thu, 27 May 2021 06:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VEI5bLvXgbpeUivVBaEMqx+txchbLnpQpbqyYjt+PAM=;
        b=cwm5LW0GBakp8nRYV1jRDGSh9pRg91ZkgADzzEoCwe6WGyqpBqUwZwOY0Kaa01Rn6E
         2eH+iw7H89o8RiEyS3uLIpmFoaKTU9tTkuRLm2Uw+7ZYJeEsv+KtReXC6x3Y8PGfFbSS
         2sko2odHhgWqu2WVo6nYS29ZmZhTTAoV5/J8SdRy7Y7/oP4h0NxO2lkTCeGUWnUrCm98
         SYJFvX3O0iAG9CAPJDE3c2+2mXJ5sG86j7vl/ajWDh4gESiz5d/1PLfVMLWVQnZjinmV
         +Ddl8TRlEsPNlCiavUhszTUx+C/vqbFiJaZS0Kh5zbwDsa8te5H0iSF1syEQjLB+x1iz
         CQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VEI5bLvXgbpeUivVBaEMqx+txchbLnpQpbqyYjt+PAM=;
        b=VVzcsmPX/Nm8H6xStwP05AzAVO5PHvSiDR+twI1y9UC9QMtHd0KqS1j31o8jlbOPTP
         aIyiJ97PZLsY6sApJAiJVqUNn1wbYscmTJOvLYmCSbSBmCu/SBLNwWXTokjZ2S0llkNN
         JyqkqNoOT826Iz+ydqYtGA+rur+PEDBleJtKDhbUAgpiSl/bjtGXRWy4gBygZFYjWkB3
         ChSWeoYFiRdrl0JtOEXNbtFrL9+HZlwnVFGqS8arOdolqsjwXfDh3Sw9sQQnQTE7edb8
         toWF1hSvCeoCj8iRsX85Xjky7bH/GivQb7boV8vAgkhBptpTjagJ2WGGHG3EWf9TAjXr
         Qp9g==
X-Gm-Message-State: AOAM532AOnEUhyf0vKHVXnimil8yNpkn9lg95uEWGLPPVaKFDtURTolt
        dvpYuR6N95qZS4i63ATO94A=
X-Google-Smtp-Source: ABdhPJyNoWNmDmTgjQkaLfmJlu3gcChA52ovRWg4GgXNQwjckGRj6Ti+j+d0suc/pmb3jV4D1m44wA==
X-Received: by 2002:a17:906:d1d2:: with SMTP id bs18mr3864295ejb.56.1622122495798;
        Thu, 27 May 2021 06:34:55 -0700 (PDT)
Received: from BV030612LT ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id y15sm1011399ejc.48.2021.05.27.06.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 06:34:55 -0700 (PDT)
Date:   Thu, 27 May 2021 16:34:52 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/6] clk: actions: Fix bisp_factor_table based clocks on
 Owl S500 SoC
Message-ID: <20210527133452.GB1300160@BV030612LT>
References: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
 <13576ddb604a9097603d95cd2605275c20fb2f56.1615221459.git.cristian.ciocaltea@gmail.com>
 <20210316041739.GC1798@thinkpad>
 <20210316183753.GC1111731@BV030612LT>
 <20210526101830.GE10723@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526101830.GE10723@work>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 03:48:30PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Mar 16, 2021 at 08:37:53PM +0200, Cristian Ciocaltea wrote:
> > On Tue, Mar 16, 2021 at 09:47:39AM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Mar 08, 2021 at 07:18:28PM +0200, Cristian Ciocaltea wrote:
> > > > The following clocks of the Actions Semi Owl S500 SoC have been defined
> > > > to use a shared clock factor table 'bisp_factor_table[]': DE[1-2], VCE,
> > > > VDE, BISP, SENSOR[0-1]
> > > > 
> > > > There are several issues involved in this approach:
> > > > 
> > > > * 'bisp_factor_table[]' describes the configuration of a regular 8-rates
> > > >   divider, so its usage is redundant. Additionally, judging by the BISP
> > > >   clock context, it is incomplete since it maps only 8 out of 12
> > > >   possible entries.
> > > > 
> > > > * The clocks mentioned above are not identical in terms of the available
> > > >   rates, therefore cannot rely on the same factor table. Specifically,
> > > >   BISP and SENSOR* are standard 12-rate dividers so their configuration
> > > >   should rely on a proper clock div table, while VCE and VDE require a
> > > >   factor table that is a actually a subset of the one needed for DE[1-2]
> > > >   clocks.
> > > > 
> > > > Let's fix this by implementing the following:
> > > > 
> > > > * Add new factor tables 'de_factor_table' and 'hde_factor_table' to
> > > >   properly handle DE[1-2], VCE and VDE clocks.
> > > > 
> > > > * Add a common div table 'std12rate_div_table' for BISP and SENSOR[0-1]
> > > >   clocks converted to OWL_COMP_DIV.
> > > > 
> > > > * Drop the now unused 'bisp_factor_table[]'.
> > > > 
> > > 
> > > Nice!
> > > 
> > > > Additionally, since SENSOR[0-1] are not gated, unset the OWL_GATE_HW
> > > > configuration and drop the CLK_IGNORE_UNUSED flag in their definitions.
> > > > 
> > > 
> > > No. You should not screen the functionality exposed by the hw, that's what the
> > > purpose of these CLK_ flags.
> > 
> > I'm not sure I get this, or maybe I wasn't clear enough with my
> > explanation regarding the changes to SENSOR clocks: they are not gated
> > in hardware, hence the statement 'OWL_GATE_HW(CMU_DEVCLKEN0, 14, 0)' 
> > was invalid and I replaced it with '{ 0 }'.
> > 
> 
> This clock is gated in hw as per the datasheet. Again, please don't make
> judgements based on the vendor code as it is not upto date with HW. I
> know it is silly but that's how things are...

Indeed, a newer datasheet states the clock is gated. I fixed the patch
accordingly in v2.

> > Additionally, I assumed the 'CLK_IGNORE_UNUSED' flag makes sense only
> > for the gated clocks. Do I miss something?
> > 
> 
> CLK_IGNORE_UNUSED is used by the clk framework to essentially skip
> gating the clocks which are turned ON by the bootloader and there is no
> other driver using it. But I think you can remove this flag because
> there is no reason to leave this specific clock to be ON always.

Thanks for the explanation, I kept the flag removed in v2.

Regards,
Cristi

> Thanks,
> Mani
> 
> > > Other than that, this patch looks good to me.
> > 
> > Thanks,
> > Cristi
> > 
> > [...]
