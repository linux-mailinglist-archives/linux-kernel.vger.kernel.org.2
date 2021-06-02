Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50303398EE6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhFBPok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:44:40 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:14757 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhFBPoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:44:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622648568; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nHPhEbhw3GtWZh395foZPkBGtmGcLKIFZh8XNK3thfk9ds732t8lzzg9mgKToEmUTi
    yKFSiXAdBVw5FfUmB/LBtdszrrTasZkvwf4swK42QlRgX/lX8or0l4OPj2y4TU8ay0x8
    cxz9shahoG988nSzPhglK3TFHKjVS8MctfbswZRhKGobvCi5R8zll4lks0SlkUgVNsKF
    SlojVIYSJL+ufmtnMdUsBZq1+V7EgG2FgUBawjekko8x66FwuAPv2xGBzetNctRki4zb
    8hE7vOUH3TZ6KVEFEmQcf051t/Vh5DFg97ETgA/nR6hXg+2o19fgvRfxOHjz9osFIONO
    Xupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622648568;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=5p/0Zp4I29UELEPG0LINP5Cg95GbvMFVWa4EZnENcbk=;
    b=OSaDGeOpxm4+IVfPsPja38ZW6krI8620m75UuQg7fRX34oi670Hyz/CoZ/xAR0EL0L
    l3nPxA+OaZ9XZjYASOmSw7IVdAhD72MPi1h0Z5WAihpCwJ+lWgvs72gHjY/HAmEnmKCY
    qN5AZUlz9RLZOWgEhqgp+bbpqvDtXq1DK5RPO13dZSKzGsvY/WtI6rMOgh/Rz96CmhvD
    35RjoguD8bRg5yF7Fx8zAphux0hyH8NLQu0i/yp9mUY2LTnhO9IdFwmxLJBIV1qQYAAq
    BORiBSsWwgj14sUOMUXb+PjXPHZBTKoM2zKlvDb0MkBCiLg9syNDNpv/vtsZIST4lv7D
    h4qg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622648568;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=5p/0Zp4I29UELEPG0LINP5Cg95GbvMFVWa4EZnENcbk=;
    b=SIB27v/OV0Kq/sdIFTva3iL87Wh/Dp0DFIXiMg1OYCre+Lq7cIGFRcM/Fp9glWIjdq
    wT09wVpVdf9eOpHleOUjLJe5PrHmSAscFcSjdRi5RZ2OijJt4ZekuLi/Ea7VB7nZZwrf
    cRnorvvVyQ+FtLnW+j7BvR+Tf+XJVowiwxhLHYDm8Z5c7cwWXsXVmRyvyRR6ek3pYl06
    BsEiEll6Y6nVqHTxONW22wPT1UJ5Fi/XrYY2gLwrd5PCJ3z4sXV6DhcBxt50w6ugueqA
    KKzvyj8VfJKXslsyz2/ojk0SONyCaN56kJPCablRDFzquIIzHZ365AZLOW0nZEww98BN
    DR3Q==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j6IcjHBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x52Fgl3XW
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 2 Jun 2021 17:42:47 +0200 (CEST)
Date:   Wed, 2 Jun 2021 17:42:46 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 2/3] extcon: sm5502: Refactor driver to use
 chip-specific struct
Message-ID: <YLem9vz2KnpDYS1K@gerhold.net>
References: <20210601200007.218802-1-stephan@gerhold.net>
 <20210601200007.218802-3-stephan@gerhold.net>
 <b3a9eed8-0d7c-e935-36d4-13918f5b7b21@gmail.com>
 <YLeh2Q1q3643iFkZ@gerhold.net>
 <83b00ca8-aa70-6c4b-5f9f-eebf571ee621@gmail.com>
 <a53f8fa3-60c3-2727-d309-f77f35cfd510@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a53f8fa3-60c3-2727-d309-f77f35cfd510@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 12:35:58AM +0900, Chanwoo Choi wrote:
