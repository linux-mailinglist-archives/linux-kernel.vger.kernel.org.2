Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D43D3C89B9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239641AbhGNR2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhGNR2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:28:20 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26783C061762
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 10:25:29 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so3355769otl.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 10:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4Kumx3nS5y9nz9rWe/sEdbMMcdp5ffd/gZuxBQbNya4=;
        b=IYaHXcWbRW58qcNEf1nShgqUxB13n2Xl2hBMhmSAeknojrMiTnIh/2w4JC4WBEpmz3
         SjsdAEJcE6QHDole4Fe40mfdpoQe7eTNuRHMvrbu5DY4npCrSRtmnEGzwk0kXkCXLwqj
         VqEYbOkVuh5L0askie7wCgU6nQz3cBemjnAAOgjOejBCCFamATFLSzf7i4AQl7DnQJVP
         BngZkmi/1fck4UB01js5oqRrhRLFw7+YHWPRWaRMAjehCeUjQmVelorxsV8o3FEoUtvz
         8UostLjfjTNF/+gHVkAP/xzWPeAScK9lPVT1L4pZ/ebzY1x+KYYtJp71a8k1+K+l680o
         9wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Kumx3nS5y9nz9rWe/sEdbMMcdp5ffd/gZuxBQbNya4=;
        b=OX7+ZXzlX7DkYFX5qn02v9LtupWSpTE7QIvreQNlvIxq/m6bEtYgG1yqPWvJd2IXBW
         Nq1qTnfAN71+LCM2Cxf0FAFv+kXSwWovbyjXlLMN/ftXt4AdSbOo2iKdd8FzpKtfrhHh
         v+qQEQl26SrIIIVYczZh0jabzrdjf5Xyhw8K9vPBdadvQvWqFpE/daVWBor9OgZRTCFy
         OF5eKkFUVFGXSLw7FSLpYcEme6YIKUIKfmF3jeesITF8Q1JQw4hV3tv6DZKsG5LJ39l8
         AOEo2KMATwnLvKdWTrzxvQu5On/T74hly1XHejBeUZjkQm3vUBEfwncJvoVCwm0oHQPO
         Xx7Q==
X-Gm-Message-State: AOAM530gWUhKkmV/jL0ilmLAtr/GZE6i4gQlalc9xmnjWjKv0GmYC5bi
        aR6IhEaldHP6XQIxc/DeZEvxUg==
X-Google-Smtp-Source: ABdhPJxJhQltkVBXqegdnO9IaV/+FtL3Hn5ISoeGdm1cXIRjDt1pi4WI2yOMSRkOnK2cup+024ClQg==
X-Received: by 2002:a9d:4916:: with SMTP id e22mr9268121otf.112.1626283528429;
        Wed, 14 Jul 2021 10:25:28 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p9sm553538otl.64.2021.07.14.10.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 10:25:27 -0700 (PDT)
Date:   Wed, 14 Jul 2021 12:25:25 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 4/7] Bluetooth: hci_qca: merge qca_power into
 qca_serdev
Message-ID: <YO8eBZfLd0vnTy/x@yoga>
References: <20210621223141.1638189-1-dmitry.baryshkov@linaro.org>
 <20210621223141.1638189-5-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621223141.1638189-5-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21 Jun 17:31 CDT 2021, Dmitry Baryshkov wrote:

