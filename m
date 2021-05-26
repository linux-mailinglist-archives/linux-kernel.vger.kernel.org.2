Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB9F3914B8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhEZKUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbhEZKUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:20:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF87C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 03:18:35 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q16so374356pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 03:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XSi3eEZGuE/2YFaQr+R0aCzKJxfy8VJGKcJVdLww6Hg=;
        b=VUW/mY1pRYOS0Oz3reGWDXfF/PieVcGzL47ZKVJA2N8+uUA+pwLwgqo6FB4AlpokDY
         dmamG3lfFC/ErlYruqqd40vWDP9dzd5oaMlBn1S+URR+JSxJDbjRlgKfdwTJmy8Z/N6o
         A7uZnaQiNjrACXwgQlRNXIaOiPJL7ahEutdh5+UoB4sa7b8apqR6c+k3Y7U5dUmpac1X
         WWomYVMU8JgIckH0e7JZeExzlpD+Evt3PdMOasAR62yDySoq/3nX0CdvwxL7xQ5sZrBr
         a8N98IgWtVGVCxrFG/hLNCkUKCRuOMD6TcKcYXVEOAn5U9epaTU5J+/CPh1Lh10HBse/
         ZFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XSi3eEZGuE/2YFaQr+R0aCzKJxfy8VJGKcJVdLww6Hg=;
        b=V+wKFbtryI7XDBXkdNByCDv0QW6Vu3UapUNUQuEaKm0uN9D7S84sXit8aJ17L/BpP7
         mceNE0CEhC6r5eAjfwn62ztlASs2YIpbfNP+C62xmKmae2IZSAG4wGywhfrUyzpeKm4m
         YJGJs6hiVmV+WVPxIgiGGXM5ktMxop9zw8Tqrx/YhxdrpFEyH7gQHikRrfKXkOLK9Pui
         YqWKzHDN9mROGz4fBpDEXMskMZDOzKs+IvX0WmjPIHa3NFViVGpINGjeeJWNlezGeAxg
         mig97Y2oXl/nxaRxVNa5WRXUnFpyg30xwy94EfSZZanXMd9KNnjoQZ4woY5VfS3yG9ms
         hkFA==
X-Gm-Message-State: AOAM532TnpKcwq2Fas3i3XUa5NK10f8fe6FJEyMqPxdZqKidHawI62LJ
        tTFBp4x3HGtvI7s5DKJ2Gt3pnSCm8LZK
X-Google-Smtp-Source: ABdhPJwuWcSHpObOVOjzCc0SZHP/m4Ox5RQ4y5X0r3eESQIQEwnY+dMPKWw0wFBV9czZ9+5zlyhldA==
X-Received: by 2002:a17:902:34f:b029:ef:3d14:1c27 with SMTP id 73-20020a170902034fb02900ef3d141c27mr35650682pld.65.1622024315280;
        Wed, 26 May 2021 03:18:35 -0700 (PDT)
Received: from work ([120.138.12.4])
        by smtp.gmail.com with ESMTPSA id p1sm15306479pfp.137.2021.05.26.03.18.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 May 2021 03:18:34 -0700 (PDT)
Date:   Wed, 26 May 2021 15:48:30 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/6] clk: actions: Fix bisp_factor_table based clocks on
 Owl S500 SoC
Message-ID: <20210526101830.GE10723@work>
References: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
 <13576ddb604a9097603d95cd2605275c20fb2f56.1615221459.git.cristian.ciocaltea@gmail.com>
 <20210316041739.GC1798@thinkpad>
 <20210316183753.GC1111731@BV030612LT>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316183753.GC1111731@BV030612LT>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 08:37:53PM +0200, Cristian Ciocaltea wrote:
> On Tue, Mar 16, 2021 at 09:47:39AM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Mar 08, 2021 at 07:18:28PM +0200, Cristian Ciocaltea wrote:
> > > The following clocks of the Actions Semi Owl S500 SoC have been defined
> > > to use a shared clock factor table 'bisp_factor_table[]': DE[1-2], VCE,
> > > VDE, BISP, SENSOR[0-1]
> > > 
> > > There are several issues involved in this approach:
> > > 
> > > * 'bisp_factor_table[]' describes the configuration of a regular 8-rates
> > >   divider, so its usage is redundant. Additionally, judging by the BISP
> > >   clock context, it is incomplete since it maps only 8 out of 12
> > >   possible entries.
> > > 
> > > * The clocks mentioned above are not identical in terms of the available
> > >   rates, therefore cannot rely on the same factor table. Specifically,
> > >   BISP and SENSOR* are standard 12-rate dividers so their configuration
> > >   should rely on a proper clock div table, while VCE and VDE require a
> > >   factor table that is a actually a subset of the one needed for DE[1-2]
> > >   clocks.
> > > 
> > > Let's fix this by implementing the following:
> > > 
> > > * Add new factor tables 'de_factor_table' and 'hde_factor_table' to
> > >   properly handle DE[1-2], VCE and VDE clocks.
> > > 
> > > * Add a common div table 'std12rate_div_table' for BISP and SENSOR[0-1]
> > >   clocks converted to OWL_COMP_DIV.
> > > 
> > > * Drop the now unused 'bisp_factor_table[]'.
> > > 
> > 
> > Nice!
> > 
> > > Additionally, since SENSOR[0-1] are not gated, unset the OWL_GATE_HW
> > > configuration and drop the CLK_IGNORE_UNUSED flag in their definitions.
> > > 
> > 
> > No. You should not screen the functionality exposed by the hw, that's what the
> > purpose of these CLK_ flags.
> 
> I'm not sure I get this, or maybe I wasn't clear enough with my
> explanation regarding the changes to SENSOR clocks: they are not gated
> in hardware, hence the statement 'OWL_GATE_HW(CMU_DEVCLKEN0, 14, 0)' 
> was invalid and I replaced it with '{ 0 }'.
> 

This clock is gated in hw as per the datasheet. Again, please don't make
judgements based on the vendor code as it is not upto date with HW. I
know it is silly but that's how things are...

> Additionally, I assumed the 'CLK_IGNORE_UNUSED' flag makes sense only
> for the gated clocks. Do I miss something?
> 

CLK_IGNORE_UNUSED is used by the clk framework to essentially skip
gating the clocks which are turned ON by the bootloader and there is no
other driver using it. But I think you can remove this flag because
there is no reason to leave this specific clock to be ON always.

Thanks,
Mani

> > Other than that, this patch looks good to me.
> 
> Thanks,
> Cristi
> 
> [...]
