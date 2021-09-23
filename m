Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9448416806
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 00:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243465AbhIWWa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 18:30:27 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:45949 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239507AbhIWWa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 18:30:26 -0400
Received: by mail-ot1-f46.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso10579874otv.12;
        Thu, 23 Sep 2021 15:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8LuhT+hwUfGfKsdp2p0Zj6c1iUcRHgKSeaQyIG39eWk=;
        b=hgrc9nO7t8PxN7REWHfEHHinOmGiwJhVkun0Vivqwt9X+l6UUzRKqsnugVw3A7SkV/
         U+aii75N7+x47lu3SBw8rgTViyEsXQ0WugTS8y2JJw+0U1kKqpykJqgxmS0DzX4fZbYp
         QdzidUmTdSp2snbxfDTYjAVSKqm+4o5DLcT1vWjpO7C82RV+q4M9vHb34XF7lGMKyzxI
         B2ad2GzF9yecBfhmYeV1stAvVNDNSWD0xEhKaXPEdCz6bE4QG5aulUW4ImFYiElfW4CA
         DyGgUkPLhnMiP/PxsNo+MBEye44U1KUzC0Yba5lMFt89z9ehqOmoBSMewe5pdqcNcI/j
         iolg==
X-Gm-Message-State: AOAM531xObr7L+xyhkNQoUCqVRTu8p6XHMsz5CFVxQBEXluqmr1XuvaC
        vY+DHkiVYa/TOrjuyiOE4g==
X-Google-Smtp-Source: ABdhPJwQtmUke5bqMoNe/7yPXWnQlFibQPHA+ia3CLW7T2vLndFGguShmCzGzj0aYdzujx03U9qVXA==
X-Received: by 2002:a05:6830:40cb:: with SMTP id h11mr1019749otu.176.1632436134235;
        Thu, 23 Sep 2021 15:28:54 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y12sm1562748otu.11.2021.09.23.15.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 15:28:53 -0700 (PDT)
Received: (nullmailer pid 3639888 invoked by uid 1000);
        Thu, 23 Sep 2021 22:28:52 -0000
Date:   Thu, 23 Sep 2021 17:28:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org, Jiri Kosina <trivial@kernel.org>,
        devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 4/6] dt-bindings: hwmon: lltc,ltc4151: convert to dtschema
Message-ID: <YUz/pI2Nn7pEEqVP@robh.at.kernel.org>
References: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
 <20210921102832.143352-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921102832.143352-4-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2021 12:28:30 +0200, Krzysztof Kozlowski wrote:
> Convert the LTC4151 current and voltage sensor bindings to DT schema
> format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/hwmon/lltc,ltc4151.yaml          | 41 +++++++++++++++++++
>  .../devicetree/bindings/hwmon/ltc4151.txt     | 18 --------
>  2 files changed, 41 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/lltc,ltc4151.yaml
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/ltc4151.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
