Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED2C440A8B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 19:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhJ3RWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 13:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhJ3RWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 13:22:50 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097F6C061570
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 10:20:18 -0700 (PDT)
Date:   Sat, 30 Oct 2021 19:20:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1635614417; bh=ifToxbXFvrqpVsPBgtjtkXpdeT5nleHplDjWdA/8Trw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kv3LatTuIWb3lGlRIL4OEPc9BDzBj2rxOx/WctWrxA91izJJfZRl+cX+aNm434Hv/
         9mxl68QL+CYVsD3AMy5Tt6zWLO3rtBHw9D0cn2Baghc9ecCFi8KBt2ULhzwKpXc3KO
         MGeheVaJ/8fwPDKHnLZ2GRtXlr2rQQst+fneUa/U=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Charles Mirabile <cmirabil@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rpi-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: Re: [PATCH 1/5] drivers/mfd: sensehat: Raspberry Pi Sense HAT core
 driver
Message-ID: <12caa13c-7399-49c9-9a2d-689a646891d0@t-8ch.de>
References: <20211029215516.801593-1-cmirabil@redhat.com>
 <20211029215516.801593-2-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211029215516.801593-2-cmirabil@redhat.com>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-29 17:55-0400, Charles Mirabile wrote:
> +static int sensehat_probe(struct i2c_client *i2c,
> +			       const struct i2c_device_id *id)
> +{
> 	...
> +
> +	sensehat->joystick.pdev = sensehat_client_dev_register(sensehat,
> +							       "sensehat-joystick");

Will this not fail the complete driver load if the driver for this single
subdevice is not available?
For example if the Kconfig option has not been selected, the patch for the
driver is not applied or the user has blacklisted the respective module in
their system.

> +	if (IS_ERR(sensehat->joystick.pdev)) {
> +		dev_err(sensehat->dev, "failed to register sensehat-joystick");
> +		return PTR_ERR(sensehat->joystick.pdev);
> +	}
> +
> +	sensehat->display.pdev = sensehat_client_dev_register(sensehat,
> +								  "sensehat-display");

Same as above.

> +
> +	if (IS_ERR(sensehat->display.pdev)) {
> +		dev_err(sensehat->dev, "failed to register sensehat-display");
> +		return PTR_ERR(sensehat->display.pdev);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_device *
> +sensehat_client_dev_register(struct sensehat *sensehat, const char *name)
> +{
> +	long ret = -ENOMEM;
> +	struct platform_device *pdev = platform_device_alloc(name, -1);
> +
> +	if (!pdev)
> +		goto alloc_fail;
> +
> +	pdev->dev.parent = sensehat->dev;
> +	platform_set_drvdata(pdev, sensehat);
> +
> +	ret = platform_device_add(pdev);
> +	if (ret)
> +		goto add_fail;
> +
> +	ret = devm_add_action_or_reset(sensehat->dev,
> +		(void *)platform_device_unregister, pdev);
> +	if (ret)
> +		goto alloc_fail;
> +
> +	return pdev;
> +
> +add_fail:
> +	platform_device_put(pdev);
> +alloc_fail:
> +	return ERR_PTR(ret);
> +}

Thomas
