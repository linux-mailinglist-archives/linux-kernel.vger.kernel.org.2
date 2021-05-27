Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5886392FA1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbhE0N3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236483AbhE0N3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:29:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B91C061574;
        Thu, 27 May 2021 06:27:37 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id s22so18231ejv.12;
        Thu, 27 May 2021 06:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ppiS+kUHEmNMA/rfiFdU2fGCovIYKgvsvBDMkMx1l8g=;
        b=N1ld5ltqPVFeWqGp+B9xVK3nRLjNtJfBEO3iq55ubS3wXZjWH65JSzfQL20TnWsEwg
         Qw1WwKn39XWjuFxzRXL6jAu6RJJymed0cbr5GjwRlZABwYYffYfVrlXuyYLQAZENPvJD
         CiPKtinmr7xwogY5ChiR2cMTCrW1G5C0ZSTGtSDF/L88GmokztHKdFSzX/fU+fzu7HiM
         sodB2E25l3ZqtpXhJDpcOv/zm/vIH2TWjY/dQECaj/IAVweEe4lLx+KO1IxKYs0K8pns
         jlVj9lmjcZM5OJL0BLeF6bqI/nDvTt5VCpb7MovQHrGafqNpIqd4388FoH9ucvjv0JOq
         ylsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ppiS+kUHEmNMA/rfiFdU2fGCovIYKgvsvBDMkMx1l8g=;
        b=qqadja0NUmDxLQaw148Vknbl7WeBfpigH+4uk9qYYdovl8EcxiWuZ0aikI03TA9nT2
         Q8JvKVyMMXVeMXnY04uFRipu8HhTRH4WTEg2JG4RmYBWwll9mVnhz1F6CL0wm1aE39RP
         0/+A5RckpNJRCdYW/0pOyyJcps/pFwC6CJwC+fyaOZugFDgHC2kAYp0DljDvl7e6IC89
         jPdpG5da0Pnk9IwkIKwockGeY6kW0XNE8L+puGhdd1NIBrV3Pc46/gDOmPAlr787VrUq
         JjAJMx5F3DALS1cJzqSnx71cmuMP1ZNYZo7BwTRzRInV3N0zrTLF3GeuEIOdBvMXTS3F
         PwlA==
X-Gm-Message-State: AOAM533qdGex8ym7yGVksPecJSH7arPJc+Fx/d+G5C22A1n6Fo0qBvBz
        j7G6Gwa8YmbcYdWsnQA71sc=
X-Google-Smtp-Source: ABdhPJwHz+PO0bxmokSeO7kLTi0+JZ/h/GLDeWjzuo/3J0bHnA1plBUGwNC8SjCRQyMwcMX/Beskxw==
X-Received: by 2002:a17:906:90c9:: with SMTP id v9mr3813868ejw.102.1622122056454;
        Thu, 27 May 2021 06:27:36 -0700 (PDT)
Received: from BV030612LT ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id p25sm1011450eja.35.2021.05.27.06.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 06:27:35 -0700 (PDT)
Date:   Thu, 27 May 2021 16:27:33 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/6] clk: actions: Fix SD clocks factor table on Owl S500
 SoC
Message-ID: <20210527132733.GA1300160@BV030612LT>
References: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
 <973b08fe414321ba4ade096a4917cadc2013426e.1615221459.git.cristian.ciocaltea@gmail.com>
 <20210316035845.GB1798@thinkpad>
 <20210316181437.GB1111731@BV030612LT>
 <20210526100719.GC10723@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526100719.GC10723@work>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 03:37:43PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Mar 16, 2021 at 08:14:37PM +0200, Cristian Ciocaltea wrote:
> > Hi Mani,
> > 
> > Thanks for reviewing this patch series!
> > 
> > On Tue, Mar 16, 2021 at 09:28:45AM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Mar 08, 2021 at 07:18:27PM +0200, Cristian Ciocaltea wrote:
> > > > Drop the unsupported entries in the factor table used for the SD[0-2]
> > > > clocks definitions on the Actions Semi Owl S500 SoC.
> > > > 
> > > > Fixes: ed6b4795ece4 ("clk: actions: Add clock driver for S500 SoC")
> > > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > > ---
> > > >  drivers/clk/actions/owl-s500.c | 4 ----
> > > >  1 file changed, 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
> > > > index 75b7186185b0..69cd959205f5 100644
> > > > --- a/drivers/clk/actions/owl-s500.c
> > > > +++ b/drivers/clk/actions/owl-s500.c
> > > > @@ -127,8 +127,6 @@ static struct clk_factor_table sd_factor_table[] = {
> > > >  	{ 12, 1, 13 }, { 13, 1, 14 }, { 14, 1, 15 }, { 15, 1, 16 },
> > > >  	{ 16, 1, 17 }, { 17, 1, 18 }, { 18, 1, 19 }, { 19, 1, 20 },
> > > >  	{ 20, 1, 21 }, { 21, 1, 22 }, { 22, 1, 23 }, { 23, 1, 24 },
> > > > -	{ 24, 1, 25 }, { 25, 1, 26 }, { 26, 1, 27 }, { 27, 1, 28 },
> > > > -	{ 28, 1, 29 }, { 29, 1, 30 }, { 30, 1, 31 }, { 31, 1, 32 },
> > > 
> 
> [...]
> 
> > This is basically what gets translated to sd_factor_table and I removed
> > the extra entries 25..31. Actually I also dropped the 24th one, since
> > that would give us an odd number of items, although I'm not quite sure
> > this is a bug in the xapp-le code or the HW is really supposed to work
> > like that.
> > 
> 
> In my datasheet I can see the factor values till 24. So let's remove the
> entries from 25-31.

I got an updated datasheet and I confirm 24 is a valid selector. Applied
the correction in v2:

https://lore.kernel.org/lkml/cover.1622119892.git.cristian.ciocaltea@gmail.com/

Thanks,
Cristi

> Thanks,
> Mani
> 
> > Kind regards,
> > Cristi
> > 
> > > Thanks,
> > > Mani
> > > 
> > > >  
> > > >  	/* bit8: /128 */
> > > >  	{ 256, 1, 1 * 128 }, { 257, 1, 2 * 128 }, { 258, 1, 3 * 128 }, { 259, 1, 4 * 128 },
> > > > @@ -137,8 +135,6 @@ static struct clk_factor_table sd_factor_table[] = {
> > > >  	{ 268, 1, 13 * 128 }, { 269, 1, 14 * 128 }, { 270, 1, 15 * 128 }, { 271, 1, 16 * 128 },
> > > >  	{ 272, 1, 17 * 128 }, { 273, 1, 18 * 128 }, { 274, 1, 19 * 128 }, { 275, 1, 20 * 128 },
> > > >  	{ 276, 1, 21 * 128 }, { 277, 1, 22 * 128 }, { 278, 1, 23 * 128 }, { 279, 1, 24 * 128 },
> > > > -	{ 280, 1, 25 * 128 }, { 281, 1, 26 * 128 }, { 282, 1, 27 * 128 }, { 283, 1, 28 * 128 },
> > > > -	{ 284, 1, 29 * 128 }, { 285, 1, 30 * 128 }, { 286, 1, 31 * 128 }, { 287, 1, 32 * 128 },
> > > >  	{ 0, 0, 0 },
> > > >  };
> > > >  
> > > > -- 
> > > > 2.30.1
> > > > 
