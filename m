Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18324374B58
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 00:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhEEWn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 18:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbhEEWn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 18:43:26 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77364C061763
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 15:42:29 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e2so3137880ilr.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 15:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SJUIBuHhepEp+wT3Pjt2XdzXn6TjSxT+NTsD6f9oXzE=;
        b=aLJGnU2lofLk8T5SKMI5HiMHi0AC5Siw3ASIZgbvpXpNUHY6I/7epkzbiHbJetS7/Z
         jPw9j2p0s/oV3DIowNUOIB51Ld8H2vRdnTZRi4DvecRZC/7rxL1mFapldxkm3w616IW+
         GuKKsbO3D3lN+VD3kTY75Fhjse3bqV3mHfKBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SJUIBuHhepEp+wT3Pjt2XdzXn6TjSxT+NTsD6f9oXzE=;
        b=rL98pj0236DzSyzoOTC8Prs4YiO+JRMkK64ZCa1kEzsjlPTmVLbgqiZoei9LCGW+eo
         X9jERrLxPRMNEuGs90qN8i+o8HxFq+cfoJgYHhBsTq24E0L46oEIWDDPTs+7y9Msb2mH
         cDnzhbow1Zj8CM2EdwJk3hSKg4VzwPgD6uWrqpKq/0MmOptL27R3dJEmw19S76a2J72K
         7EMXutW2cWZcmoJQK2+w0o+yvdSK8P+4Ib8HqP+pCMQ2ZKzDkwf4K5LosvGo+0pFgmEA
         FOG4ae6FbhqL2stykWnTFeP5hRDOwU6hxXjEGaHxInm8KcZJpskkFOd4WlBgbh++iipM
         xXUQ==
X-Gm-Message-State: AOAM5328qI9n1FvBMfIHuOTudA37DVY7oRta06sw4DuMFi0Iqs7GRYSH
        HCPhqlqgrnNL3Bg4oxPsKw9htA==
X-Google-Smtp-Source: ABdhPJzpOIJYXTtrBoE4gzVj1n3QhpQh1YxXjwNLyB+fFgVot5NUODhfO/vNkmHHD5edyIo95KuGSw==
X-Received: by 2002:a05:6e02:c71:: with SMTP id f17mr1195410ilj.176.1620254548798;
        Wed, 05 May 2021 15:42:28 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id z3sm250286ioe.40.2021.05.05.15.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 15:42:28 -0700 (PDT)
Subject: Re: [PATCH v1 0/7] Add support for IPA v3.1, GSI v1.0, MSM8998 IPA
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>, elder@kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, davem@davemloft.net,
        kuba@kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, phone-devel@vger.kernel.org
References: <20210211175015.200772-1-angelogioacchino.delregno@somainline.org>
From:   Alex Elder <elder@ieee.org>
Message-ID: <687152bb-b1b0-f250-ec7d-ca8ea763da7d@ieee.org>
Date:   Wed, 5 May 2021 17:42:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210211175015.200772-1-angelogioacchino.delregno@somainline.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/21 11:50 AM, AngeloGioacchino Del Regno wrote:
> Hey all!
> 
> This time around I thought that it would be nice to get some modem
> action going on. We have it, it's working (ish), so just.. why not.

When I reviewed this series in March, I said I wanted to
post a bunch of patches I had already been working on,
which enabled support for many versions of IPA, including
IPA v3.1.  That work is complete now, so I'm returning to
your series and seeing if there is anything you included
in your patches that I did not.

There are a few differences, which I will point out in a new
set of responses to your original patches.  I will be posting
some updates, and will explain what I intend to do in those
updates in the messages that follow.

					-Alex

> This series adds support for IPA v3.1 (featuring GSI v1.0) and also
> takes account for some bits that are shared with other unimplemented
> IPA v3 variants and it is specifically targeting MSM8998, for which
> support is added.
> 
> Since the userspace isn't entirely ready (as far as I can see) for
> data connection (3g/lte/whatever) through the modem, it was possible
> to only partially test this series.
> Specifically, loading the IPA firmware and setting up the interface
> went just fine, along with a basic setup of the network interface
> that got exposed by this driver.
> 
> With this series, the benefits that I see are:
>   1. The modem doesn't crash anymore when trying to setup a data
>      connection, as now the modem firmware seems to be happy with
>      having IPA initialized and ready;
>   2. Other random modem crashes while picking up LTE home network
>      signal (even just for calling, nothing fancy) seem to be gone.
> 
> These are the reasons why I think that this series is ready for
> upstream action. It's *at least* stabilizing the platform when
> the modem is up.
> 
> This was tested on the F(x)Tec Pro 1 (MSM8998) smartphone.
> 
> AngeloGioacchino Del Regno (7):
>    net: ipa: Add support for IPA v3.1 with GSI v1.0
>    net: ipa: endpoint: Don't read unexistant register on IPAv3.1
>    net: ipa: gsi: Avoid some writes during irq setup for older IPA
>    net: ipa: gsi: Use right masks for GSI v1.0 channels hw param
>    net: ipa: Add support for IPA on MSM8998
>    dt-bindings: net: qcom-ipa: Document qcom,sc7180-ipa compatible
>    dt-bindings: net: qcom-ipa: Document qcom,msm8998-ipa compatible
> 
>   .../devicetree/bindings/net/qcom,ipa.yaml     |   7 +-
>   drivers/net/ipa/Makefile                      |   3 +-
>   drivers/net/ipa/gsi.c                         |  33 +-
>   drivers/net/ipa/gsi_reg.h                     |   5 +
>   drivers/net/ipa/ipa_data-msm8998.c            | 407 ++++++++++++++++++
>   drivers/net/ipa/ipa_data.h                    |   5 +
>   drivers/net/ipa/ipa_endpoint.c                |  26 +-
>   drivers/net/ipa/ipa_main.c                    |  12 +-
>   drivers/net/ipa/ipa_reg.h                     |   3 +
>   drivers/net/ipa/ipa_version.h                 |   1 +
>   10 files changed, 480 insertions(+), 22 deletions(-)
>   create mode 100644 drivers/net/ipa/ipa_data-msm8998.c
> 

