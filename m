Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611C74167FA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 00:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243485AbhIWW0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 18:26:46 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:36433 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243484AbhIWW0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 18:26:44 -0400
Received: by mail-oo1-f49.google.com with SMTP id y47-20020a4a9832000000b00290fb9f6d3fso2667713ooi.3;
        Thu, 23 Sep 2021 15:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WjbcHv9YAoiynw7wV7LlXs+zCylIWS/RAWT+npRBVhw=;
        b=6inZcJtQDeEALvHZZFN5KtR8YxxT7kKEzTnFKeaA90zKcfYUrTVb/6EULEfPolu2rp
         QWqsMk1SmZWjTDLVw3oMaX0DmxNlKe52RoYQCwQmdw4bVO0GbbwoRu07mS6q/0caOsEx
         3eMljKiTb57WD/jO5WlIMx66jeFL8R9kbbFHB3OJh49vmgBPfwxR9xURQxdZNeryIyyB
         3/I4QOD+t10F/f2Y/b181tXkCj7MD85kvnvidrExaI2IkK3dVf+tDXtQed66pkQwH80d
         1hOLJWfKO7zPDX2/TS9sV+wGVNF3uw3HcrZZntR5IGXyToDJi3SIDUbX3yGEOCILMXMI
         sF2w==
X-Gm-Message-State: AOAM532rjbfz2o5NmfEN8913gSKAx/FAiDVAjEMuQOpMSuxa9GzrWI2n
        mwFsM6Ekamj3ExBFi2d3/M1lM643LA==
X-Google-Smtp-Source: ABdhPJytXyAuXAlQQd5wh1gc3K7BfuWpgI8d47LIugldDsmTAnfaA39Gaa41onDub4Mt3kKfdmkFIA==
X-Received: by 2002:a4a:d794:: with SMTP id c20mr5793367oou.23.1632435912197;
        Thu, 23 Sep 2021 15:25:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r3sm1678245oia.4.2021.09.23.15.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 15:25:11 -0700 (PDT)
Received: (nullmailer pid 3634785 invoked by uid 1000);
        Thu, 23 Sep 2021 22:25:10 -0000
Date:   Thu, 23 Sep 2021 17:25:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH 1/6] dt-bindings: hwmon: ti,tmp108: convert to dtschema
Message-ID: <YUz+xpCSJwsz+i9B@robh.at.kernel.org>
References: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2021 12:28:27 +0200, Krzysztof Kozlowski wrote:
> Convert the TI TMP108 temperature sensor bindings to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/hwmon/ti,tmp108.yaml  | 50 +++++++++++++++++++
>  .../devicetree/bindings/hwmon/tmp108.txt      | 18 -------
>  2 files changed, 50 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp108.yaml
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/tmp108.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
