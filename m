Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68A2416728
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243261AbhIWVMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:12:43 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:42732 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243189AbhIWVMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:12:41 -0400
Received: by mail-oi1-f172.google.com with SMTP id x124so11546367oix.9;
        Thu, 23 Sep 2021 14:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r/+C4RWfXuf4J4PV+1A5NzCm+2F6V6un9scbYMc9KVM=;
        b=MFumNC9W2x9EoAVGU1xXPsDmsx62KFMMNGRPw1wH4P1futGVReHq6Pi3Gc4q7qPDIF
         FzrIg07hNHd2MPxwEtYLCSaAUNOsRipCuUZk54qEoah66WKcLUjJL7jZRQmRHyqisF5D
         o3s5WT6mdQcJJWjRk6G6EEpOkw35MthPH9OWomCMLTBzorTDEPlEE6arMRPKcQ2/4Lx9
         LaVlIixgMi0BIVtHK5RY8oHDBAF4c1HyS3P1z4Pfio1mT4TdymKmsHuzzdCaEf4yfwCw
         cBIO86UDJbyW5O2VOWZnYpuOBfo4h7lBdlIo+u3iuH+OExox6cYBMT6eaabN+qSbIHmv
         9d1g==
X-Gm-Message-State: AOAM530USWWrAVKhZi8Shxco4G4PlquwnUmRdeYj40q4z9w8yXwD0kdq
        /o+gsT/mxv4rBVi6OSCpc3WaYGfDsw==
X-Google-Smtp-Source: ABdhPJx4blJeDBUA0kv+vZLi6rvu+cXm1eK7P8e/5xXdDDWK068ZBGzVfg/UJl1LM3nPNi29EzYZYQ==
X-Received: by 2002:a05:6808:287:: with SMTP id z7mr5436354oic.8.1632431469304;
        Thu, 23 Sep 2021 14:11:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u12sm1609760otq.20.2021.09.23.14.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 14:11:08 -0700 (PDT)
Received: (nullmailer pid 3529913 invoked by uid 1000);
        Thu, 23 Sep 2021 21:11:08 -0000
Date:   Thu, 23 Sep 2021 16:11:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: lm90: convert to dtschema
Message-ID: <YUztbEMVqAFGyWER@robh.at.kernel.org>
References: <20210920181913.338772-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920181913.338772-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2021 20:19:12 +0200, Krzysztof Kozlowski wrote:
> Convert the National LM90 hwmon sensor bindings to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Changes since v1:
> 1. Drop adi,adt7461 from trivial-devices.
> ---
>  .../devicetree/bindings/hwmon/lm90.txt        | 51 ------------
>  .../bindings/hwmon/national,lm90.yaml         | 79 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  4 -
>  MAINTAINERS                                   |  2 +-
>  4 files changed, 80 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/lm90.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/national,lm90.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
