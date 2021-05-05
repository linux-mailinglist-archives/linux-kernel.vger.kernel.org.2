Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE531374B89
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 00:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhEEWzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 18:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhEEWzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 18:55:19 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885CDC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 15:54:22 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id f15so2594543qtv.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 15:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q0zaKRzVGTfWicFKwAlACr051DkRY61aB+V34lEP+IA=;
        b=j//dnuDqqgd1N5DOil+G4gzmT2ik8uFoLeEhVq+HpkRWkz4y7xDWHyiP4LF77UzSB/
         vKwools9QClihcN9Mop6spO30pPbEfXMt5YxnKxoYgUzKn09yW0gANLO9ipUbm7izU7W
         Z4lcJiv2mBnf8KssxDIHZeZ9hVUwSAehuuywggg4TmaZbdkzzFCtHcY32HoKxGW7lbK0
         0Ixx8OUlqM3wQ3EITck0/gPsfD7ZCi+msx191keWX/4G89grao/VJuEecz/kpZYg8Iiw
         HE8SDOado5mFDuoafp/E3flRCIC5N72u2rtTfzWvJmPSJnRSN0aYaxhaJC367CKdHz9T
         Ebkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q0zaKRzVGTfWicFKwAlACr051DkRY61aB+V34lEP+IA=;
        b=Pua5EDBKAYOWEb2SvQ0vaS0Qsh3h/0tZrpnDQSV02yXGJ4YF/K1g7/pMaCMjpKxUPr
         woG+IAc36SLnOe1cMygsClG8ADrOTiUcRsecuownAXC+GuyS0SXqC/FR1XHWjA+Wa+Bg
         bRxt6+FKgPxsE4Vpmjr/KMqaCnYeXXxiT1HTX+cuq3NCH76Uj9Qk5hqiorASoKWY9KU9
         16vJFcI5hnocX7u4Csde79qIrvybgDPzsY1wW0xRMs6OwIFmIaV65L8nWmEM/tREf6+6
         jYK6PkJ7QUIgfw9ZSFNPLaGbaAkObRDeVak+8e61O0+s79RlvkkG22fE/XGmi4W5RL19
         rQQQ==
X-Gm-Message-State: AOAM53192Wwr1yfxlSp0VHV6IntP70c/T6sA10mvlnmyXsXR6aS6dC5L
        nMNhoIVqMGiipqk4VblZrMUj+A==
X-Google-Smtp-Source: ABdhPJxV4JR7XYvl9CET37aFz6TdncEItz78NEQmI3EZzHqQXLhOb8abvNkaRYc9/Jd6307iu7d5zQ==
X-Received: by 2002:ac8:6f79:: with SMTP id u25mr960182qtv.166.1620255261363;
        Wed, 05 May 2021 15:54:21 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id x13sm627365qtf.32.2021.05.05.15.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 15:54:20 -0700 (PDT)
Subject: Re: [Patch v4 0/7] Add support for AEAD algorithms in Qualcomm Crypto
 Engine driver
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20210429150707.3168383-1-thara.gopinath@linaro.org>
Message-ID: <48d51bb5-a107-4756-4767-f62131d28505@linaro.org>
Date:   Wed, 5 May 2021 18:54:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210429150707.3168383-1-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/21 11:07 AM, Thara Gopinath wrote:
> Enable support for AEAD algorithms in Qualcomm CE driver.  The first three
> patches in this series are cleanups and add a few missing pieces required
> to add support for AEAD algorithms.  Patch 4 introduces supported AEAD
> transformations on Qualcomm CE.  Patches 5 and 6 implements the h/w
> infrastructure needed to enable and run the AEAD transformations on
> Qualcomm CE.  Patch 7 adds support to queue fallback algorithms in case of
> unsupported special inputs.
> 
> This patch series has been tested with in kernel crypto testing module
> tcrypt.ko with fuzz tests enabled as well.

Hi Herbert,

I have fixed all the review comments on this series and fuzz tests pass 
as well. Do you think this can be merged ?

-- 
Warm Regards
Thara
> 
> Thara Gopinath (7):
>    crypto: qce: common: Add MAC failed error checking
>    crypto: qce: common: Make result dump optional
>    crypto: qce: Add mode for rfc4309
>    crypto: qce: Add support for AEAD algorithms
>    crypto: qce: common: Clean up qce_auth_cfg
>    crypto: qce: common: Add support for AEAD algorithms
>    crypto: qce: aead: Schedule fallback algorithm
> 
>   drivers/crypto/Kconfig      |  15 +
>   drivers/crypto/qce/Makefile |   1 +
>   drivers/crypto/qce/aead.c   | 841 ++++++++++++++++++++++++++++++++++++
>   drivers/crypto/qce/aead.h   |  56 +++
>   drivers/crypto/qce/common.c | 196 ++++++++-
>   drivers/crypto/qce/common.h |   9 +-
>   drivers/crypto/qce/core.c   |   4 +
>   7 files changed, 1102 insertions(+), 20 deletions(-)
>   create mode 100644 drivers/crypto/qce/aead.c
>   create mode 100644 drivers/crypto/qce/aead.h
> 


