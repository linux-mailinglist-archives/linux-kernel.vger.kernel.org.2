Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFAA40371A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 11:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347754AbhIHJmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 05:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245528AbhIHJmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 05:42:20 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39343C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 02:41:13 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so1015898wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 02:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SyPGzxAlIqgp8BIndR9Y9ROAIR781ZTstJe/EicRs6I=;
        b=xgl5YoSwmZ/JDpR5AsGbii8s58EHYdi//SdRbQOLJKixRBhIZy0BQCLNlzGexZ6qdw
         h8lBMzGQpdASpjBUSLMFnzYXbj7bGFl9dAEN34sAhTIrpG2yw3qgoMgIvIhIIKQ+7Ffr
         51oW5U/swPa/1r7WbQtZJscez/dsoO/nrBuX38uPFluHu1fDXpqwrhPgdiEadyZ5mKA+
         QtH/mCi1iJMM/WPTqIncsBYD9Y3wPKy0ROgwmR+rB6v7BozQkJdgsrUrN0X73ONL+5oV
         NInwqT4dLj2wCH4HQGxRs0i8jIYd7Yjg9HcVCPu+4aygjZAyawRC541SxhU1rUsOvZh0
         iitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SyPGzxAlIqgp8BIndR9Y9ROAIR781ZTstJe/EicRs6I=;
        b=EGvs52hnIUlgMjfUyPmXnmPcH+W4UtbW1EPPdzL3bfAa6Z8nROj3Id35QxwkKDoSFl
         CRW3cnDH20Zjvp5L6lYD3qwLElzoY8CDTm1m7i6KsrORDwEnxtsK0/2WE/L9LnVe4VOc
         hI95NndZ6BCpx0xPu3sFWquExn+c544qGAoWPtY5qmWe3v7VGiUitbdLBty9ZAu3N9Y9
         4PotwKmRlGI6Cqrd+UnVzro8Ps9JXIeprzgTH1wLfwm8eMMvW89JFh7h9hLFuCHbQTFS
         ej2fco/UkQo9l8LBIynHHPHmHZxhsr/zyNzK+e9QLqLtAhx9Zk00lOwzNBT9Vx0RFhsO
         vU1A==
X-Gm-Message-State: AOAM532FmB64OcHiu3bvboZ1JkLcHzGA/o9XhYFcZT8RlNV2HDZhjpN6
        qQpmL9FF62VDc1WXLdgNG/06Ig==
X-Google-Smtp-Source: ABdhPJx+MGhYGRDQv1Wckw4j7kWKIVjSN3mAwvDiPMKb4OmbCpAMkXCnTxgyYueaL00h2huX4/Crow==
X-Received: by 2002:a05:600c:4ece:: with SMTP id g14mr2531749wmq.6.1631094071666;
        Wed, 08 Sep 2021 02:41:11 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id j4sm1599363wrt.23.2021.09.08.02.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 02:41:10 -0700 (PDT)
Subject: Re: [PATCH] ASoC: dt-bindings: lpass: add binding headers for digital
 codecs
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
References: <1630934854-14086-1-git-send-email-srivasam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4a513810-ab33-006d-4bce-5e35702a51e0@linaro.org>
Date:   Wed, 8 Sep 2021 10:41:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1630934854-14086-1-git-send-email-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/09/2021 14:27, Srinivasa Rao Mandadapu wrote:
> +#define LPASS_CDC_DMA_RX0 6

You are only adding RX0, what happens to RX1.. RX7

TBH, skipping other entries for ex CDC_DMA_RX will end up with sparse 
numbering.

Please add all the entries for CDC_DMA_RX and other ports as well.

Like:

#define LPASS_CDC_DMA_RX0	6
#define LPASS_CDC_DMA_RX1	7
#define LPASS_CDC_DMA_RX2	8
#define LPASS_CDC_DMA_RX3	9
#define LPASS_CDC_DMA_RX4	10
#define LPASS_CDC_DMA_RX5	11
#define LPASS_CDC_DMA_RX6	12
#define LPASS_CDC_DMA_RX7	13


> +#define LPASS_CDC_DMA_TX3 7
> +#define LPASS_CDC_DMA_VA0 8
You mean VA_TX0?


> +#define LPASS_MAX_PORTS 9
We really do not need this in bindings.
You could add this is some of the driver header files instead.

--srini
> +
