Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A42B41673B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243230AbhIWVOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:14:43 -0400
Received: from mail-oo1-f42.google.com ([209.85.161.42]:40815 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243224AbhIWVOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:14:42 -0400
Received: by mail-oo1-f42.google.com with SMTP id j11-20020a4a92cb000000b002902ae8cb10so2599044ooh.7;
        Thu, 23 Sep 2021 14:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J36WTteO3845rl137wT1Wa/oj+6hJoxSWkPDTmTZtZU=;
        b=N2Kb7r9hMc59Xn+TsafTyQ2r7WzV3PFIqru6c7XhP5JQdwsk4G1sQRe7wwbdE56QPw
         56PV6l+wBOLBpjElWKOR73spsEeuKcFlN+sqL4pgc9BGCR58fL5khEy7vH0YhW2fk1/M
         lmUPEeWUNKCH0JjdOluwn2HW1yE/JGVvMjLfniOTfTI5ExYZ4huEJFVjFw6D3VDgUvW9
         4YI4teVgOGq2BFgk0Toim1y0mo2JIag9mCFaLSpeMeFnZlNtzgYlGZlPLhtY+TvkpRiy
         IAmKJKlbGZMieJ/WLmCjYjaWcjPG2VQxdNugPsetBBvBrzVaIH9UshK7IyiqhrVFIXcK
         weug==
X-Gm-Message-State: AOAM5301+luM+k1nRFSY9wX8ZCFdo0Cea+R+s29GppvAL7y4vnx3D7t8
        uURRg7olQGRpRNsm9D4xOomat4j+uA==
X-Google-Smtp-Source: ABdhPJxiqRH/5TBCnwOhhbCgf7gLEhz9iiTXaeQ9JD8ncxcPN3ZYSAmuMbkId4IpxElirK4304kpgQ==
X-Received: by 2002:a4a:d5d2:: with SMTP id a18mr5568625oot.43.1632431589836;
        Thu, 23 Sep 2021 14:13:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k6sm1521772otf.80.2021.09.23.14.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 14:13:09 -0700 (PDT)
Received: (nullmailer pid 3533203 invoked by uid 1000);
        Thu, 23 Sep 2021 21:13:08 -0000
Date:   Thu, 23 Sep 2021 16:13:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jiri Kosina <trivial@kernel.org>, linux-hwmon@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/6] dt-bindings: hwmon: lm70: move to trivial devices
Message-ID: <YUzt5Em2EZyMZK3D@robh.at.kernel.org>
References: <20210920182114.339419-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920182114.339419-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2021 20:21:09 +0200, Krzysztof Kozlowski wrote:
> The lm70 thermometer bindings are trivial, so like many other I2C/SPI
> temperature sensors can be integrated into trivial devices bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/hwmon/lm70.txt        | 22 -------------------
>  .../devicetree/bindings/trivial-devices.yaml  |  8 +++++++
>  2 files changed, 8 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/lm70.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
