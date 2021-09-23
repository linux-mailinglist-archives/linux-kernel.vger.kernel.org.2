Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8DF4167FD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 00:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243496AbhIWW1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 18:27:09 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:38643 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243491AbhIWW1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 18:27:08 -0400
Received: by mail-oi1-f180.google.com with SMTP id u22so11839802oie.5;
        Thu, 23 Sep 2021 15:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HhFMiNAtzktgelDJMRh6J8mQ6oa3kr8f3NRqH7OdArE=;
        b=wEYMeodNLbLi6Dv5hIuiVpX7s7brRGJv7s8EaYP62yWuWhgY/wIT7bT0CUySRTe69u
         ycWq2Y9W27qRtmPmhmOjhiq7CqFV1ZfKU22akH0rfWtB93jFhg/dxsh7Ry7kWsjkmjKv
         ++YxC+yJQ7UCxRlt+NFd3F2v8jdIzSdiDWauCN4IGKmFg/MICxNC93cPnx35bLgvfsMt
         i9kW1OuyvGTQ0yBa1MSpnJIvvjJ6K1zotQf7JGk9lEzN4PZhUE8UULT2rO7k1EZPwSxJ
         /FpuOPYWh5/XXB2xBONO35PNzauOhO9zTwmf6Fg6adatBTJQ9qwNJSl0SwM4f5Z2Dd16
         TR5g==
X-Gm-Message-State: AOAM5329e8Lw4NnKt0btm8XFb3+9vh9gU7gIYspKGSkdLMoapJlSjGyt
        2k1cH+7aCbkI9RnFj+WyAw==
X-Google-Smtp-Source: ABdhPJwTRFCrH3tw93X5LfDSYDM9V7ydA4B+oWGaoBg+c0kqA8ojDuZo30BX87QDIVyZ5PlLkmxrKA==
X-Received: by 2002:a54:489a:: with SMTP id r26mr2738379oic.158.1632435935864;
        Thu, 23 Sep 2021 15:25:35 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v2sm1700100ooh.28.2021.09.23.15.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 15:25:35 -0700 (PDT)
Received: (nullmailer pid 3635421 invoked by uid 1000);
        Thu, 23 Sep 2021 22:25:34 -0000
Date:   Thu, 23 Sep 2021 17:25:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <trivial@kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: hwmon: ti,tmp102: add bindings and
 remove from trivial devices
Message-ID: <YUz+3uoaoSlu0xaq@robh.at.kernel.org>
References: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
 <20210921102832.143352-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921102832.143352-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2021 12:28:28 +0200, Krzysztof Kozlowski wrote:
> The TI TMP102 temperature sensor does not fit into trivial devices
> bindings due to additional properties.  Add separate bindings for it.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/hwmon/ti,tmp102.yaml  | 47 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  2 files changed, 47 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
