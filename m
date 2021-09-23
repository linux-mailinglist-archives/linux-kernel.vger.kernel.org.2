Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5574163BA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238628AbhIWQ6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:58:24 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:39886 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhIWQ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:58:21 -0400
Received: by mail-ot1-f43.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so9395065ota.6;
        Thu, 23 Sep 2021 09:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yCuhDbFySv0WBASIMuHbe9F9f8YaVqjJ37FH7IkOu2Q=;
        b=DBg6VDNvYa37lnsq6/Y7Mq0Z5LwlGRJnFhRurImxfeUD846HwX9xC8LRJAwgaPOiSH
         kLfdGKhWl30szY2K0YPKgk79XFT5KS5syPgsZ0GcWWE3EeZWD4VPs0z2NY/a737vAu75
         YLR9xsV2fLvbb4F2x7Dfnq+QaO6i7MZhZwirmjEdrvwl/rjUKJzlBjOQyQkXsXp6yCT+
         /wVC3/v2teEug9Z9A3CDYSg2/Xjey3/go8SM8DBQyW53k1ikASdQuej/sk92CyTTUm8Z
         /oIaPnOgbe7vqPh6rus9tKI1Xk2iPGjMCxWl3q0leD4p6Ji+IBI5/FGCvvGG9pqlliWG
         ZPYw==
X-Gm-Message-State: AOAM5319MFY82foKQ/n9CleQS40PdDNfyqm4voF6jiVPBm5qIVGhMVZe
        k+DvK1rrMrTRCHfuZaAU/w==
X-Google-Smtp-Source: ABdhPJwZF13O3L94Az07rbZOHYKpGcxO0Y3TsLBWTY4BwTvdCjMK2u5P9d4TPJIIAl0Dmte2Oz4hQQ==
X-Received: by 2002:a9d:7dd0:: with SMTP id k16mr5369860otn.51.1632416209860;
        Thu, 23 Sep 2021 09:56:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s26sm1498922ooc.26.2021.09.23.09.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 09:56:49 -0700 (PDT)
Received: (nullmailer pid 3165231 invoked by uid 1000);
        Thu, 23 Sep 2021 16:56:48 -0000
Date:   Thu, 23 Sep 2021 11:56:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Anikiel <pan@semihalf.com>
Cc:     linux-mtd@lists.infradead.org, olof@lixom.net, ka@semihalf.com,
        dinguyen@kernel.org, devicetree@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, jam@semihalf.com,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        tn@semihalf.com, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, arnd@arndb.de, vigneshr@ti.com,
        robh+dt@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: mtd: spi-nor: add n25q00 schema
Message-ID: <YUyx0K9M7wspVl+E@robh.at.kernel.org>
References: <20210920124141.1166544-1-pan@semihalf.com>
 <20210920124141.1166544-2-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210920124141.1166544-2-pan@semihalf.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2021 14:41:39 +0200, Paweł Anikiel wrote:
> Add schema for the n25q00 NOR flash memory.
> 
> Signed-off-by: Paweł Anikiel <pan@semihalf.com>
> ---
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
