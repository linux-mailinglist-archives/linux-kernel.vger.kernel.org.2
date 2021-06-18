Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6993AD421
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 23:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbhFRVIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 17:08:53 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:47087 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbhFRVIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 17:08:49 -0400
Received: by mail-oi1-f178.google.com with SMTP id c13so11940859oib.13;
        Fri, 18 Jun 2021 14:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w7lyGyrFAML0Yig1eUfs9PBn3aotrCMVHhnAEEshvHs=;
        b=LeTtj3P7lcT9+cgAKfApex2m3T2imyCXaH7GL9mzgX+h2HsLB6NDkPP0yYkwFUqcm7
         zjh6P4Gz583PAdrT8LJKR1Ewv/eLp7Xl7eNylRywTetYc1lG35Kkp7s9V0VzvDiFzXxr
         QczGLszwYIyFhgASdfn/89F7gL8IOVsZjMpDWPDUWKWHYCAM36nVzGCet+qnGy0E0+az
         kbeaf3FUj5UlgKI+qDhx7+TXsO/fYmyvxnHlQJlxlUoEH2rOoMKw5hYWCjRQ/byyOCTE
         VNfDoR/PzuWOYi85CUdC+B48crKarkD8QNaWNbEfGZmQRBDTeOij6A2pH35OvvazHIrb
         Yvzw==
X-Gm-Message-State: AOAM533oqfG+VJrt8PB169/889GCcMaCDiCIREYKbPsMYvEMNpxImwks
        CBs+KeAt0bKMA3Q+4QjlEA==
X-Google-Smtp-Source: ABdhPJy9BVM8JnW1fklyNIsJf+HjmUAJv6l+X1dfrWJd5kHxG8MZpWxMuP+Z3rmPjas11wLLEtoWDg==
X-Received: by 2002:aca:fc91:: with SMTP id a139mr15981093oii.12.1624050398597;
        Fri, 18 Jun 2021 14:06:38 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id 129sm2063231ooq.34.2021.06.18.14.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 14:06:37 -0700 (PDT)
Received: (nullmailer pid 2874290 invoked by uid 1000);
        Fri, 18 Jun 2021 21:06:32 -0000
Date:   Fri, 18 Jun 2021 15:06:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, soc@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v1 2/4] dt-bindings: vendor-prefixes: Add an entry for
 SKOV A/S
Message-ID: <20210618210632.GA2874235@robh.at.kernel.org>
References: <20210609121050.18715-1-o.rempel@pengutronix.de>
 <20210609121050.18715-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609121050.18715-3-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Jun 2021 14:10:48 +0200, Oleksij Rempel wrote:
> Add "skov" entry for the SKOV A/S: https://www.skov.com/en/
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
