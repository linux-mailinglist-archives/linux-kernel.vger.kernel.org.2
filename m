Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B922A41680F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 00:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243511AbhIWWbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 18:31:45 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:46701 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243423AbhIWWbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 18:31:39 -0400
Received: by mail-ot1-f43.google.com with SMTP id o59-20020a9d2241000000b0054745f28c69so8578145ota.13;
        Thu, 23 Sep 2021 15:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0wd54PgFVno+JC/HFzigQaGj1doCQQ9u26dCzaiPks4=;
        b=h8Be6D3zolXdPZODaOA/fCI1VSZ9SvQnRTvUddlIvQOAXCLl/T6kgTIcd3jPWfDKTO
         dIKhaozOq029c+K7cFCSO1qwol4pLeIMqD7PcQF+rMYM07r6gP15Bn4eLhwrsWVXXc1E
         7JwSYbSVdGBb8xbq6fvdqBipTSZgGOCLYM2RZbcmmj97/i9q1wqPrZ9X3r43MftqYL6D
         waZpteIsoyWlSLt9IaSWulN1ESqSbgj/dH+BxHdedxGSOs4qM0tBv8h3AjR5pEvy/1gV
         xhfJ9M7EOEXl0zU8gv2VryrImf+2B7D48owBupLAcXoFLmcdzqFadckDBVGu9HUqz9Jh
         98Kw==
X-Gm-Message-State: AOAM532OvJAQq1HEwLR/cvo+mamHQSUdo0IOR8F0SikUVTAuXuEo3/V0
        We53cSAQlG1+hLJ38i2Dmg==
X-Google-Smtp-Source: ABdhPJzB7OzB8hZjggiv41iY+eUtHtfwDS5i4q/vbmTXNgxcAOrie4BF9o+EfM/7B8sGqlTp2vWScg==
X-Received: by 2002:a9d:470b:: with SMTP id a11mr955838otf.337.1632436207380;
        Thu, 23 Sep 2021 15:30:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 14sm1616929oiy.53.2021.09.23.15.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 15:30:06 -0700 (PDT)
Received: (nullmailer pid 3641740 invoked by uid 1000);
        Thu, 23 Sep 2021 22:30:06 -0000
Date:   Thu, 23 Sep 2021 17:30:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jiri Kosina <trivial@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH 6/6] dt-bindings: hwmon: sensirion,sht15: convert to
 dtschema
Message-ID: <YUz/7qprAGbh7fu9@robh.at.kernel.org>
References: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
 <20210921102832.143352-6-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921102832.143352-6-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2021 12:28:32 +0200, Krzysztof Kozlowski wrote:
> Convert the Sensirion SHT15 humidity sensor to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/hwmon/sensirion,sht15.yaml       | 43 +++++++++++++++++++
>  .../devicetree/bindings/hwmon/sht15.txt       | 19 --------
>  2 files changed, 43 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,sht15.yaml
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/sht15.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
