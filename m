Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168C841680A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 00:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243490AbhIWWbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 18:31:01 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:40901 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243475AbhIWWbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 18:31:00 -0400
Received: by mail-oo1-f43.google.com with SMTP id j11-20020a4a92cb000000b002902ae8cb10so2659071ooh.7;
        Thu, 23 Sep 2021 15:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=skzmqDVj+AYYg0qqfqSYSfj5gw5GdEUyGDWIBsc6lAk=;
        b=6tJHNs05tpC7Xq6SKIimuP5XWTd8N5TW9pDzbvn06oEHW3avYVe/VwBOAmhilmRZHf
         267CCgc0ygaKQKoVcWo4XgLVFeTR6ORFB3GrFcSD0fmoGjwfUXysZQdgLuU/cfgvPr7n
         g+eXgsOfiCFxqLnOUs+qHIv8LMlXcQjQ91p0YlOnd5G1N76bWNZ1ovDiR7u/wr/eUXXE
         qMcGsx2OliGGHRSTtHy2OvYIS6EtnyLOCtkqyFY74bconL/eOTrDlbebtmgxx3UXVegE
         KRXK1wCGm7tRRdR4Kv6DnFWYjHRYxsZBJMhL6L9PYS1h88VpT5bzpLm9BvG86Ql/cYY9
         MbVA==
X-Gm-Message-State: AOAM531H8FPaK8mtaD1XtAx1/uTA+IO5QyH9m5xIRdSMSQ4Z95u2JSBT
        SIGgyjrDrpPMw8YoopIfUw==
X-Google-Smtp-Source: ABdhPJyYVpQ0X9ed7tshlxsOpcUXJwN90gmjXMk37nqZyfYnx4nhdU+DMgEkDWSNhFVzqUXflD6XwQ==
X-Received: by 2002:a4a:d9c6:: with SMTP id l6mr5932233oou.0.1632436167854;
        Thu, 23 Sep 2021 15:29:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 12sm1377475otg.69.2021.09.23.15.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 15:29:27 -0700 (PDT)
Received: (nullmailer pid 3640755 invoked by uid 1000);
        Thu, 23 Sep 2021 22:29:26 -0000
Date:   Thu, 23 Sep 2021 17:29:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jiri Kosina <trivial@kernel.org>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: hwmon: microchip,mcp3021: convert to
 dtschema
Message-ID: <YUz/xlpJzCOr3Z0I@robh.at.kernel.org>
References: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
 <20210921102832.143352-5-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921102832.143352-5-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2021 12:28:31 +0200, Krzysztof Kozlowski wrote:
> Convert the Microchip MCP3021 ADC bindings to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/hwmon/mcp3021.txt     | 21 ---------
>  .../bindings/hwmon/microchip,mcp3021.yaml     | 43 +++++++++++++++++++
>  2 files changed, 43 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/mcp3021.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,mcp3021.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
