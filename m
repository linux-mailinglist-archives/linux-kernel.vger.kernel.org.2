Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F5639B525
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFDItU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 04:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDItT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:49:19 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD464C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 01:47:17 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so182533wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 01:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/FKlwDtg6Z1tlii4rMQLDyghNbnnLvKNz1TIQNqgqBo=;
        b=EgM8YszLM1vgbYmSMkftvJOnA8yDgD3REicNnHyLOne3FfUvpjhdm9SIsHD9aFcMgt
         xaP55nQ6/rSU2Ej4bNklexIgjA1wMRgcthYfWN/JaG5e3J4K7Qexm+Ukk2JmkV+LsUHY
         vN92j0ZiC8y1Xb7HXayIaop7mZ01lN8JMMOWB0PTQ9pqqsOFBpN099CP+KZAG33lgjvZ
         Yqtkl2hNRcwZg02Q/tpcIwxlUKQ4Y9E7sIV03AJIlU0cER48bwC5lBiM4MaQLJhAWoNs
         nmpHmG1tQwK6Q9S9/G32qlAwheHPSOn6+Lli+NFa+agRSJdtCh/Dmr/R9s9BSIv/G3Is
         RX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/FKlwDtg6Z1tlii4rMQLDyghNbnnLvKNz1TIQNqgqBo=;
        b=NzMQOtffGS2CBmN1L6Zpka4fUxAyy9pg/h7hky12qMIr6idivhRIq8Cq06uzc8yArL
         niS+sXV9+0q8yYgvQ0sycMQOhRweRERXyp3PbNpJMMeoMr54LmQozP3DEJl9a12z+VP5
         gjjSFXd2YWAY/l+4FHdtbI62RYqa6eW9/YlXeZtUhUEiILvSEPewjVl4+ScHZys1thJ/
         nJGnGfegY6aYpD6/dVBaWJyhc94dIXoo9TpFV0p9rAZe9X7EsRfa6KWNQ7rkgltc76kH
         tjw983QWTxwAXi14gh37uAFeAzLOCs5vR9wgjQn7NNElwbekfWic6p2GoKl0+e+r6EFN
         nsBw==
X-Gm-Message-State: AOAM531FVVbz5TrdE2J7+Hs5fsGlAT7hIuwxtl/tdZ5MBZH8Xp3saZ7Z
        zqbYimTLZA/mxbH1ScsGu9MTeA==
X-Google-Smtp-Source: ABdhPJwyERrKS1FbST/ERIbVBsDwXBv3+isYP3qFsmwNsAz+46MuX7tv4ih6HnPItANwBpX/1os3ow==
X-Received: by 2002:a7b:c749:: with SMTP id w9mr2480723wmk.3.1622796434560;
        Fri, 04 Jun 2021 01:47:14 -0700 (PDT)
Received: from dell ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id o22sm7801640wmc.17.2021.06.04.01.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 01:47:14 -0700 (PDT)
Date:   Fri, 4 Jun 2021 09:47:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 09/16] i2c: busses: i2c-mxs: Demote barely half complete
 kernel-doc header
Message-ID: <20210604084710.GG2435141@dell>
References: <20210520190105.3772683-1-lee.jones@linaro.org>
 <20210520190105.3772683-10-lee.jones@linaro.org>
 <YLk7qcWTZnQmLGkW@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YLk7qcWTZnQmLGkW@kunai>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Jun 2021, Wolfram Sang wrote:

> On Thu, May 20, 2021 at 08:00:58PM +0100, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or member 'timing0' not described in 'mxs_i2c_dev'
> >  drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or member 'timing1' not described in 'mxs_i2c_dev'
> >  drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or member 'timing2' not described in 'mxs_i2c_dev'
> >  drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or member 'dmach' not described in 'mxs_i2c_dev'
> >  drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or member 'pio_data' not described in 'mxs_i2c_dev'
> >  drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or member 'addr_data' not described in 'mxs_i2c_dev'
> >  drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or member 'sg_io' not described in 'mxs_i2c_dev'
> >  drivers/i2c/busses/i2c-mxs.c:131: warning: Function parameter or member 'dma_read' not described in 'mxs_i2c_dev'
> 
> Disabling kernel-doc works around, does not really fix, or?

You're right.

With cases of genuine oversight or a bit of doc-rot, I tend to help
where I can.  However issues such as these where documentation has
been either severely neglected or half-arsed require either the author
or another knowledgeable person so provide fix-ups in the way of
additional quality descriptions.

IMHO, we wouldn't want to foster the impression that it's okay to
provide a non-determined effort, safe in the knowledge that someone
will come along later and finish the job for them at a later date.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
