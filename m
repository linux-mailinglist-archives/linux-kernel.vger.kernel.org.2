Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F6A315FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhBJHCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:02:07 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:33040 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhBJHB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:01:58 -0500
Received: by mail-lj1-f177.google.com with SMTP id a25so1481311ljn.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 23:01:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=Kkc+vL76oFsI+gKvpPWRMS2VWzccYZ7RAvh7RS/YjSk=;
        b=CrooNhNPlxm2jPhoxRdK5GzlIuaT/zkNYYBz/OWC0+YgcEsLUDK8klb5f5b8KRMzWN
         0Bb9sTR5ouDt7FIPdUweGvfIvWUr1MyLjjhfX0QYSCa0YlDa6nMbkolZz/tCpWQfvx+Q
         znsOdmhIScd/rMIPWzrhwCZ6x0eb59F0LDQl+BrynUe8hfnU6bKce6PQs09gA2HWLG4t
         8E7pX3LGX3tnIRnkdua1Y7T4HuSoJqI4hO8HTTrDycgAwN3+a5bdb2BKwoW/Zs4AzLFI
         9Xf9984f1spLoDNpA58Tyq2way2UgY3qnEpdu/iEMUfScgv4Fkp0ZOmt31j0hCFReGdD
         9I1Q==
X-Gm-Message-State: AOAM533zT78o1cizRIR21XXygLhGf8m6HpBB53sfiT3ZULm+SnjASOE1
        DvvckgLhyuK6RUcibSvUNcPHGiYXIBR9Pw==
X-Google-Smtp-Source: ABdhPJwEZrYpE8+mMtD6TpNi718O6MfSbWnHwoZng4puNNinZR7ThXryqFeXkAxz+9tVxIOZjjamQw==
X-Received: by 2002:a2e:8ed2:: with SMTP id e18mr1064236ljl.87.1612940474965;
        Tue, 09 Feb 2021 23:01:14 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id y10sm159678lfy.57.2021.02.09.23.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 23:01:14 -0800 (PST)
Message-ID: <bd59188a1aa360385edf33bf14de5e82ad60a766.camel@fi.rohmeurope.com>
Subject: Re: [PATCH v7 3/6] mfd: bd9576: Add IRQ support
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, linux-power@fi.rohmeurope.com,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20210209152538.GB220368@dell>
References: <cover.1611324968.git.matti.vaittinen@fi.rohmeurope.com>
         <8489e5d34a6ae26309772f7cbffaa340fbb6c34e.1611324968.git.matti.vaittinen@fi.rohmeurope.com>
         <20210209152538.GB220368@dell>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Wed, 10 Feb 2021 09:01:08 +0200
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lee,

I appreciate your thorough reviews :) Thanks.

On Tue, 2021-02-09 at 15:25 +0000, Lee Jones wrote:
> On Fri, 22 Jan 2021, Matti Vaittinen wrote:
> 
> > BD9573 and BD9576 support set of "protection" interrupts for
> > "fatal"
> > issues. Those lead to SOC reset as PMIC shuts the power outputs.
> > Thus
> > there is no relevant IRQ handling for them.
> > 
> > Few "detection" interrupts were added to the BD9576 with the idea
> > that
> > SOC could take some recovery-action before error gets
> > unrecoverable.
> > 
> > Unfortunately the BD9576 interrupt logic was not re-evaluated. IRQs
> > are not designed to be properly acknowleged - and IRQ line is kept
> > active for whole duration of error condition (in comparison to
> > informing only about state change).
> > 
> > For above reason, do not consider missing IRQ as error.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> >  	case ROHM_CHIP_TYPE_BD9573:
> >  		mfd = bd9573_mfd_cells;
> >  		cells = ARRAY_SIZE(bd9573_mfd_cells);
> > +		/* BD9573 only supports fatal IRQs which we do not
> > handle */
> 
> Why not?

Because 'fatal' in the context of this comment means that when this
condition occurs the PMIC will do emergency shut down for power outputs
- which means the processor will not be able to handle the IRQ as it
loses the power. Maybe I'd better clarify the meaning of 'fatal' here.
+	/*
> > +	 * BD9576 behaves badly. It kepts IRQ asserted for the whole
> 
> This is solution is less than pretty.

Um, sorry, What are you referring to?

> > +	 * duration of detected HW condition (like over temp). This
> > does
> 
> "over-temperature"

Right. Thanks :)

> > +	 * not play nicely under any condition but we can work around
> > it
> > +	 * except when we have shared IRQs. So we don't require IRQ to
> > be
> > +	 * populated to help those poor sods who did connect IRQ to
> > shared pin.
> 
> No swearing in comments please.

Ok. This is actually a good reminder for me that I can't know how
something sounds like for a reader. (That phrase sounds quite innocent
to me but I've no idea how 'severe' swearing that is for the rest of
the world). I'll clean this up.

> How do you know if an IRQ is shared?

I don't. This is something that board designer does know. And my
thinking here was to allow board designer to omit the IRQ information
from DT if he prefers to not use these IRQs. I just tried to explain
that the driver does not _require_ IRQ information to be populated.

> 
> > +	 * If IRQ information is not given, then we mask all IRQs and
> > do not
> > +	 * provide IRQ resources to regulator driver - which then just
> > omits
> > +	 * the notifiers.
> > +	 */
> 
> This situation doesn't sound totally crazy.  Is there no way to
> handle
> 'persistent IRQ' conditions in the kernel?

