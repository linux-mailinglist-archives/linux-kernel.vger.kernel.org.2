Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027F23613CC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 23:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbhDOVAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 17:00:18 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:39501 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbhDOVAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 17:00:15 -0400
Received: by mail-oi1-f175.google.com with SMTP id i81so25669350oif.6;
        Thu, 15 Apr 2021 13:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7mGMuPtccSuN83Y4SSY9hXYKt6fW+rM8hyYTNMYHq0U=;
        b=fPpJvhpssqRHF2wzzmnV1Iu/gp6DHreH2YOhnZUOwZm2UgS20tFLUIdMRRNfTDyrIc
         LnQQQ0RYAhprTZFeIprmzZ2H1PRidG52OLABMQJoJcQwFN1ZTQCaZvbx9UaoJjQsjoqg
         +dqJtoGjLJMpPwqdLt1W2Xz494e2PftElAx/HuncGixfPRr8mdqCtGS9Qxsec6ODswv2
         DiAPLBwNwM3W2gpfaUTb9+Rx3/GAdFu2TtKrI5RWnzsdV7Ir10HwGjKtc169NiDy8WIy
         sM2u8EEDou/bY6ZUBbZOb35KZ5uQ3eC6oz79DVfpljMcMl1xeA1S0cE0JoGL6ycXcp5h
         svAQ==
X-Gm-Message-State: AOAM530iUYYqy9SF7sP8cWlchNs9oOUaWiZWnmZrnSwDy14J7qoUryBi
        CLFO3Pul0GSSFaWx4PkXKg==
X-Google-Smtp-Source: ABdhPJw2k2YwivWYCgq6XP9+mYQZvcd7jcDxyuLTvkx4ro7eLday2daD8QuolWy9Vt1ZS3dYDG5S5g==
X-Received: by 2002:a05:6808:14c8:: with SMTP id f8mr4016531oiw.55.1618520391545;
        Thu, 15 Apr 2021 13:59:51 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 79sm29256oty.76.2021.04.15.13.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 13:59:28 -0700 (PDT)
Received: (nullmailer pid 1871299 invoked by uid 1000);
        Thu, 15 Apr 2021 20:59:07 -0000
Date:   Thu, 15 Apr 2021 15:59:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v3 16/24] dt-bindings: atmel-sysreg: add bindings for
 sama7g5
Message-ID: <20210415205907.GA1871251@robh.at.kernel.org>
References: <20210415105010.569620-1-claudiu.beznea@microchip.com>
 <20210415105010.569620-17-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415105010.569620-17-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021 13:50:02 +0300, Claudiu Beznea wrote:
> Add RAM controller and RAM PHY controller DT bindings.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../devicetree/bindings/arm/atmel-sysregs.txt      | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
