Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AE6435DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhJUJ1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhJUJ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:27:01 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC659C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 02:24:45 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u13so72774edy.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 02:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V5V3mrMbGu1ppi6ARFhGUSANkmRh+1a3b9M8ZtI/3z4=;
        b=ddBd6V4x0LmBfVs0vWUySyZVPTrIMF1gV+CCLfHKHDKc3ECi5Fmd/GaH8SzbNtk/8A
         EoM0ln1xJOL7zBl2ZRajrUOHvohw8Swt4OA8rIc81MlinO1h5+ySqYC+40rQ+NxBJfsh
         0W40qXW4TCeVGiqmw6FLXQb2xzRF1kCnx91dmbldr1K5iDIOQbiXILBBSJU5buxK2Cwh
         VWqaUnwpsfR00unKVDXvsRI02792Ajy/YXTWrpOAm53ZkbAG59myMlmtriBJvvSlUxNN
         9eDOkMTVaO29cfs+bdSZS97QtQnH5ut5qvCIgjRS1bZE3Yqdq/vwThRvauytwAAi9T50
         a0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V5V3mrMbGu1ppi6ARFhGUSANkmRh+1a3b9M8ZtI/3z4=;
        b=EFakkHak118S6RPvnTkD6Ure3Xb4mTJtMW/Vro9B78c8szHyKL/Dhqfcmmfh9jf01f
         F/hvKqTK/q/K93+JAr+mnKxvbQL7077wO2aAfgUcZAdCrLDJq0AR8G9EYm+0NLvR6mNr
         hJAe+FxoMl9tLBEEagZIswvs+NN0XeaxWFobSM78Z42c1z4J/mmMpOHnhuRE6r2+5uyt
         PvEm8OYohCVGYXPZykWMnnEScrrBGWg0OZQexGdD55vuGhKKQllvtz9Jlm/Kxk5YALh3
         XLNGj/WyKPIS92pW7u5aTdu1nhLQx5F/0meKqFKJpXokqPZQOu1a+AoArUSxWfUMw2ve
         FK8Q==
X-Gm-Message-State: AOAM532dgK2o2k1MTOQKGeFgVy8ZeZesG3Ozji/eXMEGyJ47LCsUTZxi
        U4FdpddU2CiGaRUZirWY5MiX2Q==
X-Google-Smtp-Source: ABdhPJy8oS0zIhlGWv0DvQGXh9QF2VSWhQLKdi+HZnhxRaaHACjc9YqWyLKfLgZGT7KGPkEhCd2ssw==
X-Received: by 2002:a17:906:8893:: with SMTP id ak19mr6013410ejc.124.1634808284520;
        Thu, 21 Oct 2021 02:24:44 -0700 (PDT)
Received: from [192.168.1.15] (hst-221-64.medicom.bg. [84.238.221.64])
        by smtp.googlemail.com with ESMTPSA id t6sm2558168edj.27.2021.10.21.02.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 02:24:44 -0700 (PDT)
Subject: Re: [PATCH 1/3] dt-bindings: media: venus: Add sdm660 dt schema
To:     Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mchehab@kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, martin.botka@somainline.org,
        robh+dt@kernel.org, phone-devel@vger.kernel.org,
        linux-media@vger.kernel.org, agross@kernel.org,
        stanimir.varbanov@linaro.org, bjorn.andersson@linaro.org
References: <20211008102119.268869-1-angelogioacchino.delregno@collabora.com>
 <YW824G+mII83pjU5@robh.at.kernel.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <99a0bb09-6892-f103-6eb7-b6333b56090a@linaro.org>
Date:   Thu, 21 Oct 2021 12:24:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YW824G+mII83pjU5@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Rob, I will push this through media tree.

On 10/20/21 12:21 AM, Rob Herring wrote:
> Reviewed-by: Rob Herring <robh@kernel.org>

-- 
regards,
Stan
