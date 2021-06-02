Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA1C398E75
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhFBPW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:22:57 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:24248 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhFBPW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:22:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622647265; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FcsDN7GmZwwYCQCaL609+lS+YWE1rX1tMHH+yc9meC2GVwCt0MhzFLscvLbbajY6ji
    5gbVhIrkGtDYQkaWUzErOmwfawIrk9rSQQJOLeL/kcdFXezLCss3gIdU2YhzvUEba0Fg
    tB4kEKbS2iyKKstvNm7uQTBN8izIlyAR7y9spPFEdIYmWf9HMrGN+TuPo/35lXlcmjae
    7a0Ato65rNKcqTmb2Uou6+0InlVcoYtxqs+BD5nDB0uajkNV7HN1ysVPQD0ICl9j93Ii
    gp0IMI0/C3sRXv3JcPLxWqY/0svyxSjHzpsKAQJolAvHW/6236GMb6SZ2uv03SxvY5OC
    Y19w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622647265;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=H1gWGyE6aKr6MZYG5AS5yi8wLNX85LARR9MiEBFffXk=;
    b=BYgfMxlOpoeh/lbVLHFG0u9lbxPn3H+tupF5w/+dG+gRN/ksXSficF9EDyakqr7iI8
    obd/dK5fzMKW8V0KaSNrUS/o7p3qOl/oTmytPaRbwVyiINuHjfJCcY1l6tr2wj/BBmWx
    trq6GMnd7Zq4+tnB1iawHI7ZnrxymRmxtWj8hp2CE6gU7OdpnioXLWAZ4RjOio9mIMjD
    WbIXrFWyDIoTO7cA2szcDbvP3CHyjkQaSWJiTrFcK7y8rIzmjWdUJIQy58QReYrleYcr
    W6MaVluGIlc+d1QEYmSx1x4hHZ/0AEh3pJYRihkneJvu5F5WJZEngYBH6VxBxUkEXCua
    yzwA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622647265;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=H1gWGyE6aKr6MZYG5AS5yi8wLNX85LARR9MiEBFffXk=;
    b=DKk1X0r7oBmqWVVFasJNT6UU3Ad6XU5qBH6sse91drViVF1BiHE8VlhshIULDTQS/g
    mrFfEcz/wOSXCAgNYoq4Rp6+tlApzSPK3FEajmc5ah1s6UL5Slws+b8pLb5eMFEriipa
    jHresoQJC2GQo9l/MIS+5++SSUH7RcNnjAolENYG0/oWJfF0rA1Il1+V9rSI2acGijoZ
    sgc1eB/0yGQbi4xHPOu6hChQifCXzApYUaJQaSHtj3vjGLNBqb69YEolxhGTfzeN031p
    dnYUKzI5HXIKbaL8jUlbBP3oyBxZNlCkv2aUVSjWyS6z1BCHFRZjkG1HiPIZxtOyeAM6
    eObA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j6IcjHBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x52FL43Td
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 2 Jun 2021 17:21:04 +0200 (CEST)
Date:   Wed, 2 Jun 2021 17:20:57 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 2/3] extcon: sm5502: Refactor driver to use
 chip-specific struct
Message-ID: <YLeh2Q1q3643iFkZ@gerhold.net>
References: <20210601200007.218802-1-stephan@gerhold.net>
 <20210601200007.218802-3-stephan@gerhold.net>
 <b3a9eed8-0d7c-e935-36d4-13918f5b7b21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3a9eed8-0d7c-e935-36d4-13918f5b7b21@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 12:13:18AM +0900, Chanwoo Choi wrote:
> On 21. 6. 2. 오전 5:00, Stephan Gerhold wrote:
> > Prepare for supporting SM5504 in the extcon-sm5502 driver by replacing
> > enum sm5504_types with a struct sm5504_type that stores the chip-specific
> > definitions. This struct can then be defined separately for SM5504
> > without having to add if (type == TYPE_SM5504) everywhere in the code.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> > Changes in v3: New patch to simplify diff on next patch
> > ---
> >   drivers/extcon/extcon-sm5502.c | 64 +++++++++++++++++++++-------------
> >   drivers/extcon/extcon-sm5502.h |  4 ---
> >   2 files changed, 40 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
> > index 9f40bb9f1f81..951f6ca4c479 100644
> > --- a/drivers/extcon/extcon-sm5502.c
> > +++ b/drivers/extcon/extcon-sm5502.c
> > @@ -40,17 +40,13 @@ struct sm5502_muic_info {
> >   	struct i2c_client *i2c;
> >   	struct regmap *regmap;
> > +	const struct sm5502_type *type;
> >   	struct regmap_irq_chip_data *irq_data;
> > -	struct muic_irq *muic_irqs;
> > -	unsigned int num_muic_irqs;
> >   	int irq;
> >   	bool irq_attach;
> >   	bool irq_detach;
> >   	struct work_struct irq_work;
> > -	struct reg_data *reg_data;
> > -	unsigned int num_reg_data;
> > -
> >   	struct mutex mutex;
> >   	/*
> > @@ -62,6 +58,17 @@ struct sm5502_muic_info {
> >   	struct delayed_work wq_detcable;
> >   };
> > +struct sm5502_type {
> > +	struct muic_irq *muic_irqs;
> > +	unsigned int num_muic_irqs;
> > +	const struct regmap_irq_chip *irq_chip;
> > +
> > +	struct reg_data *reg_data;
> > +	unsigned int num_reg_data;
> > +
> > +	int (*parse_irq)(struct sm5502_muic_info *info, int irq_type);
> > +};
> > +
> >   /* Default value of SM5502 register to bring up MUIC device. */
> >   static struct reg_data sm5502_reg_data[] = {
> >   	{
> > @@ -502,11 +509,11 @@ static irqreturn_t sm5502_muic_irq_handler(int irq, void *data)
> >   	struct sm5502_muic_info *info = data;
> >   	int i, irq_type = -1, ret;
> > -	for (i = 0; i < info->num_muic_irqs; i++)
> > -		if (irq == info->muic_irqs[i].virq)
> > -			irq_type = info->muic_irqs[i].irq;
> > +	for (i = 0; i < info->type->num_muic_irqs; i++)
> > +		if (irq == info->type->muic_irqs[i].virq)
> > +			irq_type = info->type->muic_irqs[i].irq;
> > -	ret = sm5502_parse_irq(info, irq_type);
> > +	ret = info->type->parse_irq(info, irq_type);
> 
> Looks good to me. But there is only one comment.
> Need to check the 'parse_irq' as following:
> 
> If you agree this suggestion, I'll apply with following changes by myself:
> 
> 	if (!info->type->parse_irq) {
> 		dev_err(info->dev, "failed to handle irq due to parse_irq\n",
> 		return IRQ_NONE;
> 	}
> 
> 

This condition should be impossible, since .parse_irq is set for both
SM5502 and SM5504:

static const struct sm5502_type sm5502_data = {
	/* ... */
	.parse_irq = sm5502_parse_irq,
};

static const struct sm5502_type sm5504_data = {
	/* ... */
	.parse_irq = sm5504_parse_irq,
};

Which failure case are you trying to handle with that if statement?

Thanks!
Stephan
