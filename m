Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D882243CF38
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243141AbhJ0RBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:01:30 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:40753 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243102AbhJ0RBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:01:21 -0400
Received: by mail-ot1-f52.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so4486596otr.7;
        Wed, 27 Oct 2021 09:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xXiPHa4TA9EYEoRX25TcNS6AEt1DojwiuVZSZr83YMg=;
        b=gRKBNne1y0PT2nikxYn5sIu+E9wpzUT6su5IKwn/UWweBK8MbOdRXNmYA842iShKSI
         j6LscxhpKlyx2ZNRRp81rfwU/Kd1F9YRC0xVttityeBbRqX/kKrgXbalYiJqvQ191xFT
         0QJfZFZ4pSSsa4APMU5wbBKILMEYcyGgJa3Ichgny8AnFwAjwevOtucr+fZw9lhgEerU
         E2VFwSU6MSohwp7tecelBsTO6MhK5oW6v8Nwyg+6Et/d/cso9TgQrk5/1NIHDtIPYR+C
         scLUDNDCr5UFLBCufhY88RpdvVIKB0KYr7ZHovsPWQd0CEJYcCPn5LKuQkzy7EuD9l85
         TIeA==
X-Gm-Message-State: AOAM532m0ujxvs0bGPr6o8rAd4HYh7ES2Mn6U671upfTaP6Ce2G2Q9mw
        IR0M1VBzRky8wRjIn/py54/0QDK7/w==
X-Google-Smtp-Source: ABdhPJyicMSFZbe/jiYgHOSHUitLrp7UQjTAXu0BY1znPC7C6n9LXsigkQOr7bGeVFYibZqG25BvMA==
X-Received: by 2002:a9d:d68:: with SMTP id 95mr8478889oti.377.1635353935867;
        Wed, 27 Oct 2021 09:58:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e25sm158256oot.38.2021.10.27.09.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 09:58:55 -0700 (PDT)
Received: (nullmailer pid 1673955 invoked by uid 1000);
        Wed, 27 Oct 2021 16:58:54 -0000
Date:   Wed, 27 Oct 2021 11:58:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oskar Senft <osk@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: hwmon: Add nct7802 bindings
Message-ID: <YXmFTtKXd52eKsh3@robh.at.kernel.org>
References: <20211020164213.174597-1-osk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020164213.174597-1-osk@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 12:42:12 -0400, Oskar Senft wrote:
> This change documents the device tree bindings for the Nuvoton
> NCT7802Y driver.
> 
> Signed-off-by: Oskar Senft <osk@google.com>
> ---
> Changes from PATCH v7:
> - Implemented review comments:
>   - Added blank lines to increase readability.
>   - Moved "additionalProperties" up to increase readability.
> 
> Changes from PATCH v6:
> - Fixed formatting error reported by yamllint
> 
> Changes from PATCH v5:
> - Refactored to use patternProperties.
> - Added validation for sensor-type and temperature-mode.
> ---
>  .../bindings/hwmon/nuvoton,nct7802.yaml       | 145 ++++++++++++++++++
>  1 file changed, 145 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