> There is no need to allocate separate structure for handling regulators
> used by QCA chips, we gain nothing from it. Move all used data fields
> directly to struct qca_serdev.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/bluetooth/hci_qca.c | 58 ++++++++++++++-----------------------
>  1 file changed, 22 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 3704dbadba1d..9cc8a9153d76 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -208,20 +208,15 @@ struct qca_device_data {
>  /*
>   * Platform data for the QCA Bluetooth power driver.
>   */
> -struct qca_power {
> -	struct device *dev;
> -	struct regulator_bulk_data *vreg_bulk;
> -	int num_vregs;
> -	bool vregs_on;
> -};
> -
>  struct qca_serdev {
>  	struct hci_uart	 serdev_hu;
>  	struct gpio_desc *bt_en;
>  	struct gpio_desc *sw_ctrl;
>  	struct clk	 *susclk;
>  	enum qca_btsoc_type btsoc_type;
> -	struct qca_power *bt_power;
> +	struct regulator_bulk_data *vreg_bulk;
> +	int num_vregs;
> +	bool vregs_on;
>  	u32 init_speed;
>  	u32 oper_speed;
>  	const char *firmware_name;
> @@ -1602,7 +1597,7 @@ static int qca_regulator_init(struct hci_uart *hu)
>  	 * off the voltage regulator.
>  	 */
>  	qcadev = serdev_device_get_drvdata(hu->serdev);
> -	if (!qcadev->bt_power->vregs_on) {
> +	if (!qcadev->vregs_on) {
>  		serdev_device_close(hu->serdev);
>  		ret = qca_regulator_enable(qcadev);
>  		if (ret)
> @@ -1945,20 +1940,19 @@ static int qca_power_off(struct hci_dev *hdev)
>  
>  static int qca_regulator_enable(struct qca_serdev *qcadev)
>  {
> -	struct qca_power *power = qcadev->bt_power;
>  	int ret;
>  
>  	/* Already enabled */
> -	if (power->vregs_on)
> +	if (qcadev->vregs_on)
>  		return 0;
>  
> -	BT_DBG("enabling %d regulators)", power->num_vregs);
> +	BT_DBG("enabling %d regulators)", qcadev->num_vregs);
>  
> -	ret = regulator_bulk_enable(power->num_vregs, power->vreg_bulk);
> +	ret = regulator_bulk_enable(qcadev->num_vregs, qcadev->vreg_bulk);
>  	if (ret)
>  		return ret;
>  
> -	power->vregs_on = true;
> +	qcadev->vregs_on = true;
>  
>  	ret = clk_prepare_enable(qcadev->susclk);
>  	if (ret)
> @@ -1969,38 +1963,37 @@ static int qca_regulator_enable(struct qca_serdev *qcadev)
>  
>  static void qca_regulator_disable(struct qca_serdev *qcadev)
>  {
> -	struct qca_power *power;
> -
>  	if (!qcadev)
>  		return;
>  
> -	power = qcadev->bt_power;
> -
>  	/* Already disabled? */
> -	if (!power->vregs_on)
> +	if (!qcadev->vregs_on)
>  		return;
>  
> -	regulator_bulk_disable(power->num_vregs, power->vreg_bulk);
> -	power->vregs_on = false;
> +	regulator_bulk_disable(qcadev->num_vregs, qcadev->vreg_bulk);
> +	qcadev->vregs_on = false;
>  
>  	clk_disable_unprepare(qcadev->susclk);
>  }
>  
> -static int qca_init_regulators(struct qca_power *qca,
> -				const struct qca_vreg *vregs, size_t num_vregs)
> +static int qca_init_regulators(struct device *dev, struct qca_serdev *qca,
> +			       const struct qca_vreg *vregs, size_t num_vregs)
>  {
>  	struct regulator_bulk_data *bulk;
>  	int ret;
>  	int i;
>  
> -	bulk = devm_kcalloc(qca->dev, num_vregs, sizeof(*bulk), GFP_KERNEL);
> +	if (!num_vregs)
> +		return 0;
> +
> +	bulk = devm_kcalloc(dev, num_vregs, sizeof(*bulk), GFP_KERNEL);
>  	if (!bulk)
>  		return -ENOMEM;
>  
>  	for (i = 0; i < num_vregs; i++)
>  		bulk[i].supply = vregs[i].name;
>  
> -	ret = devm_regulator_bulk_get(qca->dev, num_vregs, bulk);
> +	ret = devm_regulator_bulk_get(dev, num_vregs, bulk);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -2044,21 +2037,15 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  	if ((qca_is_wcn399x(data->soc_type) ||
>  	     qca_is_wcn6750(data->soc_type))) {
>  		qcadev->btsoc_type = data->soc_type;
> -		qcadev->bt_power = devm_kzalloc(&serdev->dev,
> -						sizeof(struct qca_power),
> -						GFP_KERNEL);
> -		if (!qcadev->bt_power)
> -			return -ENOMEM;
> -
> -		qcadev->bt_power->dev = &serdev->dev;
> -		err = qca_init_regulators(qcadev->bt_power, data->vregs,
> +
> +		err = qca_init_regulators(&serdev->dev, qcadev, data->vregs,
>  					  data->num_vregs);
>  		if (err) {
>  			BT_ERR("Failed to init regulators:%d", err);
>  			return err;
>  		}
>  
> -		qcadev->bt_power->vregs_on = false;
> +		qcadev->vregs_on = false;
>  
>  		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>  					       GPIOD_OUT_LOW);
> @@ -2139,11 +2126,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  static void qca_serdev_remove(struct serdev_device *serdev)
>  {
>  	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
> -	struct qca_power *power = qcadev->bt_power;
>  
>  	if ((qca_is_wcn399x(qcadev->btsoc_type) ||
>  	     qca_is_wcn6750(qcadev->btsoc_type)) &&
> -	     power->vregs_on)
> +	     qcadev->vregs_on)
>  		qca_power_shutdown(&qcadev->serdev_hu);
>  	else if (qcadev->susclk)
>  		clk_disable_unprepare(qcadev->susclk);
> -- 
> 2.30.2
> 
