Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CC03D3407
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 07:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhGWEpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 00:45:16 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:48734 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhGWEpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 00:45:12 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210723052545epoutp017596e90d525ce20c2c6a19944c6d9ad8~UVDNrCQ7m0645206452epoutp01F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 05:25:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210723052545epoutp017596e90d525ce20c2c6a19944c6d9ad8~UVDNrCQ7m0645206452epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1627017945;
        bh=PJtf0RMk0PIkn0sdK/CRl6CBJbquHvKrWdxRhl2yIbY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=IY8hEph8RKzU3Go8JROK0NKS4YYHF6pkO3OlJSTjsnaxLbMJaeiTjvnYx5sRAWIs9
         3l+nr98JuENSdlCE1i7PLFY9Z3sAMNJipMWopSXjDoo06TvtxwfhKrHjp8d42Z36HG
         KcqQhlCxsMajRuqWXFtWwv0/NTYGZL2qoJ77Tm9g=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210723052543epcas1p4c84a47201338e6d5b31d615bd9867140~UVDMRxpPp0243202432epcas1p4j;
        Fri, 23 Jul 2021 05:25:43 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4GWHpW1Wtkz4x9QK; Fri, 23 Jul
        2021 05:25:39 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.5F.13454.3D25AF06; Fri, 23 Jul 2021 14:25:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210723052538epcas1p2d21933167581ee2b35f4d5b5d9140ead~UVDHG3qyk2586625866epcas1p2J;
        Fri, 23 Jul 2021 05:25:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210723052538epsmtrp163305215f5530febbf2b556981fc20b5~UVDHGE38E1396413964epsmtrp1b;
        Fri, 23 Jul 2021 05:25:38 +0000 (GMT)
X-AuditID: b6c32a39-16fff7000002348e-1e-60fa52d33be9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.FE.08289.1D25AF06; Fri, 23 Jul 2021 14:25:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210723052537epsmtip1df25f6b9198853b8b4db1ecc1340ba23~UVDG4egWr0295302953epsmtip1h;
        Fri, 23 Jul 2021 05:25:37 +0000 (GMT)
