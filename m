Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A643416D85
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 10:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244611AbhIXISs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 04:18:48 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53878
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244596AbhIXISr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 04:18:47 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B52194079D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 08:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632471433;
        bh=EXS4i7/UM+obnQxSd1z8wLNVqi/HuXi6RdmLnjeH2JE=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=M5+zz/2rJxZvkyeih0BUZKW1hYqsWkpYSVSXP24PTd+nRUFBuinliKJM6r3W8Ynan
         a1v6Q45HbTemez4MZc1CoiksMnLaP/vR/act4qdJh/5a4eMujmhYT9oZKd5EEwbal0
         KuRhk2POJUseefr2X5lutIzUJyzXdREn40tB8A5l92XMfQvQSf2q0vsOWB0MRmeTA9
         iJgUC3YXRwOVNQ47pFbZfzCYlczhEPDw8eadaxDULiDIGOOzDojwexxy0vRpjvwtcr
         2SxOsWwkrwiCfsoneqxXoMsCQAGONQ5MWDymhLhDSfv4VovUfNEU+n+ivjZNVRGIAB
         GrCGM5IxgrvxQ==
Received: by mail-wr1-f71.google.com with SMTP id m18-20020adfe952000000b0015b0aa32fd6so7384179wrn.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 01:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EXS4i7/UM+obnQxSd1z8wLNVqi/HuXi6RdmLnjeH2JE=;
        b=Wo5ixcWWsVWewXTewWJPH26JicILlhJBF40p3jsYoq8CTBluibULy7PfsWpfOGAuEo
         2L7Xn44LGkFYbndA52f1xImEh9IjfUj3zvwG9daF1qnuI4eEdg7h77fq/KcY/YQz7e+I
         98Uyo4uGcc2XPOlUUz63lYOkbPIhM49auQZ4yzxRNURJkSvMEMC9JRfFs5Fc7pACd8nY
         U/De1GdaQ8QzotNFZVTCjFYL6girdiK0r2sLyYyAXxhoMz4zHJgP4pR/yEyPxn1TL/uE
         V5BQUnWFwBHSP4pI1mCRx39YT1OziKf4BHMqO6/86VtVPRpJXxTQePhzmQ7cbqGHDz02
         YCjw==
X-Gm-Message-State: AOAM5335PGVOZaZe4OweyAGqwCaOSwPmhkLZ6PtbQeqZbJChXiBGb/h1
        MVRbezIFiPW7uQuLLzyyMXl9+sWQfD7pQFw8Ae/vxpfGFqKFCJ+8ueeauA/gLuUkrw0NnywsQzi
        KgATdu76uSMj1Pp3JLax0IZm9WGkvNF7dzrDkBS3C1Q==
X-Received: by 2002:a5d:404b:: with SMTP id w11mr9561049wrp.437.1632471433290;
        Fri, 24 Sep 2021 01:17:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+vjhZAx/ULGOawL+W6ez/4NvIuds33IzJPVlTeG1/oU9kqKCA9AkDVpnCpge4bLZlTNV+jA==
X-Received: by 2002:a5d:404b:: with SMTP id w11mr9561029wrp.437.1632471433160;
        Fri, 24 Sep 2021 01:17:13 -0700 (PDT)
Received: from [192.168.0.134] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id m2sm11457315wmm.3.2021.09.24.01.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 01:17:12 -0700 (PDT)
Subject: Re: [PATCH 2/5] ARM: dts: imx6sl: fixup of operating points
To:     Andreas Kemnade <andreas@kemnade.info>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210923201238.2516844-1-andreas@kemnade.info>
 <20210923201238.2516844-3-andreas@kemnade.info>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <e41f9570-3350-651a-f4f6-c9864d3504c4@canonical.com>
Date:   Fri, 24 Sep 2021 10:17:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923201238.2516844-3-andreas@kemnade.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2021 22:12, Andreas Kemnade wrote:
> Make operating point definitions comply with binding
> specifications.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  arch/arm/boot/dts/imx6sl.dtsi | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
