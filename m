Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2127E35A5EA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbhDISiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:38:20 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:40926 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbhDISiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:38:19 -0400
Received: by mail-ot1-f41.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so6594326otb.7;
        Fri, 09 Apr 2021 11:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6WpzY8UUDISV6xZLMz1SDYJJM0LsXpA8karXEZ8KMj0=;
        b=P2dcIE36auEzIBkSi6i26yPJrvlZK5xe3m4miAEwjABYQT6RSTT/heV8WgCJlM2B29
         hwgAR0azNawd7eMmrHqzEJdAHhPWa4HTVeniBISlwO7wDBSeZ5cAnJfQghkSdOLGCAkz
         TnEnU9Ayqbbr3PuDW+HVkjyfWTXtXJivwNGmwPCH6vgg+sW01qa5jFyv/tQVA7A8VdRL
         Xnk31If5fREcQx8WexatJ7A95030p+98wyT33yA0+mV+8nVIk9olr85be1fvBG58apB4
         uqYeYdXjtLser+k32D8NCl/MGwsk2wxMQt5Q9jnvRPVFZVBTuhfyxg3MN4g+uQv+EkNm
         X8Mg==
X-Gm-Message-State: AOAM533U81V1IaQBd0IWwm+9dyQIt7ziBeo+WFEoXc+CTQLD+HjiUWvP
        xZvusQmMPsZ23tU5JrBS+g==
X-Google-Smtp-Source: ABdhPJzdAr1yBws4pgNus0fHyGlM0zYfP3P4oRkVJuCImaU+OqrhOPcN+nIjqkEmYCoKuO4hM0DnwQ==
X-Received: by 2002:a9d:6c52:: with SMTP id g18mr12892485otq.29.1617993485451;
        Fri, 09 Apr 2021 11:38:05 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m129sm663748oif.34.2021.04.09.11.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:38:04 -0700 (PDT)
Received: (nullmailer pid 3932693 invoked by uid 1000);
        Fri, 09 Apr 2021 18:38:03 -0000
Date:   Fri, 9 Apr 2021 13:38:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v2 6/6] Documentation: connector: Add slow-charger-loop
 definition
Message-ID: <20210409183803.GA3928012@robh.at.kernel.org>
References: <20210407200723.1914388-1-badhri@google.com>
 <20210407200723.1914388-6-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407200723.1914388-6-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 01:07:23PM -0700, Badhri Jagan Sridharan wrote:
> To allow slow charger loops to comply to pSnkStby requirement,
> this patch introduces slow-charger-loop which when set makes
> the port request PD_P_SNK_STDBY_MW upon entering SNK_DISCOVERY
> (instead of 3A or the 1.5A during SNK_DISCOVERY) and the actual
> currrent limit after RX of PD_CTRL_PSRDY for PD link or during
> SNK_READY for non-pd link.

What are 'slow charger loops' and pSnkStby?

'dt-bindings: connector: ...' for the subject. Follow the pattern you 
see with 'git log --oneline' for a directory.

> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  .../devicetree/bindings/connector/usb-connector.yaml       | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index b6daedd62516..09ad3ad983a6 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -197,6 +197,13 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [1, 2, 3]
>  
> +  slow-charger-loop:
> +    description: Allows slow charging loops to comply to pSnkStby. When set makes
> +      the port request pSnkStby(2.5W - 5V@500mA) upon entering SNK_DISCOVERY(instead
> +      of 3A or the 1.5A during SNK_DISCOVERY) and the actual currrent limit after
> +      reception of PS_Ready for PD link or during SNK_READY for non-pd link.
> +    type: boolean
> +
>  required:
>    - compatible
>  
> -- 
> 2.31.1.295.g9ea45b61b8-goog
> 
