Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E80442141
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 21:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhKAUEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 16:04:33 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:34668 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhKAUEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 16:04:31 -0400
Received: by mail-oi1-f178.google.com with SMTP id w193so26633858oie.1;
        Mon, 01 Nov 2021 13:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vKbU3K+WrEp4o3QSdl7uJ5u0m9E6kBLDNmgHPy+kDDM=;
        b=u7ot7sA50uXMPix8B+B1TXNVaK0O9tjeMgI2RlSJSYpIny15K7NKzNv4hq3GqqA3nd
         EzpCcMMSz7PyGoci7XvAW2pzZaGas+Atu1DwCOn7rMPENEAHkYR8UDCfSkZw2kef/IJC
         p4SKd1GxeWDND2htcLzRN0+XG2tbnKzBNyNmTlVnJ1GIm4I2krwcbmeY3wub7CtEhxaN
         qKxK+FEwWB3PY5R6/xMDb5R8T5AX4byG91LH6imUHO3dnMkfygRgkKOq5SnjxfFFlVgt
         0tAnz10Y5YwJxDZpscMSDOeNp9ArwYaBvLG6c+nabkBk8CXfTsDKuKDacuw2TC+vHugZ
         VTcg==
X-Gm-Message-State: AOAM53317AZDxMIypndxoWJBBvrggEUhc4hPZwhb0TbfAUfldAiKbXVP
        avXb+PIkdcOfJnxvzIA9NA==
X-Google-Smtp-Source: ABdhPJzu9huACWQR3JSRs6TW0bAUKDyIXz9rtmEFdctQS4TyLEu9YE4GVHGZhVUykEvaSkqL5HdO7w==
X-Received: by 2002:a05:6808:2201:: with SMTP id bd1mr1004520oib.73.1635796917384;
        Mon, 01 Nov 2021 13:01:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g15sm4551923oiy.8.2021.11.01.13.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 13:01:56 -0700 (PDT)
Received: (nullmailer pid 943361 invoked by uid 1000);
        Mon, 01 Nov 2021 20:01:55 -0000
Date:   Mon, 1 Nov 2021 15:01:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     tommy-huang <tommy_huang@aspeedtech.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, daniel@ffwll.ch,
        BMC-SW@aspeedtech.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, airlied@linux.ie
Subject: Re: [PATCH 4/4] dt-bindings: gpu: Add ASPEED GFX bindings document
Message-ID: <YYBHsy3Ed3Ss9281@robh.at.kernel.org>
References: <20211101110107.29010-1-tommy_huang@aspeedtech.com>
 <20211101110107.29010-5-tommy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101110107.29010-5-tommy_huang@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Nov 2021 19:01:07 +0800, tommy-huang wrote:
> Add ast2600-gfx description for gfx driver.
> 
> Signed-off-by: tommy-huang <tommy_huang@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/gpu/aspeed-gfx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

