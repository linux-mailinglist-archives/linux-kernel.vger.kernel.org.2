Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A4B3997C3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 03:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhFCB4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 21:56:20 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:35667 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCB4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 21:56:18 -0400
Received: by mail-oi1-f174.google.com with SMTP id v22so4742963oic.2;
        Wed, 02 Jun 2021 18:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5REQDOInYr+Rxz1Hbv6uToT1N9uIZqHL7TEfsvN/SsI=;
        b=J/6igK7mF37CqBPQZOipUyxkssIU402nVi6+zXqw27rO2T6YA9zKhRelS0bm18UwYh
         yojWCZ+IOmZDppVllR01fCbIndUuBp3Lc/n2w9gpN82nqjB4UYpvd0rh2ZPeUjRs/o7m
         yRf0O59iBWESrqINQsO/yKQAQJzwZv6VQ1BEFEaBSiUWxWWA565deHFfsYtAQAtwLmal
         POCSgUvJDj9+4nTOGVFoD8PAaIADB77+lFMk7Whv7dWE2GYUWFg7mxzUiIu/S2ysLwHq
         urA+EEFvR2VPHcbMGqZC9J6phTcmJx/yELDeAQbFoDC+5Px3DN/HWAicIUyHLXeCZdgK
         qfVg==
X-Gm-Message-State: AOAM533tbh5vwLeTxCsnyzMJNIRkid9hkFxi9GgG+FIM1wbgqSTyLKbv
        sJN6v+3Ke4uPXk3Jh9eVnQ==
X-Google-Smtp-Source: ABdhPJxBGswFS8v+XqMBHoWogwVlR6GsKdAifZEzB0x0rZK9KvzU/6hbXOChq/jsdSef8Qr7NwM5Vg==
X-Received: by 2002:aca:fc84:: with SMTP id a126mr5806199oii.49.1622685274188;
        Wed, 02 Jun 2021 18:54:34 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u6sm377910otk.63.2021.06.02.18.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 18:54:33 -0700 (PDT)
Received: (nullmailer pid 378697 invoked by uid 1000);
        Thu, 03 Jun 2021 01:54:32 -0000
Date:   Wed, 2 Jun 2021 20:54:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/12] dt-bindings: power: supply: cpcap-charger: update
 cpcap-charger.yaml reference
Message-ID: <20210603015432.GA378600@robh.at.kernel.org>
References: <cover.1622648507.git.mchehab+huawei@kernel.org>
 <e9ce216362b7b9dcf84d707a3854247123440bf7.1622648507.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9ce216362b7b9dcf84d707a3854247123440bf7.1622648507.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jun 2021 17:43:08 +0200, Mauro Carvalho Chehab wrote:
> Changeset ce49e4282200 ("dt-bindings: power: supply: cpcap-charger: Convert to DT schema format")
> renamed: Documentation/devicetree/bindings/power/supply/cpcap-charger.txt
> to: Documentation/devicetree/bindings/power/supply/cpcap-charger.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: ce49e4282200 ("dt-bindings: power: supply: cpcap-charger: Convert to DT schema format")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/motorola-cpcap.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
