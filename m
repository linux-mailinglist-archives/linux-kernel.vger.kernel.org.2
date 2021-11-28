Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF72460B21
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 00:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359609AbhK1XeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 18:34:12 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:34343 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359496AbhK1XcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 18:32:10 -0500
Received: by mail-ot1-f41.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso22994080otj.1;
        Sun, 28 Nov 2021 15:28:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WrsDPJbzgUeYn4FWXGCy58UMSdy3S9PAKGtFuXoKMgg=;
        b=q6e1z561hoIU6jkOoOZRk2V0vasXd7xxN+ZdnyVWGkeIY1rEtAVmlmpdlz473CDOa0
         7lqTo692UW4uTZ50f1S1/SZs1sg+S077ey7xTIo7Ud2k0y8YVG5TADqoB3IRwiDSkb68
         cCYWWRFuENbuXxyh+l/dB4vmodQuM15HOb1oXNCY8nbf0nxQyGt0Ga4T6dKbngMAQSrs
         sQAMU6vRSZWVChSk6MUpvp+dKsyMfShECzphO/3R7B/3JALbVYyd4awSOGVt8GdHoRWj
         9WDTGBpXwtc5k8DhV4nVnTUTwB8gZbamag6X4wUU/INJUQvvWKOl/x7gtf+9JhxH7UJ8
         GiBQ==
X-Gm-Message-State: AOAM5323+STFO988+U+/wNMZ7XJfOWGeV/yE5xT3i5RbP59840fLPvdM
        KpNP4jRwrL5KwKye9wHl1Q==
X-Google-Smtp-Source: ABdhPJx3o50WxjGKsbAL7Bq7mRBhNE1BS2wmFuph/j+9fhfRkiIsbR0VbsA2Qp3j+V4xqfBf9tNIdA==
X-Received: by 2002:a9d:4702:: with SMTP id a2mr42013920otf.262.1638142133950;
        Sun, 28 Nov 2021 15:28:53 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fe7:4487:4f99:dbc0:75d1:3e27])
        by smtp.gmail.com with ESMTPSA id bl33sm2683669oib.47.2021.11.28.15.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 15:28:53 -0800 (PST)
Received: (nullmailer pid 2815542 invoked by uid 1000);
        Sun, 28 Nov 2021 23:28:50 -0000
Date:   Sun, 28 Nov 2021 17:28:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        john@phrozen.org
Subject: Re: [PATCH v4 01/12] dt-bindings: Add vendor prefix for Airoha
Message-ID: <YaQQskhAwdVpK0al@robh.at.kernel.org>
References: <20211125110738.41028-1-nbd@nbd.name>
 <20211125110738.41028-2-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125110738.41028-2-nbd@nbd.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 12:07:27 +0100, Felix Fietkau wrote:
> From: John Crispin <john@phrozen.org>
> 
> Add vendor prefix "airoha" for Airoha, a subsidiary of MediaTek
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Bert Vermeulen <bert@biot.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