> On 21. 6. 3. 오전 12:30, Chanwoo Choi wrote:
> > On 21. 6. 3. 오전 12:20, Stephan Gerhold wrote:
> > > On Thu, Jun 03, 2021 at 12:13:18AM +0900, Chanwoo Choi wrote:
> > > > On 21. 6. 2. 오전 5:00, Stephan Gerhold wrote:
> > > > > Prepare for supporting SM5504 in the extcon-sm5502 driver by replacing
> > > > > enum sm5504_types with a struct sm5504_type that stores the
> > > > > chip-specific
> > > > > definitions. This struct can then be defined separately for SM5504
> > > > > without having to add if (type == TYPE_SM5504) everywhere in the code.
> > > > > 
> > > > > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > > > > ---
> > > > > Changes in v3: New patch to simplify diff on next patch
> > > > > ---
> > > > >    drivers/extcon/extcon-sm5502.c | 64
> > > > > +++++++++++++++++++++-------------
> > > > >    drivers/extcon/extcon-sm5502.h |  4 ---
> > > > >    2 files changed, 40 insertions(+), 28 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/extcon/extcon-sm5502.c
> > > > > b/drivers/extcon/extcon-sm5502.c
> > > > > index 9f40bb9f1f81..951f6ca4c479 100644
> > > > > --- a/drivers/extcon/extcon-sm5502.c
> > > > > +++ b/drivers/extcon/extcon-sm5502.c
> > > > > @@ -40,17 +40,13 @@ struct sm5502_muic_info {
> > > > >        struct i2c_client *i2c;
> > > > >        struct regmap *regmap;
> > > > > +    const struct sm5502_type *type;
> > > > >        struct regmap_irq_chip_data *irq_data;
> > > > > -    struct muic_irq *muic_irqs;
> > > > > -    unsigned int num_muic_irqs;
> > > > >        int irq;
> > > > >        bool irq_attach;
> > > > >        bool irq_detach;
> > > > >        struct work_struct irq_work;
> > > > > -    struct reg_data *reg_data;
> > > > > -    unsigned int num_reg_data;
> > > > > -
> > > > >        struct mutex mutex;
> > > > >        /*
> > > > > @@ -62,6 +58,17 @@ struct sm5502_muic_info {
> > > > >        struct delayed_work wq_detcable;
> > > > >    };
> > > > > +struct sm5502_type {
> > > > > +    struct muic_irq *muic_irqs;
> > > > > +    unsigned int num_muic_irqs;
> > > > > +    const struct regmap_irq_chip *irq_chip;
> > > > > +
> > > > > +    struct reg_data *reg_data;
> > > > > +    unsigned int num_reg_data;
> > > > > +
> > > > > +    int (*parse_irq)(struct sm5502_muic_info *info, int irq_type);
> > > > > +};
> > > > > +
> > > > >    /* Default value of SM5502 register to bring up MUIC device. */
> > > > >    static struct reg_data sm5502_reg_data[] = {
> > > > >        {
> > > > > @@ -502,11 +509,11 @@ static irqreturn_t
> > > > > sm5502_muic_irq_handler(int irq, void *data)
> > > > >        struct sm5502_muic_info *info = data;
> > > > >        int i, irq_type = -1, ret;
> > > > > -    for (i = 0; i < info->num_muic_irqs; i++)
> > > > > -        if (irq == info->muic_irqs[i].virq)
> > > > > -            irq_type = info->muic_irqs[i].irq;
> > > > > +    for (i = 0; i < info->type->num_muic_irqs; i++)
> > > > > +        if (irq == info->type->muic_irqs[i].virq)
> > > > > +            irq_type = info->type->muic_irqs[i].irq;
> > > > > -    ret = sm5502_parse_irq(info, irq_type);
> > > > > +    ret = info->type->parse_irq(info, irq_type);
> > > > 
> > > > Looks good to me. But there is only one comment.
> > > > Need to check the 'parse_irq' as following:
> > > > 
> > > > If you agree this suggestion, I'll apply with following changes
> > > > by myself:
> > > > 
> > > >     if (!info->type->parse_irq) {
> > > >         dev_err(info->dev, "failed to handle irq due to parse_irq\n",
> > > >         return IRQ_NONE;
> > > >     }
> > > > 
> > > > 
> > > 
> > > This condition should be impossible, since .parse_irq is set for both
> > > SM5502 and SM5504:
> > > 
> > > static const struct sm5502_type sm5502_data = {
> > >     /* ... */
> > >     .parse_irq = sm5502_parse_irq,
> > > };
> > > 
> > > static const struct sm5502_type sm5504_data = {
> > >     /* ... */
> > >     .parse_irq = sm5504_parse_irq,
> > > };
> > > 
> > > Which failure case are you trying to handle with that if statement?
> > 
> > There is not failure case of this patchset. But, this refactoring
> > suggestion has the potential problem without checking whether mandatory
> > function pointer is NULL or not. When adding new chip by using this
> > driver, the author might have the human error without parse_irq
> > initialization even if the mandatory.
> > 
> 
> Instead, it is better to check whether parser_irq is NULL or not
> on probe function in order to reduce the unnecessary repetitive checking.
> 

Thanks for the explanation. This suggestion sounds better to me.
(Although I consider it unlikely that someone would forget to define
 .parse_irq when adding a new chip...)

Feel free to add something like the below when applying.
Or let me know if I should re-send with this change:

diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index af44c1e2f368..93da2d8379b1 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -694,6 +694,10 @@ static int sm5022_muic_i2c_probe(struct i2c_client *i2c)
 	info->type = device_get_match_data(info->dev);
 	if (!info->type)
 		return -EINVAL;
+	if (!info->type->parse_irq) {
+		dev_err(info->dev, "parse_irq missing in struct sm5502_type\n");
+		return -EINVAL;
+	}
 
 	mutex_init(&info->mutex);
 

Thanks for your review!
Stephan
