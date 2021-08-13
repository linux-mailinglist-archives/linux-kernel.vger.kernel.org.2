Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BB93EBC46
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 20:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbhHMS4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 14:56:35 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:47009 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbhHMS4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 14:56:32 -0400
Received: by mail-ot1-f42.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso382614ott.13;
        Fri, 13 Aug 2021 11:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L0pfLxRNKo02qzCvo3QeOM9KCSwF5hE7nSVfXNEo/n4=;
        b=UC+QgaIAT1tlC8hr5trflgmbNcDoKaqmy9PFtdsYUTXxDRiCZBhs/4jhElO5DuZYiV
         bRzg2u4QJLnaXl9icvY6/3eTdIqTbIgi6jC/AmPPFihW9ZMY3PPhjFQjmT2alX+WM/Fv
         dqa2RbzNtWZS0hLEYIJ+fNiQpNTgA3MeeTU92jMabajdWKi6zJAwnaSIgSD+JjSVI4CQ
         nat1acPPhx8fSe2BU+9XYblhkxU7v8WKZ1VFk9I/xIOMh9pIN1mDtWRZI5su56cxqS/7
         DR13JrYB/F0eZVwQ9VS6sqKDVkaDmFaviAzrQa6v79qwMNSWZ+N+J+lFAYCCgM7DphFt
         uvlg==
X-Gm-Message-State: AOAM531dekPY3YGgXkUswPHTIOgCIywR7oUQuz6nGEMUiKvvR+xKNsP+
        Fgg6g0yT4nracw6KozbEjA==
X-Google-Smtp-Source: ABdhPJxF8W59I5HF/nGleAn8s5FNFCVTubE+Y9Cx1YpkOP7Ji8jY4ePHPHUQr9pRU2lN8utICytuLQ==
X-Received: by 2002:a9d:266a:: with SMTP id a97mr1850524otb.114.1628880955277;
        Fri, 13 Aug 2021 11:55:55 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t21sm463096otl.67.2021.08.13.11.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 11:55:54 -0700 (PDT)
Received: (nullmailer pid 3860141 invoked by uid 1000);
        Fri, 13 Aug 2021 18:55:53 -0000
Date:   Fri, 13 Aug 2021 13:55:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        nicolas.ferre@microchip.com, olof@lixom.net, arnd@arndb.de,
        soc@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/7] dt-bindings: ARM: at91: document exegin q5xr5 board
Message-ID: <YRbAOYoRoMCtxuGL@robh.at.kernel.org>
References: <20210805155357.594414-1-claudiu.beznea@microchip.com>
 <20210805155357.594414-4-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805155357.594414-4-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Aug 2021 18:53:53 +0300, Claudiu Beznea wrote:
> Document Exegin Q5xR5 board.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
