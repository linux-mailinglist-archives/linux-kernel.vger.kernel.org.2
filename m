Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67ED37ED63
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386742AbhELUWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:22:01 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:34749 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385218AbhELUHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 16:07:16 -0400
Received: by mail-ot1-f43.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso21699497ote.1;
        Wed, 12 May 2021 13:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jJ6/WIxX35/cgvS4ItB41jw5rTb0BK4tQYBXu93W67Y=;
        b=iASOdExmAtk05NUsiIVjSjKMkAOR/JdXCCJR27VeaFb0/yMxzk9WkkkDlU+r6cYdmf
         iFQBKo7YBDRI5zQs0s4syfJO3q6H2CFI29KWUn1OPoA76Yd7V6mTQzw+LmTtZhSApN75
         3xXvu7o/IC/yqEfVZMZSxTWAgzxEyuEO913HBYD89qW6cjTszLFxZsM6M8M3u3y2r/0Z
         rc3BWX/eWSQTa8lIKzOoZw1KDOW9uh5TsRg19zUk6RdI2szIeCJ+KUqr8Vswk+6DfPO5
         XhK3UCbDAAPR+O3A4RREVOA+lnOSP8gJwiatOXBOqDyx44oP9DdC9cf5SDgWtHJIBfa7
         E7Hw==
X-Gm-Message-State: AOAM533UyfXXLb73I9wflas1rYsLwz3XWmOquP1J00EISqbc6etec5XU
        ZabdfGxFkapWJiLT2skgWJZL0Gxhzw==
X-Google-Smtp-Source: ABdhPJzKpxijVnBg01nSUqX6XBNqlBFU569+S2ZMwpc/HM4IjbTww8FstbHf9rltb5ioWwGcfA7oIQ==
X-Received: by 2002:a9d:7189:: with SMTP id o9mr622813otj.180.1620849966762;
        Wed, 12 May 2021 13:06:06 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l11sm214762ooq.44.2021.05.12.13.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 13:06:05 -0700 (PDT)
Received: (nullmailer pid 2451241 invoked by uid 1000);
        Tue, 11 May 2021 19:16:53 -0000
Date:   Tue, 11 May 2021 14:16:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eugen.Hristev@microchip.com
Cc:     alexandre.belloni@bootlin.com, Nicolas.Ferre@microchip.com,
        Ludovic.Desroches@microchip.com, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Claudiu.Beznea@microchip.com,
        Codrin.Ciubotariu@microchip.com
Subject: Re: [PATCH v2 2/4] ARM: dts: at91: add sama7g5 SoC DT and sama7g5-ek
Message-ID: <20210511191653.GA2446068@robh.at.kernel.org>
References: <20210511071223.71379-1-eugen.hristev@microchip.com>
 <20210511071223.71379-2-eugen.hristev@microchip.com>
 <070939b0-ec77-a135-b351-4c4c8bc543f0@microchip.com>
 <YJo0PY2E36v2Pqz/@piout.net>
 <8c74596c-6d23-c822-fc2e-6cbb984fa4fd@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c74596c-6d23-c822-fc2e-6cbb984fa4fd@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 09:03:37AM +0000, Eugen.Hristev@microchip.com wrote:
> On 5/11/21 10:37 AM, Alexandre Belloni wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On 11/05/2021 07:18:31+0000, Eugen.Hristev@microchip.com wrote:
> >> On 5/11/21 10:12 AM, Eugen Hristev wrote:
> >>> Add Device Tree for sama7g5 SoC and associated board sama7g5-ek
> >>>
> >>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> >>> [claudiu.beznea@microchip.com: add clocks, ethernet, timers, power]
> >>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> >>> [codrin.ciubotariu@microchip.com: add audio]
> >>> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> >>> ---
> >>
> >> Changes in v2:
> >> - fixed license
> >> - fixed warnings for make dtbs (changed ahb/apb to just soc)
> >> - changed some node names as suggested
> >> - removed some okay status properties
> >> - addressed cpu node by label
> >> - removed stdout path
> > 
> > Why would you remove stdout-path? The solution was to remove The console
> > parameter from bootargs, especially since you don't know what name the
> > console device will have depending on CONFIG_SERIAL_ATMEL_TTYAT.
> 
> Ok, sure, I will add it back and remove console=...
> 
> I will wait to see if Rob has anymore comments before preparing a v3.

No, nothing else.
