Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F2A36100C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 18:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhDOQWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 12:22:40 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:34436 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhDOQWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 12:22:36 -0400
Received: by mail-oi1-f170.google.com with SMTP id k18so19909575oik.1;
        Thu, 15 Apr 2021 09:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d/9SSe9qd76j3w/26tWnM9Z02p15+WwuG2Knfg+0n4s=;
        b=hdh4Th3wA+wRxuR7Je/bM6fb8IuoKOCDo0hK3d3HU9doWjuBGO2Vaba2yQdDpVuDi0
         FElJwI3P7sb5tggARlO7uQG9CrlMBHuZv/L0ixEIP+QHRCyv/aBemwpMUhPgo2wk3QNu
         pSdkuZ8aJwW4P9leo0QEV6WMQ7HOImo/4VubsjuukThr/rPGB3p9y/VM7Q45exJMYpQv
         vzhRHee04iVAdjrYQcbojpPj+6N4iDKfMRuxMJkWLHZcw6djN7+tLeP35r5dDMzyzRkB
         yFADqygdJhGz4TCxBC/6B0phS7yZQLaWqQP/VnApXbZp2/og3FQzodn8sdzT6bykqHpV
         y6fg==
X-Gm-Message-State: AOAM531WTsXkRMZWK/ngmUmwUHWq0vLhXikv+rP8zu8pg1W5cUbexvE0
        V11Fmy3kw7UTW5tHGdKvFg==
X-Google-Smtp-Source: ABdhPJz/joP0ivmfqTjdzeEFa3WPY4cCr6cMFUQUdkSY3DpUdPQyNScyGlDoY4gcKaJ2jEHokIejNw==
X-Received: by 2002:aca:5dd4:: with SMTP id r203mr3171331oib.6.1618503732015;
        Thu, 15 Apr 2021 09:22:12 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f12sm749230otf.65.2021.04.15.09.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 09:22:11 -0700 (PDT)
Received: (nullmailer pid 1510943 invoked by uid 1000);
        Thu, 15 Apr 2021 16:22:09 -0000
Date:   Thu, 15 Apr 2021 11:22:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Kyle Tso <kyletso@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/3] dt-bindings: connector: Add slow-charger-loop
 definition
Message-ID: <20210415162209.GA1510914@robh.at.kernel.org>
References: <20210414142656.63749-1-badhri@google.com>
 <20210414142656.63749-3-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414142656.63749-3-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021 07:26:56 -0700, Badhri Jagan Sridharan wrote:
> Allows PMIC charger loops which are slow(i.e. cannot meet the
> 15ms deadline) to still comply to pSnkStby i.e Maximum power
> that can be consumed by sink while in Sink Standby state as defined
> in 7.4.2 Sink Electrical Parameters of USB Power Delivery Specification
> Revision 3.0, Version 1.2.
> 
> This patch introduces slow-charger-loop which when set makes
> the port request PD_P_SNK_STDBY_MW(2.5W i.e 500mA@5V) upon entering
> SNK_DISCOVERY (instead of 3A or the 1.5A during SNK_DISCOVERY) and the
> actual currrent limit after RX of PD_CTRL_PSRDY for PD link or during
> SNK_READY for non-pd link.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
> Changes since v3:
> * Removed additional semi-colon in the subject line
> Changes since V2:
> To address Rob's comments
> * Updated commit and the binding description.
> * Updated subject as well.
> ---
>  .../devicetree/bindings/connector/usb-connector.yaml   | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
