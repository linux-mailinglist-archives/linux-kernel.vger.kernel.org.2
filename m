Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00AB3EF230
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhHQSrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:47:19 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:34438 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhHQSrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:47:16 -0400
Received: by mail-oi1-f171.google.com with SMTP id t128so571122oig.1;
        Tue, 17 Aug 2021 11:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b4LH5u0KhUfAlgd1fdyz9ZjG+CpygTQr8w8JJtZ1B74=;
        b=fkraXGYoNXTZ9flpBGdGdauX99TGhqK4/4CO03WCJhCx0Pn4CbbEbvhRvAqKLUz02L
         QnPqUTjdaMRNIFk9MIHZ8JZmmvM6uihwPUHw4lbjg3FO9J5i4WYqcv1d8ycSdvR4bwYQ
         6F1s5BUbnZiBKyCGcMphP9qs9GRLNrClnmQfaWSxArsz3pH79Kl9WmajCh2uOjNjjeZ7
         0fnHs9frVvIZktncmRdfzQxnx/H7nnYB3s8eogoSqKX76PgWzcZPL+b9ziYQwlGfW0iJ
         W1iiIsWjFkh4os4pY/juMwOjuP8Jid8jAxk4DDiZ/3uJMFKs0aMF2SNsXQulhj0/pIJ6
         YsAw==
X-Gm-Message-State: AOAM530TfahtotnhOiNbA8qRLgfiZQlHZ24H2DTIGHNyHjRcFPlXavwR
        JVkLC9Q4pkHbudsd5omzCQ==
X-Google-Smtp-Source: ABdhPJyb+e3INPAtFRLFklMWl+fZQxDDn2l23zD16hQgbtUM3bjFJ83mJs0R8MOWe+/4wpRFVgwPeQ==
X-Received: by 2002:a05:6808:7c2:: with SMTP id f2mr2342723oij.20.1629226002922;
        Tue, 17 Aug 2021 11:46:42 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y24sm551038oto.40.2021.08.17.11.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:46:42 -0700 (PDT)
Received: (nullmailer pid 640500 invoked by uid 1000);
        Tue, 17 Aug 2021 18:46:41 -0000
Date:   Tue, 17 Aug 2021 13:46:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, alexandre.belloni@bootlin.com, olof@lixom.net,
        arnd@arndb.de, devicetree@vger.kernel.org, robh+dt@kernel.org,
        ludovic.desroches@microchip.com, nicolas.ferre@microchip.com
Subject: Re: [PATCH v2 6/7] dt-bindings: ARM: at91: document exegin q5xr5
 board
Message-ID: <YRwEEQ0SgQRDnd7t@robh.at.kernel.org>
References: <20210816064416.1630674-1-claudiu.beznea@microchip.com>
 <20210816064416.1630674-7-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816064416.1630674-7-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2021 09:44:15 +0300, Claudiu Beznea wrote:
> Document Exegin Q5xR5 board.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