Actually there is. Even for shared IRQs in this case. I made a mistake
at the beginning when I noticed that not all of these IRQs have mask
bits in the sub-IRQ registers. So I thought that for these IRQs the
device can't be told to revert IRQ back to normal. That would have
meaned that only way to prevent IRQ storm was to disable IRQs from the
processor end. But I was mistaken. All of the IRQs can be masked from
the 'main IRQ' level register. So we can mask the whole set of IRQs
form BD9576 when IRQ triggers - and then we can get the BD9576 to
restore the IRQ line.

So yes - we can make this to somehow work. And more importantly, we
don't completely spoil the shared IRQs. Still, the IRQ handling for
BD9576 is ... how to put it ... hacky. And I think few of the setups
might not actually have use for the notifications - so making IRQs
optional just sounded like the best course of action (to me). 
+	} else {
> > +		ret = regmap_update_bits(regmap,
> > BD957X_REG_INT_MAIN_MASK,
> > +					 BD957X_MASK_INT_ALL,
> > +					 BD957X_MASK_INT_ALL);
> 
> What's the default state of the interrupts?  Unmasked?

I've learned that I'd rather not assume the default state with ROHM
ICs. I've seen all kinds of defaults changing between IC revisions. And
occasionally I've seen same IC versions having different set of
defaults depending on the OTP version. I guess this comes from
traditional operation model where ICs have been tailored to meet needs
of the different customers.
 
> > diff --git a/include/linux/mfd/rohm-bd957x.h
> > b/include/linux/mfd/rohm-bd957x.h
> > index 3e7ca6fe5d4f..4fa632d8467a 100644
> > --- a/include/linux/mfd/rohm-bd957x.h
> > +++ b/include/linux/mfd/rohm-bd957x.h
> > @@ -13,47 +13,109 @@ enum {
> >  	BD957X_VOUTS1,
> >  };
> >  
> > +/* The BD9576 has own IRQ 'blocks' for:
> 
> Comments start on line 2.

Do you mean I should move this comment block top of the file? The idea
of this comment is to clarify the IRQs in the hardware. Hence I placed
it in the section where IRQ definitions dwell.

> > + * I2C/THERMAL,
> 
> Does this precede each line?

You mean the I2C/THERMAL? No. The first IRQ block is combined set of
I2C/thermal IRQs. Caps are misleading, right?

> + *    temperature. Best mitigation for high temperature for sure
> > is to
> > + *    keep the processor in IRQ loop, right? (NO!)
> 
> No sarcasm in comments please it can be easily lost in translation.
> 
> Please stay helpful and keep to the facts.

Right. I'll clean this up.

> 
> >  #define BD957X_REG_SMRB_ASSERT		0x15
> >  #define BD957X_REG_PMIC_INTERNAL_STAT	0x20
> >  #define BD957X_REG_INT_THERM_STAT	0x23
> > -#define BD957X_REG_INT_THERM_MASK 0x24
> > -#define BD957X_REG_INT_OVP_STAT 0x25
> > -#define BD957X_REG_INT_SCP_STAT 0x26
> > -#define BD957X_REG_INT_OCP_STAT 0x27

//snip

> > +
> > +#define BD957X_REGULATOR_EN_MASK	0xff
> > +#define BD957X_REGULATOR_DIS_VAL	0xff
> > +
> > +#define BD957X_VSEL_REG_MASK		0xff
> > +
> > +#define BD957X_MASK_VOUT1_TUNE		0x87
> > +#define BD957X_MASK_VOUT2_TUNE		0x87
> > +#define BD957X_MASK_VOUT3_TUNE		0x1f
> > +#define BD957X_MASK_VOUT4_TUNE		0x1f
> > +#define BD957X_MASK_VOUTL1_TUNE		0x87
> > +
> > +#define BD957X_REG_VOUT1_TUNE		0x50
> > +#define BD957X_REG_VOUT2_TUNE		0x53
> > +#define BD957X_REG_VOUT3_TUNE		0x56
> > +#define BD957X_REG_VOUT4_TUNE		0x59
> > +#define BD957X_REG_VOUTL1_TUNE		0x5c
> > +
> > +#define BD957X_MAX_REGISTER		0x61
> 
> Line all these up please.

By 'line up' you mean I should remove the empty lines, right?

Best Regards
	Matti Vaittinen



