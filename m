Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF299332CCC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 18:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhCIRFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 12:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhCIRFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:05:09 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90F1C061760
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 09:05:08 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id f1so28263966lfu.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 09:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mE0qq7XWVraqToRnsf3TWr4SmhFzw0GeG0Z8j3nI9qk=;
        b=RF0XJTHsGZt8YwSWIY/2+2L1Kg/lvZUqTc9N8rUmyJxLjVeP8dHjBmarbWM1LcRz3C
         VRSNQl4EuL8RUpwjlmI1JReg2+dCsgNxYGTsuSmW41ysQ/0LDPMC20N/4WlIlV5MiMi4
         ECjte96LZx7gX6FHP8FzCMmClWwg9pWH1gIjNTJfyak+bvCGgAkhZWlUiaoQh6JUtJJ+
         atxoV6A1wGVLpNQ0MB46EVHEaHET0i4AQPhoUbMGh3qioaCJFTbYTuAepRP5hoqEl/Po
         3MbAa+BcrE0ZZSPiAY7rV5pUS4ud9M0oXhbG5+Ehb6iJG+nrrYc64bFwmIqu5sOCfdDd
         IyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mE0qq7XWVraqToRnsf3TWr4SmhFzw0GeG0Z8j3nI9qk=;
        b=WCUfnehK05IhEmAMKyXAcYpXVnIlI1DLHuQNkW0MZjHxQBmM19D/+vzhIe4A98BlVm
         WpJL0dsjRyn93JS8JVWLv/LpJ2GYv3JMt66kUkADJLw9WBV/U/tTRycFiF+FfFf0Wfv+
         d++RKGa66yMVluy67QNsm2oqi1Jni+uEwBwFQsxkjqCT8u7U4GIOgmYJm9bZE8fy9787
         C/+IuaZbcQ2Q3DEKWKjsQoJQNP+u1YuSA7xHcEYcS1FCmH7W0wtxHbBBfDoiP2aRIgcc
         FyaF3uK2rnjHUxYyLh1C26KdEs6gYZgINKCrxhEOv8IzkrClzFg2JlH6sp+ZICtp3X1O
         4JNw==
X-Gm-Message-State: AOAM533z8gaLJoAf1jZd42Sh2h12vdg9Gqe4DDLvROTF0a26cgGfOvRU
        Cu8Am0Tw07ktuTfKRsc4TgFlIT+vkmo=
X-Google-Smtp-Source: ABdhPJwUWqWWQW8jmhGdxVsNALyN05motUXwh2kAtGHjxhQ4p/U0kevgq11J+ob+i3Bh4PRTI89wPA==
X-Received: by 2002:a05:6512:a8e:: with SMTP id m14mr18226138lfu.641.1615309501730;
        Tue, 09 Mar 2021 09:05:01 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.googlemail.com with ESMTPSA id h28sm1847449lfp.155.2021.03.09.09.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 09:05:01 -0800 (PST)
Subject: Re: [RFC] reset: add reset_control_bulk API
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <20210303121000.26072-1-p.zabel@pengutronix.de>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b1704d04-14bf-9950-5bae-d97e357d6832@gmail.com>
Date:   Tue, 9 Mar 2021 20:05:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210303121000.26072-1-p.zabel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

03.03.2021 15:10, Philipp Zabel пишет:
> Follow the clock and regulator subsystems' lead and add a bulk API
> for reset controls.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---

Hello Philipp,

The patch is almost okay to me. I'll fix the minor issues and include it
in the next version of the Tegra audio patches. Thanks!

> +/**
> + * reset_control_bulk_deassert - asserts the reset lines in order

I'll correct this comment

> + * @num_rstcs: number of entries in rstcs array
> + * @rstcs: array of struct reset_control_bulk_data with reset controls set
> + *
> + * Deassert the reset lines for all provided reset controls, in order.
> + * If a deassertion fails, already deasserted resets are asserted again.
> + *
> + * See also: reset_control_assert()
> + */
> +int reset_control_bulk_deassert(int num_rstcs,
> +				struct reset_control_bulk_data *rstcs)
> +{
> +	int ret, i;
> +
> +	for (i = 0; i < num_rstcs; i++) {
> +		ret = reset_control_deassert(rstcs[i].rstc);
> +		if (ret)
> +			goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	while (i--)
> +		reset_control_assert(rstcs[i].rstc);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(reset_control_bulk_deassert);

and change the bulk_deassert to use the reverse order

...
> +int __reset_control_bulk_get(struct device *dev, int num_rstcs,
> +			     struct reset_control_bulk_data *rstcs,
> +			     bool shared, bool optional, bool acquired)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < num_rstcs; i++) {
> +		rstcs[i].rstc = __reset_control_get(dev, rstcs[i].id, 0,
> +						    shared, optional, acquired);
> +		if (IS_ERR(rstcs[i].rstc)) {
> +			ret = PTR_ERR(rstcs[i].rstc);
> +			goto err;
> +		}
> +	}
> +

and add the missing "return 0" here.

> +err:
> +	mutex_lock(&reset_list_mutex);
> +	while (i--)
> +		__reset_control_put_internal(rstcs[i].rstc);
> +	mutex_unlock(&reset_list_mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(__reset_control_bulk_get);
...

