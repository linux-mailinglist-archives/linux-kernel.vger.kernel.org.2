Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D78413906
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhIURqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:46:44 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:38421 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbhIURqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:46:40 -0400
Received: by mail-oi1-f180.google.com with SMTP id u22so291761oie.5;
        Tue, 21 Sep 2021 10:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BPCfoCM1F77FKIJgOPAAqMaAIQkoOT5dw2aKLimvk3U=;
        b=Dt5pXygOoR0hHQ2IM7ODLfFSKN+NExAl5r2juKN4nM3UkyAwiL8O4JFH2SQrwWD+pN
         3FLh8XI+K2gkdKLiGoi5pCn0OiRIYHHiltktkKrDjO8hs/cdXAE9qZui6zlOoSKpVoxy
         41IjDuQjn+RyQupIwCrl+DucroPqMbFnUMjbBT+6nb697U2y74lLj2rQ7WKNeIig+t7Q
         OowSfgfDUKT4ZEsG7WRtX289P4GTv6qaYVI/zbkYV+59BVGwQmtt7qvhoR3yr6jl57vo
         2QGvcjOeo/6zEu+hY57R5V0ieC2nWzEhNKhpI8CBui1jW3yt6bQDMQQiklwpITwRAQch
         LkDw==
X-Gm-Message-State: AOAM530e2Gp6UZAw811EfnVV/UcekJddF6mGIhs30JZepAkTnznnd3/1
        oyPhSeQbP9ySY4gUyvKCLuT+P2kUtw==
X-Google-Smtp-Source: ABdhPJziN+dX23OBHWWp2Sh5tDcknX8PwlnGu4aAbkxurvumjURn9ooaFoUgmjN1BDLf2cNhIM6WhA==
X-Received: by 2002:aca:2218:: with SMTP id b24mr4631303oic.55.1632246311022;
        Tue, 21 Sep 2021 10:45:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a9sm1023376otk.3.2021.09.21.10.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 10:45:10 -0700 (PDT)
Received: (nullmailer pid 3026304 invoked by uid 1000);
        Tue, 21 Sep 2021 17:45:09 -0000
Date:   Tue, 21 Sep 2021 12:45:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tglx@linutronix.de, maz@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: microchip,eic: add bindings
Message-ID: <YUoaJTGF5zyLyOEY@robh.at.kernel.org>
References: <20210910060656.1061234-1-claudiu.beznea@microchip.com>
 <20210910060656.1061234-2-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910060656.1061234-2-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2021 09:06:55 +0300, Claudiu Beznea wrote:
> Add DT bindings for Microchip External Interrupt Controller.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../interrupt-controller/microchip,eic.yaml   | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/microchip,eic.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
