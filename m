Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22C734E385
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhC3Ivh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:51:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37072 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhC3IvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:51:18 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lRA5l-0004u9-CQ
        for linux-kernel@vger.kernel.org; Tue, 30 Mar 2021 08:51:17 +0000
Received: by mail-wr1-f70.google.com with SMTP id e9so9524339wrg.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 01:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=djVlT/RAmq6AwtihToV3c2qx0PjKLnFe2UuBJ80EzkM=;
        b=At5hmxVBiFi390K2N3ROIO+khRVclb/kc83ULlY7x6HEMa4b4gzISi/jrLvoZmPGEE
         YJJBS+Irp+OxDmo+nxmAAfQY4iRDAGpGWq80s0+xq+l6fWrMK/cg1cSjAvMt2L9b8tSN
         jdxbx8GVM86qnnzMyiXBTW5T6EK3o6jA4D7HhUOvgVRBrEyPJ0/9ol9V3SRINozeBo/D
         sEblSp8HVgbOW8kRt76IHD5j6SBt+s5w1TBoxew8zHASFxl6E0nBSN8Nj1jWtALLiB8Y
         H+Q/jlCZoIsDzLOFJ9XUxzlGwN/+RioRGY6J3LWFGzLzd8SYya57mCbqTWS3KPQm1+eT
         9BLw==
X-Gm-Message-State: AOAM533md4BQvEC67vq3QJ74gMbc+AT7CZN4Ectc31Euposx4xBXwDFb
        wwhzVFVbBqy+oMXcHp7e6zYd6ebFHKK1QS82BmyaeQYkIiG/MSdUr47t9pok+v1/lzZPfO7jL3R
        OsSfa3WIH+dLgYvMx0+8Ct/3eqkLZUWGKriTo6ZUV/A==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr2898601wmc.90.1617094276521;
        Tue, 30 Mar 2021 01:51:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMM+kQaqpCWb0b7OW+orw77+hmaUElyaV7pasIVj3HsWg6jELlm0lBduYBq4l8/WLCYe23Ww==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr2898587wmc.90.1617094276417;
        Tue, 30 Mar 2021 01:51:16 -0700 (PDT)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id l6sm34969120wrn.3.2021.03.30.01.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 01:51:16 -0700 (PDT)
Subject: Re: [PATCH] usb: dwc3: exynos: fix incorrect kernel-doc comment
 syntax
To:     Aditya Srivastava <yashsri421@gmail.com>, balbi@kernel.org
Cc:     lukas.bulwahn@gmail.com, gregkh@linuxfoundation.org,
        rdunlap@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210329140318.27742-1-yashsri421@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <b341b0a5-4f78-d986-d038-8e067bf5d34e@canonical.com>
Date:   Tue, 30 Mar 2021 10:51:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210329140318.27742-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2021 16:03, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> The header for drivers/usb/dwc3/dwc3-exynos.c follows this syntax, but the
> content inside does not comply with kernel-doc.
> 
> This line was probably not meant for kernel-doc parsing, but is parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warning from kernel-doc:
> "warning: expecting prototype for dwc3(). Prototype was for DWC3_EXYNOS_MAX_CLOCKS() instead"
> 
> Provide a simple fix by replacing this occurrence with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.

One sentence with error log would be enough for such trivial change. Anyway:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