Subject: Re: [PATCH 1/2] extcon: usbc-tusb320: Add support for TUSB320L
To:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Michael Auchter <michael.auchter@ni.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <eba0ddbe-7644-1c3f-baaf-6562bdba3b96@samsung.com>
Date:   Fri, 23 Jul 2021 14:45:27 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <Tpxz1duGadcCGUuPx9JHqz3HwOY5B3viYWEP3jC1Kk@cp4-web-030.plabs.ch>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmge7loF8JBuvWcFrMP3KO1eLyrjls
        Fs+e/2S1uN24gs2ide8Rdour6yayO7B5bFrVyeZx/cx2Jo+etk1MHn1bVjF6fN4kF8AalW2T
        kZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SBkkJZYk4p
        UCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAskCvODG3uDQvXS85P9fK0MDAyBSoMCE7Y9WZ
        N8wF11wrHm3fzdLA+Mu8i5GTQ0LARKJ5yQGWLkYuDiGBHYwSm6b/h3I+MUrM+neLDcL5zCgx
        f/UDVpiW/W+3MkEkdjFK3G27AFX1Hqj/zBU2kCphAXeJjYf+gnWICERJ3LmzE6yDWaCbUWJj
        11wmkASbgJbE/hc3wBr4BRQlrv54zAhi8wrYSZx/fIwFxGYRUJW4/P0DM4gtKhAmcXJbC1SN
        oMTJmU/AajgF/CSOHNwHtoxZQFzi1pP5TBC2vMT2t3OYQRZLCMzkkOh5s5cN4gcXibXzFkD9
        Iyzx6vgWdghbSuJlfxuUXS2x8uQRNojmDkaJLfsvQDUYS+xfOhloAwfQBk2J9bv0IcKKEjt/
        z2WEWMwn8e5rDytIiYQAr0RHmxBEibLE5Qd3mSBsSYnF7Z1sExiVZiF5ZxaSF2YheWEWwrIF
        jCyrGMVSC4pz01OLDQtMkeN7EyM4fWpZ7mCc/vaD3iFGJg7GQ4wSHMxKIrxHAn8lCPGmJFZW
        pRblxxeV5qQWH2I0BQbwRGYp0eR8YALPK4k3NDUyNja2MDE0MzU0VBLn/Rb7NUFIID2xJDU7
        NbUgtQimj4mDU6qBKVpXuf6348Tgt4IF7h2MgR6qXrx/6xOrRD7d/Z5z5NfarjutfZ4nPA32
        dP55VPdoKne4w1WeLWsW7GVzu7xp+vSJG2W8mkqjDx5raj2y5GF5qubitwFHjx5Jq5vlNH0F
        z+dgy5WX5lyeFfnrgrcwS5qkfs6h5Mk8/z+/smtZvL9erKrkrf6vhL9qlmIyLW1Xeh2XruOe
        XJeza8I9r/2L/lY8eMyUtoxplth2i6e+NXcjRGR3+e87ZPLhlkFoyuvVkmtPicysaZR/MstG
        Pe7JvruuLuLVMxfFHzr812qzQFGbz/4lSznWGGe020xwF10jG88tvfL8sQuS0+q95gYd7jQ5
        pnI1wkezYO3rqiuPlimxFGckGmoxFxUnAgByzovDKAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSnO6loF8JBoveMVrMP3KO1eLyrjls
        Fs+e/2S1uN24gs2ide8Rdour6yayO7B5bFrVyeZx/cx2Jo+etk1MHn1bVjF6fN4kF8AaxWWT
        kpqTWZZapG+XwJWx6swb5oJrrhWPtu9maWD8Zd7FyMkhIWAisf/tVqYuRi4OIYEdjBKT105l
        gkhISky7eJS5i5EDyBaWOHy4GKLmLaPEk8fHmEFqhAXcJTYe+ssKUiMiECVxa24sSA2zQDej
        xO85a1khGhYySkz/dIgFpIFNQEti/4sbbCA2v4CixNUfjxlBbF4BO4nzj4+B1bAIqEpc/v4B
        bIGoQJjEziWPmSBqBCVOznwCVsMp4Cdx5OA+VhCbWUBd4s+8S8wQtrjErSfzmSBseYntb+cw
        T2AUnoWkfRaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4irS0
        djDuWfVB7xAjEwfjIUYJDmYlEd4jgb8ShHhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQ
        nliSmp2aWpBaBJNl4uCUamDqUIyIkjsRvHlKycdlX0JcI/Suhb7q7nFrCrtvImTqcNv7pWf7
        +oDYyRyBii4v2RfNaWf/w+u3MIHdZuHz7WnaLnwslR5vDspfmCbs+uincZ6RrbXL4h07IzP9
        3OUM+yuvr/1XsmWWYYSHopjAjhVypz+/kL4UH/Y1f1v1hV3Xr9xWfrImb9kMyXvq/Cl5Oo31
        GxwSWELVMlq5Jiv2PGkP3XFScZ58rcvisxdDH/lt26xSoM1uVqKzMtpkd/q1edmCR/otbkY/
        f7jQtP9Ch8evVRHB3CXtaxu1TJY8WfW4W0/6qvKqR85rbjC2uTov/ly+7kXTpJ51H36VWNQd
        XlclzfXm/tb37u3x99reuyuxFGckGmoxFxUnAgC1/tItEQMAAA==
X-CMS-MailID: 20210723052538epcas1p2d21933167581ee2b35f4d5b5d9140ead
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210714174345epcas1p2d5516c1f648a0272b9aa85b3cb4fdefc
References: <CGME20210714174345epcas1p2d5516c1f648a0272b9aa85b3cb4fdefc@epcas1p2.samsung.com>
        <Tpxz1duGadcCGUuPx9JHqz3HwOY5B3viYWEP3jC1Kk@cp4-web-030.plabs.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yassine,

It seems that this patch has the two role.
Firstly, it has the some refactoring code and print the more information
Secondly, add support for TUSB320L new device.

So that you better need to make two patches separately in order to split out 
two roles.

