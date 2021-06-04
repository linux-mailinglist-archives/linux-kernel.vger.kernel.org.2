Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC1339C1B3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 22:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhFDU45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 16:56:57 -0400
Received: from mail-oo1-f44.google.com ([209.85.161.44]:38722 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhFDU44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:56:56 -0400
Received: by mail-oo1-f44.google.com with SMTP id o66-20020a4a44450000b029020d44dea886so2551035ooa.5;
        Fri, 04 Jun 2021 13:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z4eBPRewUmZbrRr0u/ml79wEbFbzXyZBVVGIi7p60to=;
        b=NV0fzji+JRSbMc9cdwGZIhFAh1NF3NQbdAuwWsK4NiQT83EPNJeUEGz+Ssy9NE66Oi
         pssfRCRPYbwdB81yqIGCkj1CDPAv4NbWm9+SY6cPnVE0jd4h0jKJAIR3niRSeW9Ewjow
         W89thiyh5dS0FNKfXTAy4BCFJT+PXTQrqfQhBy7o/dCMhTlQ1mctIK4Bj48AvpJgnb8h
         Jt/qWVmJT/5+zVQu8Dyv5eDPPVjHwKtVH89ZChei9HVeHlrQU55ZvCK1pIBtw2mEMlzL
         cIt07C0yS1vGoORP+ZwmHhl1U1xi8s2vg8jaJUJJogrFodG2gG4suLJTu/C28otPrSpV
         pePA==
X-Gm-Message-State: AOAM532QL38efElXF3/WcLXUmNRhofs89r/9BJ8NFq9nfWLXAs9w+UKg
        E1BDjCCffo7m2ZxDyvOARg==
X-Google-Smtp-Source: ABdhPJyDQ+0FKy+gM3GzZgZvov9BF3UaiCP8vEVNUljLo4vmGEUfYskWYbC+ZDC4FBBihY8Kg7h5Pg==
X-Received: by 2002:a05:6820:100a:: with SMTP id v10mr5032044oor.55.1622840109774;
        Fri, 04 Jun 2021 13:55:09 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z25sm706005oic.30.2021.06.04.13.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 13:55:09 -0700 (PDT)
Received: (nullmailer pid 3899660 invoked by uid 1000);
        Fri, 04 Jun 2021 20:55:07 -0000
Date:   Fri, 4 Jun 2021 15:55:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        devicetree@vger.kernel.org,
        Aswath Govindraju <a-govindraju@ti.com>,
        linux-usb@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: usb: cdns,usb3: Fix interrupts order
Message-ID: <20210604205507.GA3899579@robh.at.kernel.org>
References: <20210527193952.1705127-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527193952.1705127-1-geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 21:39:52 +0200, Geert Uytterhoeven wrote:
> Correct the order of the descriptions for the "interrupts" property to
> match the order of the "interrupt-names" property.
> 
> Fixes: 68989fe1c39d9b32 ("dt-bindings: usb: Convert cdns-usb3.txt to YAML schema")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  Documentation/devicetree/bindings/usb/cdns,usb3.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
