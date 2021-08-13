Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DC93EBC43
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 20:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhHMSzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 14:55:49 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:45774 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbhHMSzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 14:55:47 -0400
Received: by mail-oi1-f174.google.com with SMTP id o20so17256075oiw.12;
        Fri, 13 Aug 2021 11:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cng24zHOfefhsIyuo8+sls9JUJaOQc7bK59B/LvqdMk=;
        b=C9MTHj0M9zhEt0ax4uGz4M++Fpo2lXTZFeNY+MJl1sQrHRahX0rSIP72vvZEY0eLfO
         M2ciIcTnJH25b9Q7M5aKEPVc+NLfPl94gdXyP4CVpcedXlC6m/FEuoaBvD1TXWbkPpzS
         D6RwRy7JjZdHHrAAL17cC/miUo39iCW8ZktbfcaYxfzZH3OiPFVLV8eEsLzWluT1mNoN
         jOFUfXddCBw/a218r4fY6X9xcNsZ9PfAx48JpPGCRVjPsOZdX6o9pjVZdpeM1VM0WH+t
         Sv9WyRpE5czu8i5e/MEGN4fciurrzZ5A/qv0zxlturI87Xq2a4SpGQTzjjYJ5iyVfhKS
         cDqA==
X-Gm-Message-State: AOAM530Ed5mKY/OyiYCaD0wiVtpDwGB1g/RsRsu4eD2W7tCqHcKXoPrr
        8bQLyVg15naPgtziFRwQ9w==
X-Google-Smtp-Source: ABdhPJzwh8U81EC0A8V3HPWGGTJ4J2sIg/6C2OiLum4E+86UHhc9fu+Yxp/WTdfVouHPjIRsBKPoDg==
X-Received: by 2002:a05:6808:bcd:: with SMTP id o13mr3401856oik.61.1628880919869;
        Fri, 13 Aug 2021 11:55:19 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t3sm520494oic.13.2021.08.13.11.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 11:55:19 -0700 (PDT)
Received: (nullmailer pid 3859064 invoked by uid 1000);
        Fri, 13 Aug 2021 18:55:18 -0000
Date:   Fri, 13 Aug 2021 13:55:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     olof@lixom.net, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        devicetree@vger.kernel.org, nicolas.ferre@microchip.com,
        soc@kernel.org, ludovic.desroches@microchip.com,
        robh+dt@kernel.org, alexandre.belloni@bootlin.com
Subject: Re: [PATCH 2/7] dt-bindings: add vendor prefix for exegin
Message-ID: <YRbAFrGzKv9s0mKe@robh.at.kernel.org>
References: <20210805155357.594414-1-claudiu.beznea@microchip.com>
 <20210805155357.594414-3-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805155357.594414-3-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Aug 2021 18:53:52 +0300, Claudiu Beznea wrote:
> Add vendor prefix for Exegin Technologies Limited.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
