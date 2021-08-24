Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8BE3F5DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 14:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbhHXMYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 08:24:52 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:38766 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhHXMYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 08:24:51 -0400
Received: by mail-ot1-f45.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso34210440ots.5;
        Tue, 24 Aug 2021 05:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YOpisWwE2AtZUvDm9pU+nX/33+ebZs5q4FxhHFD85u4=;
        b=kf7NamiL14sz6rOFEtSw5QaD53JYPdRjHj+v7RWtcXfsZoIJYzg+nlvRyVhss58Hb8
         yn1168g2wVwxwDuTyYgFoCixtNuKkfdhi7LmPTOpSOBAEvgtEqtxUdZT4rn6dJFQ34yu
         kvZmFHs3CcPmj/v2enFSDNFqKgzPeJnJhF6bPD2iQoCH6ThKTPyKnkbxkDj8lzMpglYU
         y5jnsaddMxuicweXeiAfdBGaclnAsG6tRGZE7dCSKLnPydCZHWX4a18ApbFl4lIUzOuu
         +6cW3lgnk3+8yCuqMULbK4Av7phnP5AMTLMkCQMpoXpssg6UdzB4vZ6gIDBoxW3xsxcI
         6DHQ==
X-Gm-Message-State: AOAM533TyFwguQVTysajfNxRs1jKiHtPuWJX5MS9g747FgVI0GvCrD/8
        mJjPzXcLmyjzqlUL8vSAbw==
X-Google-Smtp-Source: ABdhPJwVBjO0Ez+4iwU9v9RKrH3MYflFy6b7Ssq2UV4pK3ZXl9j2oQAbFWwrK9+S0RBdlPW9ZwR3nQ==
X-Received: by 2002:a9d:17c2:: with SMTP id j60mr33147836otj.128.1629807847166;
        Tue, 24 Aug 2021 05:24:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z26sm4362417oih.3.2021.08.24.05.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 05:24:06 -0700 (PDT)
Received: (nullmailer pid 51545 invoked by uid 1000);
        Tue, 24 Aug 2021 12:24:05 -0000
Date:   Tue, 24 Aug 2021 07:24:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     ulf.hansson@linaro.org, alexandre.belloni@bootlin.com,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v3 1/4] dt-bindings: pwrseq-sd8787: add binding for
 wilc1000
Message-ID: <YSTk5cbpne4QPazI@robh.at.kernel.org>
References: <20210820092803.78523-1-claudiu.beznea@microchip.com>
 <20210820092803.78523-2-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820092803.78523-2-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 12:28:00 +0300, Claudiu Beznea wrote:
> Add binding for wilc1000 devices.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
