Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C17398FE5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 18:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhFBQ03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:26:29 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:36756 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFBQ01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:26:27 -0400
Received: by mail-oi1-f176.google.com with SMTP id a21so3219780oiw.3;
        Wed, 02 Jun 2021 09:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=53S/fFCs9+Nn0oXITnfIPS9D5tUEwRl/Jdla/qwUi0A=;
        b=DazfuXnm8GVEecOOdHbbWg4FSuZKgx0vdx9xZPrtpfeUq9TB4qP4EB7SoGvT9RgL8k
         epLbJXoCx6lXseMmadKHOn0b4nWHYgxEp58n93XaIuj8OMeqGwEE4kJVxXhjoIbpxO5t
         3x5YymDx8JE45YW1W4k8x1EL6rKIDdXY9TFojdk8COOSkvUHNozcyCRLE1/JD0267OA3
         hQzjCY7dZ9Xstoom5AMNX43/ZdVNP1ljeSNW02IiIZ4TeBchEUeViuQrqfbntee0nX59
         tJNj9n3zxYtaFLgBbh9gtt+remYSRnDce1igaHr//eCHrncteFsMXLwMmdJkjlqK22O0
         yHoA==
X-Gm-Message-State: AOAM533EloZt3r9PA8nFkK4zTnyjwjyVp5Zq5gyZIBEW/B1JObCy4Svi
        tSNhKehsiKiJl4UhRJZTq3VGvUK2Ag==
X-Google-Smtp-Source: ABdhPJzVP4mIHE0ZmQug3GtJrRBii4GJlgiykQxMxIoZudo673B7gCzQsGIdiWnhunSOC9LV4vTRHw==
X-Received: by 2002:aca:b784:: with SMTP id h126mr4311771oif.98.1622651083682;
        Wed, 02 Jun 2021 09:24:43 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f1sm89873oto.40.2021.06.02.09.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 09:24:43 -0700 (PDT)
Received: (nullmailer pid 3500509 invoked by uid 1000);
        Wed, 02 Jun 2021 16:24:42 -0000
Date:   Wed, 2 Jun 2021 11:24:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [RESEND PATCH] dt-bindings: arm: intel,keembay: limit the
 dtschema to root node
Message-ID: <20210602162442.GA3500424@robh.at.kernel.org>
References: <20210526162750.135139-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526162750.135139-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2021 12:27:50 -0400, Krzysztof Kozlowski wrote:
> From: Krzysztof Kozlowski <krzk@kernel.org>
> 
> The check for the board compatible should be limited only to the root
> node.  Any other nodes with such compatible are not part of this schema
> and should not match.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> ---
> 
> Hi Rob,
> 
> Can you take it directly?
> 
> Best regards,
> Krzysztof
> 
> 
> ---
>  Documentation/devicetree/bindings/arm/intel,keembay.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
