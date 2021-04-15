Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CAE3610BD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 19:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhDORHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 13:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbhDORHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 13:07:14 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F312C061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 10:06:51 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s15so28978942edd.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 10:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qiaTdRxVP+PjHJWnCOqI9pORWv0g/7bqvQKS7jz0//U=;
        b=SeU4I60J41yRkWpulsHcyPQ0lGGZjLMdyTuau+HGDQ2VjSz3SciXMHUC3QvsZbqVcZ
         voda+hYW9t0JiCwoD+6pWkUmyxu8t2ZvdA/PN+qMiHpbrhnM+z79QAtyGCb9577D4F/5
         cb8mDEjiHuRcGGOQl8CsUsHU8dKj4L/bTu8JwtubTZWnlJ10yUV9DMW9zk7oyUTfilo1
         PB96VLQ5miWm6uBcSkcY8dsCa9J0GgeCuRyJETl9c6vJAtiTh6alxsYKQ7tEbzHCPbv7
         V8YMGaYrHRewcISh9agCA2zc5m6KwvJEMnVq5HSSWud0g0I+Sf58ew0RLoRfmX/dGO6f
         uHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qiaTdRxVP+PjHJWnCOqI9pORWv0g/7bqvQKS7jz0//U=;
        b=tL0wpnQjCc7PAIE8zE+Hqz6ghnZZYOJ8aGIayXmG9GNDtqUVDQx99txnvAaMikeCpt
         XnbT5ycYq6tNYMRxuquoL5LU7P0gRWBoYpZML+QuREEaMX4WLmRXo+y0rk7XpuwZH/2a
         MzIYnzaYcGPkCl1bWUWtk19we6crJx8US97rrv19pnF3UzOeFpGqj3h6pdOSar6fsQee
         CjcZRJr1GHOpGuIwjXzi4x5UpvAmmVLZtrvC1WCpp/Pun1c8SPmwtasSKQVCmJ/GRdPP
         WKTj2ayLNvdQvmXdWgE9bUGjoanLm2YLUaInncWTV/OHSsPzvQxZE7f/LP1N/jWROc8n
         u3pw==
X-Gm-Message-State: AOAM5316X0tLRS2dnm1irnofj3AkcDyL+hiRZ+Lv8xX+60fY5RtOucD2
        GdGGN7RMBAR5fZQHsQ20ImZBkA==
X-Google-Smtp-Source: ABdhPJxnIwBJcv7n1yI2CZjRa7oKLiVaHxuL6ZCvd/+6CoD3FiDgjO1KW9xeG7XlP6U3ppCryqzvfQ==
X-Received: by 2002:aa7:c349:: with SMTP id j9mr5643684edr.41.1618506409735;
        Thu, 15 Apr 2021 10:06:49 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id cq26sm3046543edb.60.2021.04.15.10.06.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 10:06:49 -0700 (PDT)
Subject: Re: [PATCH v4 1/9] ASoC: dt-bindings: wcd938x: add bindings for
 wcd938x
To:     Rob Herring <robh@kernel.org>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
References: <20210414154845.21964-1-srinivas.kandagatla@linaro.org>
 <20210414154845.21964-2-srinivas.kandagatla@linaro.org>
 <20210415162947.GA1511094@robh.at.kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <019aa3c0-56ce-de17-4d64-be6dbc0a3a65@linaro.org>
Date:   Thu, 15 Apr 2021 18:06:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210415162947.GA1511094@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/04/2021 17:29, Rob Herring wrote:
>> +    codec {
>> +        compatible = "qcom,wcd9380-codec";
>> +        reset-gpios = <&tlmm 32 0>;
>> +        #sound-dai-cells = <1>;
>> +        qcom,tx-device = <&wcd938x_tx>;
>> +        qcom,rx-device = <&wcd938x_rx>;
>> +        qcom,micbias1-microvolt = <1800000>;
>> +        qcom,micbias2-microvolt = <1800000>;
>> +        qcom,micbias3-microvolt = <1800000>;
>> +        qcom,micbias4-microvolt = <1800000>;
>> +        qcom,mbhc-hphl-switch;
>> +        qcom,mbhc-ground-switch;
>> +        qcom,mbhc-button0-vthreshold-microvolt = <75000>;
>> +        qcom,mbhc-button1-vthreshold-microvolt = <150000>;
>> +        qcom,mbhc-button2-vthreshold-microvolt = <237000>;
>> +        qcom,mbhc-button3-vthreshold-microvolt = <500000>;
>> +        qcom,mbhc-button5-vthreshold-microvolt = <500000>;
>> +        qcom,mbhc-button6-vthreshold-microvolt = <500000>;
>> +        qcom,mbhc-button7-vthreshold-microvolt = <500000>;
>> +    };
>> +
>> +    /* ... */
>> +
>> +    soundwire@3230000 {
>> +        #address-cells = <2>;
>> +        #size-cells = <0>;
>> +        reg = <0x03230000 0x2000>;
>> +        wcd938x_tx: codec@0,3 {
>> +            compatible = "sdw20217010d00";
>> +            reg  = <0 3>;
>> +            qcom,direction = "tx";
>> +            qcom,port-mapping = <2 3 4 5>;
>> +        };
>> +
>> +        wcd938x_rx: codec@0,4 {
>> +            compatible = "sdw20217010d00";
>> +            reg  = <0 4>;
>> +            qcom,direction = "rx";
>> +            qcom,port-mapping = <1 2 3 4 5>;
>> +        };

> This is a single device, right? We shouldn't need 3 nodes to describe

Just realized that the example is bit misleading here.
It should look like:

  codec {
         compatible = "qcom,wcd9380-codec";
         reset-gpios = <&tlmm 32 0>;
         #sound-dai-cells = <1>;
         qcom,tx-device = <&wcd938x_tx>;
         qcom,rx-device = <&wcd938x_rx>;
         qcom,micbias1-microvolt = <1800000>;
         qcom,micbias2-microvolt = <1800000>;
         qcom,micbias3-microvolt = <1800000>;
         qcom,micbias4-microvolt = <1800000>;
         qcom,mbhc-hphl-switch;
         qcom,mbhc-ground-switch;
         qcom,mbhc-button0-vthreshold-microvolt = <75000>;
         qcom,mbhc-button1-vthreshold-microvolt = <150000>;
         qcom,mbhc-button2-vthreshold-microvolt = <237000>;
         qcom,mbhc-button3-vthreshold-microvolt = <500000>;
         qcom,mbhc-button5-vthreshold-microvolt = <500000>;
         qcom,mbhc-button6-vthreshold-microvolt = <500000>;
         qcom,mbhc-button7-vthreshold-microvolt = <500000>;
     };


soundwire-controller@3230000 {
	reg = <0 0x3230000 0 0x2000>;
	compatible = "qcom,soundwire-v1.5.1";
	wcd938x_tx: codec@0,3 {
		compatible = "sdw20217010d00";
		reg  = <0 3>;
		qcom,direction = "tx";
		qcom,port-mapping = <2 3 4 5>;
	};
};


soundwire-controller@3210000 {
	reg = <0 0x3210000 0 0x2000>;
	compatible = "qcom,soundwire-v1.5.1";
	 wcd938x_rx: codec@0,4 {
		compatible = "sdw20217010d00";
		reg  = <0 4>;
		qcom,direction = "rx";
		qcom,port-mapping = <1 2 3 4 5>;
	};
};


--srini