On 7/15/21 2:43 AM, Yassine Oudjana wrote:
> TUSB320L is a newer chip with additional features. Add support for resetting
> and setting its and TUSB320's mode, and reset it during probe to make sure it starts in the
> default mode (maintain mode according to PORT pin selection).
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  drivers/extcon/extcon-usbc-tusb320.c | 172 ++++++++++++++++++++++++---
>  1 file changed, 156 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
> index 805af73b4152..a6741eff60cc 100644
> --- a/drivers/extcon/extcon-usbc-tusb320.c
> +++ b/drivers/extcon/extcon-usbc-tusb320.c
> @@ -13,21 +13,47 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> -
> + 
>  #define TUSB320_REG9				0x9
>  #define TUSB320_REG9_ATTACHED_STATE_SHIFT	6
>  #define TUSB320_REG9_ATTACHED_STATE_MASK	0x3
>  #define TUSB320_REG9_CABLE_DIRECTION		BIT(5)
>  #define TUSB320_REG9_INTERRUPT_STATUS		BIT(4)
> -#define TUSB320_ATTACHED_STATE_NONE		0x0
> -#define TUSB320_ATTACHED_STATE_DFP		0x1
> -#define TUSB320_ATTACHED_STATE_UFP		0x2
> -#define TUSB320_ATTACHED_STATE_ACC		0x3
> +
> +#define TUSB320_REGA				0xa
> +#define TUSB320L_REGA_DISABLE_TERM		BIT(0)
> +#define TUSB320_REGA_I2C_SOFT_RESET		BIT(3)
> +#define TUSB320_REGA_MODE_SELECT_SHIFT		4
> +#define TUSB320_REGA_MODE_SELECT_MASK		0x3
> +
> +#define TUSB320L_REGA0_REVISION			0xa0
> +
> +enum tusb320_attached_state {
> +	TUSB320_ATTACHED_STATE_NONE,
> +	TUSB320_ATTACHED_STATE_DFP,
> +	TUSB320_ATTACHED_STATE_UFP,
> +	TUSB320_ATTACHED_STATE_ACC,
> +};
> +
> +enum tusb320_mode {
> +	TUSB320_MODE_PORT,
> +	TUSB320_MODE_UFP,
> +	TUSB320_MODE_DFP,
> +	TUSB320_MODE_DRP,
> +};
> +
> +enum tusb320_type {
> +	TYPE_TUSB320,
> +	TYPE_TUSB320L,
> +};
>  
>  struct tusb320_priv {
>  	struct device *dev;
>  	struct regmap *regmap;
> +	enum tusb320_type type;
>  	struct extcon_dev *edev;
> +
> +	enum tusb320_attached_state state;
>  };
>  
>  static const char * const tusb_attached_states[] = {
> @@ -37,6 +63,13 @@ static const char * const tusb_attached_states[] = {
>  	[TUSB320_ATTACHED_STATE_ACC]  = "accessory",
>  };
>  
> +static const char * const tusb_modes[] = {
> +	[TUSB320_MODE_PORT] = "maintain mode set by PORT pin",
> +	[TUSB320_MODE_UFP]  = "upstream facing port",
> +	[TUSB320_MODE_DFP]  = "downstream facing port",
> +	[TUSB320_MODE_DRP]  = "dual role port",
> +};
> +
>  static const unsigned int tusb320_extcon_cable[] = {
>  	EXTCON_USB,
>  	EXTCON_USB_HOST,
> @@ -62,26 +95,106 @@ static int tusb320_check_signature(struct tusb320_priv *priv)
>  	return 0;
>  }
>  
> +static int tusb320_set_mode(struct tusb320_priv *priv, enum tusb320_mode mode)
> +{
> +	int ret;
> +
> +	if(priv->type == TYPE_TUSB320)
> +		goto write_mode;
> +
> +	/* Disable CC state machine */
> +	ret = regmap_write_bits(priv->regmap, TUSB320_REGA,
> +		TUSB320L_REGA_DISABLE_TERM, 1);
> +	if(ret) {
> +		dev_err(priv->dev,
> +			"failed to disable CC state machine: %d\n", ret);
> +		return ret;
> +	}
> +
> +write_mode:
> +	/* Mode cannot be changed on TUSB320 while cable is attached */
> +	if(priv->type == TYPE_TUSB320 && priv->state != TUSB320_ATTACHED_STATE_NONE)
> +		return -EBUSY;
> +
> +	/* Write mode */
> +	ret = regmap_write_bits(priv->regmap, TUSB320_REGA,
> +		TUSB320_REGA_MODE_SELECT_MASK << TUSB320_REGA_MODE_SELECT_SHIFT,
> +		mode << TUSB320_REGA_MODE_SELECT_SHIFT);
> +	if(ret) {
> +		dev_err(priv->dev, "failed to write mode: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if(priv->type == TYPE_TUSB320)
> +		return 0;
> +
> +	msleep(5);
> +
> +	/* Re-enable CC state machine */
> +	ret = regmap_write_bits(priv->regmap, TUSB320_REGA,
> +		TUSB320L_REGA_DISABLE_TERM, 0);
> +	if(ret) {
> +		dev_err(priv->dev,
> +			"failed to re-enable CC state machine: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tusb320_reset(struct tusb320_priv *priv)
> +{
> +	int ret;
> +
> +	/* Set mode to default (follow PORT pin) */
> +	ret = tusb320_set_mode(priv, TUSB320_MODE_PORT);
> +	if(ret && ret != -EBUSY) {
> +		dev_err(priv->dev,
> +			"failed to set mode to PORT: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Perform soft reset */
> +	ret = regmap_write_bits(priv->regmap, TUSB320_REGA,
> +			TUSB320_REGA_I2C_SOFT_RESET, 1);
> +	if(ret) {
> +		dev_err(priv->dev,
> +			"failed to write soft reset bit: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
>  {
>  	struct tusb320_priv *priv = dev_id;
> -	int state, polarity;
> -	unsigned reg;
> +	int state, polarity, mode;
> +	unsigned reg9, rega;
>  
> -	if (regmap_read(priv->regmap, TUSB320_REG9, &reg)) {
> -		dev_err(priv->dev, "error during i2c read!\n");
> +	if (regmap_read(priv->regmap, TUSB320_REG9, &reg9)) {
> +		dev_err(priv->dev, "error during register 0x9 i2c read!\n");
>  		return IRQ_NONE;
>  	}
>  
> -	if (!(reg & TUSB320_REG9_INTERRUPT_STATUS))
> +	if (regmap_read(priv->regmap, TUSB320_REGA, &rega)) {
> +		dev_err(priv->dev, "error during register 0xa i2c read!\n");
>  		return IRQ_NONE;
> +	}
>  
> -	state = (reg >> TUSB320_REG9_ATTACHED_STATE_SHIFT) &
> +	if (!(reg9 & TUSB320_REG9_INTERRUPT_STATUS))
> +		return IRQ_NONE;
> +
> +	state = (reg9 >> TUSB320_REG9_ATTACHED_STATE_SHIFT) &
>  		TUSB320_REG9_ATTACHED_STATE_MASK;
> -	polarity = !!(reg & TUSB320_REG9_CABLE_DIRECTION);
> +	polarity = !!(reg9 & TUSB320_REG9_CABLE_DIRECTION);
> +
> +	mode = (rega >> TUSB320_REGA_MODE_SELECT_SHIFT) &
> +		TUSB320_REGA_MODE_SELECT_MASK;
>  
> -	dev_dbg(priv->dev, "attached state: %s, polarity: %d\n",
> -		tusb_attached_states[state], polarity);
> +	dev_dbg(priv->dev, "mode: %s, attached state: %s, polarity: %d\n",
> +		tusb_modes[mode], tusb_attached_states[state], polarity);
>  
>  	extcon_set_state(priv->edev, EXTCON_USB,
>  			 state == TUSB320_ATTACHED_STATE_UFP);
> @@ -96,7 +209,10 @@ static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
>  	extcon_sync(priv->edev, EXTCON_USB);
>  	extcon_sync(priv->edev, EXTCON_USB_HOST);
>  
> -	regmap_write(priv->regmap, TUSB320_REG9, reg);
> +	priv->state = state;
> +
> +	regmap_write(priv->regmap, TUSB320_REG9, reg9);
> +	regmap_write(priv->regmap, TUSB320_REGA, rega);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -110,6 +226,8 @@ static int tusb320_extcon_probe(struct i2c_client *client,
>  				const struct i2c_device_id *id)
>  {
>  	struct tusb320_priv *priv;
> +	const void *match_data;
> +	unsigned int revision;
>  	int ret;
>  
>  	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
> @@ -125,6 +243,22 @@ static int tusb320_extcon_probe(struct i2c_client *client,
>  	if (ret)
>  		return ret;
>  
> +	match_data = device_get_match_data(&client->dev);
> +	if (!match_data)
> +		return -EINVAL;
> +
> +	priv->type = (enum tusb320_type)match_data;
> +
> +	if(priv->type == TYPE_TUSB320L) {
> +		ret = regmap_read(priv->regmap, TUSB320L_REGA0_REVISION, &revision);
> +
> +		if(ret < 0)
> +			dev_warn(priv->dev,
> +				"failed to read revision register: %d\n", ret);
> +		else
> +			dev_info(priv->dev, "chip revision %d\n", revision);
> +	}
> +
>  	priv->edev = devm_extcon_dev_allocate(priv->dev, tusb320_extcon_cable);
>  	if (IS_ERR(priv->edev)) {
>  		dev_err(priv->dev, "failed to allocate extcon device\n");
> @@ -137,6 +271,11 @@ static int tusb320_extcon_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> +	/* Reset chip to its default state */
> +	ret = tusb320_reset(priv);
> +	if(ret)
> +		dev_warn(priv->dev, "failed to reset chip: %d\n", ret);
> +

If you want to reset the h/w device, need to be reset before registering extcon device.
Please move it before 

>  	extcon_set_property_capability(priv->edev, EXTCON_USB,
>  				       EXTCON_PROP_USB_TYPEC_POLARITY);
>  	extcon_set_property_capability(priv->edev, EXTCON_USB_HOST,
> @@ -154,7 +293,8 @@ static int tusb320_extcon_probe(struct i2c_client *client,
>  }
>  
>  static const struct of_device_id tusb320_extcon_dt_match[] = {
> -	{ .compatible = "ti,tusb320", },
> +	{ .compatible = "ti,tusb320", .data = (void *)TYPE_TUSB320, },
> +	{ .compatible = "ti,tusb320l", .data = (void *)TYPE_TUSB320L, },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, tusb320_extcon_dt_match);
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
