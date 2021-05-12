Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874FF37BC09
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 13:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhELLsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 07:48:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55328 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhELLsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 07:48:18 -0400
Received: from mail-vs1-f70.google.com ([209.85.217.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lgnKX-0007OS-E8
        for linux-kernel@vger.kernel.org; Wed, 12 May 2021 11:47:09 +0000
Received: by mail-vs1-f70.google.com with SMTP id x22-20020a67c0960000b02902259994ab39so11049889vsi.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 04:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yBitZcNhIM9z4KET6YAuzNPYaMvvVUiEAXXH4qj8xVM=;
        b=uUAHzSYkCzaF6H8qObgSiNcUnO9N89WtMmJk4eAwrhZRnkeaYwFxwlFgO9hR+W9RsY
         qwYxi5AQT20/2/nq4oMc+XPaGHTGsR7ImoGxnRkGXtMrF4++7w5sTlpSbXCtioWb+3uX
         S/7pO0efLtKZWXEVbeT/LI2oQO7ybHwjEu67bOXc0ZtKpMnANvpcCkX5Ou7goYfEGY/G
         O2TGryr7dAvFYI+Es4b73BTw49z2L7HeQEYu+JtMUMPj3MWDQG/15YpyfTvonQz3WEXc
         g7mKWGP06hQe5D78HAV4/1dCKUdfPa9m6cyHlBtcrGWEAoO1apQT+UCPZgOhUFLx5hK7
         uquw==
X-Gm-Message-State: AOAM5311BNFb5GXjdPcGP0k+3AQzUj39/rwMEqBZ+rM0k8FwRjKQ0yRZ
        huEELqoE2v/rOMZrUEd+bXCqXz3hxk/m3oZT7HyPbDnydXQVrYJWl8udk7i3XIlEwfWf7PCtS0g
        otJJaEzAAZoI3qPaONOnKT0UNhUTbopCYCDGNz3zv1Q==
X-Received: by 2002:a67:e915:: with SMTP id c21mr32088442vso.32.1620820028096;
        Wed, 12 May 2021 04:47:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYslrlexrDVfJAQWZv27Gx/WKb27rynSQ4drYxmvnOGuiXWdUXlFKZ/Vt3FdWmjVrKIrO69Q==
X-Received: by 2002:a67:e915:: with SMTP id c21mr32088437vso.32.1620820027940;
        Wed, 12 May 2021 04:47:07 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id s200sm2594366vks.34.2021.05.12.04.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 04:47:07 -0700 (PDT)
Subject: Re: [PATCH -next] dmaengine: s3c24xx: add missing MODULE_DEVICE_TABLE
To:     Zou Wei <zou_wei@huawei.com>, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1620801555-18805-1-git-send-email-zou_wei@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <ee04c671-1194-402f-c82f-36c139dd5ca7@canonical.com>
Date:   Wed, 12 May 2021 07:47:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1620801555-18805-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2021 02:39, Zou Wei wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.


Hi,

Thanks for the patch. It cannot be built as a module.

> 
> Reported-by: Hulk Robot <hulkci@huawei.com>

Please make the reports public. This is open source work and public
collaboration.

Best regards,
Krzysztof

