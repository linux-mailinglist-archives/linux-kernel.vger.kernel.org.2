Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D64C3EF409
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 22:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbhHQU2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 16:28:34 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:33336 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhHQU2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 16:28:33 -0400
Received: by mail-oi1-f169.google.com with SMTP id n27so1082680oij.0;
        Tue, 17 Aug 2021 13:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rjhi87l6/w+/P962vY2ZGzukN6DuCOJ2CH0XWyVvt40=;
        b=X6VeDfiLK+HxsdAmosBaRFpmSTm/incqTYu3HsYba5V2H1OpNEpayv7ZELnPEnrQQs
         RJcCFZ45Jplkp7YADZVEZ11SHVHWhnpkbTNTUu56o+zfvT5WPkrNLxqSVMI3bQqnlwhL
         3MDtS8geLygHKaxg4ycQPvGvWK7FW4DCMaMJNKBpMOcaubBwgnUFHRTV2FFnRhCvOWxk
         WrfAXXKE5c0gL7zfz7FVkdcGLCp4CsqMSJFoD6QuKzwagcIVRP891wpDxMP0d5Ag2xaf
         LiQkM3HelqSnlO45hO3KblLrUyuSJPS+bgL/PwVKCD5xH/1yiY/7u8f/2nwukB5SeXHY
         14Jg==
X-Gm-Message-State: AOAM533PD8QTDLA7Wys7iOJAaIVbCL8NPGCDb2WNnlKoi+TByKnY0Xhw
        nw6ZwOB462bAY8RFeUudLA==
X-Google-Smtp-Source: ABdhPJwv/9QnEIj8A3PE3LKgBldQYunD/YuwLLutOtEHIYEdDK7sVGuf1Fa8kpw+p8Nd31U4HFq3bA==
X-Received: by 2002:aca:bd8b:: with SMTP id n133mr4023748oif.75.1629232079512;
        Tue, 17 Aug 2021 13:27:59 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z26sm722154oih.3.2021.08.17.13.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 13:27:58 -0700 (PDT)
Received: (nullmailer pid 784061 invoked by uid 1000);
        Tue, 17 Aug 2021 20:27:58 -0000
Date:   Tue, 17 Aug 2021 15:27:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: amlogic: add support for Radxa
 Zero
Message-ID: <YRwbzripmlsoG3Fp@robh.at.kernel.org>
References: <20210810102613.25149-1-christianshewitt@gmail.com>
 <20210810102613.25149-2-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810102613.25149-2-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2021 10:26:12 +0000, Christian Hewitt wrote:
> Radxa Zero is a small form-factor SBC with an Amlogic S905Y2 chip.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
