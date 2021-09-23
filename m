Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E22441674E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243286AbhIWVQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:16:54 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:37653 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243189AbhIWVQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:16:53 -0400
Received: by mail-oi1-f177.google.com with SMTP id w206so11637943oiw.4;
        Thu, 23 Sep 2021 14:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qNX7Klef0SuOrVDULaH7t1ec/+dDQ3FCxQCfVYDWUNY=;
        b=t9n5ztof3DwaOhU8cOnjLSZpYP10owg09oXiXK/Us7d+wqEGBgV5dpRbxiNlDujW3o
         8Nu2EOT82D+Xe6S0G4lL9lss4841G6Qc0wPKUxwuf5CuAfLfkvyM0O6CX95VCN2gu/k2
         o1yxfh9jYZ8yxKfN8DfWQXVndv1m+XTghUn2+OIMl481H1svMrwAE3HCieMY2sfuLxKe
         Q9S4xpWBoiDd3RoE+nlCB9BvCEehcEeIgon0sT16yXWCtXvyHOAVQtEXbvD6HfDVAZgR
         aKDeSYH2RylFT/XTf6dxcpna8cTCoHxs0xZoasQOg+7dg17AQ9P9JL3giIIzlhZbESR3
         sY4w==
X-Gm-Message-State: AOAM533G5BG0tI4uRUAKJ8jP1UDvngUl9R55RBnmrzjDgn8n8eMFNe98
        mF1QhuzX5X4Fcl1+30HmL+lxD8nXqg==
X-Google-Smtp-Source: ABdhPJxVg9NNkQ+U36ybEwUEw9fpDgMS3sa5RHGTzA63vPXX3SlNz9PIO0Rau04JvHGO4b32ya9n3g==
X-Received: by 2002:aca:6008:: with SMTP id u8mr5477552oib.127.1632431720768;
        Thu, 23 Sep 2021 14:15:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e2sm1644658ooh.40.2021.09.23.14.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 14:15:19 -0700 (PDT)
Received: (nullmailer pid 3536998 invoked by uid 1000);
        Thu, 23 Sep 2021 21:15:18 -0000
Date:   Thu, 23 Sep 2021 16:15:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Jiri Kosina <trivial@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 5/6] dt-bindings: hwmon: jedec,jc42: convert to dtschema
Message-ID: <YUzuZqcDTl4Akk0p@robh.at.kernel.org>
References: <20210920182114.339419-1-krzysztof.kozlowski@canonical.com>
 <20210920182114.339419-5-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920182114.339419-5-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2021 20:21:13 +0200, Krzysztof Kozlowski wrote:
> Convert the Jedec JC-42.4 temperature sensor bindings to DT schema
> format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/hwmon/jc42.txt        | 46 -------------
>  .../devicetree/bindings/hwmon/jedec,jc42.yaml | 69 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 70 insertions(+), 46 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/jc42.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/jedec,jc42.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
